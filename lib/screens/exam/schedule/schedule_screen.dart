import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:masterjee/constants.dart';
import 'package:masterjee/models/exam/schedule/ScheduleResponse.dart';
import 'package:masterjee/others/StorageHelper.dart';
import 'package:masterjee/providers/exam_api.dart';
import 'package:masterjee/widgets/text.dart';
import 'package:provider/provider.dart';

class ScheduleScreen extends StatefulWidget {
  const ScheduleScreen({super.key});

  static String routeName = 'scheduleScreen';

  @override
  State<ScheduleScreen> createState() => _ScheduleScreenState();
}

class _ScheduleScreenState extends State<ScheduleScreen> {
  var _isLoading = false;
  late List<ScheduleData> scheduleList = [];

  @override
  void initState() {
    callApiExamSchedule();
    super.initState();
  }

  Future<void> callApiExamSchedule() async {
    setState(() {
      _isLoading = true;
    });
    try {
      ScheduleResponse data = await Provider.of<ExamApi>(context, listen: false)
          .examSchedule(
              StorageHelper.getStringData(StorageHelper.userIdKey).toString());
      if (data.result) {
        setState(() {
          scheduleList = data.data;
          _isLoading = false;
        });
        return;
      } else {
        setState(() {
          _isLoading = false;
        });
      }
    } catch (error) {
      print("callApiExamSchedule_error : $error");
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    if (_isLoading) {
      return SizedBox(
        height: MediaQuery.of(context).size.height * .5,
        child: const Center(
          child: CircularProgressIndicator(),
        ),
      );
    }
    if (scheduleList.isEmpty) {
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
          itemCount: scheduleList.length,
          padding: EdgeInsets.only(top: 10.sp,bottom: 20.sp),
          itemBuilder: (BuildContext context, int index) {
            return assignmentCard(scheduleList[index]);
          }),
    );
  }

  Widget assignmentCard(ScheduleData data) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        gap(10.00),
        CommonText.bold(data.name,
            size: 13.sp, color: colorBlack, overflow: TextOverflow.fade),
        gap(10.0),
        if (data.timeTable.isNotEmpty)
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: DataTable(
              columnSpacing: 20, // 👈 reduce column spacing if needed
              dataRowMinHeight: 30, // 👈 reduce row height
              dataRowMaxHeight: 40,
              headingRowHeight: 40,
              columns: <DataColumn>[
                DataColumn(
                    label: CommonText.semiBold("Subject",
                        size: 12.sp,
                        color: colorBlack,
                        overflow: TextOverflow.fade)),
                DataColumn(
                    label: CommonText.semiBold("Date",
                        size: 12.sp,
                        color: colorBlack,
                        overflow: TextOverflow.fade)),
                DataColumn(
                    label: CommonText.semiBold("Start Time",
                        size: 12.sp,
                        color: colorBlack,
                        overflow: TextOverflow.fade)),
                DataColumn(
                    label: CommonText.semiBold("Duration",
                        size: 12.sp,
                        color: colorBlack,
                        overflow: TextOverflow.fade)),
                DataColumn(
                    label: CommonText.semiBold("Room No.",
                        size: 12.sp,
                        color: colorBlack,
                        overflow: TextOverflow.fade)),
              ],
              rows: data.timeTable.map((data) {
                return DataRow(
                  cells: [
                    DataCell(CommonText.medium(data.subjectName,
                        size: 11.sp,
                        color: colorBlack,
                        overflow: TextOverflow.fade)),
                    DataCell(CommonText.medium(data.date,
                        size: 11.sp,
                        color: colorBlack,
                        overflow: TextOverflow.fade)),
                    DataCell(CommonText.medium(data.timeFrom,
                        size: 11.sp,
                        color: colorBlack,
                        overflow: TextOverflow.fade)),
                    DataCell(CommonText.medium(data.duration,
                        size: 11.sp,
                        color: colorBlack,
                        overflow: TextOverflow.fade)),
                    DataCell(CommonText.medium(data.roomNo,
                        size: 11.sp,
                        color: colorBlack,
                        overflow: TextOverflow.fade)),
                  ],
                );
              }).toList(),
            ),
          )
      ],
    );
  }
}
