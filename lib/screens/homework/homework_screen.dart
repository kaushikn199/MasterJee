import 'package:file_picker_pro/file_data.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:masterjee/constants.dart';
import 'package:masterjee/widgets/app_bar_two.dart';
import 'package:masterjee/widgets/text.dart';
import 'package:masterjee/widgets/util.dart';

class HomeworkScreen extends StatefulWidget {
  const HomeworkScreen({super.key});

  static String routeName = 'homeworkScreen';

  @override
  State<HomeworkScreen> createState() => _HomeworkScreenState();
}

class _HomeworkScreenState extends State<HomeworkScreen> with WidgetsBindingObserver, SingleTickerProviderStateMixin {

  bool _isLoading = false;
  List<int> contentData = [1,1,1];
  late TabController tabController;
  FileData imageFile = FileData();
  final formKey = GlobalKey<FormState>();
  final _msgController = TextEditingController();
  bool _isEditLoading = false;

  @override
  void dispose() {
    tabController.dispose();
    super.dispose();
  }


  @override
  void initState() {
    tabController = TabController(length: 3, vsync: this);
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
                            'Pending',
                            size: 14.sp,
                            overflow: TextOverflow.fade,
                          ),
                        ),
                        Tab(
                          icon: CommonText.medium(
                            'Submitted',
                            size: 14.sp,
                            overflow: TextOverflow.fade,
                          ),
                        ),
                        Tab(
                          icon: CommonText.medium(
                            'Evaluated',
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
                      children: [
                        ...List.generate(
                            3,
                                (index) => _isLoading
                                ? SizedBox(
                              height: MediaQuery.of(context).size.height * .5,
                              child: const Center(
                                child: CircularProgressIndicator(),
                              ),
                            )
                                : Builder(builder: (context) {
                              if (_isLoading) {
                                return SizedBox(
                                  height:
                                  MediaQuery.of(context).size.height * .5,
                                  child: const Center(
                                    child: CircularProgressIndicator(),
                                  ),
                                );
                              }
                              if (contentData.isEmpty) {
                                return Center(
                                  child: Column(
                                    crossAxisAlignment:
                                    CrossAxisAlignment.center,
                                    mainAxisAlignment:
                                    MainAxisAlignment.center,
                                    children: [
                                      Icon(Icons.hourglass_empty_outlined,
                                          size: 100.sp),
                                      CommonText.medium('No Record Found',
                                          size: 16.sp,
                                          color: kDarkGreyColor,
                                          overflow: TextOverflow.fade),
                                    ],
                                  ),
                                );
                              }
                              return Padding(
                                padding:
                                EdgeInsets.symmetric(horizontal: 10.sp),
                                child: ListView.builder(
                                    shrinkWrap: true,
                                    itemCount: contentData.length,
                                    padding: EdgeInsets.only(top: 10.sp),
                                    itemBuilder:
                                        (BuildContext context, int index) {
                                      int data = contentData[index];
                                      return contentCard(data, context);
                                    }),
                              );
                            })),
                      ],
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

  Widget contentCard(int data, BuildContext context) {
    return Container(
      margin: EdgeInsets.all(10.sp),
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
        children: [
          Align(
            alignment: Alignment.bottomLeft,
            child: Container(
              width: double.maxFinite,
              padding: EdgeInsets.all(10.sp),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(
                      topRight: Radius.circular(10.r),
                      topLeft: Radius.circular(10.r)),
                  color: kToastTextColor),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Text(
                      "History",
                      style: TextStyle(
                        fontSize: 18.sp,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                    GestureDetector(
                      onTap: () {
                        //_showBottomSheet(context, data.id.toString());
                      },
                      child: Container(
                        padding: EdgeInsets.symmetric(
                            vertical: 4.sp, horizontal: 8.sp),
                        decoration: BoxDecoration(
                            color: kToastTextColor,
                            borderRadius:
                            BorderRadius.all(Radius.circular(4.r)),
                            border: Border.all(color: colorGreen)),
                        child: Row(
                          children: [
                            Icon(
                              Icons.add_box_rounded,
                              size: 20.sp,
                              color: colorGreen,
                            ),
                            SizedBox(width: 8.sp),
                            CommonText.semiBold(
                              "Submit",
                              color: colorGreen,
                              size: 14.sp,
                            ),
                          ],
                        ),
                      ),
                    )
                ],
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.all(10.sp),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    rowValue("HomeWork Date", "12/02/2024"),
                      statusBadge("Submitted", colorGreen),
                  ],
                ),
                gap(5.sp),
                rowValue("Submission Date", "12/02/2024"),
                gap(10.sp),
                rowValue("Max mark", "12"),
                gap(10.sp),
                CommonText.bold("Description",
                    size: 14.sp, color: Colors.black),
                gap(5.sp),
                CommonText.medium("test homework descriptiuon",
                    size: 14.sp,
                    color: kDarkGreyColor,
                    overflow: TextOverflow.fade),
                gap(5.sp),
              ],
            ),
          ),
        ],
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

rowExValue(String key, value) {
  return Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
    SizedBox(
        width: 100.sp,
        child: CommonText.medium(key, size: 12.sp, color: Colors.black)),
    SizedBox(width: 20.w),
    Expanded(
      child: CommonText.medium(value,
          size: 12.sp, color: kDarkGreyColor, overflow: TextOverflow.fade),
    ),
  ]);

}
