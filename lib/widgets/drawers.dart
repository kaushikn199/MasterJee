
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get/get_common/get_reset.dart';
import 'package:get/get_navigation/src/bottomsheet/bottomsheet.dart';
import 'package:masterjee/constants.dart';
import 'package:masterjee/widgets/change_user.dart';
import 'package:masterjee/widgets/text.dart';
import 'package:provider/provider.dart';

import 'app_tags.dart';

const padding = EdgeInsets.symmetric(horizontal: 20);


class DrawerWidget extends StatefulWidget {
  final VoidCallback onPressed; // Define the callback

  const DrawerWidget({super.key, required this.onPressed});

  @override
  State<DrawerWidget> createState() => _DrawerWidgetState();
}

class _DrawerWidgetState extends State<DrawerWidget> {

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
              color: kBackgroundColor,
              child: InkWell(child: buildHeader(context),onTap: () {
                Navigator.of(context).pop();
                widget.onPressed();
              },),
            ),
            SizedBox(height: 25.sp),
            Expanded(
              child: Container(child:
              buildList(items: items)),
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
            Image.asset(AssetsUtils.logoIcon, height: 100.sp, fit: BoxFit.cover).paddingAll(40),
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
                      //await Provider.of<Auth>(context, listen: false).logout(context);
                    },
                    color: colorGreen,
                    textColor: Colors.white,
                    padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
                    splashColor: colorGreen,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(7.0),
                      side: const BorderSide(color: colorGreen),
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
                    textColor: colorGreen,
                    padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
                    splashColor: colorGreen,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(7.0),
                      side: const BorderSide(color: colorGreen),
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
          onClicked: () => selectItem(context, indexOffset + index),
        );
      },
    );

void selectItem(BuildContext context, int index) {
  Navigator.of(context).pop();
  switch (index) {
    case 0:
      break;
    case 1:
     // Navigator.of(context).pushNamed(MyProfileScreen.routeName,);
      break;
    case 2:
      //Navigator.of(context).pushNamed(AboutSchoolScreen.routeName,);
      break;
    case 3:
    //   break;
    // case 4:
      break;
  }
}

Widget buildMenuItem(
    {required String text,
      required IconData icon,
      VoidCallback? onClicked,
      required int itemIndex,
      required int size}) {
  bool f = true;
  final leading = Icon(
    icon,
    color: kDarkButtonBg,
    size: size.sp,
  );
  if (itemIndex == 0) {
    f = false;
  }
  return Wrap(
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
              child:
              Image.asset(width: 50,height: 50,AssetsUtils.logoIcon,fit: BoxFit.cover),
            ),
          ),
          SizedBox(
            width: 20.sp,
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CommonText.extraBold(
                "Mina Patel",
                size: 22.sp,
                color: const Color(0XFF343E87),
              ),
              gap(3.sp),
              CommonText.semiBold(
                "Class 5 (Section B)",
                size: 12.sp,
                color: Colors.blueGrey,
              ),
            ],
          )
        ],
      ),
    )
  ],
);

final items = [
  const DrawerItem(title: AppTags.home, icon: Icons.home, size: 30),
  const DrawerItem(title: AppTags.profile, icon: Icons.account_circle_outlined, size: 30),
  const DrawerItem(title: AppTags.aboutSchool, icon: Icons.account_balance_outlined, size: 30),
  const DrawerItem(title: AppTags.logout, icon: Icons.logout_rounded, size: 30),
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
}

studentWidget(/*ParentChild child,*/ BuildContext context) {
  return GestureDetector(
    onTap: () {
      // setState(() {
      /*LocalDatabase.studentId = child.studentId;
      LocalDatabase.selectedStudent = child;
      LocalDatabase.classId = child.classId;
      LocalDatabase.sectionId = child.sectionId;*/
      // });
      Navigator.pushNamedAndRemoveUntil(
        context,
        '/home',
            (route) => false,
      );
    },
    child: Card(
      margin: EdgeInsets.symmetric(vertical: 10.sp, horizontal: 20.sp),
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: 10.sp, horizontal: 20.sp),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Container(
              width: 70.sp,
              height: 70.sp,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(100.r),
                border: Border.all(width: 1, color: Colors.white),
                color: Colors.grey,
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
                child:Image.asset(AssetsUtils.logoIcon, fit: BoxFit.cover,
                    width: 50,
                    height: 50),
              ),
            ),
            SizedBox(
              width: 20.w,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                CommonText.medium("dsgdg",
                    size: 14.sp, color: Colors.black, overflow: TextOverflow.fade),
                CommonText.medium("${"dgfd"} - ${"dgdfgdfg"}",
                    size: 12.sp, color: Colors.black54, overflow: TextOverflow.fade),
              ],
            ),
          ],
        ),
      ),
    ),
  );
}