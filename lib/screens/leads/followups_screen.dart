import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:masterjee/constants.dart';
import 'package:masterjee/models/leads/followup_response.dart';
import 'package:masterjee/others/StorageHelper.dart';
import 'package:masterjee/providers/leads_api.dart';
import 'package:masterjee/widgets/app_bar_two.dart';
import 'package:masterjee/widgets/app_tags.dart';
import 'package:masterjee/widgets/text.dart';
import 'package:provider/provider.dart';

class FollowupsScreen extends StatefulWidget {
  const FollowupsScreen({super.key});

  static String routeName = 'followupsScreen';


  @override
  State<FollowupsScreen> createState() => _FollowupsScreenState();
}

class _FollowupsScreenState extends State<FollowupsScreen> {

  var _isLoading = true;
  late List<FollowupData> followupList = [];

  @override
  void initState() {
    callApiAllFollowup();
    super.initState();
  }

  Future<void> callApiAllFollowup() async {
    try {
      FollowupResponse data =
      await Provider.of<LeadsApi>(context, listen: false).allFollowup(
          StorageHelper.getStringData(StorageHelper.userIdKey).toString());
      if (data.status == "success") {
        setState(() {
          followupList = data.data;
          _isLoading = false;
        });
        return;
      }else{
        setState(() {
          _isLoading = false;
        });
      }
    } catch (error) {
      print("callApiAllFollowup error : ${error}");
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
    if (followupList.isEmpty) {
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
            itemCount: followupList.length,
            padding: EdgeInsets.only(top: 10.sp),
            itemBuilder: (BuildContext context, int index) {
              FollowupData data = followupList[index];
              return leadsCard(data, context);
            }),
      ),
    );
  }

  Widget leadsCard(FollowupData data, BuildContext context) {
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
                    CommonText.semiBold(
                      data.lName,
                      size: 14.sp,
                      maxLines: 1,
                    ),
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
                rowValue(data.cTitle ?? "-",data.nextFollowupTime),
                Row(
                  children: [
                    Container(
                      margin:  const EdgeInsets.only(right: 5),
                      width: 10, // Adjust size
                      height: 10, // Adjust size
                      decoration:  BoxDecoration(
                        color: data.followupPriority == "Low" ? Colors.red : data.followupPriority == "Medium" ? Colors.yellow : data.followupPriority == "High" ? Colors.green : Colors.transparent, // Change color
                        shape: BoxShape.rectangle,
                      ),
                    ),
                    gap(5.w),
                    CommonText.regular(data.followupPriority?? "-", size: 12.sp, color: Colors.black),
                  ],
                ),
                Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
                  Expanded(child: CommonText.regular(data.followupRemark ?? "-", size: 12.sp, color: Colors.black)),
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
