import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:masterjee/constants.dart';
import 'package:masterjee/models/assesment_response/assesment_reponse.dart';
import 'package:masterjee/models/common_functions.dart';
import 'package:masterjee/others/StorageHelper.dart';
import 'package:masterjee/providers/assesment_api.dart';
import 'package:masterjee/widgets/CommonButton.dart';
import 'package:masterjee/widgets/app_bar_two.dart';
import 'package:masterjee/widgets/app_tags.dart';
import 'package:masterjee/widgets/circular_radio_button.dart';
import 'package:masterjee/widgets/text.dart';
import 'package:masterjee/widgets/util.dart';
import 'package:provider/provider.dart';

class AssesmentScreen extends StatefulWidget {
  const AssesmentScreen({super.key});

  static String routeName = 'assesmentScreen';

  @override
  State<AssesmentScreen> createState() => _AssesmentScreenState();
}

class _AssesmentScreenState extends State<AssesmentScreen> {

  String? _selectedSubject;
  String? _selectedTemplate;
  late List<Student> studentsList = [];
  late List<ExamType> examTypeList = [];
  late List<Subject> subjectsList = [];
  String? _selectedExamId;
  String? _selectedSubjectId;
  bool _isLoading = false;

  List<TextEditingController> scoreControllers = [];
  List<TextEditingController> noteControllers = [];

