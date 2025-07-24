import 'package:flutter/material.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:masterjee/constants.dart';
import 'package:masterjee/models/class_section/class_section_response.dart';
import 'package:masterjee/models/common_functions.dart';
import 'package:masterjee/models/login/login_data.dart';
import 'package:masterjee/others/StorageHelper.dart';
import 'package:masterjee/providers/attendance_api.dart';
import 'package:masterjee/providers/auth.dart';
import 'package:masterjee/screens/apply_leave/apply_leave_screen.dart';
import 'package:masterjee/screens/assesment/assesment_screen.dart';
import 'package:masterjee/screens/attendance/attendance_screen.dart';
import 'package:masterjee/screens/communication/communication.dart';
import 'package:masterjee/screens/content/content_screen.dart';
import 'package:masterjee/screens/dues_report/dues_report_screen.dart';
import 'package:masterjee/screens/exam/exam_main_screen.dart';
import 'package:masterjee/screens/face_attendance/mark_attendance/face_screen.dart';
import 'package:masterjee/screens/face_attendance/register/register_face_screen.dart';
import 'package:masterjee/screens/face_auth/face_auth_screen.dart';
import 'package:masterjee/screens/gmeet_live_classes/gmeet_live_classes_screen.dart';
import 'package:masterjee/screens/homework/homework_screen.dart';
import 'package:masterjee/screens/hostel/hostel_screen.dart';
import 'package:masterjee/screens/leads/leads_screen.dart';
import 'package:masterjee/screens/ptm/ptm.dart';
import 'package:masterjee/screens/reports/reports_main_screen.dart';
import 'package:masterjee/screens/signup_screen.dart';
import 'package:masterjee/screens/student_behaviour/student_behaviour_screen.dart';
import 'package:masterjee/screens/student_progress/student_progress_screen.dart';
import 'package:masterjee/screens/timetable/timetable_screen.dart';
import 'package:masterjee/widgets/CommonButton.dart';
import 'package:masterjee/widgets/app_loader.dart';
import 'package:masterjee/widgets/app_tags.dart';
import 'package:masterjee/widgets/cardHomeWidget.dart';
import 'package:masterjee/widgets/drawers.dart';
import 'package:masterjee/widgets/home_app_bar.dart';
import 'package:masterjee/widgets/text.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:provider/provider.dart';

