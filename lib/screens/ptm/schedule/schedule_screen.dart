import 'dart:core';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:masterjee/constants.dart';
import 'package:masterjee/models/common_functions.dart';
import 'package:masterjee/models/ptm/get_ptm_List_response.dart';
import 'package:masterjee/models/ptm/grouped_students_response.dart';
import 'package:masterjee/others/StorageHelper.dart';
import 'package:masterjee/providers/ptm_api.dart';
import 'package:masterjee/widgets/CommonButton.dart';
import 'package:masterjee/widgets/app_bar_two.dart';
import 'package:masterjee/widgets/app_tags.dart';
import 'package:masterjee/widgets/custom_form_field.dart';
import 'package:masterjee/widgets/text.dart';
import 'package:provider/provider.dart';

class ScheduleScreen extends StatefulWidget {
  const ScheduleScreen({super.key});

  static String routeName = 'ScheduleScreen';

  @override
  State<ScheduleScreen> createState() => _ScheduleScreenState();
}

class _ScheduleScreenState extends State<ScheduleScreen> {
  String? _selectedSubject;
  int selectedPTMIndex = -1;
  int selectedSlotIndex = -1;
  String? _selectedTemplate;
  bool _isChecked = false;
  final fromRollNoController = TextEditingController();
  final toRollNoController = TextEditingController();
  var _isLoading = false;
  List<PTMData> ptmList = [];
  List<StudentData> studentList = [];
  List<StudentData> studentListTemp = [];
  late int inputFromRollNo = 0;
  late int inputToRollNo = 0;
  List<Map<String, String>> students = [
    /* {
            "student_id": 1
        }*/
  ];

  @override
  void initState() {
    callApiGetPtmList();
    callApiGetGroupedStudents();
    toRollNoController.addListener(() {
      filterStudentList();
    });
    fromRollNoController.addListener(() {
      filterStudentList();
    });
    super.initState();
  }

  void filterStudentList() {
    setState(() {
      inputFromRollNo = int.tryParse(fromRollNoController.text) ?? 0;
      inputToRollNo = int.tryParse(toRollNoController.text) ?? 0;
      studentListTemp = studentList
          .where((student) =>
              int.tryParse(student.rollNo) != null &&
              int.parse(student.rollNo) <= inputToRollNo &&
              int.parse(student.rollNo) >= inputFromRollNo)
          .toList();
    });
  }

  Future<void> callApiGetPtmList() async {
    setState(() {
      _isLoading = true;
    });
    try {
      PtmListResponse data = await Provider.of<PtmApi>(context, listen: false)
          .getPtmList(
              StorageHelper.getStringData(StorageHelper.userIdKey).toString());
      if (data.result) {
        setState(() {
          ptmList =
              data.data.where((ptm) => ptm.ptmTitle.trim().isNotEmpty).toList();
          _isLoading = false;
        });
        return;
      } else {
        setState(() {
          _isLoading = false;
        });
      }
    } catch (error) {
      print("callApiGetPtmList : $error");
      setState(() {
        _isLoading = false;
      });
    }
  }

  Future<void> callApiGetGroupedStudents() async {
    try {
      GroupedStudentsResponse data =
          await Provider.of<PtmApi>(context, listen: false).getGroupedStudents(
              StorageHelper.getStringData(StorageHelper.userIdKey).toString(),
              StorageHelper.getStringData(StorageHelper.classIdKey).toString(),
              StorageHelper.getStringData(StorageHelper.sectionIdKey)
                  .toString());
      if (data.result) {
        setState(() {
          studentList = data.data;
        });
        return;
      }
    } catch (error) {
      print("callApiGetGroupedStudents : $error");
    }
  }