  Future<void> callApiStudentAssessment() async {
    setState(() {
      _isLoading = true;
    });
    try {
      AssesmentResponse data = await Provider.of<AssesmentApi>(context,
              listen: false)
          .studentAssessment(
              StorageHelper.getStringData(StorageHelper.userIdKey).toString(),
              StorageHelper.getStringData(StorageHelper.classIdKey).toString(),
              StorageHelper.getStringData(StorageHelper.sectionIdKey).toString());
      if (data.result) {
        setState(() {
          studentsList = data.data?.students ?? [];
          examTypeList = data.data?.examType ?? [];
          subjectsList = data.data?.subjects ?? [];
          for (int i = 0; i < studentsList.length; i++) {
            scoreControllers.add(TextEditingController());
            noteControllers.add(TextEditingController());
          }
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

  Future<void> callApiSaveStudentAssessment(
       String batchId,
       String subjectId,
      List<Map<String, dynamic>> assessmentsList )
  async {
    setState(() {
      _isLoading = true;
    });
    try {
      AssesmentResponse data = await Provider.of<AssesmentApi>(context,
          listen: false)
          .saveStudentAssessment(
          StorageHelper.getStringData(StorageHelper.userIdKey).toString(),
          batchId,
          subjectId,
          assessmentsList);
      if (data.result) {
        setState(() {
          _selectedSubjectId = null;
          scoreControllers.clear();
          noteControllers.clear();
          _selectedExamId = null;
          _selectedTemplate = null;
          _selectedSubject = null;
          _isLoading = false;
          CommonFunctions.showWarningToast(data.message);
         callApiStudentAssessment();
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

  @override
  void initState() {

    callApiStudentAssessment();
    super.initState();
  }
  List<Map<String, dynamic>> assessmentsList = [];

  submit(){
    setState(() {
      if(_selectedExamId == null || _selectedExamId == ""){
        CommonFunctions.showWarningToast("Please select exam type");
      }else if(_selectedSubjectId == null || _selectedSubjectId == ""){
        CommonFunctions.showWarningToast("Please select subject");
      }else{
        for (int i = 0; i < studentsList.length; i++) {
          Student student = studentsList[i];
          if(student.isChecked){
            assessmentsList.add({
              "student_id": student.studentId,
              "score": scoreControllers[i].text,
              "note": noteControllers[i].text,
            });
          }
          print("Student name: ${student.firstname}");
        }
        if(assessmentsList.isNotEmpty){
          callApiSaveStudentAssessment(_selectedExamId!,_selectedSubjectId!,
              assessmentsList);
        }else{
          CommonFunctions.showWarningToast("Please select any student");
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBarTwo(title: AppTags.assesment),
        bottomNavigationBar: SizedBox(
          width: double.infinity,
          child: _isLoading
              ? const Center(child: CircularProgressIndicator())
              : CommonButton(
                  cornersRadius: 30,
                  text: AppTags.submit,
                  onPressed: () {
                    submit();
                  },
                ),
        ).paddingAll(10),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            gap(10.sp),
            examTypeList.isEmpty
                ? const Text('No exam data available')
                : Card(
                    margin: const EdgeInsets.only(left: 15, right: 15),
                    elevation: 0.1,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    color: kBackgroundColor,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 10, vertical: 2),
                      child: DropdownButton(
                        hint: const CommonText('Exam Type',
                            size: 14, color: Colors.black54),
                        value: _selectedSubject,
                        icon: const Card(
                          elevation: 0.1,
                          color: kBackgroundColor,
                          child: Icon(Icons.keyboard_arrow_down_outlined),
                        ),
                        underline: const SizedBox(),
                        onChanged: (value) {
                          setState(() {
                            _selectedSubject = null;
                            _selectedSubject = value.toString();
                            for (int i = 0; i < examTypeList.length; i++) {
                              if (examTypeList[i].exam.toString().toLowerCase()
                                  == value.toString().toLowerCase()) {
                                _selectedExamId = examTypeList[i].id.toString();
                                break;
                              }
                            }
                          });
                        },
                        isExpanded: true,
                        items: examTypeList.map((cd) {
                          return DropdownMenuItem(
                            value: cd.exam,
                            onTap: () {
                              setState(() {
                                _selectedSubject = cd.exam;
                                for (int i = 0; i < examTypeList.length; i++) {
                                  if (examTypeList[i].exam.toString()
                                          .toLowerCase() ==
                                      cd.toString().toLowerCase()) {
                                    _selectedExamId = examTypeList[i].id;
                                    break;
                                  }
                                }
                              });
                            },
                            child: Text(
                              cd.exam.toString(),
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
            subjectsList.isEmpty
                ? const Text('No subjects data available')
                : Card(
                    margin: const EdgeInsets.only(left: 15, right: 15),
                    elevation: 0.1,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    color: kBackgroundColor,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 10, vertical: 2),
                      child: DropdownButton(
                        hint: const CommonText('Subject',
                            size: 14, color: Colors.black54),
                        value: _selectedTemplate,
                        icon: const Card(
                          elevation: 0.1,
                          color: kBackgroundColor,
                          child: Icon(Icons.keyboard_arrow_down_outlined),
                        ),
                        underline: const SizedBox(),
                        onChanged: (value) {
                          setState(() {
                            _selectedTemplate = null;
                            _selectedTemplate = value.toString();
                            for (int i = 0; i < subjectsList.length; i++) {
                              if (subjectsList[i].name.toString().toLowerCase() ==
                                  value.toString().toLowerCase()) {
                                _selectedSubjectId = subjectsList[i].id.toString();
                                break;
                              }
                            }
                          });
                        },
                        isExpanded: true,
                        items: subjectsList.map((cd) {
                          return DropdownMenuItem(
                            value: cd.name,
                            onTap: () {
                              setState(() {
                                _selectedTemplate = cd.name;
                                for (int i = 0; i < subjectsList.length; i++) {
                                  if (subjectsList[i].name.toString().
                                  toLowerCase() == cd.toString().toLowerCase()) {
                                    _selectedSubjectId = subjectsList[i].id.toString();
                                    break;
                                  }
                                }
                              });
                            },
                            child: Text(
                              cd.name.toString(),
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
            Expanded(
                child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 10.sp),
              child: ListView.builder(
                  shrinkWrap: true,
                  itemCount: studentsList.length,
                  padding: EdgeInsets.only(top: 10.sp),
                  itemBuilder: (BuildContext context, int index) {
                    return assignmentCard(studentsList[index],index);
                  }),
            )),
          ],
        )
    );
  }

  Widget assignmentCard(Student data,int index) {
    return Container(
      margin: EdgeInsets.only(bottom: 20.sp),
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
      child: Padding(
        padding: EdgeInsets.all(10.sp),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            CommonText.semiBold("${data.admissionNo} - ${data.firstname}",
                textAlign: TextAlign.start,
                size: 12.sp,
                color: Colors.black,
                overflow: TextOverflow.fade),
            gap(10.sp),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                CircularRadioButton(
                  isSelected: data.isChecked,
                  onTap: () {
                    setState(() {
                      data.isChecked = !data.isChecked;
                    });
                    print('Checked: ${data.isChecked}');
                  },
                ),
                gap(8.0),
                CommonText.medium("Present",
                    textAlign: TextAlign.start,
                    size: 10.sp,
                    color: Colors.black,
                    overflow: TextOverflow.fade),
              ],
            ),
            gap(10.sp),
            TextFormField(
              style: const TextStyle(fontSize: 14),
              keyboardType: TextInputType.number,
              maxLines: 1,
              controller: scoreControllers[index],
              decoration: getInputDecoration(
                  'Score', null, kSecondBackgroundColor, Colors.white),
              validator: (input) {
                if (input == null) {
                  return "Please enter score";
                } else {
                  return "";
                }
              },
              onSaved: (value) {},
            ),
            gap(10.sp),
            TextFormField(
              style: const TextStyle(fontSize: 14),
              keyboardType: TextInputType.text,
              controller: noteControllers[index],
              maxLines: 1,
              decoration: getInputDecoration(
                  'Note', null, kSecondBackgroundColor, Colors.white),
              validator: (input) {
                if (input == null) {
                  return "Please enter note";
                } else {
                  return "";
                }
              },
              onSaved: (value) {

              },
            ),
          ],
        ),
      ),
    );
  }

  rowValue(String key, value) {
    return Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
      SizedBox(
          width: 100.sp,
          child: CommonText.medium(key, size: 12.sp, color: Colors.black)),
      SizedBox(width: 20.w),
      CommonText.medium(value,
          size: 14.sp, color: kDarkGreyColor, overflow: TextOverflow.fade),
    ]);
  }

}