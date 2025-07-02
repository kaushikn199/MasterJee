import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get_utils/src/extensions/widget_extensions.dart';
import 'package:masterjee/constants.dart';
import 'package:masterjee/models/exam/AllAssessmentsResponse.dart';
import 'package:masterjee/models/exam/ExamResponse.dart';
import 'package:masterjee/others/StorageHelper.dart';
import 'package:masterjee/providers/exam_api.dart';
import 'package:masterjee/screens/exam/grades/edit_uppdate_grade_screen.dart';
import 'package:masterjee/widgets/app_tags.dart';
import 'package:masterjee/widgets/text.dart';
import 'package:provider/provider.dart';

class AssessmentScreen extends StatefulWidget {
  const AssessmentScreen({super.key});

  static String routeName = 'assessmentScreen';


  @override
  State<AssessmentScreen> createState() => _AssessmentScreenState();
}

class _AssessmentScreenState extends State<AssessmentScreen> {


  var _isLoading = false;
  //List<int> ptmList = [0,1,2,3,4];

  late List<AssessmentModel> assessmentList = [];

  @override
  void initState() {
    callApiAllAssessments();
    super.initState();
  }

  Future<void> callApiAllAssessments() async {
    setState(() {
      _isLoading = true;
    });
    try {
      AssessmentResponse data =
      await Provider.of<ExamApi>(context, listen: false).allAssessments(
          StorageHelper.getStringData(StorageHelper.userIdKey).toString(),
          StorageHelper.getStringData(StorageHelper.classIdKey).toString(),
          StorageHelper.getStringData(StorageHelper.sectionIdKey).toString()
      );
      if (data.result) {
        setState(() {
          assessmentList = data.data ?? [];
          _isLoading = false;
        });
        return;
      }else{
        setState(() {
          _isLoading = false;
        });
      }
    } catch (error) {
      _isLoading = false;
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
    if (assessmentList.isEmpty) {
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
          itemCount: assessmentList.length,
          padding: EdgeInsets.only(top: 10.sp),
          itemBuilder: (BuildContext context, int index) {
            return assignmentCard(assessmentList[index], false);
          }),
    );
  }

  Widget assignmentCard(AssessmentModel data, bool isClosed) {
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
                        child: CommonText.regular(data.name,
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
                CommonText.medium(data.description,
                    size: 11.sp, color: kDarkGreyColor, overflow: TextOverflow.fade),
                gap(10.0),
                ListView.builder(
                  padding: EdgeInsets.all(0),
                    physics: const NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    itemCount: data.types.length,
                    itemBuilder: (BuildContext context, int index) {
                      return studentList(data.types[index]);
                    }),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget studentList(AssessmentTypeModel data) {
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
                Expanded(flex: 10,child: CommonText.medium(data.name, size: 12.sp, color: kDarkGreyColor, overflow: TextOverflow.fade),),
                Expanded(flex: 3, child: CommonText.medium(data.code, size: 12.sp, color: kDarkGreyColor, overflow: TextOverflow.fade)),
                Expanded(flex: 2, child: CommonText.medium(data.maximumMarks, size: 12.sp, color: kDarkGreyColor, overflow: TextOverflow.fade)),
                Expanded(flex: 2, child: CommonText.medium(data.passPercentage, size: 12.sp, color: kDarkGreyColor, overflow: TextOverflow.fade)),
              ],
            ),
          ),
        ],
      ),
    );
  }

}