import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:masterjee/models/class_section/class_section_response.dart';
import 'package:masterjee/providers/apply_leave_api.dart';
import 'package:masterjee/providers/assesment_api.dart';
import 'package:masterjee/providers/attendance_api.dart';
import 'package:masterjee/providers/auth.dart';
import 'package:masterjee/providers/class_timetable.dart';
import 'package:masterjee/providers/dues_report.dart';
import 'package:masterjee/providers/g_meet.dart';
import 'package:masterjee/providers/homework_api.dart';
import 'package:masterjee/providers/leads_api.dart';
import 'package:masterjee/providers/ptm_api.dart';
import 'package:masterjee/providers/student_behavior_api.dart';
import 'package:masterjee/providers/student_progress_api.dart';
import 'package:masterjee/screens/apply_leave/apply_leave_screen.dart';
import 'package:masterjee/screens/assesment/assesment_screen.dart';
import 'package:masterjee/screens/attendance/attendance_screen.dart';
import 'package:masterjee/screens/dues_report/dues_report_screen.dart';
import 'package:masterjee/screens/forgot_password_screen.dart';
import 'package:masterjee/screens/gmeet_live_classes/gmeet_live_classes_screen.dart';
import 'package:masterjee/screens/homework/homework_screen.dart';
import 'package:masterjee/screens/leads/campaign_leads_screen.dart';
import 'package:masterjee/screens/leads/edit_leads_screen.dart';
import 'package:masterjee/screens/leads/followups_screen.dart';
import 'package:masterjee/screens/leads/leads_screen.dart';
import 'package:masterjee/screens/leads/leads_view_screen.dart';
import 'package:masterjee/screens/leads/missed_screen.dart';
import 'package:masterjee/screens/leads/walk_in_screen.dart';
import 'package:masterjee/screens/ptm/add/add_screen.dart';
import 'package:masterjee/screens/ptm/minutebook/minutebook_screen.dart';
import 'package:masterjee/screens/ptm/ptm.dart';
import 'package:masterjee/screens/ptm/schedule/schedule_screen.dart';
import 'package:masterjee/screens/ptm/upcoming/upcoming_screen.dart';
import 'package:masterjee/screens/splash_screen.dart';
import 'package:masterjee/screens/home/main_screen.dart';
import 'package:masterjee/screens/signup_screen.dart';
import 'package:masterjee/screens/student_behaviour/behaviour_screen.dart';
import 'package:masterjee/screens/student_behaviour/comment_screen.dart';
import 'package:masterjee/screens/student_behaviour/incident_screen.dart';
import 'package:masterjee/screens/student_behaviour/student_behaviour_screen.dart';
import 'package:masterjee/screens/student_behaviour/view_screen.dart';
import 'package:masterjee/screens/student_progress/assessment_wise_screen.dart';
import 'package:masterjee/screens/student_progress/marksheet_screen.dart';
import 'package:masterjee/screens/student_progress/overall_screen.dart';
import 'package:masterjee/screens/student_progress/student_progress_screen.dart';
import 'package:masterjee/screens/student_progress/subject_wise_screen.dart';
import 'package:masterjee/screens/timetable/timetable_screen.dart';
import 'package:masterjee/widgets/app_tags.dart';
import 'package:provider/provider.dart';

import 'constants.dart';
import 'others/StorageHelper.dart';
import 'others/http_overrides.dart';
import 'screens/attendance/attendance_report_screen/attendance_report_screen.dart';
import 'screens/homework/submitted_homework_info.dart';

