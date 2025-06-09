import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:masterjee/constants.dart';
import 'package:masterjee/models/class_section/class_section_response.dart';
import 'package:masterjee/models/login/login_data.dart';
import 'package:masterjee/others/StorageHelper.dart';
import 'package:masterjee/providers/auth.dart';
import 'package:masterjee/screens/apply_leave/apply_leave_screen.dart';
import 'package:masterjee/screens/assesment/assesment_screen.dart';
import 'package:masterjee/screens/attendance/attendance_screen.dart';
import 'package:masterjee/screens/dues_report/dues_report_screen.dart';
import 'package:masterjee/screens/gmeet_live_classes/gmeet_live_classes_screen.dart';
import 'package:masterjee/screens/homework/homework_screen.dart';
import 'package:masterjee/screens/leads/leads_screen.dart';
import 'package:masterjee/screens/ptm/ptm.dart';
import 'package:masterjee/screens/signup_screen.dart';
import 'package:masterjee/screens/student_behaviour/student_behaviour_screen.dart';
import 'package:masterjee/screens/student_progress/student_progress_screen.dart';
import 'package:masterjee/screens/timetable/timetable_screen.dart';
import 'package:masterjee/widgets/CommonButton.dart';
import 'package:masterjee/widgets/app_tags.dart';
import 'package:masterjee/widgets/cardHomeWidget.dart';
import 'package:masterjee/widgets/drawers.dart';
import 'package:masterjee/widgets/home_app_bar.dart';
import 'package:masterjee/widgets/text.dart';
import 'package:provider/provider.dart';

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
  }

  @override
  void initState() {
    loadUserData();
    callApiClassSection().then((value) {
        setState(() {
          if (isClassOrSectionIdMissing()) {
            openDialog();
          }
        });
    },);

    super.initState();
  }

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

  int selectedIndex = 0;

  final List<Map<String, String>> items = [
    {'image': AssetsUtils.logoIcon, 'name': 'Attendance'},
    {'image': AssetsUtils.logoIcon, 'name': 'Dues Report'},
    {'image': AssetsUtils.logoIcon, 'name': 'Timetable'},
    {'image': AssetsUtils.logoIcon, 'name': 'Leave'},
    {'image': AssetsUtils.logoIcon, 'name': 'Homework'},
    {'image': AssetsUtils.logoIcon, 'name': 'Assessment'},
    {'image': AssetsUtils.logoIcon, 'name': 'PTM'},
    {'image': AssetsUtils.logoIcon, 'name': 'Biometric Attendance'},
    {'image': AssetsUtils.logoIcon, 'name': 'Lead Section'},
  ];

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
                    ?
               const Text('No class data available')
                   :
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
                      onChanged: (value) {
                        setState(() {
                          _selectedClass = null;
                          _selectedClass = value.toString();
                          for (int i = 0; i < loadedClassList.length; i++) {
                            if (loadedClassList[i]
                                    .className
                                    .toString()
                                    .toLowerCase() ==
                                value.toString().toLowerCase()) {
                              //_classId = loadedClassList[i].classId;
                              classData = loadedClassList[i];
                              _selectedSection = null;
                              break;
                            }
                          }
                        });
                      },
                      isExpanded: true,
                      items: loadedClassList.map((cd) {
                        return DropdownMenuItem(
                          value: cd.className,
                          onTap: () {
                            setState(() {
                              _selectedClass = cd.className;
                              /*for (int i = 0; i < loadedClassList.length; i++) {
                                if (loadedClassList[i]
                                        .className
                                        .toString()
                                        .toLowerCase() ==
                                    cd.className.toString().toLowerCase()) {
                                  _classId = loadedClassList[i].classId;
                                  dropDownIndex = i;
                                  classData = loadedClassList[i];
                                  break;
                                }
                              }
                              _selectedSection = null;*/
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
                    ?
                const Text('No Section data available')
                    :
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
                                    loadedClassList[dropDownIndex].sections[i];
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
                            if (dropDownIndex != -1) {
                              setState(() {
                                _selectedSection = cd.section;
                                /*for (int i = 0;
                                    i <
                                        loadedUsers[dropDownIndex]
                                            .sections
                                            .length;
                                    i++) {
                                  print("section data _0 : ${loadedUsers[dropDownIndex]
                                      .sections[i].sectionId
                                      .toString()
                                      .toLowerCase()} , ${cd.section.toString().toLowerCase()}");
                                  if (loadedUsers[dropDownIndex]
                                          .sections[i].sectionId
                                          .toString()
                                          .toLowerCase() ==
                                      cd.section.toString().toLowerCase()) {
                                    _sectionId = loadedUsers[dropDownIndex]
                                        .sections[i].sectionId.toString();
                                    print("section data : ${sectionData?.section}");
                                    break;
                                  }
                                }*/
                              });
                            }
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
                      StorageHelper.setStringData(StorageHelper.classIdKey,
                          classData?.classId.toString() ?? "");
                      StorageHelper.setStringData(StorageHelper.sectionIdKey,
                          sectionData?.sectionId.toString() ?? "");
                      print(
                          "classIdKey : ${StorageHelper.getStringData(StorageHelper.classIdKey)}");
                      print(
                          "sectionIdKey : ${StorageHelper.getStringData(StorageHelper.sectionIdKey)}");
                      StorageHelper.saveSelectedClass(classData!);
                      StorageHelper.saveSelectedSectionData(sectionData!);
                      print(
                          "getSelectedClass : ${StorageHelper.getSelectedClass()}");
                      print(
                          "getSelectedSection : ${StorageHelper.getSelectedSection()}");
                      Navigator.of(context).pop();
                      loadUserData();
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kBackgroundColor,
      appBar: CustomHomeAppBar(),
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
              break;
            case 1:
              // Navigator.of(context).pushNamed(MyProfileScreen.routeName,);
              break;
            case 2:
              //Navigator.of(context).pushNamed(AboutSchoolScreen.routeName,);
              break;
            case 3:
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
      body: SingleChildScrollView(
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
                        builder: (BuildContext context) =>
                            _changeUserPopup(context),
                      );
                    },
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Icon( Icons.account_circle,
                          color: kDarkGreyColor,
                          size: 60.sp,
                           )
                        /*Container(
                          width: 60.sp,
                          height: 60.sp,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(100),
                            border: Border.all(width: 1, color: Colors.white),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.blueGrey.withOpacity(0.2),
                                blurRadius: 12.r,
                                spreadRadius: 8.r,
                              )
                            ],
                          ),
                          child: ClipRRect(
                              borderRadius: BorderRadius.circular(34.r),
                              child: Image.asset(AssetsUtils.logoIcon,
                                  fit: BoxFit.cover,
                                  width: 50.w,
                                  height: 50.h)),
                        )*/,
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
                              width:
                                  MediaQuery.of(context).size.width * 0.50.sp,
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
                            Navigator.pushNamed(
                                context, DuesReportScreen.routeName);
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
                        name: AppTags.biometricAttendance,
                        image: AssetsUtils.biometricAttendanceIcon,
                        onTap: () {}),
                    cardHomeWidget(
                        name: AppTags.studentProgress,
                        image: AssetsUtils.studentProgressIcon,
                        onTap: () {
                          if (isClassOrSectionIdMissing()) {
                            openDialog();
                          } else {
                            Navigator.pushNamed(
                                context, StudentProgressScreen.routeName);
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
                        name: AppTags.gmeetLiveClasses,
                        image: AssetsUtils.gmeetliveIcon,
                        onTap: () {
                          if (isClassOrSectionIdMissing()) {
                            openDialog();
                          } else {
                            Navigator.pushNamed(
                                context, GMeetLiveClassesScreen.routeName);
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
      ),
    );
  }
}
