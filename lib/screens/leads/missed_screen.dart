import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get_utils/src/extensions/widget_extensions.dart';
import 'package:masterjee/constants.dart';
import 'package:masterjee/models/leads/leads_response.dart';
import 'package:masterjee/models/leads/missed_leads_response.dart';
import 'package:masterjee/others/StorageHelper.dart';
import 'package:masterjee/providers/leads_api.dart';
import 'package:masterjee/screens/leads/leads_view_screen.dart';
import 'package:masterjee/widgets/app_tags.dart';
import 'package:masterjee/widgets/text.dart';
import 'package:provider/provider.dart';

class MissedScreen extends StatefulWidget {
  const MissedScreen({super.key});
  static String routeName = 'missedScreen';

  @override
  State<MissedScreen> createState() => _MissedScreenState();
}

class _MissedScreenState extends State<MissedScreen> {

  List<FollowUpStatus> followUpStatusList = [];
  List<AllFollowUp> missedFollowupList = [];
  bool _isLoading = false;

  @override
  void initState() {
    callApiMissedLeads();
    super.initState();
  }

  Future<void> callApiMissedLeads() async {
    setState(() {
      _isLoading = true;
    });
    try {
      MissedLeadsResponse data = await Provider.of<LeadsApi>(context, listen: false)
          .missedLeads(StorageHelper.getStringData(StorageHelper.userIdKey));
      if (data.status == "success") {
        setState(() {
          followUpStatusList = data.data.followUpStatus;
          missedFollowupList = data.data.allFollowUp;
          _isLoading = false;
        });
        return;
      } else {
        setState(() {
          _isLoading = false;
        });
      }
    } catch (error) {
      print("callApiMissedLeads : $error");
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    if (_isLoading) {
      return SizedBox(
        height: MediaQuery.of(context).size.height * .5,
        child: const Center(
          child: CircularProgressIndicator(),
        ),
      );
    }
    if (missedFollowupList.isEmpty) {
      return Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.hourglass_empty_outlined, size: 100.sp),
            CommonText.medium('No Record Found',
                size: 16.sp,
                color: kDarkGreyColor,
                overflow: TextOverflow.fade),
          ],
        ),
      );
    }
    return Container(
      height: double.infinity,
      color: kBackgroundColor,
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 10.sp),
        child: ListView.builder(
            shrinkWrap: true,
            itemCount: missedFollowupList.length,
            padding: EdgeInsets.only(top: 10.sp),
            itemBuilder: (BuildContext context, int index) {
              AllFollowUp data = missedFollowupList[index];
              return InkWell(
                onTap: () {
                  Navigator.pushNamed(context,
                      LeadsViewScreen.routeName,
                      arguments:data.lId);
                },
                  child: leadsCard(data, context));
            }),
      ),
    );
  }

  Widget leadsCard(AllFollowUp data, BuildContext context) {
    return Container(
      margin: EdgeInsets.all(10.sp),
      decoration: BoxDecoration(
        color: kSecondBackgroundColor,
        borderRadius: BorderRadius.circular(10.r),
        boxShadow: const [
          BoxShadow(
            color: Colors.grey,
            spreadRadius: -2.0,
            blurRadius: 5.0,
          ),
        ],
      ),
      child: Column(
        children: [
          Padding(
            padding: EdgeInsets.all(10.sp),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(20),
                      child: Image.asset(
                        AssetsUtils.logoIcon,
                        width: 35,
                        height: 35,
                        fit: BoxFit.fill,
                      ),
                    ),
                    CommonText.semiBold(
                      data.lName,
                      size: 14.sp,
                      maxLines: 1,
                    ).paddingOnly(left: 5),
                    const Expanded(
                      child: SizedBox(),
                    ),
                    CommonText.regular(
                      data.nextFollowupDate,
                      size: 12.sp,
                      maxLines: 1,
                    ).paddingOnly(left: 5),
                  ],
                ),
                SizedBox(
                  height: 5.h,
                ),
                rowValue(data.cTitle ?? "",data.nextFollowupTime),
                Row(
                  children: [
                   /* Container(
                      margin: const EdgeInsets.only(right: 5),
                      width: 7, // Adjust size
                      height: 7, // Adjust size
                      decoration: const BoxDecoration(
                        color: Colors.red, // Change color
                        shape: BoxShape.circle,
                      ),
                    ),*/
                   // CommonText.regular("${data.daysAgo} days ago", size: 12.sp, color: Colors.black),
                    const Expanded(child: SizedBox()),
                    CommonText.regular(data.followupPriority ?? "-", size: 12.sp, color: Colors.black),
                    gap(5.w),
                    Container(
                      margin:  const EdgeInsets.only(right: 5),
                      width: 10, // Adjust size
                      height: 10, // Adjust size
                      decoration:  BoxDecoration(
                        color: data.followupPriority == "Low" ? Colors.red : data.followupPriority == "Medium" ? Colors.yellow : data.followupPriority == "High" ? Colors.green : Colors.transparent, // Change color
                        shape: BoxShape.rectangle,
                      ),
                    ),
                  ],
                ),
                Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
                  Expanded(child: CommonText.regular(data.followupRemark, size: 12.sp, color: Colors.black)),
                  CommonText.regular(data.callStatus,
                      size: 12.sp, color: Colors.black, overflow: TextOverflow.fade),
                ])
              ],
            ),
          ),
        ],
      ),
    );
  }

  rowValue(String key, value) {
    return Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
      SizedBox(
          width: 80.sp,
          child: CommonText.regular(key, size: 12.sp, color: Colors.black)),
      const Expanded(child: SizedBox()),
      CommonText.regular(value,
          size: 12.sp, color: Colors.black, overflow: TextOverflow.fade),
    ]);
  }

}
