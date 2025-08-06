import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:masterjee/constants.dart';
import 'package:masterjee/models/common_functions.dart';
import 'package:masterjee/models/leads/campaign_response.dart';
import 'package:masterjee/models/leads/leads_response.dart';
import 'package:masterjee/models/leads/missed_leads_response.dart';
import 'package:masterjee/others/StorageHelper.dart';
import 'package:masterjee/providers/leads_api.dart';
import 'package:masterjee/screens/leads/add_campaign_screen.dart';
import 'package:masterjee/screens/leads/add_lead_screen.dart';
import 'package:masterjee/screens/leads/all_screen.dart';
import 'package:masterjee/screens/leads/campaign_leads_screen.dart';
import 'package:masterjee/screens/leads/followups_screen.dart';
import 'package:masterjee/screens/leads/leads_view_screen.dart';
import 'package:masterjee/screens/leads/missed_screen.dart';
import 'package:masterjee/screens/leads/walk_in_screen.dart';
import 'package:masterjee/widgets/CommonButton.dart';
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

  List<CampaignModel> campaignList = [];
  List<MissedFollowup> missedFollowupList = [];
  List<FollowUpStatus> followUpStatusList = [];
  List<Lead> openLeadsList = [];

  Future<void> callApiTakeLead(String lId) async {
    setState(() {
      _isLoading = true;
    });
    try {
      LeadResponse data = await Provider.of<LeadsApi>(context, listen: false)
          .takeLead(StorageHelper.getStringData(StorageHelper.userIdKey), lId);
      if (data.status == "success") {
        setState(() {
          print("openLeadsList : ${openLeadsList.length}");
          _isLoading = false;
          CommonFunctions.showWarningToast(data.message);
          callApiLeadsList();
        });
        return;
      } else {
        setState(() {
          CommonFunctions.showWarningToast(data.message);
          _isLoading = false;
        });
      }
    } catch (error) {
      print("callApiLeadsList : $error");
      setState(() {
        CommonFunctions.showWarningToast(error.toString());
        _isLoading = false;
      });
    }
  }

  Future<void> callApiLeadsList() async {
    setState(() {
      _isLoading = true;
    });
    try {
      LeadResponse data = await Provider.of<LeadsApi>(context, listen: false)
          .getLeads(StorageHelper.getStringData(StorageHelper.userIdKey));
      if (data.status == "success") {
        setState(() {
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

  Future<void> callApiCampaign() async {
    setState(() {
      _isLoading = true;
    });
    try {
      CampaignResponse data =
          await Provider.of<LeadsApi>(context, listen: false)
              .campaign(StorageHelper.getStringData(StorageHelper.userIdKey));
      if (data.status == "success") {
        setState(() {
          campaignList = data.data;
          print("callApiCampaign : ${campaignList.length}");
          _isLoading = false;
        });
        return;
      } else {
        setState(() {
          _isLoading = false;
        });
      }
    } catch (error) {
      print("callApiCampaign : $error");
      setState(() {
        _isLoading = false;
      });
    }
  }

  Future<void> callApiStartCampaign(String newCampId) async {
    setState(() {
      _isLoading = true;
    });
    try {
      CampaignResponse data =
          await Provider.of<LeadsApi>(context, listen: false).startCampaign(
              StorageHelper.getStringData(StorageHelper.userIdKey),
              newCampId,
              "");
      if (data.result) {
        setState(() {
          _isLoading = false;
          tabController.index = 0;
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
      print("callApiStartCampaign : $error");
      setState(() {
        _isLoading = false;
      });
    }
  }

  int selectedIndex = 0;

  @override
  void initState() {
    callApiLeadsList();
    tabController = TabController(length: 6, vsync: this);
    tabController.addListener(() {
      if (tabController.indexIsChanging) return;
      setState(() {
        selectedIndex = tabController.index;
      });
      print("Tab changed to index: $selectedIndex");
      if (selectedIndex == 0) {
        callApiLeadsList();
      } else if (selectedIndex == 1) {
        callApiCampaign();
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        floatingActionButton: (selectedIndex == 1 || selectedIndex == 2)
            ? FloatingActionButton(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(50.sp)),
                backgroundColor: colorGreen,
                onPressed: () {
                  // _showBottomSheet(context, false);
                  print("selectedIndex : ${selectedIndex}");
                  if (selectedIndex == 1) {
                    Navigator.pushNamed(context, AddCampaignScreen.routeName);
                  } else if (selectedIndex == 2) {
                    Navigator.pushNamed(context, AddLeadScreen.routeName);
                  }
                },
                child: const Icon(Icons.add, color: Colors.white, size: 28),
              )
            : null,
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
                          icon: CommonText.medium(AppTags.all,
                              size: 12.sp, overflow: TextOverflow.fade)),
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
                        const AllScreen(),
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
              //Navigator.pushNamed(context, CampaignLeadsScreen.routeName, arguments: campaignList[index].cId);
              callApiStartCampaign(campaignList[index].cId!);
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
                        CommonText.semiBold(campaignList[index].cTitle ?? "",
                            size: 12.sp),
                        const Expanded(child: SizedBox()),
                        const Icon(Icons.person_rounded),
                        CommonText.medium(campaignList[index].cBy ?? "",
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
        child: const Center(child: CircularProgressIndicator()),
      );
    }
    if (openLeadsList.isEmpty && missedFollowupList.isEmpty) {
      return Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.hourglass_empty_outlined, size: 100.sp),
            CommonText.medium(
              'No Record Found',
              size: 16.sp,
              color: kDarkGreyColor,
              overflow: TextOverflow.fade,
            ),
          ],
        ),
      );
    }
    return ListView(
      padding: EdgeInsets.symmetric(horizontal: 10.sp, vertical: 10.sp),
      children: [
        ...openLeadsList.map((lead) => InkWell(
              onTap: () {
                /* Navigator.pushNamed(
              context,
              LeadsViewScreen.routeName,
              arguments: lead.leadId,
            );*/
              },
              child: openLeadsCard(lead, context),
            )),
        ...missedFollowupList.map((missed) => InkWell(
              onTap: () {
                Navigator.pushNamed(
                  context,
                  LeadsViewScreen.routeName,
                  arguments: missed.leadId,
                );
              },
              child: leadsCard(missed, context),
            )),
      ],
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

  Widget openLeadsCard(Lead data, BuildContext context) {
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
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
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
          SizedBox(width: 8), // spacing between image and text
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CommonText.semiBold(
                  data.lName,
                  size: 14.sp,
                  maxLines: 1,
                ).paddingOnly(left: 5),
                Divider(color: colorGaryLine).paddingOnly(left: 5, right: 10),
                CommonText.semiBold(
                  data.lEmail ?? "",
                  size: 14.sp,
                  maxLines: 1,
                ).paddingOnly(left: 5),
              ],
            ),
          ),
          CommonButton(
            paddingVertical: 1,
            text: AppTags.takeLeads,
            onPressed: () {
              callApiTakeLead(data.lId);
            },
          ),
        ],
      ).paddingAll(10.0),
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
