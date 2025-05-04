import 'package:file_picker_pro/file_data.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:masterjee/constants.dart';
import 'package:masterjee/models/homework_list/HomeworkListResponse.dart';
import 'package:masterjee/others/StorageHelper.dart';
import 'package:masterjee/providers/homework_api.dart';
import 'package:masterjee/screens/homework/submitted_homework_info.dart';
import 'package:masterjee/widgets/app_bar_two.dart';
import 'package:masterjee/widgets/text.dart';
import 'package:provider/provider.dart';

class HomeworkScreen extends StatefulWidget {
  const HomeworkScreen({super.key});

  static String routeName = 'homeworkScreen';

  @override
  State<HomeworkScreen> createState() => _HomeworkScreenState();
}

class _HomeworkScreenState extends State<HomeworkScreen>
    with WidgetsBindingObserver, SingleTickerProviderStateMixin {

  bool _isLoading = false;
  late TabController tabController;
  final formKey = GlobalKey<FormState>();
  late List<HomeworkData> homeworkList = [];

  Future<void> callApiHomeworkList(String type) async {
    setState(() {
      _isLoading = true;
    });
    try {
      HomeworkListResponse data = await Provider.of<HomeworkApi>(context,
              listen: false)
          .getHomeworkList(
              StorageHelper.getStringData(StorageHelper.userIdKey).toString(),
              StorageHelper.getStringData(StorageHelper.classIdKey).toString(),
              StorageHelper.getStringData(StorageHelper.sectionIdKey)
                  .toString(),
              type);
      if (data.result) {
        setState(() {
          homeworkList = data.data;
          _isLoading = false;
        });
        return;
      } else {
        setState(() {
          _isLoading = false;
        });
      }
    } catch (error) {
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  void dispose() {
    tabController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    tabController = TabController(length: 2, vsync: this);
    tabController.addListener(() {
      if (tabController.indexIsChanging == true) {
        if (tabController.index == 0) {
          callApiHomeworkList(HomeworkListType.upcoming.name);
        } else if (tabController.index == 1) {
          callApiHomeworkList(HomeworkListType.closed.name);
        }
      }
    });
    callApiHomeworkList(HomeworkListType.upcoming.name);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarTwo(title: "HomeWork"),
      body: Container(
        color: kBackgroundColor,
        child: Builder(builder: (context) {
          return Stack(
            children: [
              Container(
                padding: EdgeInsets.only(top: 10.sp),
                child: Column(children: [
                  Container(
                    height: 50.sp,
                    margin: const EdgeInsets.symmetric(horizontal: 10),
                    padding:
                        EdgeInsets.symmetric(horizontal: 10.sp, vertical: 5.sp),
                    decoration: const BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(10)),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black12,
                        ),
                        BoxShadow(
                          color: Colors.white,
                          spreadRadius: -2.0,
                          blurRadius: 5.0,
                        ),
                      ],
                    ),
                    child: TabBar(
                      controller: tabController,
                      indicatorSize: TabBarIndicatorSize.tab,
                      dividerColor: Colors.transparent,
                      indicator: const BoxDecoration(
                        color: colorGreen,
                        borderRadius: BorderRadius.all(Radius.circular(10)),
                      ),
                      labelColor: Colors.white,
                      unselectedLabelColor: Colors.black,
                      indicatorColor: colorGreen,
                      tabs: [
                        Tab(
                          icon: CommonText.medium(
                            'Upcoming',
                            size: 14.sp,
                            overflow: TextOverflow.fade,
                          ),
                        ),
                        Tab(
                          icon: CommonText.medium(
                            'Closed',
                            size: 14.sp,
                            overflow: TextOverflow.fade,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    child: TabBarView(
                      controller: tabController,
                      children: [listView(context), listView(context)],
                    ),
                  )
                ]),
              ),
            ],
          );
        }),
      ),
    );
  }

  Widget listView(BuildContext context) {
    if (_isLoading) {
      SizedBox(
        height: MediaQuery.of(context).size.height * .5,
        child: const Center(
          child: CircularProgressIndicator(),
        ),
      );
    }
    if (homeworkList.isEmpty) {
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
          itemCount: homeworkList.length,
          padding: EdgeInsets.only(top: 10.sp),
          itemBuilder: (BuildContext context, int index) {
            return contentCard(index, context);
          }),
    );
  }

  Widget contentCard(int index, BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.pushNamed(context, SubmittedHomeworkInfoScreen.routeName ,arguments: homeworkList[index]);
      },
      child: Container(
        margin: const EdgeInsets.only(bottom: 15),
        padding: EdgeInsets.all(10.sp),
        decoration: BoxDecoration(
          color: kSecondBackgroundColor,
          borderRadius: BorderRadius.circular(10.r),
          boxShadow: const [
            BoxShadow(
              color: Colors.grey,
              spreadRadius: -2.0,
              blurRadius: 5.0,
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            rowValue("Date", homeworkList[index].homeworkDate ?? '-'),
            rowValue("Subject", homeworkList[index].name ?? '-'),
            rowValue("Submitted date ", homeworkList[index].submitDate ?? '-'),
            rowValue(
                "Evaluation date ", homeworkList[index].evaluationDate ?? '-'),
          ],
        ),
      ),
    );
  }

}

rowValue(String key, value) {
  return Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
    SizedBox(
        width: 100.sp,
        child: CommonText.medium(key, size: 12.sp, color: Colors.black)),
    SizedBox(width: 20.w),
    CommonText.medium(value,
        size: 12.sp, color: kDarkGreyColor, overflow: TextOverflow.fade),
  ]);
}
