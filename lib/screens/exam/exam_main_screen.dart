import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get_utils/src/extensions/widget_extensions.dart';
import 'package:masterjee/constants.dart';
import 'package:masterjee/models/attendance/class_attendance_model.dart';
import 'package:masterjee/models/common_functions.dart';
import 'package:masterjee/models/exam/observation/ObservationInfoResponse.dart';
import 'package:masterjee/others/StorageHelper.dart';
import 'package:masterjee/providers/exam_api.dart';
import 'package:masterjee/screens/assesment/assesment_screen.dart';
import 'package:masterjee/screens/exam/assessment/assesment_screen.dart';
import 'package:masterjee/screens/exam/exam/exam_screen.dart';
import 'package:masterjee/screens/exam/grades/grades_screen.dart';
import 'package:masterjee/screens/exam/observation/observation_screen.dart';
import 'package:masterjee/screens/exam/schedule/schedule_screen.dart';
import 'package:masterjee/widgets/CommonButton.dart';
import 'package:masterjee/widgets/app_bar_two.dart';
import 'package:masterjee/widgets/app_tags.dart';
import 'package:masterjee/widgets/custom_form_field.dart';
import 'package:masterjee/widgets/text.dart';
import 'package:provider/provider.dart';

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

  Future<void> callApiSaveTerm() async {
   /* setState(() {
      _isLoading = true;
    });*/
    try {
      ObservationInfoResponse data = await Provider.of<ExamApi>(context, listen: false)
          .saveTerm(
          StorageHelper.getStringData(StorageHelper.userIdKey).toString(),
          termNameController.text,
          termCodeController.text,
        termDescriptionController.text,
      );
      if (data.result) {
        setState(() {
          _isLoading = false;
          termNameController.text = "";
          termCodeController.text = "";
          termDescriptionController.text = "";
          CommonFunctions.showWarningToast(data.message);
        });
        return;
      } else {
        setState(() {
          _isLoading = false;
          CommonFunctions.showWarningToast(data.message);
        });
      }
    } catch (error) {
      print("callApiExamSchedule_error : $error");
      /*setState(() {
        _isLoading = false;
      });*/
    }
  }

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

  late var termNameController = TextEditingController();
  late var termCodeController = TextEditingController();
  late var termDescriptionController = TextEditingController();


  void showTermsDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          insetPadding: EdgeInsets.zero,
          child: LayoutBuilder(
            builder: (context, constraints) {
              return Container(
                decoration: BoxDecoration(
                  color: kBackgroundColor, // background color
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(
                    color: Colors.transparent,
                    width: 0,
                  ),
                ),
                width: MediaQuery.of(context).size.width - 30.sp,
                padding: const EdgeInsets.all(16),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    CustomTextField(
                      borderRadius: 5,
                      hintText: 'Term Name',
                      isReadonly: false,
                      controller: termNameController,
                      keyboardType: TextInputType.name,
                      onSave: (value) {
                        termNameController.text = value as String;
                      },
                    ),
                    gap(10.0),
                    CustomTextField(
                      borderRadius: 5,
                      hintText: 'Term code',
                      isReadonly: false,
                      controller: termCodeController,
                      keyboardType: TextInputType.name,
                      onSave: (value) {
                        termCodeController.text = value as String;
                      },
                    ),
                    gap(10.0),
                    CustomTextField(
                      borderRadius: 5,
                      maxLines: 3,
                      hintText: 'Description',
                      isReadonly: false,
                      controller: termDescriptionController,
                      keyboardType: TextInputType.name,
                      onSave: (value) {
                        termDescriptionController.text = value as String;
                      },
                    ),
                    gap(10.0),
                    CommonButton(
                      cornersRadius: 30,
                      text: AppTags.add,
                      onPressed: () {
                        setState(() {

                          if(termNameController.text == ""){
                            CommonFunctions.showWarningToast("Please enter term name");
                          }else if(termCodeController.text == ""){
                            CommonFunctions.showWarningToast("Please enter term code");
                          }else if(termDescriptionController.text == ""){
                            CommonFunctions.showWarningToast("Please enter term description");
                          }else{
                            callApiSaveTerm();
                            Navigator.of(context).pop();
                          }
                        });
                      },
                    ).paddingOnly(left: 15,right: 15,bottom: 10) ,
                  ],
                ),
              );
            },
          ),
        );
      },
    );
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
                Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                  InkWell(
                    onTap: () {
                      showTermsDialog();
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        color: colorGreen,
                        border: Border.all(color: colorGreen, width: 1),
                        // Border color and width
                        borderRadius: BorderRadius.circular(20), // Rounded corners
                      ),
                      child: const CommonText.medium("Term",
                          size: 13, color: colorWhite)
                          .paddingOnly(top: 5, bottom: 5, left: 30, right: 30),
                    ),
                  ).paddingOnly(left: 20,bottom: 10,top: 10),
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
                      Tab(icon: CommonText.medium(AppTags.exam,
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
