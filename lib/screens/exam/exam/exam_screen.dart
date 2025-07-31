import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get_utils/src/extensions/widget_extensions.dart';
import 'package:masterjee/constants.dart';
import 'package:masterjee/models/common_functions.dart';
import 'package:masterjee/models/exam/ExamResponse.dart';
import 'package:masterjee/models/exam/exam/ExamScoreResponse.dart';
import 'package:masterjee/models/exam/exam/ExamStudentsResponse.dart';
import 'package:masterjee/models/exam/exam/ExamSubjectsResponse.dart';
import 'package:masterjee/others/StorageHelper.dart';
import 'package:masterjee/providers/exam_api.dart';
import 'package:masterjee/screens/exam/exam/add_exam_screen.dart';
import 'package:masterjee/screens/exam/exam/add_score_screen.dart';
import 'package:masterjee/screens/exam/exam/add_subject_screen.dart';
import 'package:masterjee/widgets/CommonButton.dart';
import 'package:masterjee/widgets/app_tags.dart';
import 'package:masterjee/widgets/text.dart';
import 'package:provider/provider.dart';

import 'add_exam_attendance_screen.dart';

class ExamScreen extends StatefulWidget {
  const ExamScreen({super.key});

  static String routeName = 'examScreen';

  @override
  State<ExamScreen> createState() => _ExamScreenState();
}

class _ExamScreenState extends State<ExamScreen> {
  var _isLoading = false;
  late List<Exam> examList = [];
  late List<Student> examStudentsList = [];
  late List<ExamSubjectData> examSubjectDataList = [];

  @override
  void initState() {
    callApiAllExams();
    super.initState();
  }

  List<Map<String, dynamic>> stuIds = [];

  Future<void> callApiAssignStudents(String examId, BuildContext c) async {
    setState(() {
      _isLoading = true;
    });
    try {
      ExamScoreResponse data =
          await Provider.of<ExamApi>(context, listen: false).assignStudents(
              StorageHelper.getStringData(StorageHelper.userIdKey).toString(),
              examId,
              stuIds);
      if (data.result) {
        setState(() {
          stuIds.clear();
          CommonFunctions.showWarningToast(data.message);
          _isLoading = false;
          Navigator.of(c).pop();
        });
        return;
      } else {
        setState(() {
          CommonFunctions.showWarningToast(data.message);
          _isLoading = false;
        });
      }
    } catch (error) {
      _isLoading = false;
    }
  }

  Future<void> callApiExamSubjects(String examId) async {
    setState(() {
      _isLoading = true;
    });
    try {
      ExamSubjectResponse data =
          await Provider.of<ExamApi>(context, listen: false).examSubjects(
              StorageHelper.getStringData(StorageHelper.userIdKey).toString(),
              examId);
      if (data.result) {
        setState(() {
          examSubjectDataList = data.data;
          showCustomSubjectDialog(examId);
          _isLoading = false;
        });
        return;
      } else {
        setState(() {
          _isLoading = false;
        });
      }
    } catch (error) {
      _isLoading = false;
    }
  }

  Future<void> callApiExamStudents(String examId, BuildContext c) async {
    setState(() {
      _isLoading = true;
    });
    try {
      ExamStudentsResponse data =
          await Provider.of<ExamApi>(context, listen: false).getExamStudents(
              StorageHelper.getStringData(StorageHelper.userIdKey).toString(),
              examId);
      if (data.result) {
        setState(() {
          examStudentsList = data.data;
          showCustomStudentDialog(c, examId);
          _isLoading = false;
        });
        return;
      } else {
        setState(() {
          _isLoading = false;
        });
      }
    } catch (error) {
      _isLoading = false;
    }
  }

  Future<void> callApiAllExams() async {
    setState(() {
      _isLoading = true;
    });
    try {
      ExamResponse data = await Provider.of<ExamApi>(context, listen: false)
          .allExams(
              StorageHelper.getStringData(StorageHelper.userIdKey).toString(),
              StorageHelper.getStringData(StorageHelper.classIdKey).toString(),
              StorageHelper.getStringData(StorageHelper.sectionIdKey)
                  .toString());
      if (data.result) {
        setState(() {
          examList = data.data?.exams ?? [];
          _isLoading = false;
        });
        return;
      } else {
        setState(() {
          _isLoading = false;
        });
      }
    } catch (error) {
      _isLoading = false;
    }
  }

