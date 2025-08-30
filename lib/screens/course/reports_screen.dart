import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:masterjee/constants.dart';
import 'package:masterjee/models/course/course_report_model.dart';
import 'package:masterjee/others/StorageHelper.dart';
import 'package:masterjee/providers/course_api.dart';
import 'package:masterjee/widgets/app_bar_two.dart';
import 'package:masterjee/widgets/app_tags.dart';
import 'package:masterjee/widgets/text.dart';
import 'package:provider/provider.dart';

class CourseReportsScreen extends StatefulWidget {
  const CourseReportsScreen({super.key});

  static String routeName = 'courseReportsScreen';

  @override
  State<CourseReportsScreen> createState() => _CourseReportsScreenState();
}

class _CourseReportsScreenState extends State<CourseReportsScreen>
    with WidgetsBindingObserver, SingleTickerProviderStateMixin {
  late TabController tabController;
  var _isInit = true;
  var _isLoading = false;
  var _isLoadingComplete = false;

  void getData({bool isRefresh = false}) {
    if (!_isInit && !isRefresh) return;
    setState(() {
      _isLoading = isRefresh ? false : true;
    });
    Provider.of<CourseApi>(context, listen: false)
        .getCourseReport(StorageHelper.getStringData(StorageHelper.userIdKey).toString(), StorageHelper.getStringData(StorageHelper.classIdKey).toString(), StorageHelper.getStringData(StorageHelper.sectionIdKey).toString())
        .then((value) {
      setState(() {
        students = value.data?.sell??[];
        rating = value.data?.rating??[];
        _isLoading = false;
      });
    });
    setState(() {
      _isInit = false;
    });
  }
  List<Rating> rating = [];
  List<CompleteReport> completeReport = [];
  List<Sell> students = [];
  int? selected;

  List<String> stringList = [];

  void getCompleteData({bool isRefresh = false}) {
    setState(() {
      _isLoadingComplete = true;
    });
    Provider.of<CourseApi>(context, listen: false)
        .getCompleteCourseReport(StorageHelper.getStringData(StorageHelper.userIdKey).toString(), StorageHelper.getStringData(StorageHelper.classIdKey).toString(), StorageHelper.getStringData(StorageHelper.sectionIdKey).toString())
        .then((value) {
      setState(() {
        completeReport = value.data??[];
        _isLoadingComplete = false;
      });
    });
  }

  @override
  void initState() {
    tabController = TabController(length: 4, vsync: this);
    getData();
    getCompleteData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBarTwo(title: AppTags.reports),
        body: Container(
          color: kBackgroundColor,
          child: Builder(builder: (context) {
            return Stack(
              children: [
                Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      TabBar(
                        isScrollable: true,
                        controller: tabController,
                        indicatorSize: TabBarIndicatorSize.tab,
                        dividerColor: Colors.transparent,
                        indicator: const BoxDecoration(
                          color: Colors.green,
                          borderRadius: BorderRadius.all(Radius.circular(15)),
                        ),
                        labelColor: Colors.white,
                        unselectedLabelColor: Colors.black,
                        indicatorColor: kRedColor,
                        tabs: [
                          Tab(
                              icon: CommonText.medium(AppTags.trending,
                                  size: 12.sp, overflow: TextOverflow.fade)),
                          Tab(
                              icon: CommonText.medium(AppTags.rating,
                                  size: 12.sp, overflow: TextOverflow.fade)),
                          Tab(
                              icon: CommonText.medium(AppTags.complete,
                                  size: 12.sp, overflow: TextOverflow.fade)),
                          Tab(
                              icon: CommonText.medium(AppTags.students,
                                  size: 12.sp, overflow: TextOverflow.fade)),
                        ],
                      ),
                      Expanded(
                        child: TabBarView(
                          controller: tabController,
                          children: [
                            trendingReports(context),
                            ratingReports(context),
                            completeReports(context),
                            studentReports(context),
                          ],
                        ),
                      ),
                    ]),
              ],
            );
          }),
        ));
  }


  Widget trendingReports(BuildContext context) {
    if (_isLoading) {
      return SizedBox(
        height: MediaQuery.of(context).size.height * .5,
        child: const Center(
          child: CircularProgressIndicator(),
        ),
      );
    }
    if (rating.isEmpty) {
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
      // scrollDirection: Axis.horizontal,
      child: DataTable(
        columnSpacing: 30,
        // 👈 reduce column spacing if needed
        dataRowMinHeight: 45,
        // 👈 reduce row height
        dataRowMaxHeight: 45,
        headingRowHeight: 40,
        columns: <DataColumn>[
          DataColumn(
              label: CommonText.semiBold("Title",
                  size: 12.sp, color: colorBlack, overflow: TextOverflow.fade)),
          DataColumn(
              label: CommonText.semiBold("Class",
                  size: 12.sp, color: colorBlack, overflow: TextOverflow.fade)),
          DataColumn(
              label: CommonText.semiBold("View",
                  size: 12.sp, color: colorBlack, overflow: TextOverflow.fade)),
          DataColumn(
              label: CommonText.semiBold("Price",
                  size: 12.sp, color: colorBlack, overflow: TextOverflow.fade)),
        ],
        rows: rating.map((data) {
          return DataRow(
            cells: [
              DataCell(CommonText.medium(
                  data.courseName ?? "",
                  size: 11.sp,
                  color: colorBlack,
                  overflow: TextOverflow.fade)),
              DataCell(CommonText.medium(data.className ?? "",
                  size: 11.sp, color: colorBlack, overflow: TextOverflow.fade)),
              DataCell(CommonText.medium(
                  data.view ?? "",
                  size: 11.sp,
                  color: colorBlack,
                  overflow: TextOverflow.fade)),
              DataCell(CommonText.medium(
                  data.paidAmount ?? "",
                  size: 11.sp,
                  color: colorBlack,
                  overflow: TextOverflow.fade)),
            ],
          );
        }).toList(),
      ),
    );
  }

  Widget ratingReports(BuildContext context) {
    if (_isLoading) {
      return SizedBox(
        height: MediaQuery.of(context).size.height * .5,
        child: const Center(
          child: CircularProgressIndicator(),
        ),
      );
    }
    if (rating.isEmpty) {
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
      // scrollDirection: Axis.horizontal,
      child: DataTable(
        columnSpacing: 30,
        // 👈 reduce column spacing if needed
        dataRowMinHeight: 45,
        // 👈 reduce row height
        dataRowMaxHeight: 45,
        headingRowHeight: 40,
        columns: <DataColumn>[
          DataColumn(
              label: CommonText.semiBold("Title",
                  size: 12.sp, color: colorBlack, overflow: TextOverflow.fade)),
          DataColumn(
              label: CommonText.semiBold("Class",
                  size: 12.sp, color: colorBlack, overflow: TextOverflow.fade)),
          DataColumn(
              label: CommonText.semiBold("Rating",
                  size: 12.sp, color: colorBlack, overflow: TextOverflow.fade)),
          DataColumn(
              label: CommonText.semiBold("Review",
                  size: 12.sp, color: colorBlack, overflow: TextOverflow.fade)),
        ],
        rows: rating.map((data) {
          return DataRow(
            cells: [
              DataCell(CommonText.medium(
                  data.courseName ?? "",
                  size: 11.sp,
                  color: colorBlack,
                  overflow: TextOverflow.fade)),
              DataCell(CommonText.medium(data.className ?? "",
                  size: 11.sp, color: colorBlack, overflow: TextOverflow.fade)),
              DataCell(CommonText.medium(
                  data.rating ?? "",
                  size: 11.sp,
                  color: colorBlack,
                  overflow: TextOverflow.fade)),
              DataCell(CommonText.medium(
                  data.review ?? "",
                  size: 11.sp,
                  color: colorBlack,
                  overflow: TextOverflow.fade)),
            ],
          );
        }).toList(),
      ),
    );
  }

  Widget completeReports(BuildContext context) {
    if (_isLoadingComplete) {
      return SizedBox(
        height: MediaQuery.of(context).size.height * .5,
        child: const Center(
          child: CircularProgressIndicator(),
        ),
      );
    }
    if (completeReport.isEmpty) {
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
      // scrollDirection: Axis.horizontal,
      child: DataTable(
        columnSpacing: 30,
        dataRowMinHeight: 45,
        dataRowMaxHeight: 45,
        headingRowHeight: 40,
        columns: <DataColumn>[
          DataColumn(
              label: CommonText.semiBold("Title",
                  size: 12.sp, color: colorBlack, overflow: TextOverflow.fade)),
          DataColumn(
              label: CommonText.semiBold("Student",
                  size: 12.sp, color: colorBlack, overflow: TextOverflow.fade)),
          DataColumn(
              label: CommonText.semiBold("Progress",
                  size: 12.sp, color: colorBlack, overflow: TextOverflow.fade)),
        ],
        rows: completeReport.map((data) {
          return DataRow(
            cells: [
              DataCell(CommonText.medium(
                  data.courseTitle ?? "",
                  size: 11.sp,
                  color: colorBlack,
                  overflow: TextOverflow.fade)),
              DataCell(CommonText.medium("${data.studentId} ${data.studentName}",
                  size: 11.sp, color: colorBlack, overflow: TextOverflow.fade)),
              DataCell(CommonText.medium(
                  data.progress.toString(),
                  size: 11.sp,
                  color: colorBlack,
                  overflow: TextOverflow.fade)),
            ],
          );
        }).toList(),
      ),
    );
  }

  Widget studentReports(BuildContext context) {
    if (_isLoading) {
      return SizedBox(
        height: MediaQuery.of(context).size.height * .5,
        child: const Center(
          child: CircularProgressIndicator(),
        ),
      );
    }
    if (students.isEmpty) {
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
      // scrollDirection: Axis.horizontal,
      child: DataTable(
        columnSpacing: 30,
        dataRowMinHeight: 45,
        dataRowMaxHeight: 45,
        headingRowHeight: 40,
        columns: <DataColumn>[
          DataColumn(
              label: CommonText.semiBold("Student",
                  size: 12.sp, color: colorBlack, overflow: TextOverflow.fade)),
          DataColumn(
              label: CommonText.semiBold("Date",
                  size: 12.sp, color: colorBlack, overflow: TextOverflow.fade)),
          DataColumn(
              label: CommonText.semiBold("Course",
                  size: 12.sp, color: colorBlack, overflow: TextOverflow.fade)),
          DataColumn(
              label: CommonText.semiBold("Price",
                  size: 12.sp, color: colorBlack, overflow: TextOverflow.fade)),
        ],

        rows: students.map((data) {
          return DataRow(
            cells: [
              DataCell(CommonText.medium("${data.studentId} ${data.studentName}",
                  size: 11.sp, color: colorBlack, overflow: TextOverflow.fade)),
              DataCell(CommonText.medium(data.date??"",
                  size: 11.sp, color: colorBlack, overflow: TextOverflow.fade)),
              DataCell(CommonText.medium(
                  data.courseName ?? "",
                  size: 11.sp,
                  color: colorBlack,
                  overflow: TextOverflow.fade)),
              DataCell(CommonText.medium(
                  data.paidAmount.toString(),
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
