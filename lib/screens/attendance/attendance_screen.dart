import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get_utils/src/extensions/export.dart';
import 'package:masterjee/constants.dart';
import 'package:masterjee/models/all_student/all_students_model.dart';
import 'package:masterjee/models/common_functions.dart';
import 'package:masterjee/others/StorageHelper.dart';
import 'package:masterjee/providers/attendance_api.dart';
import 'package:masterjee/screens/attendance/attendance_report_screen/attendance_report_screen.dart';
import 'package:masterjee/widgets/CommonButton.dart';
import 'package:masterjee/widgets/app_bar_two.dart';
import 'package:masterjee/widgets/app_tags.dart';
import 'package:masterjee/widgets/build_radio_option.dart';
import 'package:masterjee/widgets/custom_form_field.dart';
import 'package:masterjee/widgets/text.dart';
import 'package:provider/provider.dart';

class AttendanceScreen extends StatefulWidget {
  const AttendanceScreen({super.key});

  static String routeName = 'attendanceScreen';

  @override
  State<AttendanceScreen> createState() => _AttendanceScreenState();
}

class _AttendanceScreenState extends State<AttendanceScreen> {
  var _isLoading = false;
  late List<StudentData> studentList = [];

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
      if (data.result) {
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
    }
  }

  @override
  void initState() {
    callApiGetAllStudents();
    super.initState();
  }

  DateTime? _selectedFromDate;
  final _fromDateController = TextEditingController();

  Future<void> _selectFromDate(BuildContext context) async {
    final DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: _selectedFromDate ?? DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
    );
    if (pickedDate != null && pickedDate != _selectedFromDate) {
      setState(() {
        _selectedFromDate = pickedDate;
        _fromDateController.text = pickedDate.toLocalDMYDateString();
      });
    }
  }

  List<Map<String, String>> students = [
    /* {
            "student_id": 1
        }*/
  ];

  String halfDay = "HalfDay";
  String absent = "Absent";
  String leave = "Leave";
  String present = "Present";

  Future<void> callApiSaveStudentAttendance() async {
    setState(() {
      _isLoading = true;
    });
    try {
      AllStudentsResponse data = await Provider.of<ClassAttendanceApi>(context,
          listen: false)
          .saveStudentAttendance(
          StorageHelper.getStringData(StorageHelper.userIdKey).toString(),
          StorageHelper.getStringData(StorageHelper.classIdKey).toString(),
          students);
      if (data.result) {
        setState(() {
          _isLoading = false;
          setState(() {
            _fromDateController.text = "";
            CommonFunctions.showWarningToast(data.message);
            callApiGetAllStudents();
          });
        });
        return;
      } else {
        CommonFunctions.showWarningToast(data.message);
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
      appBar: AppBarTwo(title: AppTags.attendance),
      bottomNavigationBar: studentList.isNotEmpty
          ? CommonButton(
        cornersRadius: 30,
        text: AppTags.submit,
        onPressed: () {
          setState(() {
            int count = 0;
            for (int i = 0; i < studentList.length; i++) {
              if (studentList[i].selectedValue == 1) {
                count = count + 1;
              }
            }
            if (_fromDateController.text == null ||
                _fromDateController.text == "") {
              CommonFunctions.showWarningToast("Please select date");
            } else if (count == 0) {
              CommonFunctions.showWarningToast("Please select student");
            } else {
              for (int i = 0; i < studentList.length; i++) {
                String type = studentList[i].selectedValueText ?? "";
                if(studentList[i].selectedValue == 1) {
                  students.add({
                    "student_id": studentList[i].studentId,
                    "attendance_status": type == present ? "1"
                        : type == leave ? "2"
                        : type == absent ? "3"
                        : type == halfDay ? "4" : "0"
                  });
                }
              }
              callApiSaveStudentAttendance();
            }
          });
        },
      ).paddingOnly(left: 15, right: 15, bottom: 30)
          : const SizedBox(),
      body: Builder(builder: (context) {
        if (_isLoading) {
          return SizedBox(
            height: MediaQuery.of(context).size.height * .5,
            child: const Center(
              child: CircularProgressIndicator(),
            ),
          );
        }
        if (studentList.isEmpty) {
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
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              gap(10.0),
              InkWell(
                onTap: () {
                  Navigator.pushNamed(
                      context, AttendanceReportScreen.routeName);
                },
                child: Container(
                  decoration: BoxDecoration(
                    color: colorGreen,
                    border: Border.all(color: colorGreen, width: 1),
                    // Border color and width
                    borderRadius: BorderRadius.circular(20), // Rounded corners
                  ),
                  child: CommonText.medium("Attendance report",
                      size: 13, color: colorWhite)
                      .paddingOnly(top: 5, bottom: 5, left: 20, right: 20),
                ),
              ),
              gap(10.0),
              CustomTextField(
                onTap: () {
                  _selectFromDate(context);
                },
                hintText: 'Date',
                isRequired: true,
                prefixIcon: const Icon(
                  Icons.date_range_outlined,
                  color: kTextLowBlackColor,
                ),
                validate: (value) {
                  if (value!.isEmpty) {
                    return 'From Date cannot be empty';
                  }
                  return null;
                },
                isReadonly: true,
                controller: _fromDateController,
                onSave: (value) {
                  // _authData['email'] = value.toString();
                  _fromDateController.text = value as String;
                },
              ),
              gap(10.0),
              Expanded(
                child: ListView.builder(
                    shrinkWrap: true,
                    itemCount: studentList.length,
                    itemBuilder: (BuildContext context, int index) {
                      return Container(
                        margin: EdgeInsets.all(10.sp),
                        padding: EdgeInsets.all(10.sp),
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
                            CommonText.bold(
                                "${studentList[index].firstname ?? ''} "
                                    "${studentList[index].middlename ?? ''}",
                                size: 14,
                                color: colorBlack),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Expanded(
                                  child: buildRadioOption(
                                    title: present,
                                    value: 1,
                                    groupValue:
                                    studentList[index].selectedValue ?? 0,
                                    onChanged: (value) {
                                      setState(() {
                                        studentList[index].selectedValueText =
                                            present;
                                        studentList[index].selectedValue =
                                        value!;
                                      });
                                    },
                                  ),
                                ),
                                Expanded(
                                  child: buildRadioOption(
                                    title: leave,
                                    value: 2,
                                    groupValue:
                                    studentList[index].selectedValue ?? 0,
                                    onChanged: (value) {
                                      setState(() {
                                        studentList[index].selectedValueText =
                                            leave;
                                        studentList[index].selectedValue =
                                        value!;
                                      });
                                    },
                                  ),
                                ),
                              ],
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Expanded(
                                  child: buildRadioOption(
                                    title: absent,
                                    value: 3,
                                    groupValue:
                                    studentList[index].selectedValue ?? 0,
                                    onChanged: (value) {
                                      setState(() {
                                        studentList[index].selectedValueText =
                                            absent;
                                        studentList[index].selectedValue =
                                        value!;
                                      });
                                    },
                                  ),
                                ),
                                Expanded(
                                  child: buildRadioOption(
                                    title: halfDay,
                                    value: 4,
                                    groupValue:
                                    studentList[index].selectedValue ?? 0,
                                    onChanged: (value) {
                                      setState(() {
                                        studentList[index].selectedValueText =
                                            halfDay;
                                        studentList[index].selectedValue =
                                        value!;
                                      });
                                    },
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      );
                    }),
              ),
            ],
          ),
        );
      }),
    );
  }
}