import '../pay_slip/pay_slip_screen.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  static const routeName = '/Main';

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  late List<ClassData> loadedClassList = [];
  int dropDownIndex = 0;
  late UserData? userData = null;
  String? _selectedClass;
  late ClassData? classData = null;
  String? _selectedSection;
  late SectionData? sectionData = null;

  String? classId;
  String? sectionId;

  void loadUserData() async {
    final user = await StorageHelper.getUserData();
    final classD = await StorageHelper.getSelectedClass();
    final sectionD = await StorageHelper.getSelectedSection();
    final list = await StorageHelper.getClassList();

    setState(() {
      loadedClassList = list;
      userData = user;
      classData = classD;
      sectionData = sectionD;
    });

    print("userData: ${userData?.firstName}");
    print("className: ${classData?.className}");
    print("sectionData: ${sectionData?.section}");
    print("loadedClassList: ${list.length}");
  }

  @override
  void initState() {
    loadUserData();
    callApiClassSection().then(
      (value) {
        WidgetsBinding.instance.addPostFrameCallback((_) {
          if (isClassOrSectionIdMissing()) {
            openDialog();
          }
        });
      },
    );
    pages = [
      const SizedBox(),
      const FaceAuthScreen(),
      const PaySlipScreen(),
    ];
    super.initState();
  }

  List<Widget> pages = [];


  static bool isClassOrSectionIdMissing() {
    final classId = StorageHelper.getStringData(StorageHelper.classIdKey);
    final sectionId = StorageHelper.getStringData(StorageHelper.sectionIdKey);
    return classId == null ||
        classId.isEmpty ||
        sectionId == null ||
        sectionId.isEmpty;
  }

  openDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) => _changeUserPopup(context),
    );
  }

  Future<void> callApiClassSection() async {
    try {
      ClassSectionResponse userData =
          await Provider.of<Auth>(context, listen: false).getClassSection(
              StorageHelper.getStringData(StorageHelper.userIdKey).toString());
      if (userData.result && userData.data != null) {
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

  Future scanAdd() async {
    await Permission.camera.request();
    String? barcode = await FlutterBarcodeScanner.scanBarcode(
        "#ff6666", "Cancel", true, ScanMode.QR);
    if (barcode.isEmpty) {
      CommonFunctions.showWarningToast("Scan Valid QR Code");
    } else {
      if (barcode == "-1") {
      } else {
        if (barcode != "") {
          markQRAttendance();
        } else {
          CommonFunctions.showWarningToast("Scan Valid QR Code");
        }
      }
    }
  }

  Future scanFace() async {
    Get.to(AuthenticateFaceView());
  }

  Future addFace() async {
    Get.to(RegisterFaceScreen());
  }

  Future markQRAttendance() async {
    AppLoader.show(context);
    Map<String, String> data = {
      "id": "2".toString(),
    };
    await ClassAttendanceApi.qrAttendance(data).then((value) {
      if (value.status == "success") {
        CommonFunctions.showSuccessToast(value.message ?? "Success");
      } else {
        CommonFunctions.showWarningToast(value.message ?? "Failed");
      }
    });
  }

  int selectedIndex = 0;

  void onDrawerItemClicked(int index) {
    setState(() {
      selectedIndex = index;
    });
    print("Selected Index: $selectedIndex");
  }

  Widget _changeUserPopup(BuildContext context) {
    var widthSize = MediaQuery.of(context).size.width;
    return AlertDialog(
      backgroundColor: kSecondBackgroundColor,
      surfaceTintColor: kSecondBackgroundColor,
      insetPadding: const EdgeInsets.only(left: 10, right: 10),
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(10))),
      content: StatefulBuilder(
        builder: (context, setState) {
          return SizedBox(
            width: widthSize,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                const Text(
                  "Choose Class Section",
                  style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                      color: Colors.blue),
                ),
                gap(10.0),
                loadedClassList.isEmpty
                    ? const Text('No class data available')
                    : Card(
                        elevation: 0.1,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        color: colorWhite,
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 10, vertical: 2),
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
                                    for (int i = 0;
                                        i < loadedClassList.length;
                                        i++) {
                                      if (loadedClassList[i]
                                              .className
                                              .toString()
                                              .toLowerCase() ==
                                          cd.className
                                              .toString()
                                              .toLowerCase()) {
                                        //_classId = loadedClassList[i].classId;
                                        classData = loadedClassList[i];
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
                loadedClassList.isEmpty
                    ? const Text('No Section data available')
                    : Card(
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
                                if (dropDownIndex != -1) {
                                  _selectedSection = null;
                                  _selectedSection = value.toString();
                                  for (int i = 0;
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
                                      //_sectionId = loadedClassList[dropDownIndex].sections[i].sectionId.toString();
                                      sectionData =
                                          loadedClassList[dropDownIndex]
                                              .sections[i];
                                      break;
                                    }
                                  }
                                }
                              });
                            },
                            isExpanded: true,
                            items: loadedClassList[dropDownIndex]
                                .sections
                                .map((cd) {
                              return DropdownMenuItem(
                                value: cd.section,
                                onTap: () {
                                  setState(() {
                                    if (dropDownIndex != -1) {
                                      _selectedSection = null;
                                      _selectedSection = cd.section.toString();
                                      for (int i = 0;
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
                                            cd.section
                                                .toString()
                                                .toLowerCase()) {
                                          //_sectionId = loadedClassList[dropDownIndex].sections[i].sectionId.toString();
                                          sectionData =
                                              loadedClassList[dropDownIndex]
                                                  .sections[i];
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
                gap(20.0),
                CommonButton(
                  cornersRadius: 30,
                  text: AppTags.submit,
                  onPressed: () {
                    if (classData != null && sectionData != null) {
                      StorageHelper.saveSelectedClass(classData!);
                      StorageHelper.saveSelectedSectionData(sectionData!);
                      StorageHelper.setStringData(StorageHelper.classIdKey,
                          classData?.classId.toString() ?? "");
                      StorageHelper.setStringData(StorageHelper.sessionIdKey,
                          classData?.sessionId.toString() ?? "");
                      StorageHelper.setStringData(StorageHelper.sectionIdKey,
                          sectionData?.sectionId.toString() ?? "");
                      loadUserData();
                      Navigator.of(context).pop();
                    }
                  },
                )
              ],
            ),
          );
        },
      ),
    );
  }

  int pageIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: Container(
          height: 60,
          decoration: const BoxDecoration(
            color: colorGreen,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(20),
              topRight: Radius.circular(20),
            ),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              IconButton(
                enableFeedback: false,
                onPressed: () {
                  setState(() {
                    pageIndex = 0;
                    print("pageIndex : ${pageIndex}");
                  });
                },
                icon: const Icon(
                  Icons.home_outlined,
                  color: Colors.white,
                  size: 35,
                ),
              ),
              IconButton(
                enableFeedback: false,
                onPressed: () {
                  setState(() {
                    pageIndex = 1;
                    print("pageIndex : ${pageIndex}");
                  });
                },
                icon: const Icon(
                  Icons.article,
                  color: Colors.white,
                  size: 35,
                ),
              ),
              IconButton(
                enableFeedback: false,
                onPressed: () {
                  setState(() {
                    pageIndex = 2;
                    print("pageIndex : ${pageIndex}");
                  });
                },
                icon: const Icon(
                  Icons.credit_card,
                  color: Colors.white,
                  size: 35,
                ),
              ),
            ],
          )),
      backgroundColor: kBackgroundColor,
      appBar: CustomHomeAppBar(title:pageIndex == 1 ? AppTags.leaveStatus : pageIndex == 2 ? AppTags.paySlip : ""),
      drawer: DrawerWidget(
        data: userData ?? UserData(),
        onPressed: (p0) {
          print("DrawerWidget ; $p0");
          switch (p0) {
            case -1:
              print("DrawerWidget");
              showDialog(
                context: context,
                builder: (BuildContext context) => _changeUserPopup(context),
              );
              break;
            case 0:
              setState(() {
                pageIndex = 0;
              });
              break;
            case 1:
              showDialog(
                context: context,
                builder: (BuildContext context) {
                  return logOutPopup(this.context, () async {
                    await StorageHelper.clearUserData();
                    Navigator.pushNamedAndRemoveUntil(
                        this.context, SignupScreen.routeName, (r) => false);
                  });
                },
              );
              break;
              //   break;
              // case 4:
              break;
          }
        },
      ),
      body: pageIndex == 0 ?
      SingleChildScrollView(
    child: Builder(builder: (context) {
      return Padding(
        padding: const EdgeInsets.all(9.0),
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.all(20.sp),
              child: InkWell(
                onTap: () {
                  showDialog(
                    context: context,
                    builder: (BuildContext context) => _changeUserPopup(context),
                  );
                },
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                ClipRRect(
                borderRadius: BorderRadius.circular(30.sp), // Makes the image rounded
                child: userData?.userImage != null && userData?.userImage != ""
                    ? Image.network(
                  userData?.userImage ?? "",
                  width: 60.sp,
                  height: 60.sp,
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) {
                    return Icon(
                      Icons.account_circle,
                      color: kDarkGreyColor,
                      size: 60.sp,
                    );
                  },
                )
                    : Icon(
                  Icons.account_circle,
                  color: kDarkGreyColor,
                  size: 60.sp,
                ),
              ),
                    SizedBox(
                      width: 10.w,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "${userData?.firstName ?? ""} ${userData?.lastName ?? ""}",
                          style: TextStyle(
                            fontSize: 25.sp,
                            fontWeight: FontWeight.w900,
                            color: const Color(0XFF343E87),
                          ),
                        ),
                        SizedBox(
                          height: 6.h,
                        ),
                        SizedBox(
                          width: MediaQuery.of(context).size.width * 0.50.sp,
                          child: CommonText.medium(
                            "${classData?.className ?? ""} (${sectionData?.section ?? ""})",
                            size: 12.sp,
                            color: Colors.blueGrey,
                          ),
                        ),
                      ],
                    )
                  ],
                ),
              ),
            ),
            const Divider(
              color: colorBlack,
              thickness: 0.2,
            ),
            const SizedBox(
              height: 25,
            ),
            GridView.count(
              physics: const NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              crossAxisCount: 4,
              childAspectRatio: 0.8,
              padding: const EdgeInsets.symmetric(horizontal: 10),
              mainAxisSpacing: 8,
              crossAxisSpacing: 8,
              children: <Widget>[
                cardHomeWidget(
                  name: AppTags.attendance,
                  image: AssetsUtils.attendanceIcon,
                  onTap: () {
                    if (isClassOrSectionIdMissing()) {
                      openDialog();
                    } else {
                      Navigator.pushNamed(
                        context,
                        AttendanceScreen.routeName,
                        arguments: {'header': AppTags.attendance},
                      );
                    }
                  },
                ),
                cardHomeWidget(
                    name: AppTags.duesReport,
                    image: AssetsUtils.duesReportIcon,
                    onTap: () {
                      if (isClassOrSectionIdMissing()) {
                        openDialog();
                      } else {
                        Navigator.pushNamed(context, DuesReportScreen.routeName);
                      }
                    }),
                cardHomeWidget(
                    name: AppTags.timetable,
                    image: AssetsUtils.timeTableIcon,
                    onTap: () {
                      if (isClassOrSectionIdMissing()) {
                        openDialog();
                      } else {
                        Navigator.pushNamed(
                          context,
                          TimetableScreen.routeName,
                          arguments: {'header': AppTags.timetable},
                        );
                      }
                    }),
                cardHomeWidget(
                    name: AppTags.applyLeave,
                    image: AssetsUtils.leaveIcon,
                    onTap: () {
                      if (isClassOrSectionIdMissing()) {
                        openDialog();
                      } else {
                        Navigator.pushNamed(
                            context, ApplyLeaveScreen.routeName);
                      }
                    }),

                cardHomeWidget(
                    name: AppTags.assesment,
                    image: AssetsUtils.attendanceIcon,
                    onTap: () {
                      if (isClassOrSectionIdMissing()) {
                        openDialog();
                      } else {
                        Navigator.pushNamed(
                            context, AssesmentScreen.routeName);
                      }
                    }),
                cardHomeWidget(
                    name: AppTags.homework,
                    image: AssetsUtils.homeworkIcIcon,
                    onTap: () {
                      if (isClassOrSectionIdMissing()) {
                        openDialog();
                      } else {
                        Navigator.pushNamed(
                            context, HomeworkScreen.routeName);
                      }
                    }),
                cardHomeWidget(
                  name: AppTags.content,
                  image: AssetsUtils.contentIcon,
                  onTap: () {
                    Navigator.pushNamed(context, ContentScreen.routeName);
                  },
                ),
                cardHomeWidget(
                  name: AppTags.communication,
                  image: AssetsUtils.communicationIcon,
                  onTap: () {
                    Navigator.pushNamed(context, CommunicationScreen.routeName);
                  },
                ),
                cardHomeWidget(
                    name: AppTags.studentBehavior,
                    image: AssetsUtils.studentBehaviourIcon,
                    onTap: () {
                      if (isClassOrSectionIdMissing()) {
                        openDialog();
                      } else {
                        Navigator.pushNamed(
                            context, StudentBehaviourScreen.routeName);
                      }
                    }),
                cardHomeWidget(
                    name: AppTags.qrAttendance,
                    image: AssetsUtils.biometricAttendanceIcon,
                    onTap: () {
                      scanAdd();
                    }),
                cardHomeWidget(
                    name: AppTags.faceAttendance,
                    image: AssetsUtils.faceAttendance,
                    onTap: () {
                      scanFace();
                    }),
                cardHomeWidget(
                    name: AppTags.faceAuth,
                    image: AssetsUtils.faceAuth,
                    onTap: () {
                      addFace();
                    }),
                cardHomeWidget(
                    name: AppTags.studentProgress,
                    image: AssetsUtils.studentProgressIcon,
                    onTap: () {
                      if (isClassOrSectionIdMissing()) {
                        openDialog();
                      } else {
                        Navigator.pushNamed(context, StudentProgressScreen.routeName);
                      }
                    }),
                cardHomeWidget(
                    name: AppTags.ptm,
                    image: AssetsUtils.ptmIcon,
                    onTap: () {
                      if (isClassOrSectionIdMissing()) {
                        openDialog();
                      } else {
                        Navigator.pushNamed(context, PTMScreen.routeName);
                      }
                    }),
                cardHomeWidget(
                    name: AppTags.exam,
                    image: AssetsUtils.exam,
                    onTap: () {
                      if (isClassOrSectionIdMissing()) {
                        openDialog();
                      } else {
                        Navigator.pushNamed(context, ExamMainScreen.routeName);
                      }
                    }),
                cardHomeWidget(
                    name: AppTags.gmeetLiveClasses,
                    image: AssetsUtils.gmeetliveIcon,
                    onTap: () {
                      if (isClassOrSectionIdMissing()) {
                        openDialog();
                      } else {
                        Navigator.pushNamed(context, GMeetLiveClassesScreen.routeName);
                      }
                    }),
                cardHomeWidget(
                  name: AppTags.hostel,
                  image: AssetsUtils.hostelIcon,
                  onTap: () {
                    Navigator.pushNamed(context, HostelRoomsScreen.routeName);
                  },
                ),
                cardHomeWidget(
                    name: AppTags.reports,
                    image: AssetsUtils.report,
                    onTap: () {
                      if (isClassOrSectionIdMissing()) {
                        openDialog();
                      } else {
                        Navigator.pushNamed(context, ReportsMainScreen.routeName);
                      }
                    }),
                cardHomeWidget(
                    name: AppTags.leads,
                    image: AssetsUtils.leadIcon,
                    onTap: () {
                      if (isClassOrSectionIdMissing()) {
                        openDialog();
                      } else {
                        Navigator.pushNamed(context, LeadsScreen.routeName);
                      }
                    }),
              ],
            ),
          ],
        ),
      );
    }),
    )  :
      pages[pageIndex],
    );
  }

}