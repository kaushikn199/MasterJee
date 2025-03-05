import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:masterjee/constants.dart';
import 'package:masterjee/widgets/app_bar_two.dart';
import 'package:masterjee/widgets/app_tags.dart';
import 'package:masterjee/widgets/text.dart';

class DuesReportScreen extends StatefulWidget {
  const DuesReportScreen({super.key});
  static String routeName = 'duesReportScreen';

  @override
  State<DuesReportScreen> createState() => _DuesReportScreenState();
}

class _DuesReportScreenState extends State<DuesReportScreen> {

  var _isLoading = false;
  List<int> resultData = [1, 2, 3, 4, 5];

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarTwo(title: AppTags.duesReport),
      body: Stack(
        children: [
          Builder(builder: (context) {
            if (_isLoading) {
              return SizedBox(
                height: MediaQuery.of(context).size.height * .5,
                child: const Center(
                  child: CircularProgressIndicator(),
                ),
              );
            }
            if (resultData.isEmpty) {
              return Center(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.hourglass_empty_outlined, size: 100.sp),
                    CommonText.medium('No Record Found', size: 16.sp, color: kDarkGreyColor, overflow: TextOverflow.fade),
                  ],
                ),
              );
            }
            return Padding(
              padding: EdgeInsets.symmetric(horizontal: 10.sp),
              child: ListView.builder(
                  shrinkWrap: true,
                  itemCount: resultData.length,
                  padding: EdgeInsets.only(top: 10.sp),
                  itemBuilder: (BuildContext context, int index) {
                    return assignmentCard(resultData[index], false);
                  }),
            );
          }),

        ],
      ),
    );
  }

  Widget assignmentCard(int a, bool isClosed) {
    return Container(
      margin: EdgeInsets.only(bottom: 20.sp),
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
          Align(
            alignment: Alignment.bottomLeft,
            child: Container(
              width: double.maxFinite,
              padding: EdgeInsets.all(10.sp),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(topRight: Radius.circular(10.r), topLeft: Radius.circular(10.r)),
                  color: kToastTextColor),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Text(
                      "Abc1234567 - venkatesh",
                      style: TextStyle(
                        fontSize: 18.sp,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),

                ],
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.all(20.sp),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                rowValue("Payble",  "0"),
                gap(10.sp),
                rowValue("Paid", "0"),
                gap(10.sp),
                rowValue("Discount", "0"),
                gap(10.sp),
                rowValue("Dues", "0"),
                gap(10.sp),
              ],
            ),
          ),
        ],
      ),
    );
  }

  rowValue(String key, value) {
    return Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
      SizedBox(width: 100.sp, child: CommonText.medium(key, size: 12.sp, color: Colors.black)),
      SizedBox(width: 20.w),
      CommonText.medium(value, size: 14.sp, color: kDarkGreyColor, overflow: TextOverflow.fade),
    ]);
  }

}
