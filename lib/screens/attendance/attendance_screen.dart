import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get_utils/src/extensions/export.dart';
import 'package:masterjee/constants.dart';
import 'package:masterjee/models/all_student/all_students_model.dart';
import 'package:masterjee/others/StorageHelper.dart';
import 'package:masterjee/providers/attendance_api.dart';
import 'package:masterjee/screens/attendance/attendance_report_screen/attendance_report_screen.dart';
import 'package:masterjee/widgets/CommonButton.dart';
import 'package:masterjee/widgets/app_bar_two.dart';
import 'package:masterjee/widgets/app_tags.dart';
import 'package:masterjee/widgets/build_radio_option.dart';
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarTwo(title: AppTags.attendance),
      bottomNavigationBar: studentList.isNotEmpty
          ? CommonButton(
              cornersRadius: 30,
              text: AppTags.submit,
              onPressed: () {
                setState(() {});
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
              InkWell(
                onTap: () {
                  Navigator.pushNamed(
                      context, AttendanceReportScreen.routeName);
                },
                child: const CommonText.semiBold("Attendance report",
                        decoration: TextDecoration.underline,
                        size: 14,
                        color: colorGreen)
                    .paddingAll(10),
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
                                        studentList[index].selectedValue ?? 0,
                                    onChanged: (value) {
                                      setState(() {
                                        studentList[index].selectedValue =
                                            value!;
                                      });
                                    },
                                  ),
                                ),
                                Expanded(
                                  child: buildRadioOption(
                                    title: "Leave",
                                    value: 2,
                                    groupValue:
                                        studentList[index].selectedValue ?? 0,
                                    onChanged: (value) {
                                      setState(() {
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
                                    title: "Absent",
                                    value: 3,
                                    groupValue:
                                        studentList[index].selectedValue ?? 0,
                                    onChanged: (value) {
                                      setState(() {
                                        studentList[index].selectedValue =
                                            value!;
                                      });
                                    },
                                  ),
                                ),
                                Expanded(
                                  child: buildRadioOption(
                                    title: "halfDay",
                                    value: 4,
                                    groupValue:
                                        studentList[index].selectedValue ?? 0,
                                    onChanged: (value) {
                                      setState(() {
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
