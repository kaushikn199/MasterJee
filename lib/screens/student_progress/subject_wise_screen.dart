import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:masterjee/constants.dart';
import 'package:masterjee/models/all_student/all_students_model.dart';
import 'package:masterjee/models/all_student/student_template_model.dart';
import 'package:masterjee/models/common_functions.dart';
import 'package:masterjee/others/StorageHelper.dart';
import 'package:masterjee/providers/attendance_api.dart';
import 'package:masterjee/providers/student_progress_api.dart';
import 'package:masterjee/widgets/app_bar_two.dart';
import 'package:masterjee/widgets/app_tags.dart';
import 'package:masterjee/widgets/text.dart';
import 'package:provider/provider.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class SubjectWiseScreen extends StatefulWidget {
  const SubjectWiseScreen({super.key});

  static String routeName = 'SubjectWiseScreen';

  @override
  State<SubjectWiseScreen> createState() => _SubjectWiseScreenState();
}

class _SubjectWiseScreenState extends State<SubjectWiseScreen> {
  String? _selectedStudent;

  List<StudentData> studentList = [];
  List<SubjectData> assessmentData = [];
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
      List<SubjectData> data = await Provider.of<StudentProgressApi>(context, listen: false).getProgressSubjectWise(id.toString());
      setState(() {
        assessmentData = data;
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
        appBar: AppBarTwo(title: AppTags.subjectWise),
        body: Column(
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
            _isLoading ? const Center(child: CircularProgressIndicator()) : AssessmentChart(subjects: assessmentData,)
          ],
        ));
  }
}


class AssessmentChart extends StatelessWidget {
  final List<SubjectData> subjects;

  const AssessmentChart({super.key, required this.subjects});

  @override
  Widget build(BuildContext context) {
    return SfCartesianChart(
      backgroundColor: Colors.white,
      legend: const Legend(isVisible: true),
      tooltipBehavior: TooltipBehavior(enable: true),
      primaryXAxis: const CategoryAxis(),
      primaryYAxis: const NumericAxis(
        minimum: 0,
        maximum: 100,
        interval: 10,
      ),
      series: <CartesianSeries>[
        LineSeries<SubjectData, String>(
          name: 'Assessment',
          dataSource: subjects,
          xValueMapper: (SubjectData data, _) => data.subjectName,
          yValueMapper: (SubjectData data, _) => data.percentage,
          color: Colors.cyan,
          markerSettings: const MarkerSettings(isVisible: true),
          dataLabelSettings: const DataLabelSettings(isVisible: false),
        )
      ],
    );  }
}