  Future<void> callApiSavePtmSchedules(String ptmId, String ptsId) async {
    setState(() {
      _isLoading = true;
    });
    try {
      GroupedStudentsResponse data =
          await Provider.of<PtmApi>(context, listen: false).savePtmSchedule(
              StorageHelper.getStringData(StorageHelper.userIdKey).toString(),
              ptmId,
              ptsId,
              students);
      if (data.result) {
        setState(() {
          _isLoading = false;
        });
        setState(() {
          setState(() {
            _isLoading = false;
            studentListTemp.clear();
            _selectedSubject = null;
            _selectedTemplate = null;
            fromRollNoController.text = "";
            toRollNoController.text = "";
            students.clear();
            CommonFunctions.showWarningToast(data.message);
          });
        });
        return;
      }else{
        setState(() {
          _isLoading = false;
        });
      }
    } catch (error) {
      setState(() {
        _isLoading = false;
      });
      print("callApiSavePtmSchedules : $error");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: kBackgroundColor,
        appBar: AppBarTwo(title: AppTags.schedule),
        bottomNavigationBar: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
          child: SizedBox(

            child: _isLoading
                ?
            const Center(child: CircularProgressIndicator())
                :
            CommonButton(
              cornersRadius: 30,
              text: AppTags.submit,
              onPressed: () {
                setState(() {
                  if (_selectedSubject == "") {
                    CommonFunctions.showWarningToast("Please select subject");
                  } else if (_selectedTemplate == "") {
                    CommonFunctions.showWarningToast("Please select slot");
                  } else if (fromRollNoController.text == "") {
                    CommonFunctions.showWarningToast("Please enter roll no from");
                  } else if (toRollNoController.text == "") {
                    CommonFunctions.showWarningToast("Please enter roll no to");
                  } else {
                    int count = 0;
                    for (int i = 0; i < studentListTemp.length; i++) {
                      if (studentListTemp[i].isChecked) {
                        count = count + 1;
                      }
                    }
                    if (count == 0) {
                      CommonFunctions.showWarningToast("Please select student");
                    } else {
                      for (int i = 0; i < studentListTemp.length; i++) {
                        if (studentListTemp[i].isChecked) {
                          students.add({"student_id": studentListTemp[i].studentId});
                        }
                      }
                      callApiSavePtmSchedules(ptmList[selectedPTMIndex].ptmId,
                      ptmList[selectedPTMIndex].slots[selectedSlotIndex].ptsId);
                    }
                  }
                });
              },
            ),
          ),
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              gap(10.sp),
              Card(
                margin: const EdgeInsets.only(left: 15, right: 15),
                elevation: 0.1,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                color: colorWhite,
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 10, vertical: 2),
                  child: DropdownButton(
                    hint: const CommonText('Select PTM...',
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
                        _selectedTemplate = null;
                      });
                    },
                    isExpanded: true,
                    items: ptmList.map((cd) {
                      return DropdownMenuItem(
                        value: cd.ptmId,
                        onTap: () {
                          setState(() {
                            _selectedSubject = cd.ptmTitle;
                            _selectedTemplate = null;
                            for (int i = 0; i < ptmList.length; i++) {
                              if (ptmList[i].ptmId == cd.ptmId) {
                                selectedPTMIndex = i;
                                print("selectedPTMIndex : $selectedPTMIndex");
                                break;
                              }
                            }
                          });
                        },
                        child: Text(
                          cd.ptmTitle.toString(),
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
              gap(10.sp),
              selectedPTMIndex == -1
                  ? const SizedBox()
                  : Card(
                      margin: const EdgeInsets.only(left: 15, right: 15),
                      elevation: 0.1,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      color: colorWhite,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 10, vertical: 2),
                        child: DropdownButton(
                          hint: const CommonText('Select slot...',
                              size: 14, color: Colors.black54),
                          value: _selectedTemplate,
                          icon: const Card(
                            elevation: 0.1,
                            color: colorWhite,
                            child: Icon(Icons.keyboard_arrow_down_outlined),
                          ),
                          underline: const SizedBox(),
                          onChanged: (value) {
                            setState(() {
                              _selectedTemplate = null;
                              _selectedTemplate = value.toString();
                              /*for (int i = 0; i < template.length; i++) {
                          if (ptmList[selectedPTMIndex].slots[i].ptmId.toString().toLowerCase() ==
                              value.toString().toLowerCase()) {
                            break;
                          }
                        }*/
                            });
                          },
                          isExpanded: true,
                          items: ptmList[selectedPTMIndex].slots.map((cd) {
                            return DropdownMenuItem(
                              value: cd.ptsId,
                              onTap: () {
                                setState(() {
                                  for (int i = 0;
                                      i <
                                          ptmList[selectedPTMIndex]
                                              .slots
                                              .length;
                                      i++) {
                                    if (ptmList[selectedPTMIndex]
                                            .slots[i]
                                            .ptsId ==
                                        cd.ptsId) {
                                      selectedSlotIndex = i;
                                      print(
                                          "selectedSlotIndex : $selectedPTMIndex");
                                      break;
                                    }
                                  }
                                });
                              },
                              child: Text(
                                "${formatTime(cd.timeFrom)} - ${formatTime(cd.timeTo)}",
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
              gap(10.sp),
              CustomTextField(
                keyboardType: TextInputType.number,
                borderRadius: 10.0,
                onTap: () {},
                hintText: 'Roll no from',
                isRequired: true,
                validate: (value) {
                  if (value!.isEmpty) {
                    return 'Please enter Roll no from';
                  }
                  return null;
                },
                isReadonly: false,
                controller: fromRollNoController,
                onSave: (value) {
                  // _authData['email'] = value.toString();
                  fromRollNoController.text = value as String;
                },
              ).paddingOnly(left: 15, right: 15),
              gap(10.sp),
              CustomTextField(
                keyboardType: TextInputType.number,
                borderRadius: 10.0,
                onTap: () {},
                hintText: 'Roll no to',
                isRequired: true,
                validate: (value) {
                  if (value!.isEmpty) {
                    return 'Please enter Roll no to';
                  }
                  return null;
                },
                isReadonly: false,
                controller: toRollNoController,
                onSave: (value) {
                  // _authData['email'] = value.toString();
                  toRollNoController.text = value as String;
                },
              ).paddingOnly(left: 15, right: 15),
              studentListTemp.isNotEmpty
                  ? Container(
                      padding: const EdgeInsets.symmetric(horizontal: 15),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Checkbox(
                            checkColor: colorWhite,
                            activeColor: colorGreen,
                            value: _isChecked,
                            onChanged: (bool? value) {
                              setState(() {
                                _isChecked = value ?? false;
                                for (int i = 0;
                                    i < studentListTemp.length;
                                    i++) {
                                  studentListTemp[i].isChecked = _isChecked;
                                }
                              });
                            },
                          ),
                          gap(10.w),
                          const Expanded(
                            child: CommonText(
                              'Student',
                              size: 14,
                              color: colorBlack,
                            ),
                          ),
                        ],
                      ),
                    )
                  : const SizedBox(),
              ListView.builder(
                  physics: const NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  itemCount: studentListTemp.length,
                  itemBuilder: (BuildContext context, int index) {
                    return assignmentCard(studentListTemp[index]);
                  }),
              const SizedBox(
                height: 30,
              )
            ],
          ),
        ));
  }

  Widget assignmentCard(StudentData data) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 15),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Checkbox(
            checkColor: colorWhite,
            activeColor: colorGreen,
            value: data.isChecked,
            onChanged: (bool? value) {
              setState(() {
                data.isChecked = value ?? false;
              });
            },
          ),
          gap(10.w),
          Expanded(
            child: CommonText(
              '${data.admissionNo} - ${data.firstname} ${data.lastname}',
              size: 14,
              color: colorBlack,
            ),
          ),
        ],
      ),
    );
  }
}
