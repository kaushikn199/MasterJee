import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get_utils/src/extensions/widget_extensions.dart';
import 'package:masterjee/constants.dart';
import 'package:masterjee/models/common_functions.dart';
import 'package:masterjee/models/exam/exam/ExamScoreResponse.dart';
import 'package:masterjee/models/exam/exam/ExamSubjectsResponse.dart';
import 'package:masterjee/others/StorageHelper.dart';
import 'package:masterjee/providers/exam_api.dart';
import 'package:masterjee/widgets/CommonButton.dart';
import 'package:masterjee/widgets/app_bar_two.dart';
import 'package:masterjee/widgets/app_tags.dart';
import 'package:masterjee/widgets/custom_form_field.dart';
import 'package:masterjee/widgets/text.dart';
import 'package:provider/provider.dart';

class AddScoreScreen extends StatefulWidget {
  const AddScoreScreen({super.key});

  static String routeName = 'addScoreScreen';

  @override
  State<AddScoreScreen> createState() => _AddScoreScreenState();
}

class _AddScoreScreenState extends State<AddScoreScreen> {
  var _isLoading = false;
  late List<TextEditingController> nameController = [];
  late List<TextEditingController> notesController = [];
  late List<List<TextEditingController>> theoryMarkControllers = [];
  List<Map<String, dynamic>> studentsData = [];

  @override
  void initState() {
    super.initState();
  }

  bool _isInitialized = false;
  late ExamSubjectData examSubjectData;
  late List<ExamScoreData> examScoreList = [];

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (!_isInitialized) {
      examSubjectData =
          ModalRoute.of(context)!.settings.arguments as ExamSubjectData;
      if (examSubjectData != null) {
        callApiExamScore();
      }
      _isInitialized = true;
    }
  }

  Future<void> callApiSaveExamScore(String examTimetableId) async {
    setState(() {
      _isLoading = true;
    });
    try {
      ExamScoreResponse data =
          await Provider.of<ExamApi>(context, listen: false).saveExamScore(
              StorageHelper.getStringData(StorageHelper.userIdKey).toString(),
              examTimetableId,
              studentsData);
      if (data.result) {
        setState(() {
          _isLoading = false;
          studentsData.clear();
          CommonFunctions.showWarningToast(data.message);
          //Navigator.of(context).pop(true);
        });
        return;
      } else {
        setState(() {
          _isLoading = false;
        });
      }
    } catch (error) {
      print("error : ${error}");
      setState(() {
        _isLoading = false;
      });
    }
  }

  Future<void> callApiExamScore() async {
    setState(() {
      _isLoading = true;
    });
    try {
      ExamScoreResponse data =
          await Provider.of<ExamApi>(context, listen: false).examScore(
              StorageHelper.getStringData(StorageHelper.userIdKey).toString(),
              examSubjectData.cbseExamId,
              examSubjectData.subjectId);
      if (data.result) {
        setState(() {
          examScoreList = data.data;
          for (var student in examScoreList) {
            nameController
                .add(TextEditingController(text: student.studentName));
            notesController.add(TextEditingController(text: student.notes));

            List<TextEditingController> scoreControllers = student
                .assessmentScores
                .map((score) => TextEditingController(text: score.score ?? ""))
                .toList();
            theoryMarkControllers.add(scoreControllers);
          }
          _isLoading = false;
        });
        return;
      } else {
        setState(() {
          _isLoading = false;
        });
      }
    } catch (error) {
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBarTwo(title: AppTags.addScore),
        backgroundColor: colorGaryBG,
        bottomNavigationBar: CommonButton(
          paddingHorizontal: 7,
          cornersRadius: 10,
          text: AppTags.submit,
          onPressed: () {

            String examTimetableId = "";
            for (int studentIndex = 0; studentIndex < theoryMarkControllers.length; studentIndex++) {
              Map<String, dynamic> data = {};
              data["examStudentId"] = examScoreList[studentIndex].examStudentId;
              for (int scoreIndex = 0; scoreIndex < theoryMarkControllers[studentIndex].length; scoreIndex++) {
                if(studentIndex == 0 && scoreIndex == 0){
                  examTimetableId = examScoreList[studentIndex].assessmentScores[scoreIndex].examTimetableId;
                }
                data["tatid"] = examScoreList[studentIndex].assessmentScores[scoreIndex].assessmentTypeId;
                data["eatid"] = examScoreList[studentIndex].assessmentScores[scoreIndex].assessmentId;
                data["eascore"] = theoryMarkControllers[studentIndex][scoreIndex].text;
                data["note"] = notesController[studentIndex].text;
              }
              studentsData.add(data);
            }
            callApiSaveExamScore(examTimetableId);

          },
        ).paddingOnly(bottom: 30, left: 10, right: 10),
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
              if (examScoreList.isEmpty) {
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
                child: ListView.builder(
                    shrinkWrap: true,
                    itemCount: examScoreList.length,
                    padding: EdgeInsets.only(top: 10.sp),
                    itemBuilder: (BuildContext context, int index) {
                      return assignmentCard(examScoreList[index], index);
                    }),
              );
            })
          ],
        ));
  }

  Widget assignmentCard(ExamScoreData data, int i) {
    return Container(
      margin: EdgeInsets.only(bottom: 20.sp),
      child: Column(
        children: [
          CustomTextField(
            hintText: 'Name',
            isReadonly: true,
            controller: nameController[i],
            keyboardType: TextInputType.name,
            onSave: (value) {
              nameController[i].text = value as String;
            },
          ),
          gap(10.0),
          CustomTextField(
            hintText: 'Notes',
            isReadonly: false,
            controller: notesController[i],
            keyboardType: TextInputType.name,
            onSave: (value) {
              notesController[i].text = value as String;
            },
          ),
          ListView.builder(
              shrinkWrap: true,
              itemCount: data.assessmentScores.length,
              padding: EdgeInsets.only(top: 10.sp),
              itemBuilder: (BuildContext context, int index) {
                return cart(data.assessmentScores[index], i, index);
              })
        ],
      ),
    );
  }

  Widget cart(AssessmentScoreData data, int studentIndex, int scoreIndex) {
    final controller = theoryMarkControllers[studentIndex][scoreIndex];
    return Container(
      margin: EdgeInsets.only(bottom: 10.sp),
      child: Column(
        children: [
          CustomTextField(
            hintText: '${data.assessmentName} - Max score : ${data.maxScore}',
            isReadonly: false,
            controller: controller,
            keyboardType: TextInputType.number,
            onSave: (value) {
              controller.text = value as String;
            },
          ),
        ],
      ),
    );
  }
}
