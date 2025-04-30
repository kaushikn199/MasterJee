import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get/get_common/get_reset.dart';
import 'package:masterjee/constants.dart';
import 'package:masterjee/widgets/CommonButton.dart';
import 'package:masterjee/widgets/app_bar_two.dart';
import 'package:masterjee/widgets/app_tags.dart';
import 'package:masterjee/widgets/circular_radio_button.dart';
import 'package:masterjee/widgets/text.dart';
import 'package:masterjee/widgets/util.dart';

class AssesmentScreen extends StatefulWidget {
  const AssesmentScreen({super.key});

  static String routeName = 'AssesmentScreen';

  @override
  State<AssesmentScreen> createState() => _AssesmentScreenState();
}

class _AssesmentScreenState extends State<AssesmentScreen> {

  String? _selectedSubject;
  String? _selectedTemplate;

  List<String> subjectData = [
    "PA-1",
    "Personal",
    "Sanskrit",
    "Kannada",
    "English"
  ];

  List<String> template = [
    "Business Management",
    "Science",
    "History",
    "Maths",
    "Economics",
  ];
  String _selectedValue = 'Option 1'; // Default value

  String? _selectedSubjectId;
  bool _isLoading = false;
  List<ResultModel> resultData = [
    ResultModel(value: 1),
    ResultModel(value: 2),
    ResultModel(value: 3),
    ResultModel(value: 4),
    ResultModel(value: 5),
  ];

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
            },
          ),
        ).paddingAll(10),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            gap(10.sp),
            Card(
              margin: const EdgeInsets.only(left: 15, right: 15),
              elevation: 0.1,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              color: kBackgroundColor,
              child: Padding(
                padding:
                const EdgeInsets.symmetric(horizontal: 10, vertical: 2),
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
                      for (int i = 0; i < subjectData.length; i++) {
                        if (subjectData[i].toString().toLowerCase() ==
                            value.toString().toLowerCase()) {
                          _selectedSubjectId = subjectData[i].toString();
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
                              _selectedSubjectId = subjectData[i].toString();
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
              margin: const EdgeInsets.only(left: 15, right: 15),
              elevation: 0.1,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              color: kBackgroundColor,
              child: Padding(
                padding:
                const EdgeInsets.symmetric(horizontal: 10, vertical: 2),
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
                      for (int i = 0; i < template.length; i++) {
                        if (template[i].toString().toLowerCase() ==
                            value.toString().toLowerCase()) {
                          _selectedSubjectId = template[i].toString();
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
            Expanded(child:
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 10.sp),
              child: ListView.builder(
                  shrinkWrap: true,
                  itemCount: resultData.length,
                  padding: EdgeInsets.only(top: 10.sp),
                  itemBuilder: (BuildContext context, int index) {
                    return assignmentCard(resultData[index], false);
                  }),
            )
            ),
          ],
        ));
  }

  Widget assignmentCard(ResultModel a, bool isClosed) {
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
            CommonText.bold("venkatesh ${a.value*99}", textAlign: TextAlign.start,  size: 14.sp, color: Colors.black, overflow: TextOverflow.fade),
            gap(10.sp),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                CircularRadioButton(
                  isSelected: a.isChecked,
                  onTap: () {
                    setState(() {
                      a.isChecked = !a.isChecked;
                    });
                    print('Checked: ${a.isChecked}');
                  },
                ),
                gap(8.0),
                CommonText.medium("Present", textAlign: TextAlign.start,
                    size: 12.sp, color: Colors.black,
                    overflow: TextOverflow.fade),
              ],
            ),
            gap(10.sp),
            TextFormField(
              style: const TextStyle(fontSize: 14),
              keyboardType: TextInputType.number,
              maxLines: 1,
              decoration: getInputDecoration(
                  'Score',
                  null,
                  kSecondBackgroundColor,
                  Colors.white
              ),
              validator: (input) {
                if (input == null){
                  return "Please enter score";
                }else{
                  return "";
                }
              },
              onSaved: (value) {
              },
            ),
            gap(10.sp),
            TextFormField(
              style: const TextStyle(fontSize: 14),
              keyboardType: TextInputType.number,
              maxLines: 1,
              decoration: getInputDecoration(
                  'Note',
                  null,
                  kSecondBackgroundColor,
                  Colors.white
              ),
              validator: (input) {
                if (input == null){
                  return "Please enter note";
                }else{
                  return "";
                }
              },
              onSaved: (value) {
              },
            ),


            //  gap(10.sp),
          ],
        ),
      ),
    );
  }

  rowValue(String key, value) {
    return Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
      SizedBox(width: 100.sp, child: CommonText.medium(key, size: 12.sp, color: Colors.black)),
      SizedBox(width: 20.w),
      CommonText.medium(value, size: 14.sp, color: kDarkGreyColor, overflow: TextOverflow.fade),
    ]);
  }

}

class ResultModel {
  int value;
  bool isChecked;

  ResultModel({
    required this.value,
    this.isChecked = false,
  });
}
