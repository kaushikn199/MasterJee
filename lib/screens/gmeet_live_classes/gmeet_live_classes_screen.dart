import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:masterjee/constants.dart';
import 'package:masterjee/models/gmeet_response/GMeetResponse.dart';
import 'package:masterjee/others/StorageHelper.dart';
import 'package:masterjee/providers/g_meet.dart';
import 'package:masterjee/widgets/app_bar_two.dart';
import 'package:masterjee/widgets/app_tags.dart';
import 'package:masterjee/widgets/text.dart';
import 'package:masterjee/widgets/util.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';


class GMeetLiveClassesScreen extends StatefulWidget {
  const GMeetLiveClassesScreen({super.key});

  static String routeName = 'GMeetLiveClassesScreen';

  @override
  State<GMeetLiveClassesScreen> createState() => _GMeetLiveClassesScreenState();
}

class _GMeetLiveClassesScreenState extends State<GMeetLiveClassesScreen> {

  var _isLoading = true;
  late List<GMeetData> gMeetList = [];

  @override
  void initState() {
    callApiGMeet();
    super.initState();
  }

  Future<void> callApiGMeet() async {
    try {
      GMeetResponse data =
      await Provider.of<GMeetApi>(context, listen: false).getAllGMeet(
          StorageHelper.getStringData(StorageHelper.userIdKey).toString(),
          StorageHelper.getStringData(StorageHelper.classIdKey).toString(),
          StorageHelper.getStringData(StorageHelper.sectionIdKey).toString()
      );
      if (data.result) {
        setState(() {
          gMeetList = data.data;
          print("gMeetList : ${gMeetList.length}");
          _isLoading = false;
        });
        return;
      }else{
        setState(() {
          _isLoading = false;
        });
      }
    } catch (error) {}
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarTwo(title: AppTags.gmeetLiveClasses),
      body: Builder(builder: (context) {
        if (_isLoading) {
          return SizedBox(
            height: MediaQuery.of(context).size.height * .5,
            child: const Center(
              child: CircularProgressIndicator(),
            ),
          );
        }
        if (gMeetList == null || gMeetList.isEmpty) {
          return Center(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.hourglass_empty_outlined, size: 100.sp),
                CommonText.medium('No Record Found', size: 16.sp, color: kDarkGreyColor, overflow: TextOverflow.fade),
              ],
            ),
          );
        }
        return Padding(
          padding: EdgeInsets.symmetric(horizontal: 10.sp),
          child: ListView.builder(
              shrinkWrap: true,
              itemCount: gMeetList.length,
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
                    children: [
                      Align(
                        alignment: Alignment.bottomLeft,
                        child: Container(
                          width: double.maxFinite,
                          padding: EdgeInsets.all(10.sp),
                          decoration: BoxDecoration(
                              borderRadius:
                              BorderRadius.only(topRight: Radius.circular(10.r), topLeft: Radius.circular(10.r)),
                              color: kToastTextColor),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                gMeetList[index].title,
                                style: TextStyle(
                                  fontSize: 18.sp,
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                              //if (gMeetList[index].toString() == "0")
                                GestureDetector(
                                  onTap: () {
                                    _launch(Uri.parse(gMeetList[index].url));
                                  },
                                  child: Container(
                                    padding: EdgeInsets.symmetric(vertical: 4.sp, horizontal: 8.sp),
                                    decoration: BoxDecoration(
                                        border: Border.all(color: colorBlueText),
                                        color: kToastTextColor,
                                        borderRadius: BorderRadius.all(Radius.circular(4.r))),
                                    child: Row(
                                      children: [
                                        Icon(
                                          Icons.open_in_new,
                                          size: 20.sp,
                                          color: colorBlueText,
                                        ),
                                        SizedBox(width: 8.sp),
                                        CommonText.semiBold(
                                          "Join",
                                          color: colorBlueText,
                                          size: 14.sp,
                                        ),
                                      ],
                                    ),
                                  ),
                                )
                            ],
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.all(20.sp),
                        child: Column(
                          children: [
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                rowValue("Class Duration (Minutes)",  gMeetList[index].duration),
                                if (gMeetList[index].status == "0")
                                  statusBadge("Awaited", Colors.yellow),
                                if (gMeetList[index].toString() == "1")
                                  statusBadge("Cancelled", kRedColor),
                                if (gMeetList[index].toString() == "2")
                                  statusBadge("Finished", Colors.green)
                              ],
                            ),
                            //gap(10.sp),
                           // rowValue("Class", "${gMeetList[index].} (Section B)"),
                            gap(10.sp),
                            rowValue("Date Time", gMeetList[index].date ?? ""),
                            gap(10.sp),
                            rowValue("Class Host", gMeetList[index].forCreateName),
                            gap(10.sp),
                            rowValue("Description",  gMeetList[index].description),
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
    );
  }
}

Future<void> _launch(Uri url) async {
  if (!await launchUrl(
    url,
    mode: LaunchMode.externalApplication,
  )) {
    throw Exception('Could not launch $url');
  }
}

rowValue(String key, value) {
  return Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
    SizedBox(width: 100.sp, child: CommonText.medium(key, size: 14.sp, color: Colors.black)),
    SizedBox(width: 20.w),
    CommonText.medium(value, size: 14.sp, color: kDarkGreyColor, overflow: TextOverflow.fade),
  ]);
}