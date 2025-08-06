import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get_utils/src/extensions/widget_extensions.dart';
import 'package:masterjee/constants.dart';
import 'package:masterjee/models/common_functions.dart';
import 'package:masterjee/models/leads/followup_response.dart';
import 'package:masterjee/models/leads/leads_response.dart';
import 'package:masterjee/models/leads/missed_leads_response.dart';
import 'package:masterjee/others/StorageHelper.dart';
import 'package:masterjee/providers/leads_api.dart';
import 'package:masterjee/screens/leads/leads_view_screen.dart';
import 'package:masterjee/widgets/CommonButton.dart';
import 'package:masterjee/widgets/app_tags.dart';
import 'package:masterjee/widgets/text.dart';
import 'package:provider/provider.dart';

class AllScreen extends StatefulWidget {
  const AllScreen({super.key});
  static String routeName = 'allScreen';

  @override
  State<AllScreen> createState() => _AllScreenState();
}

class _AllScreenState extends State<AllScreen> {

  var _isLoading = true;
  //late List<FollowupData> followupList = [];

  List<Campaign> campaignList = [];
  List<MissedFollowup> missedFollowupList = [];
  List<FollowUpStatus> followUpStatusList = [];
  List<Lead> openLeadsList = [];

  Future<void> callApiLeadsList() async {
    setState(() {
      _isLoading = true;
    });
    try {
      LeadResponse data = await Provider.of<LeadsApi>(context, listen: false)
          .getLeads(StorageHelper.getStringData(StorageHelper.userIdKey));
      if (data.status == "success") {
        setState(() {
          campaignList = data.campaigns;
          missedFollowupList = data.missedFollowups;
          openLeadsList = data.openLeads;
          print("openLeadsList : ${missedFollowupList.length}");
          _isLoading = false;
        });
        return;
      } else {
        setState(() {
          _isLoading = false;
        });
      }
    } catch (error) {
      print("callApiLeadsList : $error");
      setState(() {
        _isLoading = false;
      });
    }
  }

  Future<void> callApiTakeLead(String lId) async {
    setState(() {
      _isLoading = true;
    });
    try {
      LeadResponse data = await Provider.of<LeadsApi>(context, listen: false)
          .takeLead(StorageHelper.getStringData(StorageHelper.userIdKey), lId);
      if (data.status == "success") {
        setState(() {
          print("openLeadsList : ${openLeadsList.length}");
          _isLoading = false;
          CommonFunctions.showWarningToast(data.message);
          callApiLeadsList();
        });
        return;
      } else {
        setState(() {
          CommonFunctions.showWarningToast(data.message);
          _isLoading = false;
        });
      }
    } catch (error) {
      print("callApiLeadsList : $error");
      setState(() {
        CommonFunctions.showWarningToast(error.toString());
        _isLoading = false;
      });
    }
  }

  @override
  void initState() {
    callApiLeadsList();
    super.initState();
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
        child: Column(
          children: [
            gap(10.0),
            Row(
              children: [
                const Icon(Icons.spatial_audio_off_outlined),
                gap(10.0),
                CommonText.regular(AppTags.myCamp,
                    size: 12.sp),
                Expanded(child: SizedBox()),
                const Icon(Icons.person_rounded),
                CommonText.regular((campaignList != null && campaignList.isNotEmpty && campaignList[0] != null) ? campaignList[0].totalLeads : "",
                    size: 12.sp),
              ],
            ).paddingOnly(left: 20,right: 20),
            Expanded(
              child: ListView(
            padding: EdgeInsets.symmetric(horizontal: 10.sp, vertical: 5.sp),
        children: [
          ...openLeadsList.map((lead) => InkWell(
            onTap: () {
              /* Navigator.pushNamed(
              context,
              LeadsViewScreen.routeName,
              arguments: lead.leadId,
            );*/
            },
            child: openLeadsCard(lead, context),
          )),
          ...missedFollowupList.map((missed) => InkWell(
            onTap: () {
              Navigator.pushNamed(
                context,
                LeadsViewScreen.routeName,
                arguments: missed.leadId,
              );
            },
            child: leadsCard(missed, context),
          )),
        ],
      ),
            ),
          ],
        ),
      ),
    );
  }

  Widget leadsCard(MissedFollowup data, BuildContext context) {
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
                      data.name,
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
                rowValue(data.campaign ?? "", data.nextFollowupTime),
                Row(
                  children: [
                    Container(
                      margin: const EdgeInsets.only(right: 5),
                      width: 7, // Adjust size
                      height: 7, // Adjust size
                      decoration: const BoxDecoration(
                        color: Colors.red, // Change color
                        shape: BoxShape.circle,
                      ),
                    ),
                    CommonText.regular("${data.daysAgo} days ago",
                        size: 12.sp, color: Colors.black),
                    const Expanded(child: SizedBox()),
                    CommonText.regular(data.followupPriority,
                        size: 12.sp, color: Colors.black),
                    gap(5.w),
                    Container(
                      margin: const EdgeInsets.only(right: 5),
                      width: 10, // Adjust size
                      height: 10, // Adjust size
                      decoration: BoxDecoration(
                        color: data.followupPriority == "Low"
                            ? Colors.red
                            : data.followupPriority == "Medium"
                            ? Colors.yellow
                            : data.followupPriority == "High"
                            ? Colors.green
                            : Colors.transparent, // Change color
                        shape: BoxShape.rectangle,
                      ),
                    ),
                  ],
                ),
                Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
                  Expanded(
                      child: CommonText.regular(data.followupRemark,
                          size: 12.sp, color: Colors.black)),
                  CommonText.regular(data.callStatus,
                      size: 12.sp,
                      color: Colors.black,
                      overflow: TextOverflow.fade),
                ])
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget openLeadsCard(Lead data, BuildContext context) {
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
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
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
          SizedBox(width: 8), // spacing between image and text
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CommonText.semiBold(
                  data.lName,
                  size: 14.sp,
                  maxLines: 1,
                ).paddingOnly(left: 5),
                Divider(color: colorGaryLine).paddingOnly(left: 5,right: 10),
                CommonText.semiBold(
                  data.lEmail ?? "",
                  size: 14.sp,
                  maxLines: 1,
                ).paddingOnly(left: 5),
              ],
            ),
          ),
          CommonButton(
            paddingVertical: 1,
            text: AppTags.takeLeads,
            onPressed: () {
              callApiTakeLead(data.lId);
            },
          ),
        ],
      ).paddingAll(10.0),
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
