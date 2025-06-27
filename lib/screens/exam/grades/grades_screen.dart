import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get_utils/src/extensions/widget_extensions.dart';
import 'package:masterjee/constants.dart';
import 'package:masterjee/screens/exam/grades/edit_uppdate_grade_screen.dart';
import 'package:masterjee/widgets/text.dart';

class GradesScreen extends StatefulWidget {
  const GradesScreen({super.key});

  static String routeName = 'gradesScreen';

  @override
  State<GradesScreen> createState() => _GradesScreenState();
}

class _GradesScreenState extends State<GradesScreen> {

  var _isLoading = false;
  List<int> ptmList = [0,1,2,3,4];

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
    if (ptmList.isEmpty) {
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
    return  Padding(
      padding: EdgeInsets.symmetric(horizontal: 10.sp),
      child: ListView.builder(
          shrinkWrap: true,
          itemCount: ptmList.length,
          padding: EdgeInsets.only(top: 10.sp),
          itemBuilder: (BuildContext context, int index) {
            return assignmentCard(ptmList[index], false);
          }),
    );
  }

  Widget assignmentCard(int ptmData, bool isClosed) {
    return Container(
      margin: EdgeInsets.only(bottom: 15.sp),
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
                    Flexible(
                      child: Container(
                        decoration: const BoxDecoration(
                            borderRadius: BorderRadius.all(Radius.circular(5)),
                            color: colorGaryText
                        ),
                        child: CommonText.regular("Regular Evaluation ",
                            size: 10.sp, color: Colors.white, overflow: TextOverflow.fade).paddingOnly(left: 5,right: 5,bottom: 2,top: 2),
                      ),
                    ),
                    gap(10.0),
                    InkWell(
                      onTap: () {
                        Navigator.pushNamed(context, EditUpdateGradeScreen.routeName);
                      },
                      child: Container(
                        decoration: BoxDecoration(
                            borderRadius:
                            BorderRadius.all(Radius.circular(5.r)),
                            color:Colors.grey ),
                        child: const Icon(Icons.edit, color: colorWhite)
                            .paddingAll(2),
                      ),
                    )
                  ],
                ),

                gap(10.00),
                CommonText.medium("Exams are formal assessments meant to demonstrate your proficiency in a subject or to help you earn a qualification. During a medical examination, a doctor examines, feels, or performs basic tests on your body to determine health.",
                    size: 11.sp, color: kDarkGreyColor, overflow: TextOverflow.fade),
                gap(10.0),
                ListView.builder(
                    padding: EdgeInsets.all(0),
                    physics: const NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    itemCount: ptmList.length,
                    itemBuilder: (BuildContext context, int index) {
                      return studentList(ptmList[index]);
                    }),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget studentList(int data) {
    return Container(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 5),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Expanded(child: CommonText.medium('A+', size: 12.sp, color: kDarkGreyColor, overflow: TextOverflow.fade),flex: 10),
                Expanded(child: CommonText.medium('100', size: 12.sp, color: kDarkGreyColor, overflow: TextOverflow.fade),flex: 10),
                Expanded(child: CommonText.medium('90', size: 12.sp, color: kDarkGreyColor, overflow: TextOverflow.fade),flex: 10),
                Expanded(child: CommonText.medium('	Excellent', size: 12.sp, color: kDarkGreyColor, overflow: TextOverflow.fade),flex: 10),
              ],
            ),
          ),

        ],
      ),
    );
  }

}
