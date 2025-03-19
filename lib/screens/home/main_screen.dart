import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:masterjee/constants.dart';
import 'package:masterjee/screens/assesment/assesment_screen.dart';
import 'package:masterjee/screens/attendance/attendance_screen.dart';
import 'package:masterjee/screens/dues_report/dues_report_screen.dart';
import 'package:masterjee/screens/gmeet_live_classes/gmeet_live_classes_screen.dart';
import 'package:masterjee/screens/homework/homework_screen.dart';
import 'package:masterjee/screens/leads/leads_screen.dart';
import 'package:masterjee/screens/student_behaviour/student_behaviour_screen.dart';
import 'package:masterjee/screens/student_progress/student_progress_screen.dart';
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
  int selectedIndex = 0; // Track the selected item

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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kBackgroundColor,
      appBar: /*AppBar(
        title: Center(
          child: CommonText.bold(
            textAlign: TextAlign.center,
            AppTags.StudentsProgress,
            size: 16.sp,
            color: colorWhite,
          ),
        ),
        backgroundColor: colorGreen,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(25),
            bottomRight: Radius.circular(25),
          ),
        ),
        actions: [
          IconButton(
            icon: const Icon(
              Icons.account_circle,
              color: colorWhite,
            ),
            // Add your desired icon
            onPressed: () {},
          ),
        ],
        iconTheme: const IconThemeData(
          color: Colors.white, // Change drawer icon color
        ),
      )*/
          CustomHomeAppBar(),
      drawer: /*Drawer(
        backgroundColor: colorGaryBG,
        child: Column(
          children: [
            Image.asset(
              width: double.infinity,
              height: MediaQuery.of(context).size.height / 6,
              'assets/images/ic_drawer_image.jpg',
              fit: BoxFit.cover,
            ).paddingOnly(top: 50,left: 70,right: 70),
            CommonText.medium(
              textAlign: TextAlign.center,
              "Pawan",
              size: 18.sp,
              color: colorGaryText,
            ).paddingOnly(top: 5),
            CommonText.regular(
              textAlign: TextAlign.center,
              "ID: 9001",
              size: 14.sp,
              color: colorGaryText,
            ).paddingOnly(top: 5),
            CommonText.regular(
              textAlign: TextAlign.center,
              "Class: class 12th | Section: Section A",
              size: 14.sp,
              color: colorGaryText,
            ),
            SizedBox(height: 10.h,),
            Expanded(
              child: ListView.builder(
                padding: EdgeInsets.zero,
                itemCount: menuItems.length,
                itemBuilder: (context, index) {
                  bool isSelected = selectedIndex == index;
                  return Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 0),
                      child: InkWell(
                        borderRadius: BorderRadius.circular(12), // Rounded effect on tap
                        onTap: () {
                          setState(() {
                            selectedIndex = index;
                          });
                          Future.delayed(Duration(milliseconds: 300), () {
                            Navigator.pop(context);
                          });
                        },
                        child: Container(
                          decoration: BoxDecoration(
                            color: isSelected ? colorGreen: Colors.transparent,
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Expanded(child:  CommonText.regular(
                                textAlign: TextAlign.start,
                                menuItems[index],
                                size: 14.sp,
                                color:  isSelected ? Colors.white : colorBlueText,
                              ),),
                              Icon(Icons.navigate_next,color: isSelected ? Colors.white :colorBlueText),
                            ],
                          ).paddingOnly(left: 15,right: 10,top: 8,bottom: 8),
                        ),
                      )
                  );
                },
              ),
            ),
          ],
        ),
      ),*/
          /* NavigationDrawerWidget(
        selectedIndex: selectedIndex,
        onClicked: onDrawerItemClicked, // Pass function to handle clicks
      )*/
          const DrawerWidget(),
      body: SingleChildScrollView(
        child: Builder(builder: (context) {
          return Padding(
            padding: const EdgeInsets.all(9.0),
            child:
                /*GridView.builder(
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 3, // 3 columns
              crossAxisSpacing: 8.0,
              mainAxisSpacing: 8.0,
              childAspectRatio: 0.7, // Adjust height
            ),
            itemCount: items.length,
            itemBuilder: (context, index) {
              return GestureDetector(
                onTap: () {
                  // Handle click event
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('Clicked on ${items[index]['name']}')),
                  );
                },
                child: Card(
                  elevation: 4,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Expanded(
                        child: Image.asset(items[index]['image']!, fit: BoxFit.fitWidth,height: 80,width: 80,),
                      ),
                      SizedBox(height: 8),
                      CommonText.regular(
                        maxLines: 1,
                        textAlign: TextAlign.center,
                        items[index]['name']!,
                        size: 14.sp,
                        color: colorBlack,
                      ).paddingOnly(top: 10),
                    ],
                  ),
                ),
              );
            },
          ),*/
                Column(
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
                            child: /*CachedNetworkImage(
                          imageUrl: LocalDatabase.siteUrl +
                              LocalDatabase.user!.image.toString(),
                          placeholder: (context, url) =>
                          const CircularProgressIndicator(),
                          errorWidget: (context, url, error) =>
                              Image.asset(
                                LocalDatabase.user!.gender == "Female"
                                    ? AssetsUtils.femaleImage
                                    : AssetsUtils.personImage,
                                fit: BoxFit.cover,
                                width: 50.w,
                                height: 50.h,
                              ),
                        ),*/
                                Image.asset(AssetsUtils.logoIcon,
                                    fit: BoxFit.cover,
                                    width: 50.w,
                                    height: 50.h)),
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
                              // ? "${LocalDatabase.user!.currencySymbol}"
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
                SizedBox(
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
                       //Navigator.pushNamed(context, AttendanceScreen.routeName);
                       Navigator.pushNamed(
                         context,
                         AttendanceScreen.routeName,
                         arguments: {'header': AppTags.attendance},
                       );
                    }),

                    cardWid(AppTags.duesReport, AssetsUtils.duesReportIcon, () {
                      //Navigator.pushNamed(context, DailyAssignmentScreen.routeName);
                      Navigator.pushNamed(context, DuesReportScreen.routeName);
                    }),
                    cardWid(AppTags.timetable, AssetsUtils.timeTableIcon, () {
                       //Navigator.pushNamed(context, AttendanceScreen.routeName);
                       Navigator.pushNamed(
                         context,
                         AttendanceScreen.routeName,
                         arguments: {'header': AppTags.timetable},
                       );
                    }),
                    cardWid(AppTags.leads, AssetsUtils.leadIcon, () {
                      Navigator.pushNamed(context,LeadsScreen.routeName);
                    }),
                    cardWid(AppTags.homework, AssetsUtils.homeworkIcIcon, () {
                      //Navigator.pushNamed(context, DownloadCenterScreen.routeName);
                      Navigator.pushNamed(context,HomeworkScreen.routeName);
                    }),
                    cardWid(AppTags.studentBehavior, AssetsUtils.studentBehaviourIcon, () {
                      //Navigator.pushNamed(context, DownloadCenterScreen.routeName);
                      Navigator.pushNamed(context,StudentBehaviourScreen.routeName);
                    }),
                    cardWid(AppTags.studentProgress, AssetsUtils.studentProgressIcon, () {
                      //Navigator.pushNamed(context, DownloadCenterScreen.routeName);
                      Navigator.pushNamed(context,StudentProgressScreen.routeName);
                    }),
                    cardWid(AppTags.assesment, AssetsUtils.attendanceIcon, () {
                       Navigator.pushNamed(context, AssesmentScreen.routeName);
                    }),
                    cardWid(AppTags.ptm, AssetsUtils.ptmIcon, () {
                      //Navigator.pushNamed(context, GMeetClassScreen.routeName);
                    }),
                    cardWid(AppTags.biometricAttendance, AssetsUtils.biometricAttendanceIcon,
                        () {
                      //Navigator.pushNamed(context, ZoomClassScreen.routeName);
                    }),
                    cardWid(AppTags.leadSection, AssetsUtils.leadIcon, () {
                      //Navigator.pushNamed(context, ZoomClassScreen.routeName);
                    }),
                    cardWid(AppTags.gmeetLiveClasses, AssetsUtils.gmeetliveIcon, () {
                      //Navigator.pushNamed(context, DownloadCenterScreen.routeName);
                      Navigator.pushNamed(context,GMeetLiveClassesScreen.routeName);
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
