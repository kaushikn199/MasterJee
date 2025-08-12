import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get_utils/src/extensions/widget_extensions.dart';
import 'package:masterjee/constants.dart';
import 'package:masterjee/models/class_section/class_section_response.dart';
import 'package:masterjee/models/common_functions.dart';
import 'package:masterjee/models/exam/GhradeResponse.dart';
import 'package:masterjee/models/exam/assesment/AllAssessmentsResponse.dart';
import 'package:masterjee/models/exam/assesment/AssessmentModel.dart';
import 'package:masterjee/models/exam/exam/ExamSubjectsResponse.dart';
import 'package:masterjee/models/exam/observation/AllTermsResponse.dart';
import 'package:masterjee/others/StorageHelper.dart';
import 'package:masterjee/providers/auth.dart';
import 'package:masterjee/providers/exam_api.dart';
import 'package:masterjee/widgets/CommonButton.dart';
import 'package:masterjee/widgets/app_bar_two.dart';
import 'package:masterjee/widgets/app_tags.dart';
import 'package:masterjee/widgets/custom_form_field.dart';
import 'package:masterjee/widgets/text.dart';
import 'package:provider/provider.dart';

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

  List<ClassData> loadedClassList = [];
  String? _selectedClass;
  late ClassData? classData = null;

  String? _selectedSection;
  int dropDownIndex = 0;
  late SectionData? sectionData = null;

  List<TermData> termList = [];
  String? _selectedTerm = null;
  int _indexTerm = -1;

  List<AssessmentModel> assessmentList = [];
  String? _selectedAssessment = null;
  int _indexAssessment = -1;

  List<GradeModel> gradeList = [];
  String? _selectedGrade = null;
  int _indexGrade = -1;

  bool isChecked = false;

  @override
  void initState() {
    callApiClassSection();
    callApiAllTerms();
    callApiAllAssessments();
    callApiAllGrades();
    super.initState();
  }

  Future<void> callApiClassSection() async {
    try {
      ClassSectionResponse userData =
          await Provider.of<Auth>(context, listen: false).getClassSection(
              StorageHelper.getStringData(StorageHelper.userIdKey).toString());
      if (userData.result && userData.data != null) {
        setState(() {
          loadedClassList = userData.data;
        });
        return;
      }
    } catch (error) {}
  }

  Future<void> callApiAllTerms() async {
    try {
      TermListResponse data = await Provider.of<ExamApi>(context, listen: false)
          .allTerms(
              StorageHelper.getStringData(StorageHelper.userIdKey).toString());
      if (data.result) {
        setState(() {
          termList = data.data ?? [];
        });
        return;
      }
    } catch (error) {}
  }

  Future<void> callApiAllAssessments() async {
    try {
      AssessmentResponse data =
          await Provider.of<ExamApi>(context, listen: false).allAssessments(
              StorageHelper.getStringData(StorageHelper.userIdKey).toString(),
              StorageHelper.getStringData(StorageHelper.classIdKey).toString(),
              StorageHelper.getStringData(StorageHelper.sectionIdKey)
                  .toString());
      if (data.result) {
        setState(() {
          assessmentList = data.data ?? [];
        });
        return;
      }
    } catch (error) {}
  }

  Future<void> callApiAllGrades() async {
    try {
      GradeResponse data = await Provider.of<ExamApi>(context, listen: false)
          .allGrades(
              StorageHelper.getStringData(StorageHelper.userIdKey).toString());
      if (data.result) {
        setState(() {
          gradeList = data.data ?? [];
        });
        return;
      }
    } catch (error) {}
  }

  Future<void> callApiSaveExam() async {
    setState(() {
      _isLoading = true;
    });
    try {
      ExamSubjectResponse data =
          await Provider.of<ExamApi>(context, listen: false).saveExam(
              StorageHelper.getStringData(StorageHelper.userIdKey).toString(),
              classData!.classId,
              sectionData!.sectionId,
              termList[_indexTerm].id,
              assessmentList[_indexAssessment].id,
              gradeList[_indexGrade].id,
              _examNameController.text,
              _descriptionController.text,
              isChecked ? "1" : "0");
      if (data.result) {
        setState(() {
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
                  onPressed: () {
                    if (classData == null) {
                      CommonFunctions.showWarningToast("Please select class");
                    } else if (sectionData == null) {
                      CommonFunctions.showWarningToast("Please select section");
                    } else if (_indexTerm == -1) {
                      CommonFunctions.showWarningToast("Please select term");
                    } else if (_indexAssessment == -1) {
                      CommonFunctions.showWarningToast(
                          "Please select assessment");
                    } else if (_indexGrade == -1) {
                      CommonFunctions.showWarningToast("Please select grade");
                    } else if (_examNameController.text == "") {
                      CommonFunctions.showWarningToast(
                          "Please enter exam name");
                    } else if (_descriptionController.text == "") {
                      CommonFunctions.showWarningToast(
                          "Please enter description");
                    } else {
                      /*  print("classId : ${classData!.id}");
                      print("sectionId : ${sectionData!.id}");
                      print("term : ${termList[_indexTerm].id}");
                      print(
                          "assessment : ${assessmentList[_indexAssessment].id}");
                      print("grade : ${gradeList[_indexGrade].id}");
                      print("examName : ${_examNameController.text}");
                      print("description : ${_descriptionController.text}");
                      print("publish : ${isChecked}");*/
                      callApiSaveExam();
                    }
                  },
                ).paddingOnly(bottom: 30, left: 10, right: 10),
        ),
        body: SingleChildScrollView(
          child: Column(children: [
            gap(10.0),
            Card(
              elevation: 0.1,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              color: colorWhite,
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 10, vertical: 2),
                child: DropdownButton(
                  hint: const CommonText('Select class',
                      size: 14, color: Colors.black54),
                  value: _selectedClass,
                  icon: const Card(
                    elevation: 0.1,
                    color: colorWhite,
                    child: Icon(Icons.keyboard_arrow_down_outlined),
                  ),
                  underline: const SizedBox(),
                  onChanged: (value) {},
                  isExpanded: true,
                  items: loadedClassList.map((cd) {
                    return DropdownMenuItem(
                      value: cd.className,
                      onTap: () {
                        setState(() {
                          _selectedClass = null;
                          _selectedClass = cd.className.toString();
                          for (int i = 0; i < loadedClassList.length; i++) {
                            if (loadedClassList[i].id == cd.id) {
                              classData = loadedClassList[i];
                              dropDownIndex = i;
                              _selectedSection = null;
                              break;
                            }
                          }
                        });
                      },
                      child: Text(
                        cd.className,
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
            loadedClassList.isNotEmpty
                ? Card(
                    elevation: 0.1,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    color: colorWhite,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 10, vertical: 2),
                      child: DropdownButton(
                        hint: const CommonText('Select section',
                            size: 14, color: Colors.black54),
                        value: _selectedSection,
                        icon: const Card(
                          elevation: 0.1,
                          color: colorWhite,
                          child: Icon(Icons.keyboard_arrow_down_outlined),
                        ),
                        underline: const SizedBox(),
                        onChanged: (value) {
                          setState(() {
                          //  if (dropDownIndex != -1) {
                              _selectedSection = null;
                              _selectedSection = value.toString();
                              /*for (int i = 0;
                        i <
                            loadedClassList[dropDownIndex]
                                .sections[i]
                                .section
                                .length;
                        i++) {
                          if (loadedClassList[dropDownIndex]
                              .sections[i]
                              .section
                              .toString()
                              .toLowerCase() ==
                              value.toString().toLowerCase()) {
                            sectionData = loadedClassList[dropDownIndex].sections[i];
                            break;
                          }
                        }*/
                           // }
                          });
                        },
                        isExpanded: true,
                        items:
                            loadedClassList[dropDownIndex].sections.map((cd) {
                          return DropdownMenuItem(
                            value: cd.section,
                            onTap: () {
                              setState(() {
                                //if (dropDownIndex != -1) {
                                  _selectedSection = null;
                                  _selectedSection = cd.section.toString();
                                  for (int i = 0; i < loadedClassList[dropDownIndex].sections[i].section.length; i++) {
                                    if (loadedClassList[dropDownIndex].sections[i].id == cd.id) {
                                      sectionData = loadedClassList[dropDownIndex].sections[i];
                                      print("sectionData : ${jsonEncode(sectionData)}");
                                      break;
                                    }
                                  }
                               // }
                              });
                            },
                            child: Text(
                              cd.section.toString(),
                              style: const TextStyle(
                                color: colorBlack,
                                fontSize: 14,
                              ),
                            ),
                          );
                        }).toList(),
                      ),
                    ),
                  )
                : SizedBox(),
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
                  value: _selectedTerm,
                  icon: const Card(
                    elevation: 0.1,
                    color: colorWhite,
                    child: Icon(Icons.keyboard_arrow_down_outlined),
                  ),
                  underline: const SizedBox(),
                  onChanged: (value) {
                    setState(() {
                      _selectedTerm = null;
                      _selectedTerm = value.toString();
                    });
                  },
                  isExpanded: true,
                  items: termList.map((cd) {
                    return DropdownMenuItem(
                      value: cd.id,
                      onTap: () {
                        setState(() {
                          _selectedTerm = cd.name;
                          for (int i = 0; i < termList.length; i++) {
                            if (termList[i].id == cd.id) {
                              _indexTerm = i;
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
                  value: _selectedAssessment,
                  icon: const Card(
                    elevation: 0.1,
                    color: colorWhite,
                    child: Icon(Icons.keyboard_arrow_down_outlined),
                  ),
                  underline: const SizedBox(),
                  onChanged: (value) {
                    setState(() {
                      _selectedAssessment = null;
                      _selectedAssessment = value.toString();
                    });
                  },
                  isExpanded: true,
                  items: assessmentList.map((cd) {
                    return DropdownMenuItem(
                      value: cd.id,
                      onTap: () {
                        setState(() {
                          _selectedAssessment = cd.name;
                          for (int i = 0; i < assessmentList.length; i++) {
                            if (assessmentList[i].id == cd.id) {
                              _indexAssessment = i;
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
                  value: _selectedGrade,
                  icon: const Card(
                    elevation: 0.1,
                    color: colorWhite,
                    child: Icon(Icons.keyboard_arrow_down_outlined),
                  ),
                  underline: const SizedBox(),
                  onChanged: (value) {
                    setState(() {
                      _selectedGrade = null;
                      _selectedGrade = value.toString();
                    });
                  },
                  isExpanded: true,
                  items: gradeList.map((cd) {
                    return DropdownMenuItem(
                      value: cd.id,
                      onTap: () {
                        setState(() {
                          _selectedGrade = cd.name;
                          for (int i = 0; i < gradeList.length; i++) {
                            if (gradeList[i].id == cd.id) {
                              _indexGrade = i;
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
            gap(10.0),
            Row(
              children: [
                Checkbox(
                  value: isChecked,
                  onChanged: (bool? value) {
                    setState(() {
                      isChecked = value ?? false;
                    });
                  },
                  checkColor: Colors.white,
                  activeColor: Colors.green,
                  materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                  visualDensity: VisualDensity.compact,
                ),
                gap(10.0),
                CommonText.medium(
                  "Publish",
                  size: 14.sp,
                  color: colorBlack,
                  overflow: TextOverflow.fade,
                ),
              ],
            ),
            gap(30.0),
          ]),
        ).paddingOnly(left: 10, right: 10, top: 10));
  }
}
