import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:masterjee/constants.dart';
import 'package:masterjee/screens/student_behaviour/behaviour_screen.dart';
import 'package:masterjee/screens/student_behaviour/progress_screen.dart';
import 'package:masterjee/widgets/CommonButton.dart';
import 'package:masterjee/widgets/app_bar_two.dart';
import 'package:masterjee/widgets/app_tags.dart';
import 'package:masterjee/widgets/text.dart';

class StudentBehaviourScreen extends StatefulWidget {
  const StudentBehaviourScreen({super.key});

  static String routeName = 'StudentBehaviourScreen';

  @override
  State<StudentBehaviourScreen> createState() => _StudentBehaviourScreenState();
}

class _StudentBehaviourScreenState extends State<StudentBehaviourScreen> {
  var _isLoading = false;
  List<int> resultData = [1, 2, 3, 4, 5];

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarTwo(title: AppTags.studentBehavior),
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
                    CommonText.medium('No Record Found',
                        size: 16.sp,
                        color: kDarkGreyColor,
                        overflow: TextOverflow.fade),
                  ],
                ),
              );
            }
            return Padding(
              padding: EdgeInsets.symmetric(horizontal: 10.sp),
              child: Column(
                children: [
                  Row(
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      Expanded(
                        child: CommonButton(
                          text: AppTags.behaviour,
                          onPressed: () {
                            Navigator.pushNamed(
                                context, BehaviourScreen.routeName);
                          },
                        ),
                      ),
                      const SizedBox(width: 10),
                      Expanded(
                        child: CommonButton(
                          text: AppTags.progress,
                          onPressed: () {
                            Navigator.pushNamed(
                                context, ProgressScreen.routeName);
                          },
                        ),
                      ),
                    ],
                  ),
                  Expanded(
                    child: ListView.builder(
                      itemCount: resultData.length,
                      padding: EdgeInsets.only(top: 10.sp),
                      itemBuilder: (BuildContext context, int index) {
                        return assignmentCard(resultData[index], false);
                      },
                    ),
                  ),
                ],
              ),
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
                  borderRadius: BorderRadius.only(
                      topRight: Radius.circular(10.r),
                      topLeft: Radius.circular(10.r)),
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
                rowValue("Theft", "point : 10"),
                CommonText.medium("not completed the homework",
                    size: 14.sp,
                    color: kDarkGreyColor,
                    overflow: TextOverflow.fade),
                gap(10.sp),
                rowValue("good behaviour", "point : 20"),
                CommonText.medium("test",
                    size: 14.sp,
                    color: kDarkGreyColor,
                    overflow: TextOverflow.fade),
                gap(10.sp),
                rowValue("mixcs", "point : 50"),
                CommonText.medium("tecfhfgvjh cfgghfgj cghgfjh st",
                    size: 14.sp,
                    color: kDarkGreyColor,
                    overflow: TextOverflow.fade),
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
      Expanded(child: CommonText.medium(key, size: 12.sp, color: Colors.black)),
      SizedBox(width: 20.w),
      CommonText.medium(value,
          size: 14.sp, color: kDarkGreyColor, overflow: TextOverflow.fade),
    ]);
  }
}
