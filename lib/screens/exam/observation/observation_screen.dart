import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get_utils/src/extensions/widget_extensions.dart';
import 'package:masterjee/constants.dart';
import 'package:masterjee/models/class_timetable/add_lesson_plan_response.dart';
import 'package:masterjee/screens/exam/observation/edit_update_observation_screen.dart';
import 'package:masterjee/widgets/CommonButton.dart';
import 'package:masterjee/widgets/app_tags.dart';
import 'package:masterjee/widgets/custom_form_field.dart';
import 'package:masterjee/widgets/text.dart';

class ObservationScreen extends StatefulWidget {
  const ObservationScreen({super.key});

  static String routeName = 'observationScreen';

  @override
  State<ObservationScreen> createState() => _ObservationScreenState();
}

class _ObservationScreenState extends State<ObservationScreen> {

  var _isLoading = false;
  List<int> ptmList = [0, 1, 2, 3, 4];

  late var paramController = TextEditingController();
  late var descriptionController = TextEditingController();

  void showParameterDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          insetPadding: EdgeInsets.zero,
          child: LayoutBuilder(
            builder: (context, constraints) {
              return Container(
                decoration: BoxDecoration(
                  color: kBackgroundColor, // background color
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(
                    color: Colors.transparent,
                    width: 0,
                  ),
                ),
                width: MediaQuery.of(context).size.width - 30.sp,
                padding: const EdgeInsets.all(16),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    gap(20.0),
                    CustomTextField(
                      hintText: 'Param Name',
                      isReadonly: false,
                      controller: paramController,
                      keyboardType: TextInputType.name,
                      onSave: (value) {
                        paramController.text = value as String;
                      },
                    ),
                    gap(50.0),
                    CommonButton(
                      cornersRadius: 30,
                      text: AppTags.add,
                      onPressed: () {
                      },
                    ),
                  ],
                ),
              );
            },
          ),
        );
      },
    );
  }

  String? _selectedLesson;
  String? _selectedTopic;
  List<Lesson> lessonsMainList = [];
  int _indexLesson = 0;

  void showAssignDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          insetPadding: EdgeInsets.zero,
          child: LayoutBuilder(
            builder: (context, constraints) {
              return Container(
                decoration: BoxDecoration(
                  color: kBackgroundColor, // background color
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(
                    color: Colors.transparent,
                    width: 0,
                  ),
                ),
                width: MediaQuery.of(context).size.width - 30.sp,
                padding: const EdgeInsets.all(16),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    gap(10.0),
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
                          hint: const CommonText('Select observation',
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
                    gap(5.0),
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
                          hint: const CommonText('Select team',
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
                    gap(5.0),
                    CustomTextField(
                      maxLines: 2,
                      hintText: 'Description',
                      isReadonly: false,
                      controller: descriptionController,
                      keyboardType: TextInputType.name,
                      onSave: (value) {
                        descriptionController.text = value as String;
                      },
                    ),
                    gap(50.0),
                    CommonButton(
                      cornersRadius: 30,
                      text: AppTags.add,
                      onPressed: () {
                      },
                    ),
                  ],
                ),
              );
            },
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    if (_isLoading) {
      return SizedBox(
        height: MediaQuery.of(context).size.height * .5,
        child: const Center(
          child: CircularProgressIndicator(),
        ),
      );
    }
    if (ptmList.isEmpty) {
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
          Row(
            children: [
              Flexible(
                child: InkWell(
                  onTap: () {
                    showParameterDialog();
                  },
                  child: Center(
                    child: Container(
                      width: double.infinity,
                      decoration: BoxDecoration(
                        color: colorGreen,
                        border: Border.all(color: colorGreen, width: 1),
                        // Border color and width
                        borderRadius: BorderRadius.circular(20), // Rounded corners
                      ),
                      child: const CommonText.medium("Parameters",
                          textAlign: TextAlign.center,
                              size: 13, color: colorWhite)
                          .paddingOnly(top: 5, bottom: 5, left: 30, right: 30),
                    ),
                  ),
                )
              ),
              gap(10.0),
              Flexible(
                child: InkWell(
                  onTap: () {
                    showAssignDialog();
                  },
                  child: Center(
                    child: Container(
                      width: double.infinity,
                      decoration: BoxDecoration(
                        color: colorGreen,
                        border: Border.all(color: colorGreen, width: 1),
                        // Border color and width
                        borderRadius: BorderRadius.circular(20), // Rounded corners
                      ),
                      child: const CommonText.medium("Assign",
                              textAlign: TextAlign.center,
                              size: 13, color: colorWhite)
                          .paddingOnly(top: 5, bottom: 5, left: 30, right: 30),
                    ),
                  ),
                )
              ),
            ],
          ),
          Expanded(
            child: ListView.builder(
                shrinkWrap: true,
                itemCount: ptmList.length,
                padding: EdgeInsets.only(top: 10.sp),
                itemBuilder: (BuildContext context, int index) {
                  return assignmentCard(ptmList[index], false);
                }),
          ),
        ],
      ),
    );
  }

  Widget assignmentCard(int ptmData, bool isClosed) {
    return Container(
      margin: EdgeInsets.only(bottom: 15.sp),
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
          Padding(
            padding: EdgeInsets.all(10.sp),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Flexible(
                      child: Container(
                        decoration: const BoxDecoration(
                            borderRadius: BorderRadius.all(Radius.circular(5)),
                            color: colorGaryText),
                        child: CommonText.regular("Conception Understanding",
                                size: 10.sp,
                                color: Colors.white,
                                overflow: TextOverflow.fade)
                            .paddingOnly(left: 5, right: 5, bottom: 2, top: 2),
                      ),
                    ),
                    gap(10.0),
                    InkWell(
                      onTap: () {
                        Navigator.pushNamed(
                            context, EditUpdateObservationScreen.routeName);
                      },
                      child: Container(
                        decoration: BoxDecoration(
                            borderRadius:
                                BorderRadius.all(Radius.circular(5.r)),
                            color: Colors.grey),
                        child: const Icon(Icons.edit, color: colorWhite)
                            .paddingAll(2),
                      ),
                    )
                  ],
                ),
                gap(10.00),
                CommonText.medium(
                    "In an observational study, researchers study how participants perform certain Actions or activities without telling them what methods or Actions to choose.",
                    size: 11.sp,
                    color: kDarkGreyColor,
                    overflow: TextOverflow.fade),
                gap(10.0),
                ListView.builder(
                    padding: EdgeInsets.all(0),
                    physics: const NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    itemCount: ptmList.length,
                    itemBuilder: (BuildContext context, int index) {
                      return studentList(ptmList[index]);
                    }),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget studentList(int data) {
    return Container(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 5),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Expanded(
                    child: CommonText.medium('Density',
                        size: 12.sp,
                        color: kDarkGreyColor,
                        overflow: TextOverflow.fade),
                    flex: 20),
                Expanded(
                    child: CommonText.medium('10',
                        size: 12.sp,
                        color: kDarkGreyColor,
                        overflow: TextOverflow.fade),
                    flex: 10),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