  Future<void> callApiGenerateRank(String examId) async {
    /* setState(() {
      _isLoading = true;
    });*/
    try {
      ExamResponse data =
          await Provider.of<ExamApi>(context, listen: false).generateRank(
        StorageHelper.getStringData(StorageHelper.userIdKey).toString(),
        examId,
      );
      if (data.result) {
        setState(() {
          //_isLoading = false;
          CommonFunctions.showWarningToast(data.message);
        });
        return;
      } else {
        /*setState(() {
          _isLoading = false;
        });*/
        CommonFunctions.showWarningToast(data.message);
      }
    } catch (error) {
      CommonFunctions.showWarningToast(error.toString());
      //_isLoading = false;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kBackgroundColor,
      floatingActionButton: FloatingActionButton(
          onPressed: () {
            Navigator.of(context).pushNamed(AddExamScreen.routeName);
          },
          backgroundColor: colorGreen,
          child: const Icon(Icons.add, color: colorWhite)),
      body: _isLoading
          ? SizedBox(
              height: MediaQuery.of(context).size.height * .5,
              child: const Center(
                child: CircularProgressIndicator(),
              ),
            )
          : examList.isEmpty
              ? Center(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.hourglass_empty_outlined, size: 100.sp),
                      CommonText.medium(
                        'No Record Found',
                        size: 16.sp,
                        color: kDarkGreyColor,
                        overflow: TextOverflow.fade,
                      ),
                    ],
                  ),
                )
              : Padding(
                  padding: EdgeInsets.symmetric(horizontal: 10.sp),
                  child: ListView.builder(
                    shrinkWrap: true,
                    itemCount: examList.length,
                    padding: EdgeInsets.only(top: 10.sp),
                    itemBuilder: (BuildContext c, int index) {
                      Exam data = examList[index];
                      return InkWell(
                        onTap: () {
                          //Navigator.push(context);
                        },
                        child: leadsCard(data, context),
                      );
                    },
                  ),
                ),
    );
  }

  Widget leadsCard(Exam data, BuildContext context) {
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
                            color: colorGaryText),
                        child: CommonText.regular(data.ename ?? "",
                                size: 10.sp,
                                color: Colors.white,
                                overflow: TextOverflow.fade)
                            .paddingOnly(left: 5, right: 5, bottom: 2, top: 2),
                      ),
                    ),
                    gap(10.w),
                    Container(
                      decoration: const BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(5)),
                          color: colorGaryText),
                      child: CommonText.regular(data.tname ?? "",
                              size: 10.sp,
                              color: Colors.white,
                              overflow: TextOverflow.fade)
                          .paddingOnly(left: 5, right: 5, bottom: 2, top: 2),
                    ),
                  ],
                ),
                SizedBox(
                  height: 5.h,
                ),
                CommonText.medium(data.ced ?? "",
                    size: 13.sp,
                    color: Colors.black,
                    overflow: TextOverflow.fade),
                gap(15.0),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    InkWell(
                      onTap: () {
                        callApiExamStudents(data.id, context);
                      },
                      child: SvgPicture.asset(
                        colorFilter: const ColorFilter.mode(
                          Colors.black,
                          BlendMode.srcIn,
                        ),
                        AssetsUtils.tag,
                        width: 15.sp,
                        height: 15.sp,
                      ).paddingAll(10),
                    ),
                    InkWell(
                      onTap: () {
                        Navigator.of(context).pushNamed(
                            AddSubjectScreen.routeName,
                            arguments: data);
                      },
                      child: SvgPicture.asset(
                        colorFilter: const ColorFilter.mode(
                          Colors.black,
                          BlendMode.srcIn,
                        ),
                        AssetsUtils.book,
                        width: 15.sp,
                        height: 15.sp,
                      ).paddingAll(10),
                    ),
                    InkWell(
                      onTap: () {
                        callApiExamSubjects(data.id);
                      },
                      child: SvgPicture.asset(
                        colorFilter: const ColorFilter.mode(
                          Colors.black,
                          BlendMode.srcIn,
                        ),
                        AssetsUtils.news,
                        width: 15.sp,
                        height: 15.sp,
                      ).paddingAll(10),
                    ),
                    InkWell(
                      onTap: () {
                        Navigator.of(context).pushNamed(
                            AddExamAttendanceScreen.routeName,
                            arguments: data);
                      },
                      child: SvgPicture.asset(
                        colorFilter: const ColorFilter.mode(
                          Colors.black,
                          BlendMode.srcIn,
                        ),
                        AssetsUtils.calendar,
                        width: 15.sp,
                        height: 15.sp,
                      ).paddingAll(10),
                    ),
                    InkWell(
                      onTap: () {
                        callApiGenerateRank(data.id);
                      },
                      child: SvgPicture.asset(
                        colorFilter: const ColorFilter.mode(
                          Colors.black,
                          BlendMode.srcIn,
                        ),
                        AssetsUtils.newspaper,
                        width: 15.sp,
                        height: 15.sp,
                      ).paddingAll(10),
                    ),
                    /*InkWell(
                      onTap: () {},
                      child: SvgPicture.asset(
                        colorFilter: const ColorFilter.mode(
                          Colors.black,
                          BlendMode.srcIn,
                        ),
                        AssetsUtils.delete,
                        width: 15.sp,
                        height: 15.sp,
                      ).paddingAll(10),
                    )*/
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

  bool _isChecked = false;

  void showCustomStudentDialog(BuildContext context, String examId) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          insetPadding: EdgeInsets.zero,
          child: LayoutBuilder(
            builder: (context, constraints) {
              return StatefulBuilder(
                builder: (BuildContext context, StateSetter setState) {
                  return Container(
                    width: MediaQuery.of(context).size.width - 30.sp,
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Row(
                          children: [
                            Checkbox(
                              value: _isChecked,
                              onChanged: (bool? value) {
                                setState(() {
                                  _isChecked = value ?? false;
                                  // Update all students' checkboxes
                                  for (var student in examStudentsList) {
                                    student.isCheck = _isChecked;
                                  }
                                });
                              },
                              checkColor: Colors.white,
                              activeColor: Colors.green,
                            ),
                            CommonText.bold('All',
                                size: 14.sp, color: colorBlack),
                            gap(50.w),
                            CommonText.bold('Student',
                                size: 14.sp, color: colorBlack),
                          ],
                        ),
                        ListView.builder(
                          shrinkWrap: true,
                          itemCount: examStudentsList.length,
                          itemBuilder: (BuildContext context, int index) {
                            return InkWell(
                              onTap: () {},
                              child:
                                  studentRow(examStudentsList[index], setState),
                            );
                          },
                        ),
                        gap(50.w),
                        CommonButton(
                          cornersRadius: 30,
                          text: AppTags.add,
                          onPressed: () {
                            stuIds.clear();
                            int a = 0;
                            for (int i = 0; i < examStudentsList.length; i++) {
                              if (examStudentsList[i].isCheck) {
                                a = a + 1;
                                stuIds.add(
                                    {"stuId": examStudentsList[i].studentId});
                              }
                              print("isCheck : ${examStudentsList[i].isCheck}");
                            }
                            if (a == 0) {
                              CommonFunctions.showWarningToast(
                                  "Please select any student");
                            } else {
                              callApiAssignStudents(examId, context);
                            }
                            // Handle save
                          },
                        ).paddingOnly(left: 15, right: 15, bottom: 10),
                      ],
                    ),
                  );
                },
              );
            },
          ),
        );
      },
    );
  }

  Widget studentRow(Student data, StateSetter setState) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        gap(8.0),
        Transform.scale(
          scale: 0.85,
          child: Checkbox(
            value: data.isCheck,
            onChanged: (bool? value) {
              setState(() {
                data.isCheck = value ?? false;
              });
            },
            checkColor: Colors.white,
            activeColor: Colors.green,
            materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
            visualDensity: VisualDensity.compact,
          ),
        ),
        const SizedBox(width: 80, height: 0),
        CommonText.medium(
          "${data.admissionNo} ${data.firstname}",
          size: 14.sp,
          color: colorBlack,
          overflow: TextOverflow.fade,
        ),
      ],
    );
  }

  void showCustomSubjectDialog(String examId) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          insetPadding: EdgeInsets.zero,
          child: LayoutBuilder(
            builder: (context, constraints) {
              return Container(
                width: MediaQuery.of(context).size.width - 30.sp,
                padding: const EdgeInsets.only(
                    left: 16, right: 16, top: 16, bottom: 25),
                child: ListView.builder(
                    shrinkWrap: true,
                    itemCount: examSubjectDataList.length,
                    itemBuilder: (BuildContext context, int index) {
                      return InkWell(
                          onTap: () {
                            //Navigator.push(context);
                          },
                          child:
                              subjectRow(examSubjectDataList[index], context));
                    }),
              );
            },
          ),
        );
      },
    );
  }

  Widget subjectRow(ExamSubjectData data, BuildContext c) {
    return InkWell(
      onTap: () {
        Navigator.of(c).pop();
        Navigator.of(context)
            .pushNamed(AddScoreScreen.routeName, arguments: data);
      },
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Flexible(
            fit: FlexFit.tight,
            flex: 1,
            child: CommonText.medium(
              data.name,
              size: 14.sp,
              color: colorBlack,
              overflow: TextOverflow.fade,
            ),
          ),
          CommonText.medium(
            data.date,
            size: 14.sp,
            color: colorBlack,
            overflow: TextOverflow.fade,
          ),
          gap(10.0),
          SvgPicture.asset(
            colorFilter: const ColorFilter.mode(
              Colors.black,
              BlendMode.srcIn,
            ),
            AssetsUtils.news,
            width: 15.sp,
            height: 15.sp,
          )
        ],
      ).paddingOnly(top: 10),
    );
  }
}
