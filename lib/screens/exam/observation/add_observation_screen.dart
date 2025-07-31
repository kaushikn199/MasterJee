import 'package:flutter/material.dart';

import 'dart:convert';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get/get_utils/src/extensions/widget_extensions.dart';
import 'package:masterjee/constants.dart';
import 'package:masterjee/models/exam/ObservationResponse.dart';
import 'package:masterjee/models/exam/exam/ExamSubjectsResponse.dart';
import 'package:masterjee/widgets/CommonButton.dart';
import 'package:masterjee/widgets/app_bar_two.dart';
import 'package:masterjee/widgets/app_tags.dart';
import 'package:masterjee/widgets/custom_form_field.dart';
import 'package:masterjee/widgets/text.dart';

class AddObservationScreen extends StatefulWidget {
  const AddObservationScreen({super.key});

  static String routeName = 'addObservationScreen';

  @override
  State<AddObservationScreen> createState() => _AddObservationScreenState();
}

class _AddObservationScreenState extends State<AddObservationScreen> {

  var _isLoading = false;
  late List<TextEditingController> selectParameterController = [];
  late List<TextEditingController> maxMarkController = [];
  late var observationNameController = TextEditingController();
  late var descriptionController = TextEditingController();
  String? _selectedLesson = null;
  List<int> paramsList = [];
  void _ensureSlotController(int index) {
    while (selectParameterController.length <= index) {
      selectParameterController.add(TextEditingController());
      maxMarkController.add(TextEditingController());
    }
  }
  late List<ExamSubjectData> examSubjectDataList = [];
  int _indexLesson = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarTwo(title: AppTags.observation),
      backgroundColor: colorGaryBG,
      bottomNavigationBar: CommonButton(
        paddingHorizontal: 7,
        cornersRadius: 10,
        text: AppTags.add,
        onPressed: () {
        },
      ).paddingOnly(bottom: 30, left: 10, right: 10),
      body: Builder(builder: (context) {
        if (_isLoading) {
          return SizedBox(
            height: MediaQuery.of(context).size.height * .5,
            child: const Center(
              child: CircularProgressIndicator(),
            ),
          );
        }
        return SingleChildScrollView(
          child: Column(
            children: [
              Center(
                child: Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      CustomTextField(
                        hintText: 'Observation Name',
                        isReadonly: false,
                        controller: observationNameController,
                        keyboardType: TextInputType.name,
                        onSave: (value) {
                          observationNameController.text = value as String;
                        },
                      ),
                      gap(10.0),
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
                      Column(
                        children: List.generate(paramsList.length, (index) {
                          return assignmentCard(index);
                        }),
                      ),
                      gap(10.0),
                      SizedBox(
                        width: 200,
                        child: CommonButton(
                          paddingHorizontal: 7,
                          paddingVertical: 9,
                          cornersRadius: 10,
                          text: "Add More",
                          onPressed: () {
                            setState(() {
                              _ensureSlotController(paramsList.length + 1);
                              paramsList.add(0);
                            });
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        );
      }),
    );
  }

  Widget assignmentCard(int index) {
    //maxMarkController[index].text = a.maximumMarks.toString();
    //  paramsList[index].selectedParam = paramsList[index].pname ?? "";
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
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
        CustomTextField(
          hintText: 'Max mark',
          isReadonly: false,
          controller: maxMarkController[index],
          keyboardType: TextInputType.number,
          onSave: (value) {
            maxMarkController[index].text = value as String;
          },
        ),
      ],
    );
  }

}