main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await StorageHelper.init();
  HttpOverrides.global = PostHttpOverrides();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});
  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {


  @override
  Widget build(BuildContext context) {

    return MultiProvider(
        providers: [
          ChangeNotifierProvider(create: (ctx) => Auth(),),
          ChangeNotifierProvider(create: (ctx) => DuesReport(),),
          ChangeNotifierProvider(create: (ctx) => GMeetApi()),
          ChangeNotifierProvider(create: (ctx) => ClassTimetable()),
          ChangeNotifierProvider(create: (ctx) => ApplyLeaveApi()),
          ChangeNotifierProvider(create: (ctx) => ClassAttendanceApi()),
          ChangeNotifierProvider(create: (ctx) => HomeworkApi()),
          ChangeNotifierProvider(create: (ctx) => StudentBehaviorApi()),
          ChangeNotifierProvider(create: (ctx) => AssesmentApi()),
          ChangeNotifierProvider(create: (ctx) => LeadsApi()),
          ChangeNotifierProvider(create: (ctx) => StudentProgressApi()),
          ChangeNotifierProvider(create: (ctx) => PtmApi()),
        ],
        child: Consumer<Auth>(
          builder: (ctx, auth, _) =>
              ScreenUtilInit(
              designSize: designSize(context),
              minTextAdapt: true,
              useInheritedMediaQuery: true,
              splitScreenMode: true,
              builder: (context, child) {
                return MaterialApp(
                  title:AppTags.appName,
                  theme: ThemeData(
                    fontFamily: 'google_sans',
                    colorScheme:
                    ColorScheme.fromSwatch(primarySwatch: Colors.grey)
                        .copyWith(secondary: colorWhite),
                  ),
                  debugShowCheckedModeBanner: false,
                  home: GetMaterialApp(
                      builder: (context, child) {
                        return MediaQuery(
                            data: MediaQuery.of(context)
                                .copyWith(textScaler: TextScaler.noScaling),
                            child: child!);
                      },
                      debugShowCheckedModeBanner: false,
                      title: AppTags.appName,
                      theme: ThemeData(
                        fontFamily: 'google_sans',
                        colorScheme:
                        ColorScheme.fromSwatch(primarySwatch: Colors.grey)
                            .copyWith(secondary: colorWhite),
                      ),
                      initialRoute: SplashScreen.routeName,
                      routes: {
                        SignupScreen.routeName: (ctx) =>  SignupScreen(),
                        MainScreen.routeName: (ctx) =>  const MainScreen(),
                        ForgotPassword.routeName: (ctx) =>  ForgotPassword(),
                        AttendanceScreen.routeName: (ctx) =>  AttendanceScreen(),
                        DuesReportScreen.routeName: (ctx) =>  DuesReportScreen(),
                        LeadsScreen.routeName: (ctx) => const LeadsScreen(),
                        HomeworkScreen.routeName: (ctx) => const HomeworkScreen(),
                        StudentBehaviourScreen.routeName: (ctx) => const StudentBehaviourScreen(),
                        StudentProgressScreen.routeName: (ctx) => const StudentProgressScreen(),
                        OverallScreen.routeName: (ctx) => const OverallScreen(),
                        MarkSheetScreen.routeName: (ctx) => const MarkSheetScreen(),
                        IncidentScreen.routeName: (ctx) => const IncidentScreen(),
                        BehaviourScreen.routeName: (ctx) => const BehaviourScreen(),
                        GMeetLiveClassesScreen.routeName: (ctx) => const GMeetLiveClassesScreen(),
                        ViewScreen.routeName: (ctx) => const ViewScreen(),
                        CommentScreen.routeName: (ctx) => const CommentScreen(),
                        AssesmentScreen.routeName: (ctx) => const AssesmentScreen(),
                        ApplyLeaveScreen.routeName: (ctx) => const ApplyLeaveScreen(),
                        PTMScreen.routeName: (ctx) => const PTMScreen(),
                        AddScreen.routeName: (ctx) => const AddScreen(),
                        MinutebookScreen.routeName: (ctx) => const MinutebookScreen(),
                        ScheduleScreen.routeName: (ctx) => const ScheduleScreen(),
                        UpcomingScreen.routeName: (ctx) => const UpcomingScreen(),
                        TimetableScreen.routeName: (ctx) => const TimetableScreen(),
                        AttendanceReportScreen.routeName: (ctx) => const AttendanceReportScreen(),
                        SubmittedHomeworkInfoScreen.routeName: (ctx) => const SubmittedHomeworkInfoScreen(),
                        FollowupsScreen.routeName: (ctx) => const FollowupsScreen(),
                        MissedScreen.routeName: (ctx) => const MissedScreen(),
                        WalkInScreen.routeName: (ctx) => const WalkInScreen(),
                        EditLeadsScreen.routeName: (ctx) => const EditLeadsScreen(),
                        CampaignLeadsScreen.routeName: (ctx) => const CampaignLeadsScreen(),
                        LeadsViewScreen.routeName: (ctx) => const LeadsViewScreen(),
                        SubjectWiseScreen.routeName: (ctx) => const SubjectWiseScreen(),
                        AssessmentWiseScreen.routeName: (ctx) => const AssessmentWiseScreen(),
                      },
                      home: const SplashScreen()),
                );
              }),
        ),
      );
  }
}
