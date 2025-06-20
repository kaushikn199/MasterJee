import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:masterjee/constants.dart';
import 'package:masterjee/models/class_timetable/add_lesson_plan_response.dart';
import 'package:masterjee/models/class_timetable/class_time_table_response.dart';
import 'package:masterjee/models/common_functions.dart';
import 'package:masterjee/models/teachers_subject/teachers_subject_response.dart';
import 'package:masterjee/others/StorageHelper.dart';
import 'package:masterjee/providers/class_timetable.dart';
import 'package:masterjee/screens/timetable/time_table_students_screen.dart';
import 'package:masterjee/widgets/CommonButton.dart';
import 'package:masterjee/widgets/app_bar_two.dart';
import 'package:masterjee/widgets/app_tags.dart';
import 'package:masterjee/widgets/custom_form_field.dart';
import 'package:masterjee/widgets/text.dart';
import 'package:provider/provider.dart';

class TimetableScreen extends StatefulWidget {
  const TimetableScreen({super.key});

  static String routeName = 'timetableScreen';

  @override
  State<TimetableScreen> createState() => _TimetableScreenState();
}

class _TimetableScreenState extends State<TimetableScreen> {
  var _isLoading = false;
  var _isLoadingBootomSheet = false;
  late List<ClassTimetableData> timeTableList = [];

  String? _selectedLesson;
  int _indexLesson = 0;
  List<SubjectData> lessonList = [];

  String? _selectedTopic;
  List<SubjectData> topicList = [];
  int _indexTopic = 0;

  DateTime? _selectedFromDate;

  final _homeworkDateController = TextEditingController();
  final _maxMarkController = TextEditingController();
  final _startTimeController = TextEditingController();
  final _endTimeController = TextEditingController();
  late var dayController = TextEditingController();
  final _lectureYouTubeUrlController = TextEditingController();
  final _teachingMethodController = TextEditingController();
  final _generalObjectiveController = TextEditingController();
  final _previousKnowledgeController = TextEditingController();
  final _comprehensiveQuestionsController = TextEditingController();

  @override
  void initState() {
    print("initState");
    callApiGetClassTimetable();
    super.initState();
  }

