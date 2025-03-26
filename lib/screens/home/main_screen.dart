import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:masterjee/constants.dart';
import 'package:masterjee/screens/apply_leave/apply_leave_screen.dart';
import 'package:masterjee/screens/assesment/assesment_screen.dart';
import 'package:masterjee/screens/attendance/attendance_screen.dart';
import 'package:masterjee/screens/dues_report/dues_report_screen.dart';
import 'package:masterjee/screens/gmeet_live_classes/gmeet_live_classes_screen.dart';
import 'package:masterjee/screens/homework/homework_screen.dart';
import 'package:masterjee/screens/leads/leads_screen.dart';
import 'package:masterjee/screens/student_behaviour/student_behaviour_screen.dart';
import 'package:masterjee/screens/student_progress/student_progress_screen.dart';
import 'package:masterjee/widgets/CommonButton.dart';
import 'package:masterjee/widgets/app_tags.dart';
import 'package:masterjee/widgets/drawers.dart';
import 'package:masterjee/widgets/home_app_bar.dart';
import 'package:masterjee/widgets/text.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  static const routeName = '/Main';

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int selectedIndex = 0;
  final List<String> menuItems = [
    "Home",
    "Attendance",
    "Dues Report",
    "Timetable",
    "Approve Leave",
    "Homework",
    "Assessment",
    "Student Progress",
    "PTM",
    "Leads",
    "Sign Out",
  ];
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
  String? _selectedClass;
  String? _selectedSubjectId;
  List<String> classData = [
    "Class 5",
    "Class 6",
    "Class 7",
    "Class 8",
    "Class 9"
  ];

  String? _selectedSection;
  List<String> sectionData = [
    "Section A",
    "Section B",
  ];

  Widget cardWid(String name, image, Function()? onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: double.infinity,
        width: double.infinity,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10.r), // Rounded corners
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.2),
              spreadRadius: 3,
              blurRadius: 5,
              offset: const Offset(0, 3),
            ),
          ],
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(height: 15.h),
            Expanded(
              child: Image.asset(
                image, // Replace with your image asset
                width: 50.sp,
                height: 50.sp,
              ),
            ),
            SizedBox(height: 5.h),
            Padding(
              padding: const EdgeInsets.all(3),
              child: Text(
                name,
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 12.sp,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
            ),
            SizedBox(height: 5.h),
          ],
        ),
      ),
    );
  }

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
      insetPadding: EdgeInsets.only(left: 10, right: 10),
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(10))),
      content: SizedBox(
        width: widthSize,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Text(
              "Choose Class Section",
              style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                  color: Colors.blue),
            ),
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
                  onChanged: (value) {
                    setState(() {
                      _selectedClass = null;
                      _selectedClass = value.toString();
                      for (int i = 0; i < classData.length; i++) {
                        if (classData[i].toString().toLowerCase() ==
                            value.toString().toLowerCase()) {
                          _selectedSubjectId = classData[i].toString();
                          break;
                        }
                      }
                    });
                  },
                  isExpanded: true,
                  items: classData.map((cd) {
                    return DropdownMenuItem(
                      value: cd,
                      onTap: () {
                        setState(() {
                          _selectedClass = cd;
                          for (int i = 0; i < classData.length; i++) {
                            if (classData[i].toString().toLowerCase() ==
                                cd.toString().toLowerCase()) {
                              _selectedSubjectId = classData[i].toString();
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
                      _selectedSection = null;
                      _selectedSection = value.toString();
                      for (int i = 0; i < sectionData.length; i++) {
                        if (sectionData[i].toString().toLowerCase() ==
                            value.toString().toLowerCase()) {
                          _selectedSubjectId = sectionData[i].toString();
                          break;
                        }
                      }
                    });
                  },
                  isExpanded: true,
                  items: sectionData.map((cd) {
                    return DropdownMenuItem(
                      value: cd,
                      onTap: () {
                        setState(() {
                          _selectedSection = cd;
                          for (int i = 0; i < sectionData.length; i++) {
                            if (sectionData[i].toString().toLowerCase() ==
                                cd.toString().toLowerCase()) {
                              _selectedSubjectId = sectionData[i].toString();
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
            gap(20.0),
            CommonButton(
              cornersRadius: 30,
              text: AppTags.submit,
              onPressed: () {},
            )
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kBackgroundColor,
      appBar: CustomHomeAppBar(),
      drawer: DrawerWidget(onPressed: () {
        print("DrawerWidget");
        showDialog(
          context: context,
          builder: (BuildContext context) => _changeUserPopup(context),
        );
      }),
      body: SingleChildScrollView(
        child: Builder(builder: (context) {
          return Padding(
            padding: const EdgeInsets.all(9.0),
            child: Column(
              children: [
                Padding(
                  padding: EdgeInsets.all(20.sp),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
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
                                fit: BoxFit.cover, width: 50.w, height: 50.h)),
                      ),
                      SizedBox(
                        width: 20.w,
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Pooja M",
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
                              "Admission No. 123 \nClass 5",
                              size: 12.sp,
                              color: Colors.blueGrey,
                            ),
                          ),
                        ],
                      )
                    ],
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
                  crossAxisCount: 3,
                  childAspectRatio: 0.8,
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  mainAxisSpacing: 8,
                  crossAxisSpacing: 8,
                  children: <Widget>[
                    cardWid(AppTags.attendance, AssetsUtils.attendanceIcon, () {
                      Navigator.pushNamed(
                        context,
                        AttendanceScreen.routeName,
                        arguments: {'header': AppTags.attendance},
                      );
                    }),
                    cardWid(AppTags.duesReport, AssetsUtils.duesReportIcon, () {
                      Navigator.pushNamed(context, DuesReportScreen.routeName);
                    }),
                    cardWid(AppTags.timetable, AssetsUtils.timeTableIcon, () {
                      Navigator.pushNamed(
                        context,
                        AttendanceScreen.routeName,
                        arguments: {'header': AppTags.timetable},
                      );
                    }),
                    cardWid(AppTags.leads, AssetsUtils.leadIcon, () {
                      Navigator.pushNamed(context, LeadsScreen.routeName);
                    }),
                    cardWid(AppTags.homework, AssetsUtils.homeworkIcIcon, () {
                      Navigator.pushNamed(context, HomeworkScreen.routeName);
                    }),
                    cardWid(AppTags.studentBehavior,
                        AssetsUtils.studentBehaviourIcon, () {
                      Navigator.pushNamed(
                          context, StudentBehaviourScreen.routeName);
                    }),
                    cardWid(AppTags.studentProgress,
                        AssetsUtils.studentProgressIcon, () {
                      Navigator.pushNamed(
                          context, StudentProgressScreen.routeName);
                    }),
                    cardWid(AppTags.assesment, AssetsUtils.attendanceIcon, () {
                      Navigator.pushNamed(context, AssesmentScreen.routeName);
                    }),
                    cardWid(AppTags.ptm, AssetsUtils.ptmIcon, () {}),
                    cardWid(AppTags.biometricAttendance,
                        AssetsUtils.biometricAttendanceIcon, () {}),
                    cardWid(AppTags.applyLeave, AssetsUtils.leaveIcon, () {
                      Navigator.pushNamed(context, ApplyLeaveScreen.routeName);
                    }),
                    cardWid(AppTags.gmeetLiveClasses, AssetsUtils.gmeetliveIcon,
                        () {
                      Navigator.pushNamed(
                          context, GMeetLiveClassesScreen.routeName);
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
