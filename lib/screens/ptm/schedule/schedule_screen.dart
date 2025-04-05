import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:masterjee/constants.dart';
import 'package:masterjee/widgets/CommonButton.dart';
import 'package:masterjee/widgets/app_bar_two.dart';
import 'package:masterjee/widgets/app_tags.dart';
import 'package:masterjee/widgets/custom_form_field.dart';
import 'package:masterjee/widgets/text.dart';

class ScheduleScreen extends StatefulWidget {
  const ScheduleScreen({super.key});

  static String routeName = 'ScheduleScreen';

  @override
  State<ScheduleScreen> createState() => _ScheduleScreenState();
}

class _ScheduleScreenState extends State<ScheduleScreen> {
  String? _selectedSubject;
  String? _selectedTemplate;

  List<int> resultData = [1, 2,];


  List<String> subjectData = [
    "PTM 2025-08-12",
    "1001 2025-08-12",
  ];
  bool _isChecked = false;
  List<String> template = [
    "08:13 - 04:14",
  ];
  final _fromDateController = TextEditingController();
  final _fromRollNoFromController = TextEditingController();
  final _fromRollNoToController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: kBackgroundColor,
        appBar: AppBarTwo(title: AppTags.schedule),
        bottomNavigationBar: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
          child: CommonButton(
            cornersRadius: 30,
            text: AppTags.submit,
            onPressed: () {
              setState(() {});
            },
          ),
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              gap(10.sp),
              Card(
                margin: EdgeInsets.only(left: 15, right: 15),
                elevation: 0.1,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                color: colorWhite,
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 10, vertical: 2),
                  child: DropdownButton(
                    hint: const CommonText('Select PTM...',
                        size: 14, color: Colors.black54),
                    value: _selectedSubject,
                    icon: const Card(
                      elevation: 0.1,
                      color: colorWhite,
                      child: Icon(Icons.keyboard_arrow_down_outlined),
                    ),
                    underline: const SizedBox(),
                    onChanged: (value) {
                      setState(() {
                        _selectedSubject = null;
                        _selectedSubject = value.toString();
                        for (int i = 0; i < subjectData.length; i++) {
                          if (subjectData[i].toString().toLowerCase() ==
                              value.toString().toLowerCase()) {
                            break;
                          }
                        }
                      });
                    },
                    isExpanded: true,
                    items: subjectData.map((cd) {
                      return DropdownMenuItem(
                        value: cd,
                        onTap: () {
                          setState(() {
                            _selectedSubject = cd;
                            for (int i = 0; i < subjectData.length; i++) {
                              if (subjectData[i].toString().toLowerCase() ==
                                  cd.toString().toLowerCase()) {
                                break;
                              }
                            }
                          });
                        },
                        child: Text(
                          cd.toString(),
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
                margin: EdgeInsets.only(left: 15, right: 15),
                elevation: 0.1,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                color: colorWhite,
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 10, vertical: 2),
                  child: DropdownButton(
                    hint: const CommonText('Select slot...',
                        size: 14, color: Colors.black54),
                    value: _selectedTemplate,
                    icon: const Card(
                      elevation: 0.1,
                      color: colorWhite,
                      child: Icon(Icons.keyboard_arrow_down_outlined),
                    ),
                    underline: const SizedBox(),
                    onChanged: (value) {
                      setState(() {
                        _selectedTemplate = null;
                        _selectedTemplate = value.toString();
                        for (int i = 0; i < template.length; i++) {
                          if (template[i].toString().toLowerCase() ==
                              value.toString().toLowerCase()) {
                            break;
                          }
                        }
                      });
                    },
                    isExpanded: true,
                    items: template.map((cd) {
                      return DropdownMenuItem(
                        value: cd,
                        onTap: () {
                          setState(() {
                            _selectedTemplate = cd;
                            for (int i = 0; i < template.length; i++) {
                              if (template[i].toString().toLowerCase() ==
                                  cd.toString().toLowerCase()) {
                                // _selectedSubjectId = template[i].toString();
                                break;
                              }
                            }
                          });
                        },
                        child: Text(
                          cd.toString(),
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
                keyboardType: TextInputType.number,
                borderRadius: 10.0,
                onTap: () {},
                hintText: 'Roll no from',
                isRequired: true,
                validate: (value) {
                  if (value!.isEmpty) {
                    return 'Please enter Roll no from';
                  }
                  return null;
                },
                isReadonly: false,
                controller: _fromRollNoFromController,
                onSave: (value) {
                  // _authData['email'] = value.toString();
                  _fromRollNoFromController.text = value as String;
                },
              ).paddingOnly(left: 15, right: 15),
              gap(10.sp),
              CustomTextField(
                keyboardType: TextInputType.number,
                borderRadius: 10.0,
                onTap: () {},
                hintText: 'Roll no to',
                isRequired: true,
                validate: (value) {
                  if (value!.isEmpty) {
                    return 'Please enter Roll no to';
                  }
                  return null;
                },
                isReadonly: false,
                controller: _fromRollNoToController,
                onSave: (value) {
                  // _authData['email'] = value.toString();
                  _fromRollNoToController.text = value as String;
                },
              ).paddingOnly(left: 15, right: 15),
              ListView.builder(
                  physics: NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  itemCount: resultData.length,
                  padding: EdgeInsets.only(top: 10.sp),
                  itemBuilder: (BuildContext context, int index) {
                    return assignmentCard(resultData[index], false);
                  }),
              SizedBox(
                height: 30,
              )
            ],
          ),
        ));
  }

  Widget assignmentCard(int a, bool isClosed) {
    return Container(
      margin: EdgeInsets.only(bottom: 10.sp),
      child: Row(
        children: [
          Checkbox(
            checkColor: colorWhite,
            activeColor: colorGreen,
            value: _isChecked,
            onChanged: (bool? value) {
              setState(() {
                _isChecked = value ?? false;
              });
            },
          ),
          CommonText('marko student ${a*99999999}', size: 14, color: colorBlack)
        ],
      ).paddingOnly(left: 5, right: 15),
    );
  }


}
