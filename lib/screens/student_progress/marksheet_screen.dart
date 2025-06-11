import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:masterjee/constants.dart';
import 'package:masterjee/models/all_student/all_students_model.dart';
import 'package:masterjee/models/all_student/student_template_model.dart';
import 'package:masterjee/models/common_functions.dart';
import 'package:masterjee/others/StorageHelper.dart';
import 'package:masterjee/providers/attendance_api.dart';
import 'package:masterjee/providers/student_progress_api.dart';
import 'package:masterjee/screens/download_controller/download_controller.dart';
import 'package:masterjee/widgets/app_bar_two.dart';
import 'package:masterjee/widgets/app_tags.dart';
import 'package:masterjee/widgets/text.dart';
import 'package:provider/provider.dart';

class MarkSheetScreen extends StatefulWidget {
  const MarkSheetScreen({super.key});

  static String routeName = 'MarkSheetScreen';

  @override
  State<MarkSheetScreen> createState() => _MarkSheetScreenState();
}

class _MarkSheetScreenState extends State<MarkSheetScreen> {
  String? _selectedStudent;
  String? _selectedTemplate;
  String _selectedDownload = "Download";
  final DownloadFileController downloadController = Get.put(DownloadFileController());


  List<StudentData> studentList = [];
  List<Template> template = [];

  Future<void> callApiGetAllStudents() async {
    setState(() {
      _isLoading = true;
    });
    try {
      AllStudentsResponse data = await Provider.of<ClassAttendanceApi>(context, listen: false).getAllStudents(
          StorageHelper.getStringData(StorageHelper.userIdKey).toString(),
          StorageHelper.getStringData(StorageHelper.classIdKey).toString(),
          StorageHelper.getStringData(StorageHelper.sectionIdKey).toString());
      if (data.result) {
        setState(() {
          studentList = data.data ?? [];
          _isLoading = false;
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

  Future<void> callApiGetAllTemplate(id) async {
    setState(() {
      _isLoading = true;
    });
    try {
      AllStudentsTemplateResponse data =
          await Provider.of<StudentProgressApi>(context, listen: false).getAllTemplate(id.toString());
      if (data.result!) {
        setState(() {
          template = data.data ?? [];
          _isLoading = false;
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

  Future<void> callApiToSaveRequest(Map<String, dynamic> body) async {
    setState(() {
      _isLoading = true;
    });
    try {
      final data = await Provider.of<StudentProgressApi>(context, listen: false).submitMarkSheet(body);
      if (data.status == "success") {
        setState(() {
          _isLoading = false;
          if(_selectedDownload == "Download") {
            downloadController.requestDownload(data.data!.fileUrl.toString());
          }else {
            CommonFunctions.showSuccessToast("Requested successfully");
          }
        });
        return;
      } else {
        setState(() {
          CommonFunctions.showWarningToast("Something went wrong.");
          _isLoading = false;
        });
      }
    } catch (error) {
      setState(() {
        _isLoading = false;
      });
    }
  }

  List<String> download = [
    "Download",
    "Email/Whatsapp",
  ];

  String? _selectedStudentId;
  String? _selectedTemplateId;
  bool _isLoading = false;

  Future<void> _submit() async {
    if (_selectedStudentId == null || _selectedStudentId == "") {
      CommonFunctions.showWarningToast("Select Student");
    } else if (_selectedTemplateId == null || _selectedTemplateId == "") {
      CommonFunctions.showWarningToast("Select Template");
    } else {
      String downloadValue = "download";
      if (_selectedDownload.toLowerCase() == "download") {
        downloadValue = "download";
      } else if (_selectedDownload.toLowerCase() == "email/whatsapp") {
        downloadValue = "email";
      }
      Map<String, dynamic> body = {
        "userId": StorageHelper.getStringData(StorageHelper.userIdKey).toString(),
        "studentId": _selectedStudentId,
        "templateId": _selectedTemplateId,
        "type": downloadValue
      };
      callApiToSaveRequest(body);
    }
  }

  @override
  void initState() {
    callApiGetAllStudents();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBarTwo(title: AppTags.markSheet),
        body: Column(
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
                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 2),
                child: DropdownButton(
                  hint: const CommonText(AppTags.student, size: 14, color: Colors.black54),
                  value: _selectedStudent,
                  icon: const Card(
                    elevation: 0.1,
                    color: kBackgroundColor,
                    child: Icon(Icons.keyboard_arrow_down_outlined),
                  ),
                  underline: const SizedBox(),
                  onChanged: (value) {},
                  isExpanded: true,
                  items: studentList.map((cd) {
                    return DropdownMenuItem(
                      value: cd.firstname,
                      onTap: () {
                        setState(() {
                          _selectedStudent = cd.firstname;
                          for (int i = 0; i < studentList.length; i++) {
                            if (studentList[i].firstname.toString().toLowerCase() ==
                                cd.firstname.toString().toLowerCase()) {
                              _selectedStudentId = studentList[i].id.toString();
                              break;
                            }
                          }
                          callApiGetAllTemplate(_selectedStudentId.toString());
                        });
                      },
                      child: Text(
                        "${cd.admissionNo} - ${cd.firstname} ${cd.lastname}".toString(),
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
                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 2),
                child: DropdownButton(
                  hint: const CommonText(AppTags.template, size: 14, color: Colors.black54),
                  value: _selectedTemplateId,
                  icon: const Card(
                    elevation: 0.1,
                    color: kBackgroundColor,
                    child: Icon(Icons.keyboard_arrow_down_outlined),
                  ),
                  underline: const SizedBox(),
                  onChanged: (value) {},
                  isExpanded: true,
                  items: template.map((cd) {
                    return DropdownMenuItem(
                      value: cd.id,
                      onTap: () {
                        setState(() {
                          _selectedTemplate = cd.name;
                          for (int i = 0; i < template.length; i++) {
                            if (template[i].id == cd.id) {
                              _selectedTemplateId = cd.id.toString();
                              break;
                            }
                          }
                        });
                      },
                      child: Text(
                        "${cd.id} - ${cd.name}",
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
                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 2),
                child: DropdownButton(
                  hint: const CommonText('Download', size: 14, color: Colors.black54),
                  value: _selectedDownload,
                  icon: const Card(
                    elevation: 0.1,
                    color: kBackgroundColor,
                    child: Icon(Icons.keyboard_arrow_down_outlined),
                  ),
                  underline: const SizedBox(),
                  onChanged: (value) {
                    setState(() {
                      _selectedDownload = value ?? "Download";
                    });
                  },
                  isExpanded: true,
                  items: download.map((cd) {
                    return DropdownMenuItem(
                      value: cd,
                      onTap: () {
                        setState(() {
                          _selectedDownload = cd;
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
                        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
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
