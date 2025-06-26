import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:masterjee/constants.dart';
import 'package:masterjee/screens/assesment/assesment_screen.dart';
import 'package:masterjee/screens/exam/assessment/assesment_screen.dart';
import 'package:masterjee/screens/exam/exam/exam_screen.dart';
import 'package:masterjee/screens/exam/grades/grades_screen.dart';
import 'package:masterjee/screens/exam/observation/observation_screen.dart';
import 'package:masterjee/screens/exam/schedule/schedule_screen.dart';
import 'package:masterjee/widgets/app_bar_two.dart';
import 'package:masterjee/widgets/app_tags.dart';
import 'package:masterjee/widgets/text.dart';

class ExamMainScreen extends StatefulWidget {
  const ExamMainScreen({super.key});

  static String routeName = 'examMainScreen';


  @override
  State<ExamMainScreen> createState() => _ExamMainScreenState();
}

class _ExamMainScreenState extends State<ExamMainScreen> with WidgetsBindingObserver, SingleTickerProviderStateMixin{

  late TabController tabController;
  bool _isLoading = false;
  List<int> contentData = [];
  int selectedIndex = 0;

  @override
  void initState() {
    tabController = TabController(length: 5, vsync: this);
    tabController.addListener(() {
      if (tabController.indexIsChanging) return; // Prevent duplicate calls
      selectedIndex = tabController.index;
      print("Tab changed to index: $selectedIndex");
      if (selectedIndex == 0 || selectedIndex == 1) {
       // callApiLeadsList();
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBarTwo(title: AppTags.exam),
        body: Container(
          color: kBackgroundColor,
          child: Builder(builder: (context) {
            return Stack(
              children: [
                Column(children: [
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
                          icon: CommonText.medium(AppTags.exam,
                              size: 12.sp, overflow: TextOverflow.fade)),
                      Tab(
                          icon: CommonText.medium(AppTags.assesment,
                              size: 12.sp, overflow: TextOverflow.fade)),
                      Tab(
                          icon: CommonText.medium(AppTags.grades,
                              size: 12.sp, overflow: TextOverflow.fade)),
                      Tab(
                          icon: CommonText.medium(AppTags.observation,
                              size: 12.sp, overflow: TextOverflow.fade)),
                      Tab(icon: CommonText.medium(AppTags.schedule,
                            size: 12.sp, overflow: TextOverflow.fade,)),
                    ],
                  ),
                  Expanded(
                    child: TabBarView(
                      controller: tabController,
                      children: const [
                        ExamScreen(),
                        AssessmentScreen(),
                        GradesScreen(),
                        ObservationScreen(),
                        ScheduleScreen(),
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
