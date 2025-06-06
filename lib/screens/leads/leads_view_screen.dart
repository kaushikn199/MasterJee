import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get_utils/src/extensions/widget_extensions.dart';
import 'package:intl/intl.dart';
import 'package:masterjee/constants.dart';
import 'package:masterjee/models/common_functions.dart';
import 'package:masterjee/models/leads/view_leads_reasponse.dart';
import 'package:masterjee/others/StorageHelper.dart';
import 'package:masterjee/providers/leads_api.dart';
import 'package:masterjee/screens/leads/edit_leads_screen.dart';
import 'package:masterjee/widgets/CommonButton.dart';
import 'package:masterjee/widgets/app_bar_two.dart';
import 'package:masterjee/widgets/app_tags.dart';
import 'package:masterjee/widgets/custom_form_field.dart';
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
  String? _selectedLevel;
  int _selectedLevelIndex = 0;
  late List<String> levelList = ["Level 1", "Level 2"];
  String? _selectedCallStatus;
  String? _campainUserStatus;
  int _transferIndexStatus = 0;
  late List<String> callStatusList = [
    "Initiated",
    "Walk-in",
    "Converted",
    "Busy",
    "Switch-off",
    "Wrong-number"
  ];
  final _nextFollowUpDateController = TextEditingController();
  final _remarkController = TextEditingController();
  DateTime? _selectedFromDate;
  late String startTime;
  final _startTimeController = TextEditingController();
  List<CampainUser> campainUserList = [];

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
          campainUserList = data.data?.campainUser ?? [];
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

  Future<void> callApiSaveFollowUp(String cId, String lId, String fr,
      String nfd, String nft, String cs, String level) async {
    setState(() {
      _isLoading = true;
    });
    try {
      ViewLeadsResponse data =
          await Provider.of<LeadsApi>(context, listen: false).saveFollowUp(
              StorageHelper.getStringData(StorageHelper.userIdKey),
              StorageHelper.getStringData(StorageHelper.classIdKey),
              cId,
              lId,
              fr,
              nfd,
              nft,
              cs,
              level);
      if (data.status == "success") {
        setState(() {
          CommonFunctions.showWarningToast(data.message);
          _selectedLevel = null;
          _selectedCallStatus = null;
          _selectedLevelIndex = 0;
          _remarkController.text = "";
          _nextFollowUpDateController.text = "";
          startTime = "";
          _startTimeController.text = "";
          _isLoading = false;
          callApiLeadsView();
        });
        return;
      } else {
        setState(() {
          _isLoading = false;
        });
      }
    } catch (error) {
      print("callApiSaveFollowUp : $error");
      setState(() {
        _isLoading = false;
      });
    }
  }

  Future<void> callApiSaveLeadTransfer(
      String tlid, String tcid, String transferTo, String level) async {
    setState(() {
      _isLoading = true;
    });
    try {
      ViewLeadsResponse data =
          await Provider.of<LeadsApi>(context, listen: false).saveLeadTransfer(
              StorageHelper.getStringData(StorageHelper.userIdKey),
              tlid,
              tcid,
              transferTo,
              level);
      if (data.status == "success") {
        setState(() {
          CommonFunctions.showWarningToast(data.message);
          _campainUserStatus = null;
          _selectedLevel = null;
          _transferIndexStatus = 0;
          _isLoading = false;
          callApiLeadsView();
        });
        return;
      } else {
        setState(() {
          _isLoading = false;
        });
      }
    } catch (error) {
      print("callApiSaveLeadTransfer : $error");
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
                        Navigator.pushNamed(context, EditLeadsScreen.routeName,
                            arguments: viewData?.data);
                      },
                      child: Container(
                        decoration: BoxDecoration(
                            borderRadius:
                                BorderRadius.all(Radius.circular(5.r)),
                            color: kRedColor),
                        child: const Icon(Icons.edit, color: colorWhite)
                            .paddingAll(5),
                      ),
                    )
                  ],
                ),
                gap(15.0),
                Row(
                  children: [
                    Expanded(
                      child: InkWell(
                        onTap: () {
                          showDialog(
                            context: context,
                            builder: (BuildContext context1) =>
                                followUpPopup(context),
                          );
                        },
                        child: Container(
                          decoration: BoxDecoration(
                            color: colorGreen,
                            border: Border.all(color: colorGreen, width: 1),
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: const CommonText.medium(AppTags.followUp,
                                  textAlign: TextAlign.center,
                                  size: 13,
                                  color: colorWhite)
                              .paddingOnly(
                                  top: 5, bottom: 5, left: 20, right: 20),
                        ),
                      ),
                    ),
                    gap(10.0.w),
                    Expanded(
                      child: InkWell(
                        onTap: () {
                          showDialog(
                            context: context,
                            builder: (BuildContext context1) =>
                                transferThisLeadPopup(context),
                          );
                        },
                        child: Container(
                          decoration: BoxDecoration(
                            color: colorGreen,
                            border: Border.all(color: colorGreen, width: 1),
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: const CommonText.medium(
                                  AppTags.transferThisLead,
                                  textAlign: TextAlign.center,
                                  size: 13,
                                  color: colorWhite)
                              .paddingOnly(
                                  top: 5, bottom: 5, left: 20, right: 20),
                        ),
                      ),
                    ),
                  ],
                ),
                gap(15.0),
                CommonText.semiBold(AppTags.followUpHistory,
                    size: 14.sp,
                    color: kDarkGreyColor,
                    overflow: TextOverflow.fade),
                gap(10.0),
                Expanded(
                  child: ListView.builder(
                      shrinkWrap: true,
                      itemCount: viewData?.data?.followUpData.length,
                      itemBuilder: (BuildContext context, int index) {
                        FollowUpData? data =
                            viewData?.data?.followUpData[index];
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

  Future<void> _selectFromDate(BuildContext context) async {
    final DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: _selectedFromDate ?? DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
    );
    if (pickedDate != null && pickedDate != _selectedFromDate) {
      setState(() {
        _selectedFromDate = pickedDate;
        _nextFollowUpDateController.text = pickedDate.toLocalDMYDateString();
      });
    }
  }

  Future<void> _selectStartTime(BuildContext context) async {
    final TimeOfDay? pickedTime = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    );
    if (pickedTime != null) {
      final now = DateTime.now();
      final selectedTime = DateTime(
        now.year,
        now.month,
        now.day,
        pickedTime.hour,
        pickedTime.minute,
      );
      final formattedTime = DateFormat('HH:mm').format(selectedTime);
      setState(() {
        startTime = formattedTime;
        _startTimeController.text = pickedTime.format(context);
        print("_fromStartTimeController : $formattedTime");
      });
    }
  }

  Widget followUpPopup(BuildContext context) {
    var widthSize = MediaQuery.of(context).size.width;
    return AlertDialog(
      backgroundColor: kSecondBackgroundColor,
      surfaceTintColor: kSecondBackgroundColor,
      insetPadding: const EdgeInsets.only(left: 10, right: 10),
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(10))),
      content: StatefulBuilder(
        builder: (context, setState) {
          return SizedBox(
            width: widthSize,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                const Text(
                  AppTags.followUp,
                  style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                      color: Colors.blue),
                ),
                gap(10.0),
                Card(
                  elevation: 0.1,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  color: colorWhite,
                  child: Padding(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
                    child: DropdownButton(
                      hint: const CommonText('Select level',
                          size: 14, color: Colors.black54),
                      value: _selectedLevel,
                      icon: const Card(
                        elevation: 0.1,
                        color: colorWhite,
                        child: Icon(Icons.keyboard_arrow_down_outlined),
                      ),
                      underline: const SizedBox(),
                      onChanged: (value) {
                        setState(() {
                          _selectedLevel = null;
                          _selectedLevel = value.toString();
                          for (int i = 0; i < levelList.length; i++) {
                            if (levelList[i].toString().toLowerCase() ==
                                value.toString().toLowerCase()) {
                              _selectedLevel = levelList[i];
                              _selectedLevelIndex = i + 1;
                              break;
                            }
                          }
                        });
                      },
                      isExpanded: true,
                      items: levelList.map((cd) {
                        return DropdownMenuItem(
                          value: cd,
                          onTap: () {
                            setState(() {
                              _selectedLevel = cd;
                            });
                          },
                          child: Text(
                            cd,
                            style: const TextStyle(
                              color: colorBlack,
                              fontSize: 14,
                            ),
                          ),
                        );
                      }).toList(),
                    ),
                  ),
                ),
                gap(5.0),
                Card(
                  elevation: 0.1,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  color: colorWhite,
                  child: Padding(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
                    child: DropdownButton(
                      hint: const CommonText('Select call status',
                          size: 14, color: Colors.black54),
                      value: _selectedCallStatus,
                      icon: const Card(
                        elevation: 0.1,
                        color: colorWhite,
                        child: Icon(Icons.keyboard_arrow_down_outlined),
                      ),
                      underline: const SizedBox(),
                      onChanged: (value) {
                        setState(() {
                          _selectedCallStatus = null;
                          _selectedCallStatus = value.toString();
                          for (int i = 0; i < callStatusList.length; i++) {
                            if (levelList[i].toString().toLowerCase() ==
                                value.toString().toLowerCase()) {
                              _selectedCallStatus = callStatusList[i];
                              break;
                            }
                          }
                        });
                      },
                      isExpanded: true,
                      items: callStatusList.map((cd) {
                        return DropdownMenuItem(
                          value: cd,
                          onTap: () {
                            setState(() {
                              _selectedCallStatus = cd;
                            });
                          },
                          child: Text(
                            cd,
                            style: const TextStyle(
                              color: colorBlack,
                              fontSize: 14,
                            ),
                          ),
                        );
                      }).toList(),
                    ),
                  ),
                ),
                gap(5.0),
                CustomTextField(
                  borderRadius: 10,
                  hintText: 'Enter remark',
                  controller: _remarkController,
                  onSave: (value) {
                    _remarkController.text = value as String;
                  },
                ).marginOnly(left: 3, right: 3),
                gap(5.0),
                CustomTextField(
                  borderRadius: 10,
                  onTap: () {
                    _selectFromDate(context);
                  },
                  hintText: 'Next Follow-Up Date',
                  isRequired: true,
                  prefixIcon: const Icon(
                    Icons.date_range_outlined,
                    color: kTextLowBlackColor,
                  ),
                  validate: (value) {
                    if (value!.isEmpty) {
                      return 'From Date cannot be empty';
                    }
                    return null;
                  },
                  isReadonly: true,
                  controller: _nextFollowUpDateController,
                  onSave: (value) {
                    _nextFollowUpDateController.text = value as String;
                  },
                ),
                gap(5.0),
                CustomTextField(
                  borderRadius: 10.0,
                  onTap: () {
                    _selectStartTime(context);
                  },
                  hintText: 'Next follow-up Time',
                  isRequired: true,
                  prefixIcon: const Icon(
                    Icons.date_range_outlined,
                    color: kTextLowBlackColor,
                  ),
                  validate: (value) {
                    if (value!.isEmpty) {
                      return 'Date cannot be empty';
                    }
                    return null;
                  },
                  isReadonly: true,
                  controller: _startTimeController,
                  onSave: (value) {
                    _startTimeController.text = value as String;
                  },
                ),
                gap(20.0),
                SizedBox(
                  width: double.infinity,
                  child: _isLoading
                      ? const Center(child: CircularProgressIndicator())
                      : CommonButton(
                          cornersRadius: 30,
                          text: AppTags.save,
                          onPressed: () {
                            if (_selectedLevel == null) {
                              CommonFunctions.showWarningToast(
                                  "Please select level");
                            } else if (_selectedCallStatus == null) {
                              CommonFunctions.showWarningToast(
                                  "Please select call status");
                            } else if (_remarkController.text == "") {
                              CommonFunctions.showWarningToast(
                                  "Please enter remarks");
                            } else if (_nextFollowUpDateController.text == "") {
                              CommonFunctions.showWarningToast(
                                  "Please select follow up date");
                            } else if (startTime == "") {
                              CommonFunctions.showWarningToast(
                                  "Please select next follow up time");
                            } else {
                              print("cId ${viewData!.data!.cId} ");
                              print("lId ${viewData!.data!.lId} ");
                              print("fr ${_remarkController.text} ");
                              print("nfd ${_nextFollowUpDateController.text} ");
                              print("nft $startTime ");
                              print("cs ${_selectedCallStatus!} ");
                              print("level ${_selectedLevelIndex} ");
                              callApiSaveFollowUp(
                                  viewData!.data!.cId,
                                  viewData!.data!.lId,
                                  _remarkController.text,
                                  _nextFollowUpDateController.text,
                                  startTime,
                                  _selectedCallStatus!,
                                  _selectedLevelIndex.toString());
                            }
                            Navigator.of(context).pop();
                          },
                        ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget transferThisLeadPopup(BuildContext context) {
    var widthSize = MediaQuery.of(context).size.width;
    return AlertDialog(
      backgroundColor: kSecondBackgroundColor,
      surfaceTintColor: kSecondBackgroundColor,
      insetPadding: const EdgeInsets.only(left: 10, right: 10),
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(10))),
      content: StatefulBuilder(
        builder: (context, setState) {
          return SizedBox(
            width: widthSize,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                const Text(
                  AppTags.transferThisLead,
                  style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                      color: Colors.blue),
                ),
                gap(10.0),
                Card(
                  elevation: 0.1,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  color: colorWhite,
                  child: Padding(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
                    child: DropdownButton(
                      hint: const CommonText('Transfer this lead',
                          size: 14, color: Colors.black54),
                      value: _campainUserStatus,
                      icon: const Card(
                        elevation: 0.1,
                        color: colorWhite,
                        child: Icon(Icons.keyboard_arrow_down_outlined),
                      ),
                      underline: const SizedBox(),
                      onChanged: (value) {
                        setState(() {
                          _campainUserStatus = null;
                          _campainUserStatus = value.toString();
                          for (int i = 0; i < campainUserList.length; i++) {
                            if (campainUserList[i].name.toString().toLowerCase() ==
                                value.toString().toLowerCase()) {
                              _transferIndexStatus = i;
                              break;
                            }
                          }
                        });
                      },
                      isExpanded: true,
                      items: campainUserList.map((cd) {
                        return DropdownMenuItem(
                          value: cd.name,
                          onTap: () {
                            setState(() {
                              _campainUserStatus = cd.name;
                            });
                          },
                          child: Text(
                            cd.name,
                            style: const TextStyle(
                              color: colorBlack,
                              fontSize: 14,
                            ),
                          ),
                        );
                      }).toList(),
                    ),
                  ),
                ),
                gap(5.0),
                Card(
                  elevation: 0.1,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  color: colorWhite,
                  child: Padding(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
                    child: DropdownButton(
                      hint: const CommonText('Select level',
                          size: 14, color: Colors.black54),
                      value: _selectedLevel,
                      icon: const Card(
                        elevation: 0.1,
                        color: colorWhite,
                        child: Icon(Icons.keyboard_arrow_down_outlined),
                      ),
                      underline: const SizedBox(),
                      onChanged: (value) {
                        setState(() {
                          _selectedLevel = null;
                          _selectedLevel = value.toString();
                          for (int i = 0; i < levelList.length; i++) {
                            if (levelList[i].toString().toLowerCase() ==
                                value.toString().toLowerCase()) {
                              _selectedLevel = levelList[i];
                              _selectedLevelIndex = i + 1;
                              break;
                            }
                          }
                        });
                      },
                      isExpanded: true,
                      items: levelList.map((cd) {
                        return DropdownMenuItem(
                          value: cd,
                          onTap: () {
                            setState(() {
                              _selectedLevel = cd;
                            });
                          },
                          child: Text(
                            cd,
                            style: const TextStyle(
                              color: colorBlack,
                              fontSize: 14,
                            ),
                          ),
                        );
                      }).toList(),
                    ),
                  ),
                ),
                gap(20.0),
                CommonButton(
                  cornersRadius: 30,
                  text: AppTags.transfer,
                  onPressed: () {
                    if (_campainUserStatus == null) {
                      CommonFunctions.showWarningToast(
                          "Please select Transfer this lead");
                    } else if (_selectedLevel == null) {
                      CommonFunctions.showWarningToast("Please select level");
                    } else {
                      print("tlid ${campainUserList[_transferIndexStatus].id} ");
                      print("tcid ${campainUserList[_transferIndexStatus].cId} ");
                      print("transferTo ${campainUserList[_transferIndexStatus].staffId} ");
                      print("level ${_selectedLevelIndex} ");
                      callApiSaveLeadTransfer(
                         campainUserList[_transferIndexStatus].id,
                          campainUserList[_transferIndexStatus].cId,
                          campainUserList[_transferIndexStatus].staffId,
                          _selectedLevelIndex.toString());
                      Navigator.of(context).pop();
                    }
                  },
                )
              ],
            ),
          );
        },
      ),
    );
  }
}
