import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:masterjee/constants.dart';
import 'package:masterjee/models/all_student/all_students_model.dart';
import 'package:masterjee/models/student_behavior/student_behavior_response.dart';
import 'package:masterjee/others/ApiHelper.dart';
import 'package:masterjee/others/StorageHelper.dart';
import 'package:masterjee/providers/attendance_api.dart';
import 'package:masterjee/providers/student_behavior_api.dart';
import 'package:masterjee/screens/student_behaviour/behaviour_screen.dart';
import 'package:masterjee/screens/student_behaviour/incident_screen.dart';
import 'package:masterjee/widgets/CommonButton.dart';
import 'package:masterjee/widgets/app_bar_two.dart';
import 'package:masterjee/widgets/app_tags.dart';
import 'package:masterjee/widgets/text.dart';
import 'package:provider/provider.dart';

class StudentBehaviourScreen extends StatefulWidget {
  const StudentBehaviourScreen({super.key});

  static String routeName = 'StudentBehaviourScreen';

  @override
  State<StudentBehaviourScreen> createState() => _StudentBehaviourScreenState();
}

class _StudentBehaviourScreenState extends State<StudentBehaviourScreen> {

  late List<StudentData> studentList = [];
  late List<StudentBehaviorData> studentBehaviorList = [];
  late List<KeyPointData> keyPointList = [];

  Future<void> callApiGetAllStudents() async {
    setState(() {
      _isLoading = true;
    });
    try {
      AllStudentsResponse data = await Provider.of<ClassAttendanceApi>(context,
          listen: false)
          .getAllStudents(
          StorageHelper.getStringData(StorageHelper.userIdKey).toString(),
          StorageHelper.getStringData(StorageHelper.classIdKey).toString(),
          StorageHelper.getStringData(StorageHelper.sectionIdKey)
              .toString());
      if (data.result!) {
        setState(() {
          studentList = data.data ?? [];
          _isLoading = false;
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
  String? _selectedSubject;
  String? _selectedSubjectId;
  var _isLoading = false;
  var _isChecked = false;

  Future<void> callApiStudentBehaviour() async {
    setState(() {
      _isLoading = true;
    });
    try {
      StudentBehaviorResponse data = await Provider.of<StudentBehaviorApi>(context,
          listen: false).studentBehaviour(
          StorageHelper.getStringData(StorageHelper.userIdKey).toString(),
          StorageHelper.getStringData(StorageHelper.classIdKey).toString(),
          StorageHelper.getStringData(StorageHelper.sectionIdKey).toString());
      if (data.result ?? false) {
        setState(() {
          studentBehaviorList = data.students ?? [];
          keyPointList = data.keyPoints ?? [];
          _isLoading = false;
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


  @override
  void initState() {
    callApiGetAllStudents();
    callApiStudentBehaviour();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarTwo(title: AppTags.studentBehavior),
      body: Container(
        color: kSecondBackgroundColor,
        child: Stack(
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
              if (keyPointList.isEmpty) {
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
                            text: AppTags.incident,
                            onPressed: () {
                              Navigator.pushNamed(
                                  context, IncidentScreen.routeName);
                            },
                          ),
                        ),
                      ],
                    ),
                    Card(
                      elevation: 0.1,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20.sp),
                      ),
                      color: colorWhite,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 10, vertical: 2),
                        child: DropdownButton(
                          hint: const CommonText(AppTags.student,
                              size: 14, color: Colors.black54),
                          value: _selectedSubject,
                          icon: const Card(
                            elevation: 0.1,
                            color: colorWhite,
                            child: Icon(Icons.keyboard_arrow_down_outlined),
                          ),
                          underline: const SizedBox(),
                          onChanged: (value) {
                            setState(() {
                              _selectedSubject = null;
                              _selectedSubject = value.toString();
                              for (int i = 0; i < studentList.length; i++) {
                                if (studentList[i].firstname.toString().toLowerCase() ==
                                    value.toString().toLowerCase()) {
                                  _selectedSubjectId = studentList[i].id.toString();
                                  break;
                                }
                              }
                            });
                          },
                          isExpanded: true,
                          items: studentList.map((cd) {
                            return DropdownMenuItem(
                              value: cd.firstname,
                              onTap: () {
                                setState(() {
                                  _selectedSubject = cd.firstname;
                                  for (int i = 0;
                                  i < studentList.length;
                                  i++) {
                                    if (studentList[i].firstname.toString()
                                        .toLowerCase() == cd.firstname.toString().toLowerCase()) {
                                      _selectedSubjectId =
                                          studentList[i].id.toString();
                                      break;
                                    }
                                  }
                                });
                              },
                              child: Text(
                                cd.firstname.toString(),
                                style: const TextStyle(
                                  color: colorBlack,
                                  fontSize: 14,
                                ),
                              ),
                            );
                          }).toList(),
                        ),
                      ),
                    ),
                    Expanded(
                      child: ListView.builder(
                        itemCount: keyPointList.length,
                        padding: EdgeInsets.only(top: 10.sp),
                        itemBuilder: (BuildContext context, int index) {
                          return assignmentCard(keyPointList[index]);
                        },
                      ),
                    ),
                    gap(10.0),
                    CommonButton(
                      cornersRadius: 30,
                      text: AppTags.submit,
                      onPressed: () {
                        //checkValidation(context);
                      },
                    ),
                    gap(10.0)
                  ],
                ),
              );
            }),
          ],
        ),
      ),
    );
  }

  Widget assignmentCard(KeyPointData data) {
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
            padding: EdgeInsets.all(20.sp),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    CommonText.semiBold(data.title ?? "",
                        size: 14.sp,
                        color: kDarkGreyColor,
                        overflow: TextOverflow.fade),
                    const Expanded(child:SizedBox()),
                    CommonText.regular("Points : ${data.point}" ?? "",
                        size: 12.sp,
                        color: kDarkGreyColor,
                        overflow: TextOverflow.fade),
                    Checkbox(
                      tristate: true,
                      checkColor: colorWhite,
                      activeColor: colorGreen,
                      value: data.isSelected,
                      onChanged: (bool? value) {
                        setState(() {
                          data.isSelected = value ?? false ;
                        });
                      },
                    ),

                  ],
                ),
                gap(10.sp),
                CommonText.medium(data.description ?? "",
                    size: 11.sp,
                    color: kDarkGreyColor,
                    overflow: TextOverflow.fade),
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
