import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:masterjee/constants.dart';
import 'package:masterjee/models/reports/HostelReportsResponse.dart';
import 'package:masterjee/others/StorageHelper.dart';
import 'package:masterjee/providers/reports_api.dart';
import 'package:masterjee/widgets/text.dart';
import 'package:provider/provider.dart';

class HostelReportsScreen extends StatefulWidget {
  const HostelReportsScreen({super.key});

  static String routeName = 'hostelReportsScreen';

  @override
  State<HostelReportsScreen> createState() => _HostelReportsScreenState();
}

class _HostelReportsScreenState extends State<HostelReportsScreen> {

  var _isLoading = false;
  late List<StudentModel> hostelReportsList = [];

  @override
  void initState() {
    callApiHostelReports();
    super.initState();
  }

  Future<void> callApiHostelReports() async {
    setState(() {
      _isLoading = true;
    });
    try {
      Hostelreportsresponse data =
          await Provider.of<ReportsApi>(context, listen: false).hostelReports(
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
      print("callApiHostelReports_error : $error");
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
              label: CommonText.semiBold("Student",
                  size: 12.sp, color: colorBlack, overflow: TextOverflow.fade)),
          DataColumn(
              label: CommonText.semiBold("Guradian",
                  size: 12.sp, color: colorBlack, overflow: TextOverflow.fade)),
          DataColumn(
              label: CommonText.semiBold("Hostel",
                  size: 12.sp, color: colorBlack, overflow: TextOverflow.fade)),
          DataColumn(
              label: CommonText.semiBold("Room",
                  size: 12.sp, color: colorBlack, overflow: TextOverflow.fade)),
          DataColumn(
              label: CommonText.semiBold("Cost",
                  size: 12.sp, color: colorBlack, overflow: TextOverflow.fade)),
        ],
        rows: hostelReportsList.map((data) {
          return DataRow(
            cells: [
              DataCell(CommonText.medium(
                  "${data.admissionNo ?? ""}\n${data.firstname ?? ""}",
                  size: 11.sp,
                  color: colorBlack,
                  overflow: TextOverflow.fade)),
              DataCell(CommonText.medium(data.fatherPhone.toString() ?? "",
                  size: 11.sp, color: colorBlack, overflow: TextOverflow.fade)),
              DataCell(CommonText.medium(
                  "${data.hostelInfo?.hostelName ?? ""} \n${data.hostelInfo?.type ?? ""} \n${data.hostelInfo?.address ?? ""}",
                  size: 11.sp,
                  color: colorBlack,
                  overflow: TextOverflow.fade)),
              DataCell(CommonText.medium(
                  "RNo : ${data.hostelInfo?.roomNo ?? ""} \nRNo : ${data.hostelInfo?.bedCode ?? ""}",
                  size: 11.sp,
                  color: colorBlack,
                  overflow: TextOverflow.fade)),
              DataCell(CommonText.medium(data.hostelInfo?.costPerBed ?? "",
                  size: 11.sp, color: colorBlack, overflow: TextOverflow.fade)),
            ],
          );
        }).toList(),
      ),
    );
  }
}