  Future<void> callApiGetClassTimetable() async {
    setState(() {
      _isLoading = true;
    });
    try {
      ClassTimetableResponse data = await Provider.of<ClassTimetable>(context,
              listen: false)
          .getClassTimetable(
              StorageHelper.getStringData(StorageHelper.userIdKey).toString(),
              StorageHelper.getStringData(StorageHelper.classIdKey).toString(),
              StorageHelper.getStringData(StorageHelper.sectionIdKey)
                  .toString());
      if (data.result) {
        setState(() {
          timeTableList = data.data;
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

  List<Lesson> lessonsMainList = [];
  late TtInfo ttInfo;

  Future<void> callApiAddLessonPlan(String sgsid, String ttid) async {
    setState(() {
      _isLoadingBootomSheet = true;
    });
    try {
      AddLessonPlanResponse data = await Provider.of<ClassTimetable>(context,
              listen: false)
          .addLessonPlan(
              StorageHelper.getStringData(StorageHelper.userIdKey).toString(),
              sgsid,
              ttid);
      if (data.result) {
        setState(() {
          ttInfo = data.data!.ttInfo!;
          lessonsMainList = data.data?.lessons ?? [];
          _isLoadingBootomSheet = false;
        });
        return;
      } else {
        setState(() {
          _isLoadingBootomSheet = false;
        });
      }
    } catch (error) {
      setState(() {
        _isLoadingBootomSheet = false;
      });
      print("callApiAddLessonPlan error : $error");
    }
  }

  Future<void> callApiSaveLessonPlan(
      String lessonId,
      String topicId,
      String subTopic,
      String date,
      String timeFrom,
      String timeTo,
      String lactureYoutubeUrl,
      String teachingMethod,
      String generalObjectives,
      String previousKnowledge,
      String comprehensiveQuestions,
      BuildContext context) async {
    setState(() {
      _isLoadingBootomSheet = true;
    });
    try {
      AddLessonPlanResponse data = await Provider.of<ClassTimetable>(context,
              listen: false)
          .saveLessonPlan(
              StorageHelper.getStringData(StorageHelper.userIdKey).toString(),
              lessonId,
              topicId,
              subTopic,
              date,
              timeFrom,
              timeTo,
              lactureYoutubeUrl,
              teachingMethod,
              generalObjectives,
              previousKnowledge,
              comprehensiveQuestions);
      if (data != null && data.result) {
        setState(() {
          _isLoadingBootomSheet = false;
          clearData();
          Navigator.pop(context);
          FocusScope.of(context).unfocus();
        });
        return;
      } else {
        setState(() {
          _isLoadingBootomSheet = false;
        });
      }
    } catch (error) {
      setState(() {
        _isLoadingBootomSheet = false;
      });
      print("callApiSaveLessonPlan error : $error");
    }
  }

  void clearData() {
    _selectedLesson = null;
    _selectedTopic = null;
    _indexLesson = 0;
    _indexTopic = 0;
    _homeworkDateController.text = "";
    _lectureYouTubeUrlController.text = "";
    _teachingMethodController.text = "";
    _generalObjectiveController.text = "";
    _previousKnowledgeController.text = "";
    _comprehensiveQuestionsController.text = "";
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarTwo(title: AppTags.timetable),
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
            if (timeTableList.isEmpty) {
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
              child: ListView.builder(
                shrinkWrap: true,
                itemCount: timeTableList.length,
                padding: EdgeInsets.only(top: 10.sp),
                itemBuilder: (BuildContext context, int index) {
                  return cardWidget(context, timeTableList[index]);
                },
              ),
            );
          }),
          if (_isLoadingBootomSheet)
            Positioned.fill(
              child: Container(
                color: Colors.black.withOpacity(0.1),
                child: const Center(
                  child: CircularProgressIndicator(),
                ),
              ),
            ),
        ],
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
        _homeworkDateController.text = pickedDate.toLocalDMYDateString();
      });
    }
  }

  void _showBottomSheet(
      BuildContext mainCon, LessonPlan data, ClassTimetableData dayList) {
    showModalBottomSheet(
      backgroundColor: kSecondBackgroundColor,
      context: mainCon,
      isScrollControlled: true,
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(
        top: Radius.circular(12.r),
        bottom: Radius.circular(12.r),
      )),
      builder: (BuildContext context) {
        return StatefulBuilder(
          builder: (BuildContext context,setState) {
        return Padding(
          padding: EdgeInsets.only(
            bottom: MediaQuery.of(context).viewInsets.bottom,
          ),
          child: Container(
            padding: const EdgeInsets.all(16.0),
            height: MediaQuery.of(context).size.height * .8,
            child: Column(
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    CommonText.bold("Add lesson plan", size: 18.sp),
                    GestureDetector(
                        onTap: () {
                          Navigator.pop(context);
                        },
                        child: const Icon(Icons.close,
                            color: Colors.black, size: 24))
                  ],
                ),
                gap(10.sp),
                Expanded(
                  child: SingleChildScrollView(
                    child: StatefulBuilder(builder: (context, setState) {
                      return Padding(
                        padding: EdgeInsets.only(
                          bottom: MediaQuery.of(context).viewInsets.bottom,
                        ),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            CustomTextField(
                              hintText: 'Day',
                              isReadonly: true,
                              controller: dayController,
                              keyboardType: TextInputType.text,
                              onSave: (value) {
                                dayController.text = value as String;
                              },
                            ),
                            gap(5.sp),
                            Card(
                              elevation: 0.1,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20.sp),
                              ),
                              color: colorWhite,
                              child: Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 10, vertical: 2),
                                child: DropdownButton(
                                  hint: const CommonText('Select lesson',
                                      size: 14, color: Colors.black54),
                                  value: _selectedLesson,
                                  icon: const Card(
                                    elevation: 0.1,
                                    color: colorWhite,
                                    child: Icon(
                                        Icons.keyboard_arrow_down_outlined),
                                  ),
                                  underline: const SizedBox(),
                                  onChanged: (value) {
                                    setState(() {
                                      _selectedLesson = null;
                                      _selectedLesson = value.toString();
                                      _selectedTopic = null;
                                    });
                                  },
                                  isExpanded: true,
                                  items: lessonsMainList.map((cd) {
                                    return DropdownMenuItem(
                                      value: cd.id,
                                      onTap: () {
                                        setState(() {
                                          _selectedLesson = cd.name;
                                          for (int i = 0;
                                              i < lessonsMainList.length;
                                              i++) {
                                            if (lessonsMainList[i].id ==
                                                cd.id) {
                                              _indexLesson = i;
                                              _selectedTopic = null;
                                              //_selectedLessonId = lessonsMainList[i].id;
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
                            gap(5.sp),
                            Card(
                              elevation: 0.1,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20.sp),
                              ),
                              color: colorWhite,
                              child: Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 10, vertical: 2),
                                child: DropdownButton(
                                  hint: const CommonText('Select topic',
                                      size: 14, color: Colors.black54),
                                  value: _selectedTopic,
                                  icon: const Card(
                                    elevation: 0.1,
                                    color: colorWhite,
                                    child: Icon(
                                        Icons.keyboard_arrow_down_outlined),
                                  ),
                                  underline: const SizedBox(),
                                  onChanged: (value) {
                                    setState(() {
                                      _selectedTopic = null;
                                      _selectedTopic = value.toString();
                                    });
                                  },
                                  isExpanded: true,
                                  items: lessonsMainList[_indexLesson]
                                      .topics
                                      .map((cd) {
                                    return DropdownMenuItem(
                                      value: cd.id,
                                      onTap: () {
                                        setState(() {
                                          _selectedTopic = cd.name;
                                          for (int i = 0;
                                              i <
                                                  lessonsMainList[_indexLesson]
                                                      .topics
                                                      .length;
                                              i++) {
                                            if (lessonsMainList[_indexLesson]
                                                    .topics[i]
                                                    .id ==
                                                cd.id) {
                                              _indexTopic = i;
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
                            gap(5.sp),
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
                              isReadonly: true,
                              controller: _homeworkDateController,
                              onSave: (value) {
                                _homeworkDateController.text = value as String;
                              },
                            ), //
                            gap(10.sp),
                            CustomTextField(
                              hintText: 'Start time',
                              isReadonly: true,
                              controller: _startTimeController,
                              keyboardType: TextInputType.text,
                              onSave: (value) {
                                _startTimeController.text = value as String;
                              },
                            ),
                            gap(10.sp),
                            CustomTextField(
                              hintText: 'End time',
                              isReadonly: true,
                              controller: _endTimeController,
                              keyboardType: TextInputType.text,
                              onSave: (value) {
                                _endTimeController.text = value as String;
                              },
                            ),
                            gap(10.sp),
                            CustomTextField(
                              hintText: 'Lecture youtube url',
                              isReadonly: false,
                              controller: _lectureYouTubeUrlController,
                              keyboardType: TextInputType.url,
                              onSave: (value) {
                                _lectureYouTubeUrlController.text =
                                    value as String;
                              },
                            ),
                            gap(10.sp),
                            CustomTextField(
                              hintText: 'Teaching method',
                              isReadonly: false,
                              controller: _teachingMethodController,
                              keyboardType: TextInputType.text,
                              onSave: (value) {
                                _teachingMethodController.text =
                                    value as String;
                              },
                            ),
                            gap(10.sp),
                            CustomTextField(
                              hintText: 'General Objective',
                              isReadonly: false,
                              controller: _generalObjectiveController,
                              keyboardType: TextInputType.text,
                              onSave: (value) {
                                _generalObjectiveController.text =
                                    value as String;
                              },
                            ),
                            gap(10.sp),
                            CustomTextField(
                              hintText: 'Previous Knowledge',
                              isReadonly: false,
                              controller: _previousKnowledgeController,
                              keyboardType: TextInputType.text,
                              onSave: (value) {
                                _previousKnowledgeController.text =
                                    value as String;
                              },
                            ),
                            gap(10.sp),
                            CustomTextField(
                              hintText: 'Comprehensive Questions',
                              isReadonly: false,
                              controller: _comprehensiveQuestionsController,
                              keyboardType: TextInputType.text,
                              onSave: (value) {
                                _comprehensiveQuestionsController.text =
                                    value as String;
                              },
                            ),
                            gap(10.sp),
                            // Submit Button
                          ],
                        ),
                      );
                    }),
                  ),
                ),
                SizedBox(
                  child: _isLoadingBootomSheet ? const CircularProgressIndicator() : CommonButton(
                    cornersRadius: 30,
                    text: AppTags.submit,
                    onPressed: () async {
                      if (_selectedLesson == null) {
                        CommonFunctions.showWarningToast("Please select lesson");
                      } else if (_selectedTopic == null) {
                        CommonFunctions.showWarningToast("Please select topic");
                      } else if (_homeworkDateController.text == "") {
                        CommonFunctions.showWarningToast("Please select date");
                      } else if (_lectureYouTubeUrlController.text == "") {
                        CommonFunctions.showWarningToast(
                            "Please enter lectureYouTubeUrl");
                      } else if (_teachingMethodController.text == "") {
                        CommonFunctions.showWarningToast(
                            "Please enter teachingMethod");
                      } else if (_generalObjectiveController.text == "") {
                        CommonFunctions.showWarningToast(
                            "Please enter generalObjective");
                      } else if (_previousKnowledgeController.text == "") {
                        CommonFunctions.showWarningToast(
                            "Please enter previousKnowledge");
                      } else if (_comprehensiveQuestionsController.text == "") {
                        CommonFunctions.showWarningToast(
                            "Please enter comprehensiveQuestions");
                      } else {
                        setState(() {
                          _isLoadingBootomSheet = true;
                        });
                        print(
                            "_startTimeController.text : ${_startTimeController.text}");
                        print(
                            "_endTimeController.text : ${_endTimeController.text}");
                        /*callApiSaveLessonPlan(
                            lessonsMainList[_indexLesson].id,
                            lessonsMainList[_indexLesson].topics[_indexTopic].id,
                            lessonsMainList[_indexLesson]
                                .topics[_indexTopic]
                                .name,
                            _homeworkDateController.text,
                            formatTo24Hour(ttInfo.startTime),
                            formatTo24Hour(ttInfo.endTime),
                            _lectureYouTubeUrlController.text,
                            _teachingMethodController.text,
                            _generalObjectiveController.text,
                            _previousKnowledgeController.text,
                            _comprehensiveQuestionsController.text,
                            context);*/
                        setState(() {
                          _isLoadingBootomSheet = true;
                        });
                        try {
                          AddLessonPlanResponse data = await Provider.of<ClassTimetable>(context,
                              listen: false)
                              .saveLessonPlan(
                              StorageHelper.getStringData(StorageHelper.userIdKey).toString(),
                            lessonsMainList[_indexLesson].id,
                            lessonsMainList[_indexLesson].topics[_indexTopic].id,
                            lessonsMainList[_indexLesson]
                                .topics[_indexTopic]
                                .name,
                            _homeworkDateController.text,
                            formatTo24Hour(ttInfo.startTime),
                            formatTo24Hour(ttInfo.endTime),
                            _lectureYouTubeUrlController.text,
                            _teachingMethodController.text,
                            _generalObjectiveController.text,
                            _previousKnowledgeController.text,
                            _comprehensiveQuestionsController.text);
                          if (data != null && data.result) {
                            setState(() {
                              callApiGetClassTimetable();
                              _isLoadingBootomSheet = false;
                              clearData();
                              Navigator.pop(context);
                              FocusScope.of(context).unfocus();
                            });
                            return;
                          } else {
                            setState(() {
                              _isLoadingBootomSheet = false;
                            });
                          }
                        } catch (error) {
                          setState(() {
                            _isLoadingBootomSheet = false;
                          });
                          print("callApiSaveLessonPlan error : $error");
                        }

                      }
                    },
                  ),
                ),

              ],
            ),
          ),
        );
          },
        );

      },
    );
  }

  cardWidget(BuildContext context, ClassTimetableData dayList) {
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
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Align(
            alignment: Alignment.bottomLeft,
            child: Container(
              width: double.maxFinite,
              padding: EdgeInsets.symmetric(horizontal: 10.sp, vertical: 5.sp),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(
                      topRight: Radius.circular(10.r),
                      topLeft: Radius.circular(10.r)),
                  color: kToastTextColor),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  CommonText.bold(dayList.day,
                      size: 14.sp, color: Colors.black),
                ],
              ),
            ),
          ),
          dayList == null
              ? Center(
                  child: Padding(
                    padding: EdgeInsets.all(20.sp),
                    child: CommonText.medium('No Schedule Available',
                        size: 12.sp,
                        color: Colors.redAccent,
                        overflow: TextOverflow.fade),
                  ),
                )
              : ListView.builder(
                  shrinkWrap: true,
                  itemCount: dayList.dayTimetable.length,
                  physics: const NeverScrollableScrollPhysics(),
                  padding: EdgeInsets.only(top: 10.sp),
                  itemBuilder: (BuildContext c, int index) {
                    return cardChildWidget(
                        context, dayList.dayTimetable[index], dayList);
                  }),


              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  InkWell(
                    onTap: () async {
                      print("ttId : ${dayList.ttData?.ttId}");
                      print("subjectGroupId : ${dayList.ttData?.subjectGroupId}");
                      Navigator.pushNamed(
                        context,
                        TimeTableStudentsScreen.routeName,
                        arguments: { "timetableId" : dayList.ttData?.ttId,
                          "subjectGroupId" : dayList.ttData?.subjectGroupId},
                      );

                    },
                    child: Container(
                      decoration: const BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(10)),
                          color: colorGreen),
                      child: CommonText.medium("Attendance", size: 13.sp, color: colorWhite)
                          .paddingOnly(left: 30, right: 30, top: 5, bottom: 5),
                    ),
                  ).paddingOnly(left: 10,bottom: 10),
                  gap(30.0)
                ],
              ),


        ],
      ),
    );
  }

  Widget cardChildWidget(
      BuildContext context, DayTimetable data, ClassTimetableData dayList) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 10.sp, horizontal: 15.sp),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: Row(
              children: [
                CommonText.bold(
                  data.timeFrom,
                  size: 12.sp,
                  color: Colors.black,
                ),
                CommonText.bold(
                  " To ",
                  size: 12.sp,
                  color: Colors.black,
                ),
                CommonText.bold(
                  data.timeTo,
                  size: 12.sp,
                  color: Colors.black,
                ),
              ],
            ),
          ),
          SizedBox(width: 10.sp),
          Expanded(
            child: ListView.builder(
              shrinkWrap: true,
              itemCount: data.lessonPlans.length,
              physics: const NeverScrollableScrollPhysics(),
              padding: const EdgeInsets.only(top: 0),
              itemBuilder: (BuildContext c, int index) {
                return cardLessonPlansWidget(
                    context, data.lessonPlans[index], data, dayList);
              },
            ),
          ),

        ],
      ),
    );
  }

  cardLessonPlansWidget(BuildContext context, LessonPlan data,
      DayTimetable dayTime, ClassTimetableData dayList) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CommonText.medium(data.name, size: 13.sp, color: colorGaryText),
        gap(5.0),
        CommonText.medium(data.section, size: 13.sp, color: colorGaryText),
        gap(5.0),
        CommonText.medium(data.lessonPlanClass,
            size: 13.sp, color: colorGaryText),
        gap(10.0),
        InkWell(
          onTap: () async {
            clearData();
            dayController.text = dayList.day.toString();
            _startTimeController.text = dayTime.timeFrom.toString();
            _endTimeController.text = dayTime.timeTo.toString();
            _selectedFromDate = DateTime.now();

            // Show loading first
            _isLoadingBootomSheet = true;
            await callApiAddLessonPlan(
              dayList.ttData?.subjectGroupSubjectId ?? "0",
              dayList.ttData?.id ?? "0",
            );
            _showBottomSheet(context, data, dayList);
          },
          child: Container(
            decoration: const BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(10)),
                color: colorGreen),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Icon(
                  Icons.add,
                  color: colorWhite,
                ),
                gap(2.0),
                CommonText.medium("Lesson Plan", size: 13.sp, color: colorWhite)
              ],
            ).paddingOnly(left: 5, right: 10, top: 5, bottom: 5),
          ),
        ),
      ],
    );
  }
}
