import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:masterjee/constants.dart';
import 'package:masterjee/models/common_functions.dart';
import 'package:masterjee/models/ptm/grouped_students_response.dart';
import 'package:masterjee/models/ptm/ptm_response.dart';
import 'package:masterjee/models/student_progress/student_overall_model.dart';
import 'package:masterjee/others/StorageHelper.dart';
import 'package:masterjee/providers/ptm_api.dart';
import 'package:masterjee/providers/student_progress_api.dart';
import 'package:masterjee/screens/student_progress/overall_screen.dart';
import 'package:masterjee/widgets/CommonButton.dart';
import 'package:masterjee/widgets/app_bar_two.dart';
import 'package:masterjee/widgets/app_tags.dart';
import 'package:masterjee/widgets/custom_form_field.dart';
import 'package:masterjee/widgets/text.dart';
import 'package:provider/provider.dart';

class MinutebookScreen extends StatefulWidget {
  const MinutebookScreen({super.key});

  static String routeName = 'MinutebookScreen';


  @override
  State<MinutebookScreen> createState() => _MinutebookScreenState();
}

class _MinutebookScreenState extends State<MinutebookScreen> {

  String? _selectedStudent;
  String? _selectedStudentId;
  String? _selectedTemplate;
  bool _isChecked = false;
  final _fromDateController = TextEditingController();
  final parentFeedbackController = TextEditingController();
  final parentComplainController = TextEditingController();
  double _progressValue = 0.1;
  List<StudentData> studentList = [];
  var _isLoading = false;
  int selectIndex = 0;
  List<Term> data = [];

  @override
  void initState() {
    callApiGetGroupedStudents();
    super.initState();
  }

