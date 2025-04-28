import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:masterjee/constants.dart';
import 'package:masterjee/models/class_timetable/class_time_table_response.dart';
import 'package:masterjee/others/StorageHelper.dart';
import 'package:masterjee/providers/class_timetable.dart';
import 'package:masterjee/widgets/app_bar_two.dart';
import 'package:masterjee/widgets/app_tags.dart';
import 'package:masterjee/widgets/text.dart';
import 'package:provider/provider.dart';

class TimetableScreen extends StatefulWidget {
  const TimetableScreen({super.key});

  static String routeName = 'timetableScreen';

  @override
  State<TimetableScreen> createState() => _TimetableScreenState();
}

class _TimetableScreenState extends State<TimetableScreen> {
  var _isLoading = false;
  late List<ClassTimetableData> timeTableList = [];

  @override
  void initState() {
    print("initState");
    callApiGetClassTimetable();
    super.initState();
  }

  Future<void> callApiGetClassTimetable() async {
    try {
      ClassTimetableResponse data = await Provider.of<ClassTimetable>(context,
              listen: false)
          .getClassTimetable(
              StorageHelper.getStringData(StorageHelper.userIdKey).toString(),
              StorageHelper.getStringData(StorageHelper.classIdKey).toString(),
              StorageHelper.getStringData(StorageHelper.sectionIdKey)
                  .toString());
      if (data.result) {
        setState(() {
          timeTableList = data.data;
          _isLoading = false;
        });
        return;
      } else {
        setState(() {
          _isLoading = false;
        });
      }
    } catch (error) {
      print("error : ${error}");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarTwo(title: AppTags.timetable),
      body: Builder(builder: (context) {
        if (_isLoading) {
          return SizedBox
            (
            height: MediaQuery.of(context).size.height * .5,
            child: const Center(
              child: CircularProgressIndicator(),
            ),
          );
        }
        if (timeTableList.isEmpty) {
          return Center(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.hourglass_empty_outlined, size: 100.sp),
                CommonText.medium('No Record Found',
                    size: 16.sp,
                    color: kDarkGreyColor,
                    overflow: TextOverflow.fade),
              ],
            ),
          );
        }
        return Padding(
          padding: EdgeInsets.symmetric(horizontal: 10.sp),
          child: ListView.builder(
              shrinkWrap: true,
              itemCount: timeTableList.length,
              padding: EdgeInsets.only(top: 10.sp),
              itemBuilder: (BuildContext context, int index) {
                return cardWidget(timeTableList[index]);
              }),
        );
      }),
    );
  }
}

cardWidget(ClassTimetableData dayList) {
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
            padding: EdgeInsets.symmetric(horizontal: 10.sp, vertical: 5.sp),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.only(
                    topRight: Radius.circular(10.r),
                    topLeft: Radius.circular(10.r)),
                color: kToastTextColor),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                CommonText.bold(dayList.day, size: 14.sp, color: Colors.black),
              ],
            ),
          ),
        ),
        dayList == null
            ? Center(
                child: Padding(
                  padding: EdgeInsets.all(20.sp),
                  child: CommonText.medium('No Schedule Available',
                      size: 12.sp,
                      color: Colors.redAccent,
                      overflow: TextOverflow.fade),
                ),
              )
            : ListView.builder(
                shrinkWrap: true,
                itemCount: dayList.dayTimetable.length,
                physics: const NeverScrollableScrollPhysics(),
                padding: EdgeInsets.only(top: 10.sp),
                itemBuilder: (BuildContext context, int index) {
                  return cardChildWidget(dayList.dayTimetable[index]);
                }),
      ],
    ),
  );
}

Widget cardChildWidget(DayTimetable data) {
  return Padding(
    padding: EdgeInsets.symmetric(vertical: 10.sp, horizontal: 15.sp),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(
          child: Row(
            children: [
              CommonText.bold(
                data.timeFrom,
                size: 12.sp,
                color: Colors.black,
              ),
              CommonText.bold(
                " To ",
                size: 12.sp,
                color: Colors.black,
              ),
              CommonText.bold(
                data.timeTo,
                size: 12.sp,
                color: Colors.black,
              ),
            ],
          ),
        ),
        SizedBox(width: 10.sp),
        Expanded(
          child: ListView.builder(
            shrinkWrap: true,
            itemCount: data.lessonPlans.length,
            physics: const NeverScrollableScrollPhysics(),
            padding: EdgeInsets.only(top: 0),
            itemBuilder: (BuildContext context, int index) {
              return cardLessonPlansWidget(data.lessonPlans[index]);
            },
          ),
        ),
      ],
    ),
  );
}

cardLessonPlansWidget(LessonPlan data) {
  return Column(
    mainAxisAlignment: MainAxisAlignment.start,
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      CommonText.medium(data.name, size: 13.sp, color: colorGaryText),
      gap(5.0),
      CommonText.medium(data.section, size: 13.sp, color: colorGaryText),
      gap(5.0),
      CommonText.medium(data.lessonPlanClass,
          size: 13.sp, color: colorGaryText),
      gap(10.0),
      Container(
        decoration: BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(10)),
            color: colorGreen),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              Icons.add,
              color: colorWhite,
            ),
            gap(2.0),
            CommonText.medium("Lesson Plan", size: 13.sp, color: colorWhite)
          ],
        ).paddingOnly(left: 5, right: 10, top: 5, bottom: 5),
      ),
    ],
  );
}
