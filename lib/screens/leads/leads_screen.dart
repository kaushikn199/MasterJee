import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:masterjee/constants.dart';
import 'package:masterjee/screens/leads/campaign_list_screen.dart';
import 'package:masterjee/screens/leads/leads_list_screen.dart';
import 'package:masterjee/widgets/app_bar_two.dart';
import 'package:masterjee/widgets/app_tags.dart';
import 'package:masterjee/widgets/text.dart';

class LeadsScreen extends StatefulWidget {
  const LeadsScreen({super.key});

  static String routeName = 'leadsScreen';

  @override
  State<LeadsScreen> createState() => _LeadsScreenState();
}

class _LeadsScreenState extends State<LeadsScreen>
    with WidgetsBindingObserver, SingleTickerProviderStateMixin {
  late TabController tabController;
  bool _isLoading = false;
  List<int> contentData = [];

  @override
  void dispose() {
    tabController.dispose();
    super.dispose();
  }

  void _handleTabChange() {
    tabController.addListener(() {
      switch (tabController.index) {
        case 0:
          getData("pending");
          break;
        case 1:
          getData("submitted");
          break;
        case 2:
          getData("evaluated");
          break;
      }
    });
  }

  void getData(String status) async {
    setState(() {
      _isLoading = true;
    });

    await Future.delayed(Duration(seconds: 2)); // Simulating network delay

    setState(() {
      contentData = List.generate(5, (index) => index + 1); // Sample data
      _isLoading = false;
    });
  }

  @override
  void initState() {
    getData("pending");
    tabController = TabController(length: 3, vsync: this);
    _handleTabChange();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBarTwo(title: AppTags.leads),
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
                      padding: EdgeInsets.symmetric(
                          horizontal: 10.sp, vertical: 5.sp),
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
                          color: Colors.green,
                          borderRadius: BorderRadius.all(Radius.circular(10)),
                        ),
                        labelColor: Colors.white,
                        unselectedLabelColor: Colors.black,
                        indicatorColor: kRedColor,
                        tabs: [
                          Tab(
                            icon: CommonText.medium(
                              AppTags.leads,
                              size: 14.sp,
                              overflow: TextOverflow.fade,
                            ),
                          ),
                          Tab(
                            icon: CommonText.medium(
                              AppTags.campaign,
                              size: 14.sp,
                              overflow: TextOverflow.fade,
                            ),
                          ),
                        ],
                      ),
                    ),
                    /*Expanded(
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
                      )*/
                    Expanded(
                      child: TabBarView(
                        controller: tabController,
                        children: const [
                          LeadsListScreen(),
                          CampaignListScreen(),
                        ],
                      ),
                    ),
                  ]),
                ),

              ],
            );
          }),
        ));
  }
}
