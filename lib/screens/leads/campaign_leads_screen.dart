import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get_utils/src/extensions/widget_extensions.dart';
import 'package:masterjee/constants.dart';
import 'package:masterjee/models/leads/campaign_leads_response.dart';
import 'package:masterjee/others/StorageHelper.dart';
import 'package:masterjee/providers/leads_api.dart';
import 'package:masterjee/widgets/app_bar_two.dart';
import 'package:masterjee/widgets/app_tags.dart';
import 'package:masterjee/widgets/text.dart';
import 'package:provider/provider.dart';

class CampaignLeadsScreen extends StatefulWidget {
  const CampaignLeadsScreen({super.key});

  static String routeName = 'campaignLeadsScreen';

  @override
  State<CampaignLeadsScreen> createState() => _CampaignLeadsScreenState();
}

class _CampaignLeadsScreenState extends State<CampaignLeadsScreen> {
  var _isLoading = false;
  List<LeadData> leadList = [];
  late String campaignId;
  bool _isInitialized = false;

  @override
  void didChangeDependencies() {
    if (!_isInitialized) {
      campaignId = ModalRoute.of(context)!.settings.arguments as String;
      callApiCampaignLeads();
      _isInitialized = true;
    }
    super.didChangeDependencies();
  }


  Future<void> callApiCampaignLeads() async {
    setState(() {
      _isLoading = true;
    });
    try {
      CampaignLeadsResponse data =
          await Provider.of<LeadsApi>(context, listen: false).campaignLeads(
              StorageHelper.getStringData(StorageHelper.userIdKey), campaignId);
      if (data.status == "success") {
        setState(() {
          leadList = data.data;
          _isLoading = false;
        });
        return;
      } else {
        setState(() {
          _isLoading = false;
        });
      }
    } catch (error) {
      print("callApiCampaignLeads : $error");
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBarTwo(title: AppTags.attendance),
      body: Builder(builder: (context) {
        if (_isLoading) {
          return SizedBox(
            height: MediaQuery.of(context).size.height * .5,
            child: const Center(
              child: CircularProgressIndicator(),
            ),
          );
        }
        if (leadList.isEmpty) {
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
                itemCount: leadList.length,
                padding: EdgeInsets.only(top: 10.sp),
                itemBuilder: (BuildContext context, int index) {
                  CampaignLead data = leadList[index].leads;
                  FollowUpData? followUpData =
                      parseFollowUpData(data.lFollowUpData);
                  return leadsCard(data, followUpData, context);
                }),
          ),
        );
      }),
    );
  }

  Widget leadsCard(
      CampaignLead data, FollowUpData? followUpData, BuildContext context) {
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
                      data.lName,
                      size: 14.sp,
                      maxLines: 1,
                    ).paddingOnly(left: 5),
                    const Expanded(
                      child: SizedBox(),
                    ),
                    CommonText.regular(
                      followUpData?.nextFollowupDate ?? "",
                      size: 12.sp,
                      maxLines: 1,
                    ).paddingOnly(left: 5),
                  ],
                ),
                SizedBox(
                  height: 5.h,
                ),
                rowValue(data.cTitle, "${followUpData?.nextFollowupTime ?? "00:00"}:00"),
                Row(
                  children: [
                    Container(
                      margin: const EdgeInsets.only(right: 5),
                      width: 7,
                      height: 7,
                      decoration: const BoxDecoration(
                        color: Colors.red,
                        shape: BoxShape.circle,
                      ),
                    ),
                    CommonText.regular(
                        "${getDaysAgo(followUpData?.nextFollowupDate ?? "0")} days ago",
                        size: 12.sp,
                        color: Colors.black),
                    const Expanded(child: SizedBox()),
                    gap(5.w),
                    Container(
                      margin: const EdgeInsets.only(right: 5),
                      width: 10, // Adjust size
                      height: 10, // Adjust size
                      decoration: BoxDecoration(
                        color: data.cStatus == "Low"
                            ? Colors.red
                            : data.cStatus == "Medium"
                                ? Colors.yellow
                                : data.cStatus == "High"
                                    ? Colors.green
                                    : Colors.transparent,
                        shape: BoxShape.rectangle,
                      ),
                    ),
                  ],
                ),
                Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
                  Expanded(
                      child: CommonText.regular(data.cDescription,
                          size: 12.sp, color: Colors.black)),
                  CommonText.regular(followUpData?.callStatus ?? "",
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

  int getDaysAgo(String? dateString) {
    if(dateString != null) {
      try{
        DateTime inputDate = DateTime.parse(dateString);
        DateTime today = DateTime.now();
        DateTime onlyToday = DateTime(today.year, today.month, today.day);
        Duration diff = onlyToday.difference(inputDate);
        return diff.inDays;
      }catch(e){
        return 0;
      }
    }
    return 0;
  }

  FollowUpData? parseFollowUpData(String? followUpString) {
    if (followUpString == null || followUpString.isEmpty) return null;
    try {
      final Map<String, dynamic> jsonMap = jsonDecode(followUpString);
      return FollowUpData.fromJson(jsonMap);
    } catch (e) {
      print("Failed to parse followUpData: $e");
      return null;
    }
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
