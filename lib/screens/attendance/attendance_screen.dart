import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:masterjee/constants.dart';
import 'package:masterjee/models/attendance/class_attendance_model.dart';
import 'package:masterjee/models/class_timetable/class_time_table_response.dart';
import 'package:masterjee/others/StorageHelper.dart';
import 'package:masterjee/providers/class_timetable.dart';
import 'package:masterjee/widgets/app_bar_two.dart';
import 'package:masterjee/widgets/text.dart';
import 'package:provider/provider.dart';

class AttendanceScreen extends StatefulWidget {
  const AttendanceScreen({super.key});
  static String routeName = 'attendanceScreen';

  @override
  State<AttendanceScreen> createState() => _AttendanceScreenState();
}

class _AttendanceScreenState extends State<AttendanceScreen> {

  var _isLoading = false;
  ScheduleResponse bData = ScheduleResponse(
    timetable: Timetable(
      monday: [
        Day(
          subjectId: "101",
          subjectName: "Mathematics",
          code: "MATH101",
          type: "Lecture",
          name: "John",
          surname: "Doe",
          employeeId: "E1001",
          id: "1",
          sessionId: "S2025",
          classId: "C1",
          sectionId: "A",
          subjectGroupId: "SG1",
          subjectGroupSubjectId: "SGS1",
          staffId: "ST1",
          day: "Monday",
          timeFrom: "09:00 AM",
          timeTo: "10:00 AM",
          startTime: "09:00 AM",
          endTime: "10:00 AM",
          roomNo: "101",
          createdAt: DateTime.now(),
          subjectGroupClassSectionsId: "SGCS1",
        ),
      ],
      tuesday: [
        Day(
          subjectId: "102",
          subjectName: "Physics",
          code: "PHY102",
          type: "Lecture",
          name: "Jane",
          surname: "Smith",
          employeeId: "E1002",
          id: "2",
          sessionId: "S2025",
          classId: "C1",
          sectionId: "A",
          subjectGroupId: "SG2",
          subjectGroupSubjectId: "SGS2",
          staffId: "ST2",
          day: "Tuesday",
          timeFrom: "10:00 AM",
          timeTo: "11:00 AM",
          startTime: "10:00 AM",
          endTime: "11:00 AM",
          roomNo: "102",
          createdAt: DateTime.now(),
          subjectGroupClassSectionsId: "SGCS2",
        ),
      ],
      wednesday: [],
      thursday: [],
      friday: [],
      saturday: [],
      sunday: [],
    ),
    status: "success",
  );

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final args = ModalRoute.of(context)?.settings.arguments as Map<String, dynamic>?;

    // Extract values safely
    final header = args?['header'];
    return Scaffold(
      appBar: AppBarTwo(title: header),
      body: Builder(builder: (context) {
        if (_isLoading) {
          return SizedBox(
            height: MediaQuery.of(context).size.height * .5,
            child: const Center(
              child: CircularProgressIndicator(),
            ),
          );
        }
        return SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 10.sp),
            child: Column(
              children: [
                cardWidget("Monday", bData.timetable
                    ?.monday),
                cardWidget("Tuesday", bData.timetable?.tuesday),
                cardWidget("Wednesday", bData.timetable?.wednesday),
                cardWidget("Thursday", bData.timetable?.thursday),
                cardWidget("Friday", bData.timetable?.friday),
                cardWidget("Saturday", bData.timetable?.saturday),
                cardWidget("Sunday", bData.timetable?.sunday),
              ],
            ),
          ),
        );
      }),
    );
  }
}

cardWidget(String day, List<Day>? dayList) {
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
            padding: EdgeInsets.symmetric(horizontal: 10.sp, vertical: 5.sp),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.only(
                    topRight: Radius.circular(10.r), topLeft: Radius.circular(10.r)),
                color: kToastTextColor),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  day,
                  style: TextStyle(
                    fontSize: 18.sp,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ],
            ),
          ),
        ),
        dayList == null || dayList.isEmpty
            ? Center(
          child: Padding(
            padding: EdgeInsets.all(20.sp),
            child: CommonText.medium('No Schedule Available',
                size: 12.sp, color: Colors.redAccent, overflow: TextOverflow.fade),
          ),
        )
            : ListView.builder(
            shrinkWrap: true,
            itemCount: dayList.length,
            physics: const NeverScrollableScrollPhysics(),
            padding: EdgeInsets.only(top: 10.sp),
            itemBuilder: (BuildContext context, int index) {
              return cardChildWidget(
                  '${dayList[index].subjectName.toString().capitalizeFirstOfEach} (${dayList[index].code.toString()})',
                  'Class : ${dayList[index].roomNo}',
                  dayList[index].startTime ?? "",
                  dayList[index].endTime ?? "",
                  index + 1 != dayList.length);
            }),
      ],
    ),
  );
}

cardChildWidget(String sub, String room, String start, String end, bool isLast) {
  return Column(
    children: [
      Padding(
        padding: EdgeInsets.symmetric(vertical: 10.sp, horizontal: 15.sp),
        child: Column(
          children: [
            Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        CommonText.medium(sub, size: 12.sp, color: Colors.black),
                        gap(2.sp),
                        CommonText.medium(room,
                            size: 12.sp, color: kDarkGreyColor, overflow: TextOverflow.fade),
                      ],
                    ),
                  ),
                  Row(
                    children: [
                      Container(
                        height: 28.sp,
                        width: 70.sp,
                        padding: EdgeInsets.symmetric(vertical: 4.sp, horizontal: 4.sp),
                        decoration:
                         BoxDecoration(color:
                        kToastTextColor, borderRadius: BorderRadius.only(bottomLeft: Radius.circular(10.r),topLeft: Radius.circular(10.r))),
                        child: Center(
                          child: CommonText.medium(start.fromLocalTimeDateString,
                              size: 12.sp, color: Colors.black, overflow: TextOverflow.fade),
                        ),
                      ),
                      Container(
                        height: 28.sp,
                        width: 70.sp,
                        decoration:
                         BoxDecoration(color: kToastTextColor, borderRadius: BorderRadius.only(bottomRight: Radius.circular(10.r),topRight: Radius.circular(10.r))),
                        child: Center(
                          child: CommonText.medium(end.fromLocalTimeDateString,
                              size: 12.sp, color: Colors.black, overflow: TextOverflow.fade),
                        ),
                      ),
                    ],
                  )
                ]),
            SizedBox(
              height: 20.h,
            ),
            Row(
              children: [
                Container(
                  decoration: BoxDecoration(
                    color: colorGreen,
                    borderRadius: BorderRadius.all(Radius.circular(20))
                  ),
                  padding: EdgeInsets.all(10),
                  child: CommonText.medium("Attendance",
                      size: 12.sp, color: Colors.white, overflow: TextOverflow.fade)
                ),
                SizedBox(
                  width: 20.h,
                ),
                Container(
                    decoration: BoxDecoration(
                        color: colorGreen,
                        borderRadius: BorderRadius.all(Radius.circular(20))
                    ),
                    padding: EdgeInsets.all(10),
                    child: CommonText.medium("Lesson Plan",
                        size: 12.sp, color: Colors.white, overflow: TextOverflow.fade)
                )
              ],
            )
          ],
        ),
      ),
      if (isLast) const Divider(color: Colors.grey, height: 0.1)
    ],
  );
}
