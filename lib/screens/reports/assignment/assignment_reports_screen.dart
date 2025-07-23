import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:masterjee/constants.dart';
import 'package:masterjee/models/reports/HostelReportsResponse.dart';
import 'package:masterjee/others/StorageHelper.dart';
import 'package:masterjee/providers/reports_api.dart';
import 'package:masterjee/widgets/text.dart';
import 'package:provider/provider.dart';

class AssignmentReportsScreen extends StatefulWidget {
  const AssignmentReportsScreen({super.key});
  static String routeName = 'assignmentReportsScreen';

  @override
  State<AssignmentReportsScreen> createState() => _AssignmentReportsScreenState();
}

class _AssignmentReportsScreenState extends State<AssignmentReportsScreen> {

  var _isLoading = false;
  late List<StudentModel> hostelReportsList = [];

  @override
  void initState() {
    callApiAssignmentReports();
    super.initState();
  }

  Future<void> callApiAssignmentReports() async {
    setState(() {
      _isLoading = true;
    });
    try {
      Hostelreportsresponse data =
      await Provider.of<ReportsApi>(context, listen: false).assignmentReports(
        StorageHelper.getStringData(StorageHelper.userIdKey).toString(),
        StorageHelper.getStringData(StorageHelper.classIdKey).toString(),
        StorageHelper.getStringData(StorageHelper.sectionIdKey).toString(),
      );
      if (data.result) {
        setState(() {
          hostelReportsList = data.data;
          _isLoading = false;
        });
        return;
      } else {
        setState(() {
          _isLoading = false;
        });
      }
    } catch (error) {
      print("callApiAssignmentReports_error : $error");
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
    if (hostelReportsList.isEmpty) {
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
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: DataTable(
        columnSpacing: 95,
        // 👈 reduce column spacing if needed
        dataRowMinHeight: 45,
        // 👈 reduce row height
        dataRowMaxHeight: 45,
        headingRowHeight: 40,
        columns: <DataColumn>[
          DataColumn(
              label: CommonText.semiBold("Student",
                  size: 12.sp, color: colorBlack, overflow: TextOverflow.fade)),
          DataColumn(
              label: CommonText.semiBold("Total Assignments",
                  size: 12.sp, color: colorBlack, overflow: TextOverflow.fade)),
        ],
        rows: hostelReportsList.map((data) {
          return DataRow(
            cells: [
              DataCell(CommonText.medium(
                  "${data.admissionNo ?? ""} ${data.firstname ?? ""}",
                  size: 11.sp,
                  color: colorBlack,
                  overflow: TextOverflow.fade)),
              DataCell(CommonText.medium("0",
                  size: 11.sp, color: colorBlack, overflow: TextOverflow.fade)),
            ],
          );
        }).toList(),
      ),
    );
  }
}
