import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:masterjee/constants.dart';
import 'package:masterjee/models/reports/HostelReportsResponse.dart';
import 'package:masterjee/others/StorageHelper.dart';
import 'package:masterjee/providers/reports_api.dart';
import 'package:masterjee/widgets/text.dart';
import 'package:provider/provider.dart';

class StudentReportsScreen extends StatefulWidget {
  const StudentReportsScreen({super.key});

  static String routeName = 'studentReportsScreen';

  @override
  State<StudentReportsScreen> createState() => _StudentReportsScreenState();
}

class _StudentReportsScreenState extends State<StudentReportsScreen> {


  var _isLoading = false;
  late List<StudentModel> hostelReportsList = [];

  @override
  void initState() {
    callApiStudentsReports();
    super.initState();
  }

  Future<void> callApiStudentsReports() async {
    setState(() {
      _isLoading = true;
    });
    try {
      Hostelreportsresponse data =
      await Provider.of<ReportsApi>(context, listen: false).studentsReports(
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
      print("callApiStudentsReports_error : $error");
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
              label: CommonText.semiBold("AdmNo",
                  size: 12.sp, color: colorBlack, overflow: TextOverflow.fade)),
          DataColumn(
              label: CommonText.semiBold("Name",
                  size: 12.sp, color: colorBlack, overflow: TextOverflow.fade)),
          DataColumn(
              label: CommonText.semiBold("father",
                  size: 12.sp, color: colorBlack, overflow: TextOverflow.fade)),
          DataColumn(
              label: CommonText.semiBold("D.O.B",
                  size: 12.sp, color: colorBlack, overflow: TextOverflow.fade)),
          DataColumn(
              label: CommonText.semiBold("Gender",
                  size: 12.sp, color: colorBlack, overflow: TextOverflow.fade)),
          DataColumn(
              label: CommonText.semiBold("category",
                  size: 12.sp, color: colorBlack, overflow: TextOverflow.fade)),
          DataColumn(
              label: CommonText.semiBold("Mobile",
                  size: 12.sp, color: colorBlack, overflow: TextOverflow.fade)),
          DataColumn(
              label: CommonText.semiBold("L.I.N",
                  size: 12.sp, color: colorBlack, overflow: TextOverflow.fade)),
          DataColumn(
              label: CommonText.semiBold("RTE",
                  size: 12.sp, color: colorBlack, overflow: TextOverflow.fade)),
        ],
        rows: hostelReportsList.map((data) {
          return DataRow(
            cells: [
              DataCell(CommonText.medium(
                  "${data.admissionNo ?? ""}",
                  size: 11.sp,
                  color: colorBlack,
                  overflow: TextOverflow.fade)),
              DataCell(CommonText.medium(data.firstname.toString() ?? "",
                  size: 11.sp, color: colorBlack, overflow: TextOverflow.fade)),
              DataCell(CommonText.medium(data.fatherName.toString() ?? "",
                  size: 11.sp, color: colorBlack, overflow: TextOverflow.fade)),
              DataCell(CommonText.medium(data.dob.toString() ?? "",
                  size: 11.sp, color: colorBlack, overflow: TextOverflow.fade)),
              DataCell(CommonText.medium(data.gender.toString() ?? "",
                  size: 11.sp, color: colorBlack, overflow: TextOverflow.fade)),
              DataCell(CommonText.medium( "",
                  size: 11.sp, color: colorBlack, overflow: TextOverflow.fade)),
              DataCell(CommonText.medium(data.mobileno.toString() ?? "",
                  size: 11.sp, color: colorBlack, overflow: TextOverflow.fade)),
              DataCell(CommonText.medium( "",
                  size: 11.sp, color: colorBlack, overflow: TextOverflow.fade)),
              DataCell(CommonText.medium(
                  data.rte ?? "",
                  size: 11.sp,
                  color: colorBlack,
                  overflow: TextOverflow.fade)),
            ],
          );
        }).toList(),
      ),
    );
  }
}
