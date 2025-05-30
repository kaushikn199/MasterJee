import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:masterjee/constants.dart';
import 'package:masterjee/widgets/app_tags.dart';
import 'package:masterjee/widgets/text.dart';

class LeadsListScreen extends StatefulWidget {
  const LeadsListScreen({super.key});

  @override
  State<LeadsListScreen> createState() => _LeadsListScreenState();
}

class _LeadsListScreenState extends State<LeadsListScreen> {

  List<int> contentData = [1, 2, 3, 4, 5, 6, 7, 8, 9];
  var _isLoading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        floatingActionButton: FloatingActionButton(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(50.sp)),
          backgroundColor: colorGreen,
          onPressed: () {
            // _showBottomSheet(context, false);
          },
          child: const Icon(Icons.add, color: Colors.white, size: 28),
        ),
        body: Builder(builder: (context) {
      if (_isLoading) {
        return SizedBox(
          height: MediaQuery.of(context).size.height * .5,
          child: const Center(
            child: CircularProgressIndicator(),
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
              itemCount: contentData.length,
              padding: EdgeInsets.only(top: 10.sp),
              itemBuilder: (BuildContext context, int index) {
                int data = contentData[index];
                return contentCard(data, context);
              }),
        ),
      );
    }));
  }

  Widget contentCard(int data, BuildContext context) {
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
                    Expanded(
                      child: CommonText.semiBold(
                        AppTags.appName,
                        size: 14.sp,
                        maxLines: 1,
                      ).paddingOnly(left: 5),
                    )
                  ],
                ),
                SizedBox(
                  height: 5.h,
                ),
                rowValue("Camp 1", "2025-01-07"),
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
                    Expanded(child: rowValue("57 days ago", "13:09:00")),
                  ],
                ),
                rowValue("This is a test content. This is a test content.",
                    "Walk-in"),
              ],
            ),
          ),
        ],
      ),
    );
  }

  rowValue(String key, value) {
    return Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
              child: CommonText.medium(key, size: 12.sp, color: Colors.black)),
          SizedBox(width: 10.w),
          CommonText.medium(value,
              size: 12.sp, color: kDarkGreyColor, overflow: TextOverflow.fade),
        ]);
  }
}
