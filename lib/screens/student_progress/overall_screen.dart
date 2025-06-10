import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:masterjee/constants.dart';
import 'package:masterjee/models/all_student/all_students_model.dart';
import 'package:masterjee/models/student_progress/student_overall_model.dart';
import 'package:masterjee/others/StorageHelper.dart';
import 'package:masterjee/providers/attendance_api.dart';
import 'package:masterjee/providers/student_progress_api.dart';
import 'package:masterjee/widgets/app_bar_two.dart';
import 'package:masterjee/widgets/app_tags.dart';
import 'package:masterjee/widgets/text.dart';
import 'package:provider/provider.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class OverallScreen extends StatefulWidget {
  const OverallScreen({super.key});

  static String routeName = 'OverallScreen';

  @override
  State<OverallScreen> createState() => _OverallScreenState();
}

class _OverallScreenState extends State<OverallScreen> {
  String? _selectedStudent;

  List<StudentData> studentList = [];
  List<Term> data = [];

  Future<void> callApiGetAllStudents() async {
    try {
      AllStudentsResponse data = await Provider.of<ClassAttendanceApi>(context, listen: false).getAllStudents(
          StorageHelper.getStringData(StorageHelper.userIdKey).toString(),
          StorageHelper.getStringData(StorageHelper.classIdKey).toString(),
          StorageHelper.getStringData(StorageHelper.sectionIdKey).toString());
      if (data.result) {
        setState(() {
          studentList = data.data??[];
        });
        return;
      }
    } catch (error) {
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

  String? _selectedStudentId;
  bool _isLoading = false;

  @override
  void initState() {
    callApiGetAllStudents();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBarTwo(title: AppTags.overall),
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
                color: kBackgroundColor,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 2),
                  child: DropdownButton(
                    hint: const CommonText(AppTags.student, size: 14, color: Colors.black54),
                    value: _selectedStudent,
                    icon: const Card(
                      elevation: 0.1,
                      color: kBackgroundColor,
                      child: Icon(Icons.keyboard_arrow_down_outlined),
                    ),
                    underline: const SizedBox(),
                    onChanged: (value) {},
                    isExpanded: true,
                    items: studentList.map((cd) {
                      return DropdownMenuItem(
                        value: cd.firstname,
                        onTap: () {
                          setState(() {
                            _selectedStudent = cd.firstname;
                            for (int i = 0; i < studentList.length; i++) {
                              if (studentList[i].firstname.toString().toLowerCase() ==
                                  cd.firstname.toString().toLowerCase()) {
                                _selectedStudentId = studentList[i].id.toString();
                                break;
                              }
                            }
                            callApiGetAllData(_selectedStudentId.toString());
                          });
                        },
                        child: Text(
                          "${cd.admissionNo} - ${cd.firstname} ${cd.lastname}".toString(),
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
                )
            ],
          ),
        ));
  }

  rowValue(String key, value) {
    return Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
      Expanded(child: CommonText.bold(key, size: 12.sp, color: Colors.black)),
      SizedBox(width: 20.w),
      CommonText.medium(value, size: 14.sp, color: kDarkGreyColor, overflow: TextOverflow.fade),
    ]);
  }
}

class TermSubjectBarChart extends StatelessWidget {
  final List<SubjectMark> chartData;

  TermSubjectBarChart({required this.chartData});

  @override
  Widget build(BuildContext context) {
    // Extract all unique terms from the data
    final allTerms = chartData.map((e) => e.term).toSet().toList();
    allTerms.sort(); // Optional: sort terms alphabetically or in order

    // Extract all unique subjects
    final subjects = chartData.map((e) => e.subject).toSet().toList();

    return SfCartesianChart(
      legend: const Legend(isVisible: true),
      backgroundColor: Colors.white,
      tooltipBehavior: TooltipBehavior(enable: true),
      primaryXAxis: CategoryAxis(
        title: const AxisTitle(text: 'Terms'),
        // Assign all terms explicitly to avoid skipping
        minimum: 0,
        maximum: allTerms.length - 1,
        interval: 1,
      ),
      primaryYAxis: const NumericAxis(
        minimum: 0,
        maximum: 100,
        interval: 20,
        title: AxisTitle(text: 'Marks (%)'),
      ),
      series: subjects.map((subject) {
        // For each subject, create data points for ALL terms
        final List<SubjectMark> data = allTerms.map((term) {
          final mark = chartData.firstWhere(
            (e) => e.subject == subject && e.term == term,
            orElse: () => SubjectMark(term: term, subject: subject, marks: 0),
          );
          return mark;
        }).toList();

        return ColumnSeries<SubjectMark, String>(
          name: subject,
          dataSource: data,
          xValueMapper: (SubjectMark mark, _) => mark.term,
          yValueMapper: (SubjectMark mark, _) => mark.marks,
        );
      }).toList(),
    );
  }
}

