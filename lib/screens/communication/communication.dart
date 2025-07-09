import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';
import 'package:masterjee/constants.dart';
import 'package:masterjee/models/all_student/all_students_model.dart';
import 'package:masterjee/models/all_student/student_template_model.dart';
import 'package:masterjee/models/class_section/class_section_response.dart';
import 'package:masterjee/models/common_functions.dart';
import 'package:masterjee/models/communication/communication_model.dart';
import 'package:masterjee/models/error_model.dart';
import 'package:masterjee/others/StorageHelper.dart';
import 'package:masterjee/providers/attendance_api.dart';
import 'package:masterjee/providers/auth.dart';
import 'package:masterjee/providers/communication.dart';
import 'package:masterjee/providers/student_progress_api.dart';
import 'package:masterjee/widgets/CommonButton.dart';
import 'package:masterjee/widgets/app_bar_two.dart';
import 'package:masterjee/widgets/app_tags.dart';
import 'package:masterjee/widgets/custom_form_field.dart';
import 'package:masterjee/widgets/text.dart';
import 'package:masterjee/widgets/util.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:provider/provider.dart';
import 'package:quill_html_editor/quill_html_editor.dart';

class CommunicationScreen extends StatefulWidget {
  const CommunicationScreen({super.key});

  static String routeName = 'communicationScreen';

  @override
  State<CommunicationScreen> createState() => _CommunicationScreenState();
}

class _CommunicationScreenState extends State<CommunicationScreen> with SingleTickerProviderStateMixin {
  var _isLoading = false;
  CommunicationLogs communicationLogs = CommunicationLogs();
  NoticeLogs noticeLogs = NoticeLogs();
  late TabController tabController;
  final formKey = GlobalKey<FormState>();

  @override
  void initState() {
    tabController = TabController(length: 2, vsync: this);
    getData();
    tabController.addListener(() {
      if (tabController.index == 0) {
        getData();
      } else if (tabController.index == 1) {
        getHostelRooms();
      }
    });
    callApiClassSection();
    callApiGetAllStudents();
    super.initState();
  }

  @override
  void dispose() {
    tabController.dispose();
    super.dispose();
  }

  void getData() {
    setState(() {
      _isLoading = true;
    });
    Provider.of<CommunicationProvider>(context, listen: false).getLogs().then((value) {
      setState(() {
        communicationLogs = value;
        _isLoading = false;
      });
    });
  }

