import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:masterjee/constants.dart';
import 'package:masterjee/models/leads/leads_response.dart';
import 'package:masterjee/models/leads/missed_leads_response.dart';
import 'package:masterjee/others/StorageHelper.dart';
import 'package:masterjee/providers/leads_api.dart';
import 'package:masterjee/screens/leads/campaign_leads_screen.dart';
import 'package:masterjee/screens/leads/edit_leads_screen.dart';
import 'package:masterjee/screens/leads/followups_screen.dart';
import 'package:masterjee/screens/leads/missed_screen.dart';
import 'package:masterjee/screens/leads/walk_in_screen.dart';
import 'package:masterjee/widgets/app_bar_two.dart';
import 'package:masterjee/widgets/app_tags.dart';
import 'package:masterjee/widgets/text.dart';
import 'package:provider/provider.dart';

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

  List<Campaign> campaignList = [];
  List<MissedFollowup> missedFollowupList = [];
  List<FollowUpStatus> followUpStatusList = [];
  List<Lead> openLeadsList = [];

  Future<void> callApiLeadsList() async {
    setState(() {
      _isLoading = true;
    });
    try {
      LeadResponse data = await Provider.of<LeadsApi>(context, listen: false)
          .getLeads(StorageHelper.getStringData(StorageHelper.userIdKey));
      if (data.status == "success") {
        setState(() {
          campaignList = data.campaigns;
          missedFollowupList = data.missedFollowups;
          openLeadsList = data.openLeads;
          print("openLeadsList : ${openLeadsList.length}");
          _isLoading = false;
        });
        return;
      } else {
        setState(() {
          _isLoading = false;
        });
      }
    } catch (error) {
      print("callApiLeadsList : $error");
      setState(() {
        _isLoading = false;
      });
    }
  }

  int selectedIndex = 0;

  @override
  void initState() {
    callApiLeadsList();
    tabController = TabController(length: 5, vsync: this);
    tabController.addListener(() {
      if (tabController.indexIsChanging) return; // Prevent duplicate calls
      selectedIndex = tabController.index;
      print("Tab changed to index: $selectedIndex");
      if (selectedIndex == 0 || selectedIndex == 1) {
        callApiLeadsList();
      }
    });
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
                          icon: CommonText.medium(AppTags.campaign,
                              size: 12.sp, overflow: TextOverflow.fade)),
                      Tab(
                          icon: CommonText.medium(AppTags.leads,
                              size: 12.sp, overflow: TextOverflow.fade)),
                      Tab(
                          icon: CommonText.medium("Followups",
                              size: 12.sp, overflow: TextOverflow.fade)),
                      Tab(
                          icon: CommonText.medium(
                        "Walk-in",
                        size: 12.sp,
                        overflow: TextOverflow.fade,
                      )),
                      Tab(
                          icon: CommonText.medium(
                        "Missed",
                        size: 10.sp,
                        overflow: TextOverflow.fade,
                      )),
                    ],
                  ),
                  Expanded(
                    child: TabBarView(
                      controller: tabController,
                      children: [
                        setCampaignList(),
                        setLeadList(),
                        const FollowupsScreen(),
                        const WalkInScreen(),
                        const MissedScreen(),
                      ],
                    ),
                  ),
                ]),
              ],
            );
          }),
        ));
  }

  Widget setCampaignList() {
    if (_isLoading) {
      return SizedBox(
        height: MediaQuery.of(context).size.height * .5,
        child: const Center(
          child: CircularProgressIndicator(),
        ),
      );
    }
    if (campaignList.isEmpty) {
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
    return ListView.builder(
        shrinkWrap: true,
        itemCount: campaignList.length,
        padding: EdgeInsets.only(top: 10.sp),
        itemBuilder: (BuildContext context, int index) {
          return InkWell(
            onTap: () {
              //Navigator.pushNamed(context, EditLeadsScreen.routeName);
              Navigator.pushNamed(context,
                  CampaignLeadsScreen.routeName,
                  arguments:campaignList[index].campaignId);
            },
            child: Container(
              margin:
                  const EdgeInsets.only(top: 7, bottom: 7, left: 20, right: 20),
              decoration: BoxDecoration(
                color: kSecondBackgroundColor,
                borderRadius: BorderRadius.circular(7.r),
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
                  Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Row(
                      children: [
                        const Icon(Icons.spatial_audio_off_outlined),
                        gap(10.0),
                        CommonText.semiBold(campaignList[index].title,
                            size: 12.sp),
                        const Expanded(child: SizedBox()),
                        const Icon(Icons.person_rounded),
                        CommonText.medium(campaignList[index].totalLeads,
                            size: 12.sp),
                        gap(10.0),
                      ],
                    ),
                  )
                ],
              ),
            ),
          );
        });
  }

  Widget setLeadList() {
    if (_isLoading) {
      return SizedBox(
        height: MediaQuery.of(context).size.height * .5,
        child: const Center(
          child: CircularProgressIndicator(),
        ),
      );
    }
    if (missedFollowupList.isEmpty) {
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
    return Container(
      height: double.infinity,
      color: kBackgroundColor,
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 10.sp),
        child: ListView.builder(
            shrinkWrap: true,
            itemCount: missedFollowupList.length,
            padding: EdgeInsets.only(top: 10.sp),
            itemBuilder: (BuildContext context, int index) {
              MissedFollowup data = missedFollowupList[index];
              return leadsCard(data, context);
            }),
      ),
    );
  }

  Widget leadsCard(MissedFollowup data, BuildContext context) {
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
          Padding(
            padding: EdgeInsets.all(10.sp),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(20),
                      child: Image.asset(
                        AssetsUtils.logoIcon,
                        width: 35,
                        height: 35,
                        fit: BoxFit.fill,
                      ),
                    ),
                    CommonText.semiBold(
                      data.name,
                      size: 14.sp,
                      maxLines: 1,
                    ).paddingOnly(left: 5),
                    const Expanded(
                      child: SizedBox(),
                    ),
                    CommonText.regular(
                      data.nextFollowupDate,
                      size: 12.sp,
                      maxLines: 1,
                    ).paddingOnly(left: 5),
                  ],
                ),
                SizedBox(
                  height: 5.h,
                ),
                rowValue(data.campaign ?? "", data.nextFollowupTime),
                Row(
                  children: [
                    Container(
                      margin: const EdgeInsets.only(right: 5),
                      width: 7, // Adjust size
                      height: 7, // Adjust size
                      decoration: const BoxDecoration(
                        color: Colors.red, // Change color
                        shape: BoxShape.circle,
                      ),
                    ),
                    CommonText.regular("${data.daysAgo} days ago",
                        size: 12.sp, color: Colors.black),
                    const Expanded(child: SizedBox()),
                    CommonText.regular(data.followupPriority,
                        size: 12.sp, color: Colors.black),
                    gap(5.w),
                    Container(
                      margin: const EdgeInsets.only(right: 5),
                      width: 10, // Adjust size
                      height: 10, // Adjust size
                      decoration: BoxDecoration(
                        color: data.followupPriority == "Low"
                            ? Colors.red
                            : data.followupPriority == "Medium"
                                ? Colors.yellow
                                : data.followupPriority == "High"
                                    ? Colors.green
                                    : Colors.transparent, // Change color
                        shape: BoxShape.rectangle,
                      ),
                    ),
                  ],
                ),
                Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
                  Expanded(
                      child: CommonText.regular(data.followupRemark,
                          size: 12.sp, color: Colors.black)),
                  CommonText.regular(data.callStatus,
                      size: 12.sp,
                      color: Colors.black,
                      overflow: TextOverflow.fade),
                ])
              ],
            ),
          ),
        ],
      ),
    );
  }

  rowValue(String key, value) {
    return Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
      SizedBox(
          width: 80.sp,
          child: CommonText.regular(key, size: 12.sp, color: Colors.black)),
      const Expanded(child: SizedBox()),
      CommonText.regular(value,
          size: 12.sp, color: Colors.black, overflow: TextOverflow.fade),
    ]);
  }
}
