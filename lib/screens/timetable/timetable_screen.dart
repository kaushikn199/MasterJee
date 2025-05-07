import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:masterjee/constants.dart';
import 'package:masterjee/models/class_timetable/class_time_table_response.dart';
import 'package:masterjee/models/teachers_subject/teachers_subject_response.dart';
import 'package:masterjee/others/StorageHelper.dart';
import 'package:masterjee/providers/class_timetable.dart';
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
  late List<ClassTimetableData> timeTableList = [];

  String? _selectedLesson;
  List<SubjectData> lessonList = [];
  String? _selectedLessonId;

  String? _selectedTopic;
  List<SubjectData> topicList = [];
  String? _selectedTopicId;

  DateTime? _selectedFromDate;

  final _homeworkDateController = TextEditingController();

  final _maxMarkController = TextEditingController();

  final _startTimeController = TextEditingController();
  final _endTimeController = TextEditingController();

  final dayController = TextEditingController();


  @override
  void initState() {
    print("initState");
    callApiGetClassTimetable();
    super.initState();
  }

  Future<void> callApiGetClassTimetable() async {
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarTwo(title: AppTags.timetable),
      body: Builder(builder: (context) {
        if (_isLoading) {
          return SizedBox
            (
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
                return cardWidget(context,timeTableList[index]);
              }),
        );
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
        _homeworkDateController.text = pickedDate.toLocalDMYDateString();
      });
    }
  }

  void _showBottomSheet(BuildContext mainCon, LessonPlan data) {
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
        return SingleChildScrollView(
          child: StatefulBuilder(builder: (context, setState) {
            return Padding(
              padding: EdgeInsets.only(
                bottom: MediaQuery.of(context).viewInsets.bottom,
              ),
              child: Container(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
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
                    CustomTextField(
                      hintText: 'Day',
                      isReadonly: true,
                      controller: dayController,
                      keyboardType: TextInputType.text,
                      onSave: (value) {
                        dayController.text = value as String;
                      },
                    ),
                    gap(10.sp),
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
                            child: Icon(Icons.keyboard_arrow_down_outlined),
                          ),
                          underline: const SizedBox(),
                          onChanged: (value) {
                            setState(() {
                              _selectedLesson = null;
                              _selectedLesson = value.toString();
                              for (int i = 0; i < lessonList.length; i++) {
                                if (lessonList[i].name.toString().toLowerCase() ==
                                    value.toString().toLowerCase()) {
                                  _selectedLessonId = lessonList[i].id.toString();
                                  break;
                                }
                              }
                            });
                          },
                          isExpanded: true,
                          items: lessonList.map((cd) {
                            return DropdownMenuItem(
                              value: cd.name,
                              onTap: () {
                                setState(() {
                                  _selectedLesson = cd.name;
                                  for (int i = 0;
                                  i < lessonList.length;
                                  i++) {
                                    if (lessonList[i].name.toString()
                                        .toLowerCase() == cd.name.toString().toLowerCase()) {
                                      _selectedLessonId =
                                          lessonList[i].id.toString();
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
                            child: Icon(Icons.keyboard_arrow_down_outlined),
                          ),
                          underline: const SizedBox(),
                          onChanged: (value) {
                            setState(() {
                              _selectedTopic = null;
                              _selectedTopic = value.toString();
                              for (int i = 0; i < topicList.length; i++) {
                                if (topicList[i].name.toString().toLowerCase() ==
                                    value.toString().toLowerCase()) {
                                  _selectedTopicId = topicList[i].id.toString();
                                  break;
                                }
                              }
                            });
                          },
                          isExpanded: true,
                          items: topicList.map((cd) {
                            return DropdownMenuItem(
                              value: cd.name,
                              onTap: () {
                                setState(() {
                                  _selectedTopic = cd.name;
                                  for (int i = 0;
                                  i < topicList.length;
                                  i++) {
                                    if (topicList[i].name.toString()
                                        .toLowerCase() == cd.name.toString().toLowerCase()) {
                                      _selectedTopicId =
                                          topicList[i].id.toString();
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
                      controller: _startTimeController,
                      keyboardType: TextInputType.text,
                      onSave: (value) {
                        _endTimeController.text = value as String;
                      },
                    ),
                    gap(10.sp),
                    // Submit Button
                    CommonButton(
                      cornersRadius: 30,
                      text: AppTags.submit,
                      onPressed: () {
                       // checkValidation(context);
                      },
                    )
                  ],
                ),
              ),
            );
          }),
        );
      },
    );
  }

  cardWidget(BuildContext context,ClassTimetableData dayList) {
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
                  CommonText.bold(dayList.day, size: 14.sp, color: Colors.black),
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
              itemBuilder: (BuildContext context, int index) {
                return cardChildWidget(context,dayList.dayTimetable[index]);
              }),
        ],
      ),
    );
  }

  Widget cardChildWidget(BuildContext context,DayTimetable data) {
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
              itemBuilder: (BuildContext context, int index) {
                return cardLessonPlansWidget(context,data.lessonPlans[index]);
              },
            ),
          ),
        ],
      ),
    );
  }

  cardLessonPlansWidget(BuildContext context,LessonPlan data) {
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
          onTap: () {
            _showBottomSheet(context,data);
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