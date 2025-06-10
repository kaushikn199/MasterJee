import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:masterjee/constants.dart';
import 'package:masterjee/models/all_student/all_students_model.dart';
import 'package:masterjee/models/all_student/student_template_model.dart';
import 'package:masterjee/others/StorageHelper.dart';
import 'package:masterjee/providers/attendance_api.dart';
import 'package:masterjee/providers/student_progress_api.dart';
import 'package:masterjee/widgets/app_bar_two.dart';
import 'package:masterjee/widgets/app_tags.dart';
import 'package:masterjee/widgets/text.dart';
import 'package:provider/provider.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class AssessmentWiseScreen extends StatefulWidget {
  const AssessmentWiseScreen({super.key});

  static String routeName = 'AssessmentWiseScreen';

  @override
  State<AssessmentWiseScreen> createState() => _AssessmentWiseScreenState();
}

class _AssessmentWiseScreenState extends State<AssessmentWiseScreen> {
  String? _selectedStudent;

  List<StudentData> studentList = [];
  List<AssessmentsData> assessmentData = [];

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
      List<AssessmentsData> data =
          await Provider.of<StudentProgressApi>(context, listen: false).getProgressAssessmentWiseData(id.toString());
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
        appBar: AppBarTwo(title: AppTags.assessmentWise),
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
            _isLoading
                ? const Center(child: CircularProgressIndicator())
                : Expanded(
                    child: StudentAssessmentScreen(
                    responseData: assessmentData,
                  ))
          ],
        ));
  }
}

class StudentAssessmentScreen extends StatelessWidget {
  final List<AssessmentsData> responseData;

  const StudentAssessmentScreen({Key? key, required this.responseData}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(12.0),
      child: SingleChildScrollView(
        child: Column(
          children: [
            // Donut Chart for First Assessment (optional logic)
            if(responseData.isNotEmpty)
            SfCircularChart(
              backgroundColor: Colors.white,
              legend: const Legend(isVisible: true, position: LegendPosition.top),
              tooltipBehavior: TooltipBehavior(enable: true),

              series: <RadialBarSeries<AssessmentsData, String>>[
                RadialBarSeries<AssessmentsData, String>(
                  dataSource: responseData,
                  xValueMapper: (AssessmentsData data, _) => data.assessmentName,
                  yValueMapper: (AssessmentsData data, _) => data.percentage,
                  maximumValue: 100,
                  radius: '100%',
                  innerRadius: '0%',
                  gap: '1%',
                  useSeriesColor: true,
                  trackOpacity: 0.4,
                  cornerStyle: CornerStyle.bothFlat,
                  enableTooltip: true,
                  dataLabelSettings: const DataLabelSettings(isVisible: false),
                ),
              ],
            ),
            const SizedBox(height: 15),
            // Bar Chart for all Assessments
            if(responseData.isNotEmpty)
              SfCartesianChart(
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
                LineSeries<AssessmentsData, String>(
                  name: 'Assessment',
                  dataSource: responseData,
                  xValueMapper: (AssessmentsData data, _) => data.assessmentName,
                  yValueMapper: (AssessmentsData data, _) => data.percentage,
                  color: Colors.cyan,
                  markerSettings: const MarkerSettings(isVisible: true),
                  dataLabelSettings: const DataLabelSettings(isVisible: false),
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
