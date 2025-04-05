import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:masterjee/constants.dart';
import 'package:masterjee/widgets/CommonButton.dart';
import 'package:masterjee/widgets/app_bar_two.dart';
import 'package:masterjee/widgets/app_tags.dart';
import 'package:masterjee/widgets/custom_form_field.dart';
import 'package:masterjee/widgets/text.dart';

class MinutebookScreen extends StatefulWidget {
  const MinutebookScreen({super.key});

  static String routeName = 'MinutebookScreen';


  @override
  State<MinutebookScreen> createState() => _MinutebookScreenState();
}

class _MinutebookScreenState extends State<MinutebookScreen> {

  String? _selectedSubject;
  String? _selectedTemplate;

  List<String> subjectData = [
    "abc133 - venkatesh",
    "1001 - ABC",
    "1 Raj L",
    "Savitha",
    "Mona d"
  ];
  bool _isChecked = false;
  List<String> template = [
    "08:13 - 04:14",
  ];
  final _fromDateController = TextEditingController();
  final _fromRollNoFromController = TextEditingController();
  final _fromRollNoToController = TextEditingController();

  double _progressValue = 0.1; // Initial progress (30%)

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
        backgroundColor: kBackgroundColor,
        appBar: AppBarTwo(title: AppTags.minutebook),
        bottomNavigationBar:  CommonButton(
          cornersRadius: 30,
          text: AppTags.submit,
          onPressed: () {
            setState(() {

            });
          },
        ).paddingOnly(left: 15,right: 15,bottom: 30),
        body: SingleChildScrollView(
          child: Column(
            children: [
              gap(10.sp),
              Card (
                margin: const EdgeInsets.only(left: 15, right: 15),
                elevation: 0.1,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                color: colorWhite,
                child: Padding(
                  padding:
                  const EdgeInsets.symmetric(horizontal: 10, vertical: 2),
                  child: DropdownButton(
                    hint: const CommonText('Student',
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
              const CommonText("Parent satisfaction score",
                  size: 14, color: colorBlack).paddingOnly(left: 20,right: 15),
              Slider(
                value: _progressValue,
                min: 0.0,
                max: 1.0,
                activeColor: colorGreen, // Progress color
                inactiveColor: colorWhite, // Background color
                onChanged: (double value) {
                  setState(() {
                    _progressValue = value; // Update progress
                  });
                },
              ),
              CommonText("${(_progressValue * 10).toInt()}%",
                  size: 14, color: colorBlack).paddingOnly(left: 20,right: 15),
              gap(15.sp),
              CustomTextField(
                keyboardType: TextInputType.text,
                borderRadius: 10.0,
                onTap: () {},
                maxLines: 3,
                hintText: 'Parents feedback',
                isRequired: true,
                validate: (value) {
                  if (value!.isEmpty) {
                    return 'Please enter parents feedback';
                  }
                  return null;
                },
                isReadonly: false,
                controller: _fromRollNoFromController,
                onSave: (value) {
                  // _authData['email'] = value.toString();
                  _fromRollNoFromController.text = value as String;
                },
              ).paddingOnly(left: 15,right: 15),
              gap(10.sp),
              CustomTextField(
                keyboardType: TextInputType.text,
                borderRadius: 10.0,
                maxLines: 3,
                onTap: () {},
                hintText: 'Parents complain',
                isRequired: true,
                validate: (value) {
                  if (value!.isEmpty) {
                    return 'Please enter parents complain';
                  }
                  return null;
                },
                isReadonly: false,
                controller: _fromRollNoToController,
                onSave: (value) {
                  // _authData['email'] = value.toString();
                  _fromRollNoToController.text = value as String;
                },
              ).paddingOnly(left: 15,right: 15),
              Row(
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
                  const CommonText('Need special attention?',
                      size: 14, color: colorBlack)
                ],
              ).paddingOnly(left: 5,right: 15),

            const SizedBox(height: 20,)
            ],
          ),
        ));
  }
}