List<SubjectMark> extractBarChartData(List<Term> json) {
  final List<SubjectMark> chartData = [];

  final terms = json;
  for (final term in terms) {
    final termName = term.termName.toString();

    for (final exam in term.exams!) {
      for (final subject in exam.subjects!) {
        String subjectCode = subject.subjectCode.toString();
        double totalObtained = 0;
        double totalMax = 0;

        for (final assessment in subject.assessments!) {
          totalObtained += double.tryParse(assessment.obtainedMarks ?? "0") ?? 0;
          totalMax += double.tryParse(assessment.maximumMarks ?? "0") ?? 0;
        }

        if (totalMax >= 0) {
          double percent = (totalObtained / totalMax) * 100;
          chartData.add(SubjectMark(
            term: termName,
            subject: subjectCode,
            marks: percent,
          ));
        }
      }
    }
  }

  return chartData;
}

class SubjectMark {
  final String term;
  final String subject;
  final double marks;

  SubjectMark({required this.term, required this.subject, required this.marks});
}


final Random _random = Random();

Color getRandomColor() {
  return Color.fromARGB(
    255, // Fully opaque
    _random.nextInt(256),
    _random.nextInt(256),
    _random.nextInt(256),
  );
}
class SubjectPercentage {
  final String subjectCode;
  final double obtainedMarks;

  SubjectPercentage({required this.subjectCode, required this.obtainedMarks});
}
class SubjectChart extends StatelessWidget {
  final List<Subject> subjects;

  SubjectChart({super.key, required this.subjects});

  List<SubjectPercentage> _generateChartData() {
    return subjects.map((subject) {
      double totalObtained = 0;
      for (var assessment in subject.assessments ?? []) {
        totalObtained += double.tryParse(assessment.obtainedMarks ?? "0") ?? 0;
      }
      return SubjectPercentage(
        subjectCode: subject.subjectCode ?? '',
        obtainedMarks: totalObtained,
      );
    }).toList();
  }

  double _calculateTotalMaxMarks() {
    double maxY = 0;
    for (var subject in subjects) {
      final total = subject.assessments?.fold<double>(0, (sum, assessment) {
        return sum + (double.tryParse(assessment.maximumMarks ?? '0') ?? 0);
      }) ?? 0;
      if (total > maxY) maxY = total;
    }
    return maxY;
  }

  @override
  Widget build(BuildContext context) {
    final chartData = _generateChartData();
    final maxTotalMarks = _calculateTotalMaxMarks();

    // Pre-generate random colors so each bar stays consistent
    final List<Color> barColors = List.generate(chartData.length, (_) => getRandomColor());

    return SfCartesianChart(
      primaryXAxis: const CategoryAxis(),
      primaryYAxis: NumericAxis(
        minimum: 0,
        maximum: (maxTotalMarks < 20) ? 20 : (maxTotalMarks + 20).clamp(40, maxTotalMarks + 100),
        interval: 20,
      ),
      series: <CartesianSeries>[
        ColumnSeries<SubjectPercentage, String>(
          dataSource: chartData,
          xValueMapper: (SubjectPercentage sp, _) => sp.subjectCode,
          yValueMapper: (SubjectPercentage sp, _) => sp.obtainedMarks,
          pointColorMapper: (_, index) => barColors[index],
          dataLabelSettings: const DataLabelSettings(isVisible: true),
        ),
      ],
    );
  }
}
