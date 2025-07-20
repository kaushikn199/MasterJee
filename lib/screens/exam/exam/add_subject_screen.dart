import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get_utils/src/extensions/widget_extensions.dart';
import 'package:intl/intl.dart';
import 'package:masterjee/constants.dart';
import 'package:masterjee/models/class_timetable/add_lesson_plan_response.dart';
import 'package:masterjee/models/common_functions.dart';
import 'package:masterjee/models/exam/ExamResponse.dart';
import 'package:masterjee/models/exam/exam/AllExamAssessmentsResponse.dart';
import 'package:masterjee/models/exam/exam/ExamSubjectsResponse.dart';
import 'package:masterjee/others/StorageHelper.dart';
import 'package:masterjee/providers/exam_api.dart';
import 'package:masterjee/widgets/CommonButton.dart';
import 'package:masterjee/widgets/app_bar_two.dart';
import 'package:masterjee/widgets/app_tags.dart';
import 'package:masterjee/widgets/custom_form_field.dart';
import 'package:masterjee/widgets/text.dart';
import 'package:provider/provider.dart';

class AddSubjectScreen extends StatefulWidget {
  const AddSubjectScreen({super.key});

  static String routeName = 'addSubjectScreen';

  @override
  State<AddSubjectScreen> createState() => _AddSubjectScreenState();
}

