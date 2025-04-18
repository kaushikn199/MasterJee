
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:masterjee/constants.dart';
import 'package:masterjee/providers/auth.dart';
import 'package:masterjee/widgets/text.dart';
import 'package:provider/provider.dart';

import 'app_tags.dart';

/*const padding = EdgeInsets.symmetric(horizontal: 10);

class NavigationDrawerWidget extends StatefulWidget {
  final int selectedIndex;
  final Function(int) onClicked; // Accepts selectedIndex
  const NavigationDrawerWidget({super.key, required this.selectedIndex, required this.onClicked});

  @override
  State<NavigationDrawerWidget> createState() => _NavigationDrawerWidgetState();
}

class _NavigationDrawerWidgetState extends State<NavigationDrawerWidget> {
  late int selectedIndex; // Store the selected index

  @override
  void initState() {
    super.initState();
    selectedIndex = widget.selectedIndex; // Initialize with passed value
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      shape: const RoundedRectangleBorder(),
      child: SafeArea(
        child: Column(
          children: [
            Container(
              padding: EdgeInsets.symmetric(vertical: 18.h),
              width: double.infinity,
              color: const Color(0xFFFAFAFA),
              child: buildHeader(context),
            ),
            SizedBox(height: 25.sp),
            Expanded(
              child: Container(child: ListView.builder(
                padding: padding,
                shrinkWrap: true,
                primary: false,
                itemCount: items.length,
                itemBuilder: (context, index) {
                  final item = items[index];
                  return buildMenuItem(
                      itemIndex: index,
                      text: item.title,
                      icon: item.icon,
                      size: item.size,
                      onClicked: () {
                        setState(() {
                          selectedIndex = index;
                        });
                        widget.onClicked(selectedIndex); // Pass index to parent

                        Navigator.of(context).pop();
                        //selectItem(context, indexOffset + index);
                        },
                      selectedIndex:selectedIndex
                  );
                },
              )),
            ),
          ],
        ),
      ),
    );
  }
}

Widget logOutPopup(BuildContext context) {
  var widthSize = MediaQuery.of(context).size.width;
  return AlertDialog(
    surfaceTintColor: Colors.white,
    insetPadding: EdgeInsets.only(left: 30.sp, right: 30.sp),
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(10.sp))),
    content: Builder(builder: (context) {
      return SizedBox(
        width: widthSize,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Image.asset(AssetsUtils.signOutIcon, height: 200.sp, fit: BoxFit.fill),
            Padding(
              padding: EdgeInsets.only(top: 10.sp, bottom: 15.sp),
              child: Align(
                alignment: Alignment.center,
                child: Text(
                  AppTags.comeBackSoon,
                  textAlign: TextAlign.center,
                  style:
                      TextStyle(fontSize: 18.sp, color: Colors.black, fontWeight: FontWeight.bold),
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(bottom: 20.sp),
              child: Align(
                alignment: Alignment.center,
                child: Text(
                  AppTags.singOutMessage,
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 14.sp, color: Colors.black45),
                ),
              ),
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Expanded(
                  child: MaterialButton(
                    onPressed: () async {
                      await Provider.of<Auth>(context, listen: false).logout(context);
                    },
                    color: colorGreen,
                    textColor: Colors.white,
                    padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
                    splashColor: Colors.redAccent,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(7.0),
                      side: const BorderSide(color: kRedColor),
                    ),
                    child: const Text(
                      'Yes, Sign out',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
                SizedBox(
                  width: 10.sp,
                ),
                Expanded(
                  child: MaterialButton(
                    onPressed: () async {
                      Navigator.pop(context);
                    },
                    color: Colors.white,
                    textColor: kRedColor,
                    padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
                    splashColor: Colors.redAccent,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(7.0),
                      side: const BorderSide(color: kRedColor),
                    ),
                    child: const Text(
                      'Cancel',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
              ],
            )
          ],
        ),
      );
    }),
  );
}

Widget buildList({
  required List<DrawerItem> items,
  int indexOffset = 0,
  int selectedIndex = -1
}) =>
    ListView.builder(
      padding: padding,
      shrinkWrap: true,
      primary: false,
      itemCount: items.length,
      itemBuilder: (context, index) {
        final item = items[index];
        return buildMenuItem(
          itemIndex: index,
          text: item.title,
          icon: item.icon,
          size: item.size,
          onClicked: () {
            selectedIndex = index;
            selectItem(context, indexOffset + index);},
            selectedIndex:selectedIndex
        );
      },
    );

void selectItem(BuildContext context, int index) {
  Navigator.of(context).pop();
  switch (index) {
    case 0:
      break;
    case 1:
      //Navigator.of(context).pushNamed(MyProfileScreen.routeName,);
      break;
    case 2:
      //Navigator.of(context).pushNamed(AboutSchoolScreen.routeName,);
      break;
    case 3:
      //   break;
      // case 4:
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return logOutPopup(context);
        },
      );
      break;
  }
}

Widget buildMenuItem(
    {required String text,
    required IconData icon,
    VoidCallback? onClicked,
    required int itemIndex,
    required int size,
    required int selectedIndex}) {
  bool f = true;
  final leading = Icon(
    icon,
    color: kDarkButtonBg,
    size: size.sp,
  );
  if (itemIndex == 0) {
    f = false;
  }
   *//*Wrap(
    spacing: 0.sp,
    children: [
      ListTile(
        trailing: Icon(
          Icons.chevron_right,
          size: 20.sp,
          color: kDarkButtonBg,
        ),
        leading: leading,
        title: Text(text),
        onTap: onClicked,
      ),
    ],
  );*//*bool isSelected = selectedIndex == itemIndex;
  return  InkWell(
        borderRadius: BorderRadius.circular(12), // Rounded effect on tap
        onTap: () {
          *//*setState(() {
            selectedIndex = index;
          });
          Future.delayed(Duration(milliseconds: 300), () {
            Navigator.pop(context);
          });*//*
          onClicked!();
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
              Expanded(child:  CommonText.semiBold(
                textAlign: TextAlign.start,
                text,
                size: 14.sp,
                color:  isSelected ? Colors.white : colorBlueText,
              ),),
              Icon(Icons.navigate_next,color: isSelected ? Colors.white :colorBlueText),
            ],
          ).paddingOnly(left: 15,right: 10,top: 10,bottom: 10),
        ),
      );
}

Widget buildHeader(BuildContext context) => Row(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Padding(
          padding: EdgeInsets.all(10.sp),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.start,
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
                      blurRadius: 12,
                      spreadRadius: 8,
                    )
                  ],
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(34.0),
                  child: *//*CachedNetworkImage(
                    imageUrl: LocalDatabase.siteUrl + LocalDatabase.user!.image.toString(),
                    placeholder: (context, url) => const CircularProgressIndicator(),
                    errorWidget: (context, url, error) => Image.asset(
                      LocalDatabase.user!.gender == "Female"
                          ? AssetsUtils.femaleImage
                          : AssetsUtils.personImage,
                      fit: BoxFit.cover,
                      width: 50,
                      height: 50,
                    ),
                  )*//*Image.asset(AssetsUtils.logoIcon,width: 50,
                      height: 50),
                ),
              ),
              SizedBox(
                width: 20.sp,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CommonText.extraBold(
                    AppTags.appName,
                    size: 22.sp,
                    color: const Color(0XFF343E87),
                  ),
                  gap(3.sp),
                  *//*LocalDatabase.user?.role == "parent"
                      ? Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                          CommonText.semiBold(
                            'Child - ${LocalDatabase.selectedStudent!.name}' ?? "",
                            size: 12.sp,
                            color: Colors.blueGrey,
                          ),
                          CommonText.semiBold(
                            "${LocalDatabase.selectedStudent?.parentChildClass ?? ""} (${LocalDatabase.selectedStudent?.section ?? ""})",
                            size: 12.sp,
                            color: Colors.blueGrey,
                          ),
                          gap(3.sp),
                          GestureDetector(
                            onTap: () async {
                              Map<String, dynamic> profileData = {};
                              List extraFields = [];
                              await Provider.of<Auth>(context, listen: false)
                                  .getStudents()
                                  .then((value) {
                                profileData = value;
                                List a = profileData['childs'];
                                extraFields = a.map((entry) {
                                  return studentWidget(
                                      ParentChild(
                                          classId: entry['class_id'],
                                          name: entry['firstname'] + " " + entry['lastname'],
                                          parentChildClass: entry['class'],
                                          image: entry['image'],
                                          section: entry['section'],
                                          admissionNo: entry['admission_no'],
                                          sectionId: entry['section_id'],
                                          studentId: entry['id']),
                                      context);
                                }).toList();
                              });
                              await showDialog(
                                context: context,
                                builder: (BuildContext context) {
                                  return Padding(
                                    padding: EdgeInsets.only(
                                        top: MediaQuery.of(context).size.height * 0.38.sp),
                                    child: Wrap(
                                      children: [
                                        Align(
                                          alignment: Alignment.bottomLeft,
                                          child: Container(
                                            width: double.maxFinite,
                                            decoration: const BoxDecoration(
                                                borderRadius: BorderRadius.only(
                                                    topRight: Radius.circular(16),
                                                    topLeft: Radius.circular(16)),
                                                color: kToastTextColor),
                                            padding: const EdgeInsets.symmetric(
                                                vertical: 15, horizontal: 12),
                                            child: Row(
                                              crossAxisAlignment: CrossAxisAlignment.start,
                                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                              children: [
                                                Text(
                                                  'Child List',
                                                  style: TextStyle(
                                                    fontSize: 18.sp,
                                                    fontWeight: FontWeight.w700,
                                                  ),
                                                ),
                                                GestureDetector(
                                                    onTap: () {
                                                      Navigator.pop(context);
                                                    },
                                                    child: const Icon(Icons.close,
                                                        color: Colors.black, size: 24))
                                              ],
                                            ),
                                          ),
                                        ),
                                        Container(
                                          color: kBackgroundColor,
                                          height: MediaQuery.of(context).size.height,
                                          child: SingleChildScrollView(
                                            child: Column(
                                              children: [...extraFields, SizedBox(height: 350.sp)],
                                            ),
                                          ),
                                        )
                                      ],
                                    ),
                                  );
                                },
                              );
                            },
                            child: Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  CommonText.medium(
                                    'Switch Child',
                                    size: 12.sp,
                                    color: Colors.black54,
                                  ),
                                  gap(3.sp),
                                  Icon(
                                    Icons.swap_horiz_rounded,
                                    size: 20.sp,
                                    color: Colors.black54,
                                  ),
                                ]),
                          )
                        ])
                      : CommonText.semiBold(
                          "${LocalDatabase.user?.recordClass ?? ""} (${LocalDatabase.user?.section ?? ""})",
                          size: 12.sp,
                          color: Colors.blueGrey,
                        ),*//*
                ],
              )
            ],
          ),
        )
      ],
    );

final items = [
  const DrawerItem(title: AppTags.attendance, icon: Icons.home, size: 30),
  const DrawerItem(title: AppTags.duesReport, icon: Icons.account_circle_outlined, size: 30),
  const DrawerItem(title: AppTags.timetable, icon: Icons.account_balance_outlined, size: 30),
  // const DrawerItem(title: AppTags.settings, icon: Icons.settings, size: 30),
  const DrawerItem(title: AppTags.leads, icon: Icons.logout_rounded, size: 30),
  const DrawerItem(title: AppTags.homework, icon: Icons.logout_rounded, size: 30),
  const DrawerItem(title: AppTags.assesment, icon: Icons.logout_rounded, size: 30),
  const DrawerItem(title: AppTags.ptm, icon: Icons.logout_rounded, size: 30),
  const DrawerItem(title: AppTags.biometricAttendance, icon: Icons.logout_rounded, size: 30),
  const DrawerItem(title: AppTags.leadSection, icon: Icons.logout_rounded, size: 30),
  const DrawerItem(title: AppTags.signOut, icon: Icons.logout_rounded, size: 30),
];

class DrawerItem {
  final String title;
  final IconData icon;
  final int size;

  const DrawerItem({
    required this.size,
    required this.title,
    required this.icon,
  });
}*/

