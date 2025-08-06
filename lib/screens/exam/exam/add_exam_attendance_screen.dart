import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get_utils/src/extensions/widget_extensions.dart';
import 'package:masterjee/constants.dart';
import 'package:masterjee/models/common_functions.dart';
import 'package:masterjee/models/exam/ExamResponse.dart';
import 'package:masterjee/models/exam/exam/ExamAssignedStudentsResponse.dart';
import 'package:masterjee/others/StorageHelper.dart';
import 'package:masterjee/providers/exam_api.dart';
import 'package:masterjee/widgets/CommonButton.dart';
import 'package:masterjee/widgets/app_bar_two.dart';
import 'package:masterjee/widgets/app_tags.dart';
import 'package:masterjee/widgets/custom_form_field.dart';
import 'package:masterjee/widgets/text.dart';
import 'package:provider/provider.dart';

class AddExamAttendanceScreen extends StatefulWidget {
  const AddExamAttendanceScreen({super.key});

  static String routeName = 'addExamAttendanceScreen';

  @override
  State<AddExamAttendanceScreen> createState() =>
      _AddExamAttendanceScreenState();
}

class _AddExamAttendanceScreenState extends State<AddExamAttendanceScreen> {
  var _isLoading = false;
  late List<ExamAssignedStudentsData> list = [];
  late List<TextEditingController> totalPresentController = [];
  TextEditingController totalAttendanceDayController = TextEditingController();

  bool _isInitialized = false;
  late Exam exam;
  List<Map<String, dynamic>> attendances = [];

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (!_isInitialized) {
      exam = ModalRoute.of(context)!.settings.arguments as Exam;
      if (exam != null) {
        callApiGetExamAssignedStudents();
      }
      _isInitialized = true;
    }
  }

  Future<void> callApiGetExamAssignedStudents() async {
    setState(() {
      _isLoading = true;
    });
    try {
      ExamAssignedStudentsResponse data = await Provider.of<ExamApi>(context,
              listen: false)
          .getExamAssignedStudents(
              StorageHelper.getStringData(StorageHelper.userIdKey).toString(),
              exam.id);
      if (data.result) {
        setState(() {
          list = data.data;
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

  Future<void> callApiAddExamAttendance() async {
    setState(() {
      _isLoading = true;
    });
    try {
      ExamAssignedStudentsResponse data =
          await Provider.of<ExamApi>(context, listen: false).addExamAttendance(
        StorageHelper.getStringData(StorageHelper.userIdKey).toString(),
        exam.id,
        totalAttendanceDayController.text,
        attendances,
      );
      if (data.result) {
        setState(() {
          _isLoading = false;
          CommonFunctions.showWarningToast(data.message);
          Navigator.of(context).pop(true);
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
        appBar: AppBarTwo(title: AppTags.attendance),
        backgroundColor: colorGaryBG,
        bottomNavigationBar: CommonButton(
          paddingHorizontal: 10,
          cornersRadius: 10,
          text: AppTags.submit,
          onPressed: () {
            for (int i = 0; i < list.length; i++) {
              attendances.add({
              "esid": list[i].esid,
              "esatnd": totalPresentController[i].text
              });
            }
            callApiAddExamAttendance();
          },
        ).paddingOnly(bottom: 30, left:20, right: 20),
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
              if (list.isEmpty) {
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
                    CustomTextField(
                      hintText: 'Total Attendance day',
                      isReadonly: false,
                      controller: totalAttendanceDayController,
                      keyboardType: TextInputType.number,
                      onSave: (value) {
                        totalAttendanceDayController.text = value as String;
                      },
                    ),
                    gap(5.0),
                    Flexible(
                      child: ListView.builder(
                          shrinkWrap: true,
                          itemCount: list.length,
                          padding: EdgeInsets.only(top: 10.sp),
                          itemBuilder: (BuildContext context, int index) {
                            return assignmentCard(list[index], index);
                          }),
                    ),
                  ],
                ),
              );
            })
          ],
        ));
  }

  Widget assignmentCard(ExamAssignedStudentsData data, int i) {
    totalPresentController.add(TextEditingController());
    return Container(
      margin: EdgeInsets.only(left: 10,right: 10),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [

          CommonText.medium(
              "${data.firstname} ${data.lastname} ${" - ${data.fatherName}"}",
              size: 12.sp,
              color: kDarkGreyColor,
              overflow: TextOverflow.fade),
          gap(5.0),
          CustomTextField(
            hintText: 'Total Present',
            isReadonly: false,
            controller: totalPresentController[i],
            keyboardType: TextInputType.number,
            onSave: (value) {
              totalPresentController[i].text = value as String;
            },
          ),
          gap(15.0),
        ],
      ),
    );
  }
}
