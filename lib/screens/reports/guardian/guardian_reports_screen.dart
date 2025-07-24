import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:masterjee/constants.dart';
import 'package:masterjee/models/reports/HostelReportsResponse.dart';
import 'package:masterjee/others/StorageHelper.dart';
import 'package:masterjee/providers/reports_api.dart';
import 'package:masterjee/widgets/text.dart';
import 'package:provider/provider.dart';

class GuardianReportsScreen extends StatefulWidget {
  const GuardianReportsScreen({super.key});
  static String routeName = 'guardianReportsScreen';

  @override
  State<GuardianReportsScreen> createState() => _GuardianReportsScreenState();
}

class _GuardianReportsScreenState extends State<GuardianReportsScreen> {

  var _isLoading = false;
  late List<StudentModel> hostelReportsList = [];

  @override
  void initState() {
    callApiSiblingReports();
    super.initState();
  }

  Future<void> callApiSiblingReports() async {
    setState(() {
      _isLoading = true;
    });
    try {
      Hostelreportsresponse data =
      await Provider.of<ReportsApi>(context, listen: false).siblingReports(
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
      print("callApiSiblingReports_error : $error");
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
        columnSpacing: 30,
        // 👈 reduce column spacing if needed
        dataRowMinHeight: 45,
        // 👈 reduce row height
        dataRowMaxHeight: 45,
        headingRowHeight: 40,
        columns: <DataColumn>[
          DataColumn(
              label: CommonText.semiBold("Admission No",
                  size: 12.sp, color: colorBlack, overflow: TextOverflow.fade)),
          DataColumn(
              label: CommonText.semiBold("Name",
                  size: 12.sp, color: colorBlack, overflow: TextOverflow.fade)),
          DataColumn(
              label: CommonText.semiBold("Mobile",
                  size: 12.sp, color: colorBlack, overflow: TextOverflow.fade)),
          DataColumn(
              label: CommonText.semiBold("Guardian Name",
                  size: 12.sp, color: colorBlack, overflow: TextOverflow.fade)),
          DataColumn(
              label: CommonText.semiBold("Guardian Relation",
                  size: 12.sp, color: colorBlack, overflow: TextOverflow.fade)),
          DataColumn(
              label: CommonText.semiBold("Guardian Phone",
                  size: 12.sp, color: colorBlack, overflow: TextOverflow.fade)),
          DataColumn(
              label: CommonText.semiBold("Father Name",
                  size: 12.sp, color: colorBlack, overflow: TextOverflow.fade)),
          DataColumn(
              label: CommonText.semiBold("Father Phone",
                  size: 12.sp, color: colorBlack, overflow: TextOverflow.fade)),
          DataColumn(
              label: CommonText.semiBold("Mother Name",
                  size: 12.sp, color: colorBlack, overflow: TextOverflow.fade)),
          DataColumn(
              label: CommonText.semiBold("Mother Phone",
                  size: 12.sp, color: colorBlack, overflow: TextOverflow.fade)),
        ],
        rows: hostelReportsList.map((data) {
          return DataRow(
            cells: [
              DataCell(CommonText.medium(
                  data.admissionNo ?? "",
                  size: 11.sp,
                  color: colorBlack,
                  overflow: TextOverflow.fade)),
              DataCell(CommonText.medium(data.firstname.toString() ?? "",
                  size: 11.sp, color: colorBlack, overflow: TextOverflow.fade)),
              DataCell(CommonText.medium(
                  data.hostelInfo?.mobileno ?? "",
                  size: 11.sp,
                  color: colorBlack,
                  overflow: TextOverflow.fade)),
              DataCell(CommonText.medium(
                  "${data.guardianName?? ""}",
                  size: 11.sp,
                  color: colorBlack,
                  overflow: TextOverflow.fade)),
              DataCell(CommonText.medium(data.guardianRelation ?? "",
                  size: 11.sp, color: colorBlack, overflow: TextOverflow.fade)),
              DataCell(CommonText.medium(data.guardianPhone ?? "",
                  size: 11.sp, color: colorBlack, overflow: TextOverflow.fade)),
              DataCell(CommonText.medium(data.fatherName ?? "",
                  size: 11.sp, color: colorBlack, overflow: TextOverflow.fade)),
              DataCell(CommonText.medium(data.fatherPhone ?? "",
                  size: 11.sp, color: colorBlack, overflow: TextOverflow.fade)),
              DataCell(CommonText.medium(data.motherName ?? "",
                  size: 11.sp, color: colorBlack, overflow: TextOverflow.fade)),
              DataCell(CommonText.medium(data.motherPhone ?? "",
                  size: 11.sp, color: colorBlack, overflow: TextOverflow.fade)),
            ],
          );
        }).toList(),
      ),
    );
  }
}
