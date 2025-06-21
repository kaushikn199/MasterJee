import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:masterjee/constants.dart';
import 'package:masterjee/models/common_functions.dart';
import 'package:masterjee/models/timetable_students/TimetableStudentsResponse.dart';
import 'package:masterjee/others/StorageHelper.dart';
import 'package:masterjee/providers/class_timetable.dart';
import 'package:masterjee/widgets/CommonButton.dart';
import 'package:masterjee/widgets/app_bar_two.dart';
import 'package:masterjee/widgets/app_tags.dart';
import 'package:masterjee/widgets/build_radio_option.dart';
import 'package:masterjee/widgets/custom_form_field.dart';
import 'package:masterjee/widgets/text.dart';
import 'package:provider/provider.dart';

class TimeTableStudentsScreen extends StatefulWidget {
  const TimeTableStudentsScreen({super.key});

  static String routeName = 'timeTableStudentsScreen';
  static String present = "Present";

  @override
  State<TimeTableStudentsScreen> createState() =>
      _TimeTableStudentsScreenState();
}

class _TimeTableStudentsScreenState extends State<TimeTableStudentsScreen> {
  var _isLoading = false;
  late List<TimetableStudentsData> timetableStudentsList = [];

  bool isCallFirst = false;
  String halfDay = "HalfDay";
  String absent = "Absent";
  String leave = "Leave";
  static String present = "Present";
  late String timetableId;
  late String subjectGroupId;

  @override
  void didChangeDependencies() {
    if (!isCallFirst) {
      final args =
          ModalRoute.of(context)?.settings.arguments as Map<String, dynamic>?;
      timetableId = args?['timetableId']?.toString() ?? '';
      subjectGroupId = args?['subjectGroupId']?.toString() ?? '';
      callApiTimetableStudents(timetableId, subjectGroupId);
      isCallFirst = true;
    }
    super.didChangeDependencies();
  }

  Future<void> callApiTimetableStudents(
      String timetableId, String subjectGroupId) async {
    setState(() {
      _isLoading = true;
    });
    try {
      TimetableStudentsResponse data =
          await Provider.of<ClassTimetable>(context, listen: false)
              .getTimetableStudents(
                  StorageHelper.getStringData(StorageHelper.userIdKey)
                      .toString(),
                  timetableId,
                  subjectGroupId);
      if (data.result) {
        setState(() {
          timetableStudentsList = data.data;
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
      print("callApiTimetableStudents error : ${error}");
    }
  }

  final _fromDateController = TextEditingController();
  DateTime? _selectedFromDate;

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

  List<Map<String, String>> students = [];

  Future<void> callApiSaveStudentPeriodAttendance() async {
    setState(() {
      _isLoading = true;
    });
    try {
      TimetableStudentsResponse data =
          await Provider.of<ClassTimetable>(context, listen: false)
              .saveStudentPeriodAttendance(
                  StorageHelper.getStringData(StorageHelper.userIdKey)
                      .toString(),
                  timetableId,
                  _fromDateController.text,
                  students);
      if (data.result) {
        setState(() {
          _isLoading = false;
          students = [];
          _fromDateController.text = "";
          CommonFunctions.showWarningToast(data.message);
          callApiTimetableStudents(timetableId, subjectGroupId);
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
      print("callApiSaveStudentPeriodAttendance : $error");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kBackgroundColor,
      appBar: AppBarTwo(title: AppTags.attendance),
      bottomNavigationBar: timetableStudentsList.isNotEmpty
          ? CommonButton(
              cornersRadius: 30,
              text: AppTags.submit,
              onPressed: () {
                setState(() {
                  int count = 0;
                  for (int i = 0; i < timetableStudentsList.length; i++) {
                    if (timetableStudentsList[i].selectedValue != 0 &&
                        timetableStudentsList[i].selectedValueText != null &&
                        timetableStudentsList[i].selectedValueText != "") {
                      count = count + 1;
                    }
                  }
                  if (_fromDateController.text == null ||
                      _fromDateController.text == "") {
                    CommonFunctions.showWarningToast("Please select date");
                  } else if (count == 0) {
                    CommonFunctions.showWarningToast("Please select student");
                  } else {
                    for (int i = 0; i < timetableStudentsList.length; i++) {
                      String type =
                          timetableStudentsList[i].selectedValueText ?? "";
                      if (timetableStudentsList[i].selectedValue != 0 &&
                          timetableStudentsList[i].selectedValueText != null &&
                          timetableStudentsList[i].selectedValueText != "") {
                        students.add({
                          "student_id": timetableStudentsList[i].studentId,
                          "attendance_status": type == present
                              ? "1"
                              : type == leave
                                  ? "3"
                                  : type == absent
                                      ? "4"
                                      : type == halfDay
                                          ? "6"
                                          : "0"
                        });
                      }
                    }
                    callApiSaveStudentPeriodAttendance();
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
        if (timetableStudentsList.isEmpty) {
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
                    itemCount: timetableStudentsList.length,
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
                                "${timetableStudentsList[index].firstname ?? ''} "
                                "${timetableStudentsList[index].middlename ?? ''}",
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
                                    groupValue: timetableStudentsList[index]
                                            .selectedValue ??
                                        1,
                                    onChanged: (value) {
                                      setState(() {
                                        timetableStudentsList[index].selectedValueText = present;
                                        timetableStudentsList[index].selectedValue = value;
                                      });
                                    },
                                  ),
                                ),
                                Expanded(
                                  child: buildRadioOption(
                                    title: leave,
                                    value: 2,
                                    groupValue: timetableStudentsList[index].selectedValue ?? 1,
                                    onChanged: (value) {
                                      setState(() {
                                        timetableStudentsList[index]
                                            .selectedValueText = leave;
                                        timetableStudentsList[index]
                                            .selectedValue = value;
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
                                    groupValue: timetableStudentsList[index]
                                            .selectedValue ??
                                        1,
                                    onChanged: (value) {
                                      setState(() {
                                        timetableStudentsList[index]
                                            .selectedValueText = absent;
                                        timetableStudentsList[index]
                                            .selectedValue = value;
                                      });
                                    },
                                  ),
                                ),
                                Expanded(
                                  child: buildRadioOption(
                                    title: halfDay,
                                    value: 4,
                                    groupValue: timetableStudentsList[index]
                                            .selectedValue ??
                                        1,
                                    onChanged: (value) {
                                      setState(() {
                                        timetableStudentsList[index]
                                            .selectedValueText = halfDay;
                                        timetableStudentsList[index]
                                            .selectedValue = value;
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
