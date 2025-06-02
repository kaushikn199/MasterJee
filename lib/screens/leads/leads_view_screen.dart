import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get_utils/src/extensions/widget_extensions.dart';
import 'package:masterjee/constants.dart';
import 'package:masterjee/models/leads/view_leads_reasponse.dart';
import 'package:masterjee/others/ApiHelper.dart';
import 'package:masterjee/others/StorageHelper.dart';
import 'package:masterjee/providers/leads_api.dart';
import 'package:masterjee/screens/leads/edit_leads_screen.dart';
import 'package:masterjee/widgets/app_bar_two.dart';
import 'package:masterjee/widgets/app_tags.dart';
import 'package:masterjee/widgets/text.dart';
import 'package:provider/provider.dart';

class LeadsViewScreen extends StatefulWidget {
  const LeadsViewScreen({super.key});

  static String routeName = 'leadsViewScreen';

  @override
  State<LeadsViewScreen> createState() => _LeadsViewScreenState();
}

class _LeadsViewScreenState extends State<LeadsViewScreen> {
  bool _isLoading = false;
  bool _isInitialized = false;
  late String leadId;
  ViewLeadsResponse? viewData;

  @override
  void didChangeDependencies() {
    if (!_isInitialized) {
      leadId = ModalRoute.of(context)!.settings.arguments as String;
      callApiLeadsView();
      _isInitialized = true;
    }
    super.didChangeDependencies();
  }

  Future<void> callApiLeadsView() async {
    setState(() {
      _isLoading = true;
    });
    try {
      ViewLeadsResponse data =
          await Provider.of<LeadsApi>(context, listen: false).leadsView(
              StorageHelper.getStringData(StorageHelper.userIdKey), leadId);
      if (data.status == "success") {
        setState(() {
          viewData = data;
          _isLoading = false;
        });
        return;
      } else {
        setState(() {
          _isLoading = false;
        });
      }
    } catch (error) {
      print("callApiMissedLeads : $error");
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBarTwo(title: AppTags.leads),
        body: Container(
          height: double.infinity,
          color: kBackgroundColor,
          child: Builder(builder: (context) {
            if (_isLoading) {
              return SizedBox(
                height: MediaQuery.of(context).size.height * .5,
                child: const Center(
                  child: CircularProgressIndicator(),
                ),
              );
            }
            if (viewData == null) {
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
            return Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Expanded(
                      child: CommonText.semiBold(viewData?.data?.lName ?? "",
                          size: 14.sp,
                          color: colorBlack,
                          overflow: TextOverflow.fade),
                    ),
                    CommonText.medium(
                        "P : ${viewData?.data?.lPhoneNumber ?? ""}",
                        size: 14.sp,
                        color: kDarkGreyColor,
                        overflow: TextOverflow.fade)
                  ],
                ),
                gap(5.0),
                rowValue(viewData?.data?.lFatherName ?? "",
                    "A : ${viewData?.data?.currentAgent ?? ""}"),
                gap(5.0),
                rowValue(viewData?.data?.lAddress ?? "", ""),
                gap(5.0),
                rowValue(viewData?.data?.lEmail ?? "", ""),
                gap(10.0),
                Row(
                  children: [
                    InkWell(
                      onTap: () {
                        launchPhoneDialer(viewData?.data?.lPhoneNumber);
                      },
                      child: Container(
                        decoration: BoxDecoration(
                            borderRadius:
                                BorderRadius.all(Radius.circular(5.r)),
                            color: kRedColor),
                        child: const Icon(Icons.call, color: colorWhite)
                            .paddingAll(5),
                      ),
                    ),
                    gap(10.w),
                    InkWell(
                      onTap: () {
                        openWhatsApp(viewData?.data?.lPhoneNumber ?? "");
                      },
                      child: Container(
                        decoration: BoxDecoration(
                            borderRadius:
                                BorderRadius.all(Radius.circular(5.r)),
                            color: colorGreen),
                        child: const Icon(Icons.call, color: colorWhite)
                            .paddingAll(5),
                      ),
                    ),
                    gap(10.w),
                    InkWell(
                      onTap: () {
                        openEmailApp(viewData?.data?.lEmail ?? "");
                      },
                      child: Container(
                        decoration: BoxDecoration(
                            borderRadius:
                                BorderRadius.all(Radius.circular(5.r)),
                            color: kYellowColor),
                        child: const Icon(Icons.email, color: colorWhite)
                            .paddingAll(5),
                      ),
                    ),
                    const Expanded(child: SizedBox()),
                    InkWell(
                      onTap: () {
                        Navigator.pushNamed(context, EditLeadsScreen.routeName ,arguments: viewData?.data);
                      },
                      child: Container(
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.all(Radius.circular(5.r)),
                            color: kRedColor),
                        child: const Icon(Icons.edit, color: colorWhite)
                            .paddingAll(5),
                      ),
                    )
                  ],
                ),
                gap(15.0),
                CommonText.semiBold(ApiHelper.followUpHistory,
                    size: 14.sp,
                    color: kDarkGreyColor,
                    overflow: TextOverflow.fade),
                gap(10.0),
                Expanded(
                  child: ListView.builder(
                      shrinkWrap: true,
                      itemCount: viewData?.data?.followUpData?.length,
                      itemBuilder: (BuildContext context, int index) {
                        FollowUpData? data =
                            viewData?.data!.followUpData?[index];
                        return contentCard(data, context);
                      }),
                )
              ],
            ).paddingOnly(left: 15, right: 15, top: 20, bottom: 10);
          }),
        ));
  }

  Widget contentCard(FollowUpData? data, BuildContext context) {
    return Container(
      margin: EdgeInsets.only(right: 1.sp, left: 1, top: 7.sp, bottom: 7.sp),
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
          CommonText.medium(
              "Next follow-up : ${formatFollowUpDate(data?.nextFollowupDate ?? "", data?.nextFollowupTime ?? "")}",
              size: 12.sp,
              color: kDarkGreyColor,
              overflow: TextOverflow.fade),
          CommonText.medium(
              "Feedback date : ${formatFollowUpDate(data?.followupDate ?? "", data?.followupTime ?? "")}",
              size: 12.sp,
              color: kDarkGreyColor,
              overflow: TextOverflow.fade),
          CommonText.medium(data?.followupRemark ?? "",
              size: 12.sp, color: kDarkGreyColor, overflow: TextOverflow.fade),
        ],
      ).paddingOnly(left: 10, right: 10, top: 10, bottom: 10),
    );
  }

  rowValue(String value1, value2) {
    return Row(
      children: [
        Expanded(
          child: CommonText.medium(value1,
              size: 14.sp, color: kDarkGreyColor, overflow: TextOverflow.fade),
        ),
        CommonText.medium(value2,
            size: 14.sp, color: kDarkGreyColor, overflow: TextOverflow.fade)
      ],
    );
  }
}
