import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get_utils/src/extensions/widget_extensions.dart';
import 'package:masterjee/constants.dart';
import 'package:masterjee/models/exam/exam/ExamSubjectsResponse.dart';
import 'package:masterjee/widgets/CommonButton.dart';
import 'package:masterjee/widgets/app_bar_two.dart';
import 'package:masterjee/widgets/app_tags.dart';
import 'package:masterjee/widgets/custom_form_field.dart';
import 'package:masterjee/widgets/text.dart';

class AddExamScreen extends StatefulWidget {
  const AddExamScreen({super.key});

  static String routeName = 'addExamScreen';

  @override
  State<AddExamScreen> createState() => _AddExamScreenState();
}

class _AddExamScreenState extends State<AddExamScreen> {
  var _isLoading = false;
  String? _selectedLesson = null;
  late List<ExamSubjectData> examSubjectDataList = [];
  int _indexLesson = 0;
  final _examNameController = TextEditingController();
  final _descriptionController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBarTwo(title: AppTags.exam),
        backgroundColor: colorGaryBG,
        bottomNavigationBar: SizedBox(
          child: _isLoading
              ? const Center(
                  child: CircularProgressIndicator(),
                )
              : CommonButton(
                  paddingHorizontal: 7,
                  cornersRadius: 10,
                  text: AppTags.add,
                  onPressed: () {},
                ).paddingOnly(bottom: 30, left: 10, right: 10),
        ),
        body: SingleChildScrollView(
          child: Column(children: [
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
                  hint: const CommonText('Select class',
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
                  hint: const CommonText('Select section',
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
                  hint: const CommonText('Select term',
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
                  hint: const CommonText('Select assessment',
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
                  hint: const CommonText('Select grade',
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
              keyboardType: TextInputType.text,
              hintText: 'Exam name',
              isRequired: true,
              isReadonly: false,
              controller: _examNameController,
              onSave: (value) {
                _examNameController.text = value as String;
              },
            ),
            gap(10.0),
            CustomTextField(
              maxLines: 3,
              keyboardType: TextInputType.text,
              hintText: 'Description',
              isRequired: true,
              isReadonly: false,
              controller: _descriptionController,
              onSave: (value) {
                _descriptionController.text = value as String;
              },
            ),
            gap(30.0),
          ]),
        ).paddingOnly(left: 10,right: 10,top: 10));
  }
}
