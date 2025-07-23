import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:masterjee/constants.dart';
import 'package:masterjee/screens/reports/assignment/assignment_reports_screen.dart';
import 'package:masterjee/screens/reports/guardian/guardian_reports_screen.dart';
import 'package:masterjee/screens/reports/hostel/hostel_reports_screen.dart';
import 'package:masterjee/screens/reports/parent_login/parent_login_screen.dart';
import 'package:masterjee/screens/reports/student/student_reports_screen.dart';
import 'package:masterjee/screens/reports/transport/transport_reports_screen.dart';
import 'package:masterjee/widgets/app_bar_two.dart';
import 'package:masterjee/widgets/app_tags.dart';
import 'package:masterjee/widgets/text.dart';

class ReportsMainScreen extends StatefulWidget {
  const ReportsMainScreen({super.key});

  static String routeName = 'reportsMainScreen';

  @override
  State<ReportsMainScreen> createState() => _ReportsMainScreenState();
}

class _ReportsMainScreenState extends State<ReportsMainScreen>
    with WidgetsBindingObserver, SingleTickerProviderStateMixin {
  late TabController tabController;

  @override
  void initState() {
    tabController = TabController(length: 6, vsync: this);
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
                              icon: CommonText.medium(AppTags.hostelReports,
                                  size: 12.sp, overflow: TextOverflow.fade)),
                          Tab(
                              icon: CommonText.medium(AppTags.transportReports,
                                  size: 12.sp, overflow: TextOverflow.fade)),
                          Tab(
                              icon: CommonText.medium(AppTags.assignmentReports,
                                  size: 12.sp, overflow: TextOverflow.fade)),
                          Tab(
                              icon: CommonText.medium(AppTags.studentReports,
                                  size: 12.sp, overflow: TextOverflow.fade)),
                          Tab(
                              icon: CommonText.medium(
                            AppTags.guardianReports,
                            size: 12.sp,
                            overflow: TextOverflow.fade,
                          )),
                          Tab(
                              icon: CommonText.medium(
                            AppTags.parentLogin,
                            size: 12.sp,
                            overflow: TextOverflow.fade,
                          )),
                        ],
                      ),
                      Expanded(
                        child: TabBarView(
                          controller: tabController,
                          children: const [
                            HostelReportsScreen(),
                            TransportReportsScreen(),
                            AssignmentReportsScreen(),
                            StudentReportsScreen(),
                            GuardianReportsScreen(),
                            ParentLoginScreen(),
                          ],
                        ),
                      ),
                    ]),
              ],
            );
          }),
        ));
  }
}
