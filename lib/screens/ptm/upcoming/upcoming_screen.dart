import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:masterjee/constants.dart';
import 'package:masterjee/widgets/app_bar_two.dart';
import 'package:masterjee/widgets/app_tags.dart';
import 'package:masterjee/widgets/text.dart';

class UpcomingScreen extends StatefulWidget {
  const UpcomingScreen({super.key});

  static String routeName = 'UpcomingScreen';

  @override
  State<UpcomingScreen> createState() => _UpcomingScreenState();
}

class _UpcomingScreenState extends State<UpcomingScreen> {

  var _isLoading = false;
  List<int> resultData = [1, 2, 3, 4, 5];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarTwo(title: AppTags.upcoming),
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
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.all(10.sp),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    CommonText.bold('OTM name', size: 14.sp, color: kDarkGreyColor, overflow: TextOverflow.fade),
                    CommonText.regular('12 Apr 2024', size: 10.sp, color: kDarkGreyColor, overflow: TextOverflow.fade),
                  ],
                ),
                gap(10.00),
                CommonText.medium('PTM stands for Parent-Teacher Meeting, a scheduled discussion between a students parents and their teacher',
                    size: 11.sp, color: kDarkGreyColor, overflow: TextOverflow.fade),
                gap(10.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Expanded(child: CommonText.bold('Student ', size: 14.sp, color: kDarkGreyColor, overflow: TextOverflow.fade)),
                Expanded(child: CommonText.bold('Slot', size: 14.sp, color: kDarkGreyColor, overflow: TextOverflow.fade)),
              ],
            ),
                ListView.builder(
                    physics: NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    itemCount: a,
                    itemBuilder: (BuildContext context, int index) {
                      return studentList(resultData[index], false);
                    }),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget studentList(int a, bool isClosed) {
    return Container(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.only(top: 5,bottom: 5),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Expanded(child: CommonText.medium('Student${a*898} ', size: 14.sp, color: kDarkGreyColor, overflow: TextOverflow.fade)),
                Expanded(child: CommonText.medium('09:00 To 10:00', size: 14.sp, color: kDarkGreyColor, overflow: TextOverflow.fade)),
              ],
            ),
          ),
        ],
      ),
    );
  }



}