  void getHostelRooms() {
    setState(() {
      _isLoading = true;
    });
    Provider.of<CommunicationProvider>(context, listen: false).getNotice().then((value) {
      setState(() {
        noticeLogs = value;
        _isLoading = false;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarTwo(title: AppTags.communication),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          if (tabController.index == 0) {
            _showBottomSheet(context);
          } else {
            _showBottomSheetForRooms(context);
          }
        },
        label: CommonText(
          "${AppTags.add}${AppTags.space}${tabController.index == 0 ? AppTags.communication : AppTags.notice}",
          color: Colors.white,
          size: 12.sp,
        ),
        icon: Icon(
          Icons.add,
          color: Colors.white,
          size: 22.sp,
        ),
        backgroundColor: colorGreen,
      ),
      body: Stack(
        children: [
          Builder(builder: (context) {
            return Container(
              padding: EdgeInsets.only(top: 10.sp),
              child: Column(children: [
                Container(
                  height: 50.sp,
                  margin: const EdgeInsets.symmetric(horizontal: 10),
                  padding: EdgeInsets.symmetric(horizontal: 10.sp, vertical: 5.sp),
                  decoration: const BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(10)),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black12,
                      ),
                      BoxShadow(
                        color: Colors.white,
                        spreadRadius: -2.0,
                        blurRadius: 5.0,
                      ),
                    ],
                  ),
                  child: TabBar(
                    controller: tabController,
                    indicatorSize: TabBarIndicatorSize.tab,
                    dividerColor: Colors.transparent,
                    indicator: const BoxDecoration(
                      color: colorGreen,
                      borderRadius: BorderRadius.all(Radius.circular(10)),
                    ),
                    labelColor: Colors.white,
                    unselectedLabelColor: Colors.black,
                    indicatorColor: colorGreen,
                    tabs: [
                      Tab(
                        icon: CommonText.medium(
                          AppTags.communication,
                          size: 14.sp,
                          overflow: TextOverflow.fade,
                        ),
                      ),
                      Tab(
                        icon: CommonText.medium(
                          AppTags.notice,
                          size: 14.sp,
                          overflow: TextOverflow.fade,
                        ),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: TabBarView(
                    controller: tabController,
                    children: [
                      Builder(builder: (context) {
                        if (_isLoading) {
                          return SizedBox(
                            height: MediaQuery.of(context).size.height * .5,
                            child: const Center(
                              child: CircularProgressIndicator(),
                            ),
                          );
                        }
                        if (communicationLogs.data == null || communicationLogs.data!.isEmpty) {
                          return Center(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(Icons.hourglass_empty_outlined, size: 100.sp),
                                CommonText.medium('No Record Found',
                                    size: 16.sp, color: kDarkGreyColor, overflow: TextOverflow.fade),
                              ],
                            ),
                          );
                        }
                        return Padding(
                          padding: EdgeInsets.symmetric(horizontal: 10.sp),
                          child: ListView.builder(
                              shrinkWrap: true,
                              itemCount: communicationLogs.data?.length ?? 0,
                              padding: EdgeInsets.only(top: 10.sp),
                              itemBuilder: (BuildContext context, int index) {
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
                                          padding: EdgeInsets.all(10.sp),
                                          decoration: BoxDecoration(
                                              borderRadius: BorderRadius.only(
                                                  topRight: Radius.circular(10.r), topLeft: Radius.circular(10.r)),
                                              color: kToastTextColor),
                                          child: Text(
                                            fromLocalYMDDateTimeString(communicationLogs.data?[index].createdAt ?? "")
                                                .toLocalMDYDateTimeString(),
                                            style: TextStyle(
                                              fontSize: 18.sp,
                                              fontWeight: FontWeight.w700,
                                            ),
                                          ),
                                        ),
                                      ),
                                      Padding(
                                        padding: EdgeInsets.all(20.sp),
                                        child: Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          mainAxisAlignment: MainAxisAlignment.start,
                                          children: [
                                            colValue("Title", communicationLogs.data?[index].title ?? "-"),
                                            gap(10.sp),
                                            colValue("Message", communicationLogs.data?[index].message ?? "-"),
                                            gap(10.sp),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                );
                              }),
                        );
                      }),
                      Builder(builder: (context) {
                        if (_isLoading) {
                          return SizedBox(
                            height: MediaQuery.of(context).size.height * .5,
                            child: const Center(
                              child: CircularProgressIndicator(),
                            ),
                          );
                        }
                        if (noticeLogs.data == null || noticeLogs.data!.isEmpty) {
                          return Center(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(Icons.hourglass_empty_outlined, size: 100.sp),
                                CommonText.medium('No Record Found',
                                    size: 16.sp, color: kDarkGreyColor, overflow: TextOverflow.fade),
                              ],
                            ),
                          );
                        }
                        return Padding(
                          padding: EdgeInsets.symmetric(horizontal: 10.sp),
                          child: ListView.builder(
                              shrinkWrap: true,
                              itemCount: noticeLogs.data?.length,
                              padding: EdgeInsets.only(top: 10.sp),
                              itemBuilder: (BuildContext context, int index) {
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
                                          padding: EdgeInsets.all(10.sp),
                                          decoration: BoxDecoration(
                                              borderRadius: BorderRadius.only(
                                                  topRight: Radius.circular(10.r), topLeft: Radius.circular(10.r)),
                                              color: kToastTextColor),
                                          child: Text(
                                            noticeLogs.data?[index].createdAt.toString() ?? "",
                                            style: TextStyle(
                                              fontSize: 18.sp,
                                              fontWeight: FontWeight.w700,
                                            ),
                                          ),
                                        ),
                                      ),
                                      Padding(
                                        padding: EdgeInsets.all(20.sp),
                                        child: Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          mainAxisAlignment: MainAxisAlignment.start,
                                          children: [
                                            colValue("Title", noticeLogs.data?[index].title ?? "-"),
                                            gap(10.sp),
                                            colHtmlValue("Message", noticeLogs.data?[index].message ?? "-"),
                                            gap(10.sp),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                );
                              }),
                        );
                      })
                    ],
                  ),
                )
              ]),
            );
          })
        ],
      ),
    );
  }

  Future<void> callApiNotice(
      String title, description, noticeDate, publishDate, List<String> audience, File? file) async {
    setState(() {
      _isLoading = true;
    });
    try {
      Map<String, String> body = {
        'userId': StorageHelper.getStringData(StorageHelper.userIdKey).toString(),
        "title": title,
        "noticeDate": noticeDate,
        "publishDate": publishDate,
        "audience": "",
        "message": description,
        "teacher": audience.contains("Teacher") ? "1" : "0",
        "parent": audience.contains("Parent") ? "1" : "0",
        "student": audience.contains("Student") ? "1" : "0",
      };
      print(body);
      ErrorMessageModel data = await Provider.of<CommunicationProvider>(context, listen: false).saveNotice(body, file);
      if (data.status == "success") {
        setState(() {
          Navigator.pop(context);
          FocusScope.of(context).unfocus();
          CommonFunctions.showSuccessToast(data.message ?? "");
          _isLoading = false;
          getData();
        });
        return;
      } else {
        setState(() {
          CommonFunctions.showWarningToast(data.message ?? "");
          _isLoading = false;
        });
      }
    } catch (error) {
      setState(() {
        _isLoading = false;
      });
    }
  }

  Future<void> callApiSaveCommunication(
      String classId, sectionId, studentId, tempId, description, List<String> selectedType, File? file) async {
    setState(() {
      _isLoading = true;
    });
    try {
      Map<String, String> body = {
        'userId': StorageHelper.getStringData(StorageHelper.userIdKey).toString(),
        "classId": classId.toString(),
        "sectionId": sectionId.toString(),
        "studentId": studentId.toString(),
        "message": description.toString(),
        "sms": selectedType.contains("SMS") ? "sms" : "",
        "whatsapp": selectedType.contains("WhatsApp") ? "whatsapp" : "",
        "email": selectedType.contains("Email") ? "email" : "",
        "tempId": tempId.toString(),
        "file":""
      };
      ErrorMessageModel data =
          await Provider.of<CommunicationProvider>(context, listen: false).saveCommunication(body, file);
      if (data.status == "success") {
        setState(() {
          Navigator.pop(context);
          FocusScope.of(context).unfocus();
          CommonFunctions.showSuccessToast(data.message ?? "");
          _isLoading = false;
          getData();
        });
        return;
      } else {
        setState(() {
          CommonFunctions.showWarningToast(data.message ?? "");
          _isLoading = false;
        });
      }
    } catch (error) {
      setState(() {
        _isLoading = false;
      });
    }
  }

  late List<ClassData> loadedClassList = [];

  Future<void> callApiClassSection() async {
    try {
      ClassSectionResponse userData = await Provider.of<Auth>(context, listen: false)
          .getClassSection(StorageHelper.getStringData(StorageHelper.userIdKey).toString());
      if (userData.result) {
        await StorageHelper.saveClassList(userData.data);
        loadedClassList = [];
        loadedClassList = await StorageHelper.getClassList();
        for (var user in loadedClassList) {
          print('${user.classId.toString()} - ${user.className.toString()}');
        }
        return;
      }
    } catch (error) {}
  }

  String? selectedStudent;
  String? selectedTemplate;
  List<StudentData> studentList = [];
  List<Template> template = [];
  String? selectedStudentId;
  String? selectedTemplateId;

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

  void _showBottomSheet(BuildContext mainCon) {
    String? selectedClass;
    int dropDownIndex = 0;
    String? selectedSection;
    String? classId;
    String? sectionId;
    final descriptionController = TextEditingController();
    String? selectedType;
    final List<String> types = ['SMS', 'WhatsApp', 'Email'];
    final List<String> selectedTypesValue = [];
    selectedStudentId = null;
    selectedTemplateId = null;
    selectedStudent = null;
    selectedTemplate = null;
    final uploadFileController = TextEditingController();
    File? selectedFile;

    checkValidation(BuildContext context) async {
      if (classId == null && sectionId == null) {
        if (selectedStudentId == null) {
          CommonFunctions.showWarningToast("Please select student");
        } else if (selectedStudentId != null) {
          if (selectedTemplateId == null) {
            CommonFunctions.showWarningToast("Please select template");
          } else if (selectedTypesValue.isEmpty) {
            CommonFunctions.showWarningToast("Please select at least one type");
          } else if (selectedTypesValue.isEmpty) {
            CommonFunctions.showWarningToast("Please select at least one type");
          } else if (selectedTypesValue.contains("Email")) {
            if (uploadFileController.text == "") {
              CommonFunctions.showWarningToast("Please select at least one type");
            }
          }
        } else {
          callApiSaveCommunication(classId ?? "", sectionId ?? "", selectedStudentId ?? "", selectedTemplateId ?? "",
              descriptionController.text, selectedTypesValue, selectedFile);
        }
      }
      if (classId == null) {
        CommonFunctions.showWarningToast("Please select class");
      } else if (sectionId == null) {
        CommonFunctions.showWarningToast("Please select section");
      } else {
        callApiSaveCommunication(classId ?? "", sectionId ?? "", selectedStudentId ?? "", selectedTemplateId ?? "",
            descriptionController.text, selectedTypesValue, selectedFile);
      }
    }

    void showToast(String msg) {
      CommonFunctions.showWarningToast(msg);
    }

    Future<void> openFilePicker() async {
      final result = await FilePicker.platform.pickFiles(
        allowMultiple: false,
        type: FileType.custom,
        allowedExtensions: ['jpg', 'jpeg', 'png', 'pdf', 'doc', 'docx', 'xls', 'xlsx'],
      );

      if (result != null) {
        selectedFile = File(result.files.first.path ?? "");
        final file = result.files.first;
        uploadFileController.text = file.name;
      } else {
        showToast("No file selected");
      }
    }

    Future<bool> requestStoragePermission() async {
      Permission permission = Permission.storage;

      if (await Permission.photos.isGranted) {
        permission = Permission.photos;
      }

      if (await permission.isGranted) {
        return true;
      }

      final status = await permission.request();

      if (status.isGranted) {
        return true;
      } else if (status.isPermanentlyDenied) {
        await openAppSettings();
      } else {
        showToast("Storage permission denied");
      }
      return false;
    }

    Future<void> pickFile() async {
      if (Theme.of(context).platform == TargetPlatform.android) {
        if (await requestStoragePermission()) {
          openFilePicker();
        }
      } else {
        openFilePicker();
      }
    }

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
                child: Form(
                  key: formKey,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          CommonText.bold(AppTags.add + AppTags.space + AppTags.communication, size: 18.sp),
                          GestureDetector(
                              onTap: () {
                                Navigator.pop(context);
                              },
                              child: const Icon(Icons.close, color: Colors.black, size: 24))
                        ],
                      ),
                      gap(10.sp),
                      loadedClassList.isEmpty
                          ? const Text('No class data available')
                          : Card(
                              elevation: 0.1,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12),
                              ),
                              color: colorWhite,
                              child: Padding(
                                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 2),
                                child: DropdownButton(
                                  hint: const CommonText('Select class', size: 14, color: Colors.black54),
                                  value: selectedClass,
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
                                          selectedClass = null;
                                          selectedClass = cd.className.toString();
                                          classId = cd.id;
                                          for (int i = 0; i < loadedClassList.length; i++) {
                                            if (loadedClassList[i].className.toString().toLowerCase() ==
                                                cd.className.toString().toLowerCase()) {
                                              classId = loadedClassList[i].classId;
                                              selectedSection = null;
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
                      loadedClassList.isEmpty
                          ? const Text('No Section data available')
                          : Card(
                              elevation: 0.1,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12),
                              ),
                              color: colorWhite,
                              child: Padding(
                                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 2),
                                child: DropdownButton(
                                  hint: const CommonText('Select section', size: 14, color: Colors.black54),
                                  value: selectedSection,
                                  icon: const Card(
                                    elevation: 0.1,
                                    color: colorWhite,
                                    child: Icon(Icons.keyboard_arrow_down_outlined),
                                  ),
                                  underline: const SizedBox(),
                                  onChanged: (value) {
                                    setState(() {
                                      if (dropDownIndex != -1) {
                                        selectedSection = null;
                                        selectedSection = value.toString();
                                        for (int i = 0;
                                            i < loadedClassList[dropDownIndex].sections[i].section.length;
                                            i++) {
                                          if (loadedClassList[dropDownIndex]
                                                  .sections[i]
                                                  .section
                                                  .toString()
                                                  .toLowerCase() ==
                                              value.toString().toLowerCase()) {
                                            sectionId = loadedClassList[dropDownIndex].sections[i].sectionId.toString();
                                            break;
                                          }
                                        }
                                      }
                                    });
                                  },
                                  isExpanded: true,
                                  items: loadedClassList[dropDownIndex].sections.map((cd) {
                                    return DropdownMenuItem(
                                      value: cd.section,
                                      onTap: () {
                                        setState(() {
                                          if (dropDownIndex != -1) {
                                            selectedSection = null;
                                            selectedSection = cd.section.toString();
                                            for (int i = 0;
                                                i < loadedClassList[dropDownIndex].sections[i].section.length;
                                                i++) {
                                              if (loadedClassList[dropDownIndex]
                                                      .sections[i]
                                                      .section
                                                      .toString()
                                                      .toLowerCase() ==
                                                  cd.section.toString().toLowerCase()) {
                                                sectionId =
                                                    loadedClassList[dropDownIndex].sections[i].sectionId.toString();
                                                break;
                                              }
                                            }
                                          }
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
                            ),
                      gap(10.sp),
                      CommonText.semiBold(AppTags.or, size: 16.sp),
                      gap(10.sp),
                      Card(
                        elevation: 0.1,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        color: colorWhite,
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 2),
                          child: DropdownButton(
                            hint: const CommonText(AppTags.student, size: 14, color: Colors.black54),
                            value: selectedStudent,
                            icon: const Card(
                              elevation: 0.1,
                              color: colorWhite,
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
                                    selectedStudent = cd.firstname;
                                    for (int i = 0; i < studentList.length; i++) {
                                      if (studentList[i].firstname.toString().toLowerCase() ==
                                          cd.firstname.toString().toLowerCase()) {
                                        selectedStudentId = studentList[i].id.toString();
                                        break;
                                      }
                                    }
                                    callApiGetAllTemplate(selectedStudentId.toString());
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
                        elevation: 0.1,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        color: colorWhite,
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 2),
                          child: DropdownButton(
                            hint: const CommonText(AppTags.template, size: 14, color: Colors.black54),
                            value: selectedTemplateId,
                            icon: const Card(
                              elevation: 0.1,
                              color: colorWhite,
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
                                    selectedTemplate = cd.name;
                                    for (int i = 0; i < template.length; i++) {
                                      if (template[i].id == cd.id) {
                                        selectedTemplateId = cd.id.toString();
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
                      CustomTextField(
                        borderRadius: 12,
                        hintText: AppTags.description,
                        controller: descriptionController,
                        keyboardType: TextInputType.text,
                        maxLines: 2,
                        onSave: (value) {
                          descriptionController.text = value as String;
                        },
                      ),
                      gap(10.sp),
                      Wrap(
                        children: types.map((meal) {
                          return Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Checkbox(
                                value: selectedTypesValue.contains(meal),
                                onChanged: (bool? value) {
                                  setState(() {
                                    if (value == true) {
                                      selectedTypesValue.add(meal);
                                    } else {
                                      selectedTypesValue.remove(meal);
                                    }
                                  });
                                },
                              ),
                              Text(meal),
                            ],
                          );
                        }).toList(),
                      ),
                      gap(10.sp),
                      if (selectedTypesValue.contains("Email"))
                        CustomTextField(
                          onTap: () {
                            pickFile();
                          },
                          hintText: 'Select file',
                          isReadonly: true,
                          controller: uploadFileController,
                          prefixIcon: const Icon(
                            Icons.cloud_upload,
                            color: kTextLowBlackColor,
                          ),
                          keyboardType: TextInputType.text,
                          validate: (value) {
                            if (value!.isEmpty) {
                              return 'Max mark cannot be empty';
                            }
                            return null;
                          },
                          onSave: (value) {
                            uploadFileController.text = value as String;
                          },
                        ),
                      gap(10.sp),
                      // Submit Button
                      CommonButton(
                        cornersRadius: 30,
                        text: AppTags.submit,
                        onPressed: () {
                          checkValidation(context);
                        },
                      )
                    ],
                  ),
                ),
              ),
            );
          }),
        );
      },
    );
  }

  void _showBottomSheetForRooms(BuildContext mainCon) {
    final titleController = TextEditingController();
    final noticeDateController = TextEditingController();
    final publishDateController = TextEditingController();
    final quillEditorController = QuillEditorController();
    final uploadFileController = TextEditingController();
    File? selectedFile;
    final List<String> type = ['Teacher', 'Parent', 'Student'];
    final List<String> selectedTypes = [];

    DateTime? _selectedFromDate;
    DateTime? _selectedToDate;

    void showToast(String msg) {
      CommonFunctions.showWarningToast(msg);
    }

    checkValidation(BuildContext context) async {
      String html = "";
      await quillEditorController.getText().then((onValue) {
        setState(() {
          html = onValue;
        });
      });
      if (titleController.text == "") {
        CommonFunctions.showWarningToast("Please enter ${AppTags.title}");
      } else if (noticeDateController.text == "") {
        CommonFunctions.showWarningToast("Please select notice date");
      } else if (publishDateController.text == "") {
        CommonFunctions.showWarningToast("Please select publish date");
      } else if (html == "") {
        CommonFunctions.showWarningToast("Please add description");
      } else if (selectedTypes.isEmpty) {
        CommonFunctions.showWarningToast("Please select at least one audience");
      } else {
        //"2025-02-08"
        await callApiNotice(titleController.text, html, _selectedFromDate!.toAPIYMDDateString(),
            _selectedToDate!.toAPIYMDDateString(), selectedTypes, selectedFile);
      }
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
          noticeDateController.text = pickedDate.toLocalMDYDateString();
        });
      }
    }

    Future<bool> requestStoragePermission() async {
      Permission permission = Permission.storage;

      if (await Permission.photos.isGranted) {
        permission = Permission.photos;
      }

      if (await permission.isGranted) {
        return true;
      }

      final status = await permission.request();

      if (status.isGranted) {
        return true;
      } else if (status.isPermanentlyDenied) {
        await openAppSettings();
      } else {
        showToast("Storage permission denied");
      }
      return false;
    }

    Future<void> openFilePicker() async {
      final result = await FilePicker.platform.pickFiles(
        allowMultiple: false,
        type: FileType.custom,
        allowedExtensions: ['jpg', 'jpeg', 'png', 'pdf', 'doc', 'docx', 'xls', 'xlsx'],
      );

      if (result != null) {
        selectedFile = File(result.files.first.path ?? "");
        final file = result.files.first;
        uploadFileController.text = file.name;
      } else {
        showToast("No file selected");
      }
    }

    Future<void> _selectToDate(BuildContext context) async {
      final DateTime? pickedDate = await showDatePicker(
        context: context,
        initialDate: _selectedToDate ?? DateTime.now(),
        firstDate: DateTime(2000),
        lastDate: DateTime(2101),
      );
      if (pickedDate != null && pickedDate != _selectedToDate) {
        setState(() {
          _selectedToDate = pickedDate;
          publishDateController.text = pickedDate.toLocalMDYDateString();
        });
      }
    }

    Future<void> pickFile() async {
      if (Theme.of(context).platform == TargetPlatform.android) {
        if (await requestStoragePermission()) {
          openFilePicker();
        }
      } else {
        openFilePicker();
      }
    }

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
                child: Form(
                  key: formKey,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          CommonText.bold(AppTags.add + AppTags.space + AppTags.notice, size: 18.sp),
                          GestureDetector(
                              onTap: () {
                                Navigator.pop(context);
                              },
                              child: const Icon(Icons.close, color: Colors.black, size: 24))
                        ],
                      ),
                      gap(10.sp),
                      ToolBar(
                        toolBarColor: Colors.cyan.shade50,
                        activeIconColor: Colors.green,
                        padding: const EdgeInsets.all(8),
                        iconSize: 20,
                        controller: quillEditorController,
                        toolBarConfig: const [
                          ToolBarStyle.undo,
                          ToolBarStyle.redo,
                          ToolBarStyle.headerOne,
                          ToolBarStyle.headerTwo,
                          ToolBarStyle.align,
                          ToolBarStyle.bold,
                          ToolBarStyle.italic,
                          ToolBarStyle.size,
                          ToolBarStyle.blockQuote,
                          ToolBarStyle.directionLtr,
                          ToolBarStyle.directionRtl,
                          ToolBarStyle.color,
                        ],
                      ),
                      QuillHtmlEditor(
                        hintText: '',
                        controller: quillEditorController,
                        text: TextEditingController().text,
                        isEnabled: true,
                        minHeight: 300,
                        hintTextAlign: TextAlign.start,
                        padding: const EdgeInsets.only(left: 10, top: 5),
                        hintTextPadding: EdgeInsets.zero,
                        onFocusChanged: (hasFocus) => debugPrint('has focus $hasFocus'),
                        onTextChanged: (text) => debugPrint('onTextChanged $text'),
                        onEditorCreated: () => debugPrint('Editor has been loaded'),
                        onEditingComplete: (s) => debugPrint('Editing completed $s'),
                        onEditorResized: (height) => debugPrint('Editor resized $height'),
                        onSelectionChanged: (sel) => debugPrint('${sel.index},${sel.length}'),
                        loadingBuilder: (context) {
                          return const Center(
                              child: CircularProgressIndicator(
                            strokeWidth: 0.4,
                          ));
                        },
                      ),
                      gap(10.sp),
                      CustomTextField(
                        hintText: AppTags.title,
                        controller: titleController,
                        keyboardType: TextInputType.name,
                        validate: (value) {
                          if (value!.isEmpty) {
                            return '${AppTags.title} cannot be empty';
                          }
                          return null;
                        },
                        onSave: (value) {
                          titleController.text = value as String;
                        },
                      ),
                      gap(10.sp), //
                      CustomTextField(
                        onTap: () {
                          _selectFromDate(context);
                        },
                        hintText: 'Notice date',
                        isRequired: true,
                        prefixIcon: const Icon(
                          Icons.date_range_outlined,
                          color: kTextLowBlackColor,
                        ),
                        validate: (value) {
                          if (value!.isEmpty) {
                            return 'Notice Date cannot be empty';
                          }
                          return null;
                        },
                        isReadonly: true,
                        controller: noticeDateController,
                        onSave: (value) {
                          noticeDateController.text = value as String;
                        },
                      ), //
                      gap(10.sp), // Dat
                      CustomTextField(
                        onTap: () {
                          _selectToDate(context);
                        },
                        hintText: 'Publish date',
                        isRequired: true,
                        prefixIcon: const Icon(
                          Icons.date_range_outlined,
                          color: kTextLowBlackColor,
                        ),
                        validate: (value) {
                          if (value!.isEmpty) {
                            return 'Publish Date cannot be empty';
                          }
                          return null;
                        },
                        isReadonly: true,
                        controller: publishDateController,
                        onSave: (value) {
                          // _authData['email'] = value.toString();
                          publishDateController.text = value as String;
                        },
                      ), // e P

                      gap(10.sp),

                      CustomTextField(
                        onTap: () {
                          pickFile();
                        },
                        hintText: 'Select file',
                        isReadonly: true,
                        controller: uploadFileController,
                        prefixIcon: const Icon(
                          Icons.cloud_upload,
                          color: kTextLowBlackColor,
                        ),
                        keyboardType: TextInputType.text,
                        validate: (value) {
                          if (value!.isEmpty) {
                            return 'Max mark cannot be empty';
                          }
                          return null;
                        },
                        onSave: (value) {
                          uploadFileController.text = value as String;
                        },
                      ),
                      gap(10.sp),
                      Wrap(
                        children: type.map((typeValue) {
                          return Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Checkbox(
                                value: selectedTypes.contains(typeValue),
                                onChanged: (bool? value) {
                                  setState(() {
                                    if (value == true) {
                                      selectedTypes.add(typeValue);
                                    } else {
                                      selectedTypes.remove(typeValue);
                                    }
                                  });
                                },
                              ),
                              Text(typeValue),
                            ],
                          );
                        }).toList(),
                      ),
                      gap(10.sp),

                      // Submit Button
                      CommonButton(
                        cornersRadius: 30,
                        text: AppTags.submit,
                        onPressed: () {
                          checkValidation(context);
                        },
                      )
                    ],
                  ),
                ),
              ),
            );
          }),
        );
      },
    );
  }
}

colValue(String key, value) {
  return Column(crossAxisAlignment: CrossAxisAlignment.start, mainAxisAlignment: MainAxisAlignment.start, children: [
    CommonText.medium(key, size: 14.sp, color: Colors.black),
    SizedBox(width: 20.w),
    CommonText.medium(value, size: 14.sp, color: Colors.grey, overflow: TextOverflow.fade),
  ]);
}

colHtmlValue(String key, value) {
  return Column(crossAxisAlignment: CrossAxisAlignment.start, mainAxisAlignment: MainAxisAlignment.start, children: [
    CommonText.medium(key, size: 14.sp, color: Colors.black),
    SizedBox(width: 20.w),
    HtmlWidget(
      value,
      textStyle: TextStyle(color: Colors.grey, fontSize: 14.sp),
    ),
  ]);
}