  Future<void> callApiGetGroupedStudents() async {
    try {
      GroupedStudentsResponse data =
      await Provider.of<PtmApi>(context, listen: false).getGroupedStudents(
          StorageHelper.getStringData(StorageHelper.userIdKey).toString(),
          StorageHelper.getStringData(StorageHelper.classIdKey).toString(),
          StorageHelper.getStringData(StorageHelper.sectionIdKey).toString());
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


  Future<void> callApiSavePtmAttendance(
      String studentId,
      String feedbackScore,
      String feedbackRemark,
      String parentsComplain,
      String specialCase) async {
    setState(() {
      _isLoading = true;
    });
    try {
      GroupedStudentsResponse data =
      await Provider.of<PtmApi>(context, listen: false).savePtmAttendance(
        StorageHelper.getStringData(StorageHelper.userIdKey).toString(),
          studentId,
          feedbackScore,
          feedbackRemark,
          parentsComplain,
          specialCase);
      if (data.result) {
        setState(() {
          _isLoading = false;
          selectIndex = 0;
          _selectedStudent = null;
          _progressValue = 0.1;
          parentFeedbackController.text = "";
          parentComplainController.text = "";
          _isChecked = false;
          CommonFunctions.showWarningToast(data.message);
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

  Future<void> callApiGetAllData(id) async {
    setState(() {
      _isLoading = true;
    });
    try {
      OverallResponseData d =
      await Provider.of<StudentProgressApi>(context, listen: false).getOverAllProgress(id.toString());
      setState(() {
        data = d.data?.terms ?? [];
      });
      setState(() {
        _isLoading = false;
      });
    } catch (error) {
      print(error);
      setState(() {
        _isLoading = false;
      });
    }
  }


  @override
  Widget build(BuildContext context) {
    return  Scaffold(
        backgroundColor: kBackgroundColor,
        appBar: AppBarTwo(title: AppTags.minutebook),
        bottomNavigationBar:  SizedBox(
          child: _isLoading ?
           const Center(child: CircularProgressIndicator()) :
          CommonButton(
            cornersRadius: 30,
            text: AppTags.submit,
            onPressed: () {
              setState(() {
                if(_selectedStudent == null || _selectedStudent == ""){
                  CommonFunctions.showWarningToast("Please select student");
                }else if(parentFeedbackController.text == ""){
                  CommonFunctions.showWarningToast("Please enter parent feedback");
                }else if(parentComplainController.text == ""){
                  CommonFunctions.showWarningToast("Please enter parent complain");
                }else{

                  callApiSavePtmAttendance(
                      studentList[selectIndex].studentId,
                      (_progressValue * 10).toInt().toString(),
                      parentFeedbackController.text,
                      parentComplainController.text,
                      _isChecked ? "1" : "0"
                  );
                }
              });
            },
          ).paddingOnly(left: 15,right: 15,bottom: 30) ,
        ),
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              gap(10.sp),
              Card (
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
                    hint: const CommonText('Student',
                        size: 14, color: Colors.black54),
                    value: _selectedStudent,
                    icon: const Card(
                      elevation: 0.1,
                      color: colorWhite,
                      child: Icon(Icons.keyboard_arrow_down_outlined),
                    ),
                    underline: const SizedBox(),
                    onChanged: (value) {
                    },
                    isExpanded: true,
                    items: studentList.map((cd) {
                      return DropdownMenuItem(
                        value: cd.studentId,
                        onTap: () {
                          setState(() {
                            _selectedStudent = cd.studentId;
                            for (int i = 0; i < studentList.length; i++) {
                              if (studentList[i].studentId == cd.studentId) {
                                selectIndex = i;
                                callApiGetAllData(cd.studentId);
                                break;
                              }
                            }
                          });

                        },
                        child: Text(
                          "${cd.admissionNo} - ${cd.firstname} ${cd.lastname}".toString(),
                          style: const TextStyle(color: colorBlack,
                              fontSize: 14),
                        ),
                      );
                    }).toList(),
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 10.sp),
                child: ListView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: data.length,
                    padding: EdgeInsets.only(top: 10.sp),
                    itemBuilder: (BuildContext context, int index) {
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
                        child: Center(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Align(
                                alignment: Alignment.bottomLeft,
                                child: Container(
                                  width: double.maxFinite,
                                  padding: EdgeInsets.all(10.sp),
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.only(
                                          topRight: Radius.circular(10.r), topLeft: Radius.circular(10.r)),
                                      color: kToastTextColor),
                                  child: Text(
                                    ((data[index].termName ?? "")).toUpperCase(),
                                    style: TextStyle(
                                      fontSize: 14.sp,
                                      fontWeight: FontWeight.w700,
                                    ),
                                  ),
                                ),
                              ),
                              if(data[index].exams!=[])
                                ListView.builder(
                                    shrinkWrap: true,
                                    physics: const NeverScrollableScrollPhysics(),
                                    itemCount: data[index].exams!.length,
                                    itemBuilder: (BuildContext context, int ind) {
                                      Exam examData = data[index].exams![ind];
                                      return Container(
                                        decoration: const BoxDecoration(
                                          color: kSecondBackgroundColor,
                                        ),
                                        child: Center(
                                          child: Column(
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            children: [
                                              Align(
                                                alignment: Alignment.bottomLeft,
                                                child: Container(
                                                  width: double.maxFinite,
                                                  padding: EdgeInsets.all(10.sp),
                                                  decoration: BoxDecoration(
                                                      borderRadius: BorderRadius.only(
                                                          topRight: Radius.circular(10.r),
                                                          topLeft: Radius.circular(10.r)),
                                                      color: kToastTextColor.withOpacity(0.5)),
                                                  child: Text(
                                                    ((examData.examName ?? "")).toUpperCase(),
                                                    style: TextStyle(
                                                      fontSize: 14.sp,
                                                      fontWeight: FontWeight.w700,
                                                    ),
                                                  ),
                                                ),
                                              ),
                                              SingleChildScrollView(
                                                scrollDirection: Axis.horizontal,
                                                child: Column(
                                                  crossAxisAlignment: CrossAxisAlignment.start,
                                                  children: [
                                                    // Header Row
                                                    Container(
                                                      color: Colors.grey.shade200,
                                                      padding: EdgeInsets.symmetric(vertical: 10.sp, horizontal: 12.sp),
                                                      child: Row(
                                                        children: [
                                                          SizedBox(
                                                            width: 150.sp,
                                                            child: CommonText.semiBold('Subject', size: 12.sp),
                                                          ),
                                                          SizedBox(
                                                            width: 120.sp,
                                                            child: CommonText.semiBold('Assessment', size: 12.sp),
                                                          ),
                                                          SizedBox(
                                                            width: 100.sp,
                                                            child: CommonText.semiBold('Marks Obtained', size: 12.sp, textAlign: TextAlign.center),
                                                          ),
                                                        ],
                                                      ),
                                                    ),

                                                    // Data Rows
                                                    ...examData.subjects!.map((itemRow) {
                                                      final assessments = itemRow.assessments!;
                                                      return Container(
                                                        padding: EdgeInsets.symmetric(vertical: 8.sp, horizontal: 12.sp),
                                                        decoration: BoxDecoration(
                                                          border: Border(bottom: BorderSide(color: Colors.grey.shade300)),
                                                        ),
                                                        child: Row(
                                                          crossAxisAlignment: CrossAxisAlignment.start,
                                                          children: [
                                                            // Subject Cell
                                                            SizedBox(
                                                              width: 150.sp,
                                                              child: CommonText.medium(
                                                                "${itemRow.subjectName!.capitalizeFirstOfEach}\n(${itemRow.subjectCode})",
                                                                size: 12.sp,
                                                              ),
                                                            ),

                                                            // Assessment Cell
                                                            SizedBox(
                                                              width: 120.sp,
                                                              child: Column(
                                                                crossAxisAlignment: CrossAxisAlignment.start,
                                                                children: assessments.map((assessment) {
                                                                  int length = assessments.length;
                                                                  return Padding(
                                                                    padding: EdgeInsets.symmetric(vertical: 4.sp),
                                                                    child: Container(
                                                                      width: 120.sp,
                                                                      padding: EdgeInsets.only(left: 10.sp, right: 10.sp,bottom: 10.sp),
                                                                      decoration: BoxDecoration(
                                                                        border: Border(
                                                                          bottom: length == 1  ? BorderSide.none :const BorderSide(color: Colors.grey, width: 0.8),
                                                                        ),
                                                                      ),

                                                                      child: CommonText.medium(
                                                                        assessment.assessmentName.toString(),
                                                                        size: 12.sp,
                                                                      ),
                                                                    ),
                                                                  );
                                                                }).toList(),
                                                              ),
                                                            ),

                                                            // Marks Obtained Cell
                                                            SizedBox(
                                                              width: 100.sp,
                                                              child: Column(
                                                                crossAxisAlignment: CrossAxisAlignment.center,
                                                                children: assessments.map((assessment) {
                                                                  int length = assessments.length;
                                                                  return Padding(
                                                                    padding: EdgeInsets.symmetric(vertical: 4.sp),
                                                                    child:Container(
                                                                      width: 100.sp,
                                                                      padding: EdgeInsets.only(left: 10.sp, right: 10.sp,bottom: 10.sp),
                                                                      decoration: BoxDecoration(
                                                                        border: Border(
                                                                          bottom: length == 1  ? BorderSide.none :const BorderSide(color: Colors.grey, width: 0.8),
                                                                        ),
                                                                      ),
                                                                      child: CommonText.medium(
                                                                        "${assessment.obtainedMarks} / ${assessment.maximumMarks}",
                                                                        size: 12.sp,
                                                                      ),
                                                                    ),
                                                                  );
                                                                }).toList(),
                                                              ),
                                                            ),
                                                          ],
                                                        ),
                                                      );
                                                    }).toList(),
                                                  ],
                                                ),
                                              ),
                                              gap(10.sp),
                                              Container(
                                                padding: EdgeInsets.symmetric(vertical: 10.sp, horizontal: 15.sp),
                                                decoration: BoxDecoration(
                                                    color: kToastTextColor.withOpacity(0.5)),
                                                child: Column(
                                                  children: [
                                                    Row(
                                                      crossAxisAlignment: CrossAxisAlignment.start,
                                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                      children: [
                                                        Flexible(
                                                          flex: 2,
                                                          child: Column(
                                                            crossAxisAlignment: CrossAxisAlignment.start,
                                                            children: [
                                                              rowValue('Grand Total', "${examData.totalMarks}   "),
                                                              const Divider(color: Colors.black,thickness: 1),
                                                              rowValue('Percentage', "${examData.percentage}   "),
                                                            ],
                                                          ),
                                                        ),
                                                        Container(color: Colors.black,width: 1,height: 50.sp),
                                                        Flexible(
                                                          flex: 1,
                                                          child: Column(
                                                            crossAxisAlignment: CrossAxisAlignment.start,
                                                            children: [
                                                              rowValue('  Rank', "${examData.rank}"),
                                                              const Divider(color: Colors.black,thickness: 1),
                                                              rowValue('  Grade', "${examData.grade}"),
                                                            ],
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ],
                                                ),
                                              ),
                                              gap(20.sp),
                                              if(examData.subjects!=[])
                                                SubjectChart(subjects: examData.subjects??[])
                                            ],
                                          ),
                                        ),
                                      );
                                    }),
                              if(data[index].observations!.isNotEmpty)
                                Align(
                                  alignment: Alignment.bottomLeft,
                                  child: Container(
                                    width: double.maxFinite,
                                    margin: EdgeInsets.only(top: 15.sp),
                                    padding: EdgeInsets.all(10.sp),
                                    decoration: BoxDecoration(
                                        color: kToastTextColor.withOpacity(0.5)),
                                    child: Text(
                                      "Observations".toUpperCase(),
                                      style: TextStyle(
                                        fontSize: 14.sp,
                                        fontWeight: FontWeight.w700,
                                      ),
                                    ),
                                  ),
                                ),
                              if(data[index].observations!.isNotEmpty)
                                SingleChildScrollView(
                                  scrollDirection: Axis.horizontal,
                                  child: DataTable(
                                    showCheckboxColumn: false,
                                    dividerThickness: 0.1.sp,
                                    columnSpacing: 15.sp,
                                    horizontalMargin: 10.sp,
                                    checkboxHorizontalMargin: 0,
                                    columns: [
                                      DataColumn(label: CommonText.semiBold('Name', size: 12.sp)),
                                      DataColumn(label: CommonText.semiBold('Obtain Marks', size: 12.sp)),
                                      DataColumn(label: CommonText.semiBold('Max Marks', size: 12.sp)),
                                    ],
                                    rows: data[index].observations!.map(
                                          (itemRow) {
                                        return DataRow(
                                          cells: [
                                            DataCell(
                                              CommonText.medium(
                                                  itemRow.parameterName!.capitalizeFirstOfEach,
                                                  size: 12.sp),
                                              showEditIcon: false,
                                              placeholder: false,
                                            ),
                                            DataCell(
                                              CommonText.medium(
                                                  itemRow.obtainMarks!.capitalizeFirstOfEach,
                                                  size: 12.sp),
                                              showEditIcon: false,
                                              placeholder: false,
                                            ), DataCell(
                                              CommonText.medium(
                                                  itemRow.maxMarks!.capitalizeFirstOfEach,
                                                  size: 12.sp),
                                              showEditIcon: false,
                                              placeholder: false,
                                            ),
                                          ],
                                        );
                                      },
                                    ).toList(),
                                  ),
                                ),
                            ],
                          ),
                        ),
                      );
                    }),
              ),
              if (data.isNotEmpty)
                TermSubjectBarChart(
                  chartData: extractBarChartData(data),
                ),
              gap(10.sp),
              const CommonText("Parent satisfaction score",
                  size: 14, color: colorBlack).paddingOnly(left: 20,right: 15),
              Slider(
                value: _progressValue,
                min: 0.0,
                max: 1.0,
                activeColor: colorGreen, // Progress color
                inactiveColor: colorWhite, // Background color
                onChanged: (double value) {
                  setState(() {
                    _progressValue = value; // Update progress
                  });
                },
              ),
              CommonText("${(_progressValue * 10).toInt()}%",
                  size: 14, color: colorBlack).paddingOnly(left: 20,right: 15),
              gap(15.sp),
              CustomTextField(
                keyboardType: TextInputType.text,
                borderRadius: 10.0,
                onTap: () {},
                maxLines: 3,
                hintText: 'Parents feedback',
                isRequired: true,
                validate: (value) {
                  if (value!.isEmpty) {
                    return 'Please enter parents feedback';
                  }
                  return null;
                },
                isReadonly: false,
                controller: parentFeedbackController,
                onSave: (value) {
                  // _authData['email'] = value.toString();
                  parentFeedbackController.text = value as String;
                },
              ).paddingOnly(left: 15,right: 15),
              gap(10.sp),
              CustomTextField(
                keyboardType: TextInputType.text,
                borderRadius: 10.0,
                maxLines: 3,
                onTap: () {},
                hintText: 'Parents complain',
                isRequired: true,
                validate: (value) {
                  if (value!.isEmpty) {
                    return 'Please enter parents complain';
                  }
                  return null;
                },
                isReadonly: false,
                controller: parentComplainController,
                onSave: (value) {
                  // _authData['email'] = value.toString();
                  parentComplainController.text = value as String;
                },
              ).paddingOnly(left: 15,right: 15),
              Row(
                children: [
                  Checkbox(
                    checkColor: colorWhite,
                    activeColor: colorGreen,

                    value: _isChecked,
                    onChanged: (bool? value) {
                      setState(() {
                        _isChecked = value ?? false;
                      });
                    },
                  ),
                  const CommonText('Need special attention?',
                      size: 14, color: colorBlack)
                ],
              ).paddingOnly(left: 5,right: 15),

            const SizedBox(height: 20,)
            ],
          ),
        ));
  }
}

rowValue(String key, value) {
  return Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
    Expanded(child: CommonText.bold(key, size: 12.sp, color: Colors.black)),
    SizedBox(width: 20.w),
    CommonText.medium(value, size: 14.sp, color: kDarkGreyColor, overflow: TextOverflow.fade),
  ]);
}
