import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get_utils/src/extensions/widget_extensions.dart';
import 'package:masterjee/constants.dart';
import 'package:masterjee/models/attendance_report/attendance_report_model.dart';
import 'package:masterjee/others/StorageHelper.dart';
import 'package:masterjee/providers/attendance_api.dart';
import 'package:masterjee/widgets/CommonButton.dart';
import 'package:masterjee/widgets/app_bar_two.dart';
import 'package:masterjee/widgets/app_tags.dart';
import 'package:masterjee/widgets/build_radio_option.dart';
import 'package:masterjee/widgets/custom_form_field.dart';
import 'package:masterjee/widgets/text.dart';
import 'package:provider/provider.dart';

class AttendanceReportScreen extends StatefulWidget {
  const AttendanceReportScreen({super.key});

  static String routeName = 'attendanceReportScreen';

  @override
  State<AttendanceReportScreen> createState() => _AttendanceReportScreenState();
}

class _AttendanceReportScreenState extends State<AttendanceReportScreen> {
  var _isLoading = false;
  late List<AttendanceReportData> studentList = [];
  final _fromDateController = TextEditingController();
  DateTime? _selectedFromDate;

  Future<void> callApiGetAttendanceReport(String date) async {
    setState(() {
      _isLoading = true;
    });
    try {
      AttendanceReportResponse data = await Provider.of<ClassAttendanceApi>(
              context,
              listen: false)
          .getAttendanceReport(
              StorageHelper.getStringData(StorageHelper.userIdKey).toString(),
              StorageHelper.getStringData(StorageHelper.classIdKey).toString(),
              StorageHelper.getStringData(StorageHelper.sectionIdKey)
                  .toString(),
              date);
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
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarTwo(title: AppTags.attendance),
      body: Builder(builder: (context) {
        if (_isLoading) {
          return SizedBox(
            height: MediaQuery.of(context).size.height * .5,
            child: const Center(
              child: CircularProgressIndicator(),
            ),
          );
        }
        return Padding(
          padding: EdgeInsets.symmetric(horizontal: 10.sp),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                color: kBackgroundColor,
                child: Row(
                  children: [
                    Expanded(
                      child: CustomTextField(
                        onTap: () {
                          _selectFromDate(context);
                        },
                        hintText: 'Select date',
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
                      ).paddingOnly(top: 10, bottom: 10),
                    ),
                    gap(10.0),
                    Expanded(
                        child: CommonButton(
                      cornersRadius: 30,
                      text: AppTags.submit,
                      onPressed: () {
                        setState(() {
                          if(_selectedFromDate != null) {
                            print("_selectedFromDate : ${_selectedFromDate}");
                            callApiGetAttendanceReport(_selectedFromDate.toString());
                          }
                          //_fromDateController.text = "";
                          //_selectedFromDate = null;
                        });
                      },
                    ))
                  ],
                ),
              ),
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
                                    title: "Present",
                                    value: 1,
                                    groupValue:
                                        /*studentList[index].selectedValue ??*/ 0,
                                    onChanged: (value) {
                                      setState(() {
                                        /*studentList[index].selectedValue =
                                        value!;*/
                                      });
                                    },
                                  ),
                                ),
                                Expanded(
                                  child: buildRadioOption(
                                    title: "Leave",
                                    value: 2,
                                    groupValue:
                                        /*studentList[index].selectedValue ??*/ 0,
                                    onChanged: (value) {
                                      setState(() {
                                        /*studentList[index].selectedValue =
                                        value!;*/
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
                                    title: "Absent",
                                    value: 3,
                                    groupValue:
                                        /*studentList[index].selectedValue ??*/ 0,
                                    onChanged: (value) {
                                      setState(() {
                                        /*studentList[index].selectedValue =
                                        value!;*/
                                      });
                                    },
                                  ),
                                ),
                                Expanded(
                                  child: buildRadioOption(
                                    title: "halfDay",
                                    value: 4,
                                    groupValue:
                                        /*studentList[index].selectedValue ??*/ 0,
                                    onChanged: (value) {
                                      setState(() {
                                        /*studentList[index].selectedValue =
                                        value!;*/
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
        // }
      }),
    );
  }

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
}
