import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get_utils/src/extensions/widget_extensions.dart';
import 'package:masterjee/constants.dart';
import 'package:masterjee/models/leads/followup_response.dart';
import 'package:masterjee/screens/leads/leads_view_screen.dart';
import 'package:masterjee/widgets/app_tags.dart';
import 'package:masterjee/widgets/text.dart';

class ExamScreen extends StatefulWidget {
  const ExamScreen({super.key});
  static String routeName = 'examScreen';

  @override
  State<ExamScreen> createState() => _ExamScreenState();
}

class _ExamScreenState extends State<ExamScreen> {

  var _isLoading = false;
  late List<int> followupList = [0,1,2,3,4,5,6,7,8];

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
              int data = followupList[index];
              return InkWell(
                  onTap: () {
                    //Navigator.push(context);
                  },
                  child: leadsCard(data, context));
            }),
      ),
    );
  }

  Widget leadsCard(int data, BuildContext context) {
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
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Flexible(
                      child: Container(
                        decoration: const BoxDecoration(
                            borderRadius: BorderRadius.all(Radius.circular(5)),
                            color: colorGaryText
                        ),
                        child: CommonText.regular("Chapter Wise Weekly Test(Februar-2024)",
                            size: 10.sp, color: Colors.white, overflow: TextOverflow.fade).paddingOnly(left: 5,right: 5,bottom: 2,top: 2),
                      ),
                    ),
                    gap(10.w),
                    Container(
                      decoration: const BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(5)),
                          color: colorGaryText
                      ),
                      child: CommonText.regular("Term 1",
                          size: 10.sp, color: Colors.white, overflow: TextOverflow.fade).paddingOnly(left: 5,right: 5,bottom: 2,top: 2),
                    ),
                  ],
                ),
                SizedBox(
                  height: 5.h,
                ),
                CommonText.medium("Chapter Wise Weekly Test",
                    size: 13.sp, color: Colors.black, overflow: TextOverflow.fade),
                gap(15.0),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    SvgPicture.asset(
                      colorFilter: const ColorFilter.mode(
                        Colors.black,
                        BlendMode.srcIn,
                      ),
                      AssetsUtils.tag,
                      width: 15.sp,
                      height: 15.sp,
                    ).paddingAll(10),
                    SvgPicture.asset(
                      colorFilter: const ColorFilter.mode(
                        Colors.black,
                        BlendMode.srcIn,
                      ),
                      AssetsUtils.book,
                      width: 15.sp,
                      height: 15.sp,
                    ).paddingAll(10),
                    SvgPicture.asset(
                      colorFilter: const ColorFilter.mode(
                        Colors.black,
                        BlendMode.srcIn,
                      ),
                      AssetsUtils.news,
                      width: 15.sp,
                      height: 15.sp,
                    ).paddingAll(10),
                    SvgPicture.asset(
                      colorFilter: const ColorFilter.mode(
                        Colors.black,
                        BlendMode.srcIn,
                      ),
                      AssetsUtils.calendar,
                      width: 15.sp,
                      height: 15.sp,
                    ).paddingAll(10),
                    SvgPicture.asset(
                      colorFilter: const ColorFilter.mode(
                        Colors.black,
                        BlendMode.srcIn,
                      ),
                      AssetsUtils.newspaper,
                      width: 15.sp,
                      height: 15.sp,
                    ).paddingAll(10),
                    SvgPicture.asset(
                      colorFilter: const ColorFilter.mode(
                        Colors.black,
                        BlendMode.srcIn,
                      ),
                      AssetsUtils.delete,
                      width: 15.sp,
                      height: 15.sp,
                    ).paddingAll(10)

                  ],
                )
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