class _AddSubjectScreenState extends State<AddSubjectScreen> {
  GlobalKey<FormState> globalFormKey = GlobalKey<FormState>();
  String? _selectedLesson = null;
  List<Lesson> lessonsMainList = [];
  List<AssessmentData> allExamAssessmentsList = [];
  int _indexLesson = 0;
  DateTime? _selectedFromDate;
  final _fromDateController = TextEditingController();
  late String startTime;
  final _fromStartTimeControllers = TextEditingController();
  final _durationController = TextEditingController();
  final roomController = TextEditingController();
  var _isLoading = false;
  bool _isInitialized = false;
  late Exam exam;
  late List<ExamSubjectData> examSubjectDataList = [];
  List<Map<String, dynamic>> assessData = [];

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (!_isInitialized) {
      exam = ModalRoute.of(context)!.settings.arguments as Exam;
      if (exam != null) {
        callApiAllExamAssessments();
        callApiExamSubjects();
      }
      _isInitialized = true;
    }
  }

  Future<void> callApiExamSubjects() async {
    setState(() {
      _isLoading = true;
    });
    try {
      ExamSubjectResponse data =
          await Provider.of<ExamApi>(context, listen: false).examSubjects(
              StorageHelper.getStringData(StorageHelper.userIdKey).toString(),
              exam.id);
      if (data.result) {
        setState(() {
          examSubjectDataList = data.data;
          _isLoading = false;
        });
        return;
      } else {
        setState(() {
          _isLoading = false;
        });
      }
    } catch (error) {
      _isLoading = false;
    }
  }

  Future<void> callApiAllExamAssessments() async {
    setState(() {
      _isLoading = true;
    });
    try {
      AllExamAssessmentsResponse data =
          await Provider.of<ExamApi>(context, listen: false).allExamAssessments(
              StorageHelper.getStringData(StorageHelper.userIdKey).toString(),
              exam.id);
      if (data.result) {
        setState(() {
          allExamAssessmentsList = data.data;
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

  Future<void> callApiSaveExamSubjects() async {
    setState(() {
      _isLoading = true;
    });
    try {
      AllExamAssessmentsResponse data =
          await Provider.of<ExamApi>(context, listen: false).saveExamSubjects(
              StorageHelper.getStringData(StorageHelper.userIdKey).toString(),
              exam.id,
              examSubjectDataList[_indexLesson].id,
              _fromDateController.text,
              _fromStartTimeControllers.text,
              _durationController.text,
              roomController.text,
              assessData);
      if (data.result) {
        setState(() {
          /*_selectedLesson = null;
          _indexLesson = -1;
          _fromDateController.text = "";
          _fromStartTimeControllers.text = "";
          _durationController.text = "";
          roomController.text = "";
          assessData.clear();
          _isLoading = false;*/
          CommonFunctions.showWarningToast(data.message);
          Navigator.pop(context);
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
      appBar: AppBarTwo(title: AppTags.addSubject),
      backgroundColor: colorGaryBG,
      bottomNavigationBar: SizedBox(
        child: _isLoading ? const Center(
          child: CircularProgressIndicator(),
        ) : CommonButton(
          paddingHorizontal: 7,
          cornersRadius: 10,
          text: AppTags.add,
          onPressed: () {
            assessData.clear();
            int a = 0;
            for (int i = 0; i < allExamAssessmentsList.length; i++) {
              AssessmentData data = allExamAssessmentsList[i];
              if (data.isChecked) {
                a = a + 1;
                assessData.add({
                  "assessId": data.id,
                });
              }
            }
            if (_selectedLesson == null) {
              CommonFunctions.showWarningToast("Please select lesson");
            } else if (_fromDateController.text == null ||
                _fromDateController.text == "") {
              CommonFunctions.showWarningToast("Please select date");
            } else if (_fromStartTimeControllers.text == null ||
                _fromStartTimeControllers.text == "") {
              CommonFunctions.showWarningToast("Please select time");
            } else if (_durationController.text == null ||
                _durationController.text == "") {
              CommonFunctions.showWarningToast("Please enter duration");
            } else if (roomController.text == null || roomController.text == "") {
              CommonFunctions.showWarningToast("Please enter room");
            } else if (a == 0) {
              CommonFunctions.showWarningToast("Please select assessments");
            } else {
              callApiSaveExamSubjects();
            }
          },
        ).paddingOnly(bottom: 30, left: 10, right: 10),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            gap(10.0),
            Card(
              elevation: 0.1,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20.sp),
              ),
              color: colorWhite,
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 10, vertical: 2),
                child: DropdownButton(
                  hint: const CommonText('Select...',
                      size: 14, color: Colors.black54),
                  value: _selectedLesson,
                  icon: const Card(
                    elevation: 0.1,
                    color: colorWhite,
                    child: Icon(Icons.keyboard_arrow_down_outlined),
                  ),
                  underline: const SizedBox(),
                  onChanged: (value) {
                    setState(() {
                      _selectedLesson = null;
                      _selectedLesson = value.toString();
                    });
                  },
                  isExpanded: true,
                  items: examSubjectDataList.map((cd) {
                    return DropdownMenuItem(
                      value: cd.id + cd.ttid,
                      onTap: () {
                        setState(() {
                          _selectedLesson = cd.name;
                          for (int i = 0; i < examSubjectDataList.length; i++) {
                            if (examSubjectDataList[i].id == cd.id) {
                              _indexLesson = i;
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
            gap(10.0),
            CustomTextField(
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
            ),
            gap(10.0),
            CustomTextField(
              onTap: () {
                _selectStartTime(context);
              },
              hintText: 'Time',
              isRequired: true,
              prefixIcon: const Icon(
                Icons.date_range_outlined,
                color: kTextLowBlackColor,
              ),
              isReadonly: true,
              controller: _fromStartTimeControllers,
              onSave: (value) {
                _fromStartTimeControllers.text = value as String;
              },
            ),
            gap(10.0),
            CustomTextField(
              keyboardType: TextInputType.number,
              hintText: 'Duration',
              isRequired: true,
              isReadonly: false,
              controller: _durationController,
              onSave: (value) {
                _durationController.text = value as String;
              },
            ),
            gap(10.0),
            CustomTextField(
              keyboardType: TextInputType.number,
              hintText: 'Room',
              isRequired: true,
              isReadonly: false,
              controller: roomController,
              onSave: (value) {
                roomController.text = value as String;
              },
            ),
            gap(10.0),
            ListView.builder(
                shrinkWrap: true,
                itemCount: allExamAssessmentsList.length,
                itemBuilder: (BuildContext context, int index) {
                  return InkWell(
                      onTap: () {
                        //Navigator.push(context);
                      },
                      child: studentRow(allExamAssessmentsList[index]));
                }),
          ],
        ).paddingOnly(left: 10, right: 10),
      ),
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

  Future<void> _selectStartTime(BuildContext context) async {
    final TimeOfDay? pickedTime = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    );
    if (pickedTime != null) {
      final now = DateTime.now();
      final selectedTime = DateTime(
        now.year,
        now.month,
        now.day,
        pickedTime.hour,
        pickedTime.minute,
      );
      final formattedTime = DateFormat('HH:mm').format(selectedTime);
      setState(() {
        startTime = formattedTime;
        _fromStartTimeControllers.text = startTime;
        print("_fromStartTimeController : ${_fromStartTimeControllers.text}");
      });
    }
  }

  Widget studentRow(AssessmentData data) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        gap(8.0),
        Transform.scale(
          scale: 0.85,
          child: Checkbox(
            value: data.isChecked,
            onChanged: (bool? value) {
              setState(() {
                data.isChecked = value ?? false;
              });
            },
            checkColor: Colors.white,
            activeColor: Colors.green,
            materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
            visualDensity: VisualDensity.compact,
          ),
        ),
        const SizedBox(
          width: 10,
          height: 0,
        ),
        CommonText.medium(
          data.name,
          size: 14.sp,
          color: colorBlack,
          overflow: TextOverflow.fade,
        ),
      ],
    );
  }
}
