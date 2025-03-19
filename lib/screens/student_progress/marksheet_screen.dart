import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:masterjee/constants.dart';
import 'package:masterjee/widgets/app_bar_two.dart';
import 'package:masterjee/widgets/app_tags.dart';
import 'package:masterjee/widgets/text.dart';

class MarkSheetScreen extends StatefulWidget {
  const MarkSheetScreen({super.key});

  static String routeName = 'MarkSheetScreen';

  @override
  State<MarkSheetScreen> createState() => _MarkSheetScreenState();
}

class _MarkSheetScreenState extends State<MarkSheetScreen> {

  String? _selectedSubject;
  String? _selectedTemplate;
  String? _selectedDownload;

  List<String> subjectData = [
    "abc133 - venkatesh",
    "1001 - ABC",
    "1 Raj L",
    "Savitha",
    "Mona d"
  ];

  List<String> template = [
    "CBSE Examination template",
    "CBSE Exam template",
    "Examination",
    "Performance Profile",
    "UT Template"
  ];

  List<String> download = [
    "Download",
    "Email/Whatsapp",
  ];

  String? _selectedSubjectId;
  bool _isLoading = false;

  Future<void> _submit() async {}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBarTwo(title: AppTags.markSheet),
        body: Column(
          children: [
            gap(10.sp),
            Card(
              margin: EdgeInsets.only(left: 15, right: 15),
              elevation: 0.1,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              color: kBackgroundColor,
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 10, vertical: 2),
                child: DropdownButton(
                  hint: const CommonText('Student',
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
              margin: EdgeInsets.only(left: 15, right: 15),
              elevation: 0.1,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              color: kBackgroundColor,
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 10, vertical: 2),
                child: DropdownButton(
                  hint: const CommonText('Template',
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
            Card(
              margin: EdgeInsets.only(left: 15, right: 15),
              elevation: 0.1,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              color: kBackgroundColor,
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 10, vertical: 2),
                child: DropdownButton(
                  hint: const CommonText('Download',
                      size: 14, color: Colors.black54),
                  value: _selectedDownload,
                  icon: const Card(
                    elevation: 0.1,
                    color: kBackgroundColor,
                    child: Icon(Icons.keyboard_arrow_down_outlined),
                  ),
                  underline: const SizedBox(),
                  onChanged: (value) {
                    setState(() {
                      _selectedDownload = null;
                      _selectedDownload = value.toString();
                      for (int i = 0; i < download.length; i++) {
                        if (download[i].toString().toLowerCase() ==
                            value.toString().toLowerCase()) {
                         // _selectedSubjectId = download[i].toString();
                          break;
                        }
                      }
                    });
                  },
                  isExpanded: true,
                  items: download.map((cd) {
                    return DropdownMenuItem(
                      value: cd,
                      onTap: () {
                        setState(() {
                          _selectedDownload = cd;
                          for (int i = 0; i < download.length; i++) {
                            if (download[i].toString().toLowerCase() ==
                                cd.toString().toLowerCase()) {
                             // _selectedSubjectId = download[i].toString();
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
            const Expanded(child: SizedBox()),
            SizedBox(
              width: double.infinity,
              child: _isLoading
                  ? const Center(child: CircularProgressIndicator())
                  : Padding(
                      padding: const EdgeInsets.all(15.0),
                      child: MaterialButton(
                        elevation: 0,
                        color: colorGreen,
                        onPressed: _submit,
                        padding: const EdgeInsets.symmetric(
                            horizontal: 20, vertical: 16),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadiusDirectional.circular(10),
                          // side: const BorderSide(color: kRedColor),
                        ),
                        child: const Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              'Submit',
                              style: TextStyle(
                                fontSize: 16,
                                color: Colors.white,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
            ),
            const SizedBox(height: 20),
          ],
        ));
  }
}
