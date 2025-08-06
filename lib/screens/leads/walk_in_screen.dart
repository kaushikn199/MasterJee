import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get_utils/src/extensions/widget_extensions.dart';
import 'package:masterjee/constants.dart';
import 'package:masterjee/models/class_section/class_section_response.dart';
import 'package:masterjee/models/leads/missed_leads_response.dart';
import 'package:masterjee/others/StorageHelper.dart';
import 'package:masterjee/providers/leads_api.dart';
import 'package:masterjee/screens/leads/leads_view_screen.dart';
import 'package:masterjee/widgets/CommonButton.dart';
import 'package:masterjee/widgets/app_tags.dart';
import 'package:masterjee/widgets/custom_form_field.dart';
import 'package:masterjee/widgets/text.dart';
import 'package:provider/provider.dart';

class WalkInScreen extends StatefulWidget {
  const WalkInScreen({super.key});

  static String routeName = 'walkInScreen';

  @override
  State<WalkInScreen> createState() => _WalkInScreenState();
}

class _WalkInScreenState extends State<WalkInScreen> {

  var _isLoading = false;
  List<FollowUpStatus> followUpStatusList = [];
  List<AllFollowUp> missedFollowupList = [];

  @override
  void initState() {
    callApiWalkinLeads();
    super.initState();
  }

  Future<void> callApiWalkinLeads() async {
    setState(() {
      _isLoading = true;
    });
    try {
      MissedLeadsResponse data = await Provider.of<LeadsApi>(context, listen: false)
          .walkinLeads(StorageHelper.getStringData(StorageHelper.userIdKey));
      if (data.status == "success") {
        setState(() {
          followUpStatusList = data.data.followUpStatus;
          missedFollowupList = data.data.allFollowUp;
          _isLoading = false;
        });
        return;
      } else {
        setState(() {
          _isLoading = false;
        });
      }
    } catch (error) {
      print("callApiWalkinLeads : $error");
      setState(() {
        _isLoading = false;
      });
    }
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
        _fromDateController.text = pickedDate.toLocalDMYDateString();
        _selectedToDate = null;
        _toDateController.text = "";
      });
    }
  }
  DateTime? _selectedFromDate;
  final _fromDateController = TextEditingController();

  DateTime? _selectedToDate;
  final _toDateController = TextEditingController();
  Future<void> _selectToDate(BuildContext context) async {
    final DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: _selectedToDate ?? DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
    );
    if (pickedDate != null && pickedDate != _selectedToDate) {
      setState(() {
        _selectedToDate = pickedDate;
        _toDateController.text = pickedDate.toLocalDMYDateString();
      });
    }
  }

  String? _selectedClass;
  late List<ClassData> loadedClassList = [];
  String? _selectedSection;

  @override
  Widget build(BuildContext context) {
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
        child: Column(
          children: [
            Row(
              children: [
                Flexible(
                  child: CustomTextField(
                    onTap: () {
                      _selectFromDate(context);
                    },
                    hintText: 'From date',
                    isRequired: true,
                    prefixIcon: const Icon(
                      Icons.date_range_outlined,
                      color: kTextLowBlackColor,
                    ),
                    isReadonly: true,
                    controller: _fromDateController,
                    onSave: (value) {
                      _fromDateController.text = value as String;
                    },
                  ),
                ),
                gap(10.0),
                Flexible(
                  child: CustomTextField(
                    onTap: () {
                      _selectToDate(context);
                    },
                    hintText: 'To date',
                    isRequired: true,
                    prefixIcon: const Icon(
                      Icons.date_range_outlined,
                      color: kTextLowBlackColor,
                    ),
                    isReadonly: true,
                    controller: _toDateController,
                    onSave: (value) {
                      _toDateController.text = value as String;
                    },
                  ),
                ),
              ],
            ).paddingOnly(left: 10.0,right: 10.0),
            Row(
              children: [
                Flexible(
                    child: Card(
                      elevation: 0.1,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(50),
                      ),
                      color: colorWhite,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 10, vertical: 2),
                        child: DropdownButton(
                          hint: const CommonText('Select class',
                              size: 14, color: Colors.black54),
                          value: _selectedClass,
                          icon: const Card(
                            elevation: 0.1,
                            color: colorWhite,
                            child: Icon(Icons.keyboard_arrow_down_outlined),
                          ),
                          underline: const SizedBox(),
                          onChanged: (value) {},
                          isExpanded: true,
                          items: loadedClassList.map((cd) {
                            return DropdownMenuItem(
                              value: cd.className,
                              onTap: () {
                                setState(() {
                                  _selectedClass = null;
                                  _selectedClass = cd.className.toString();
                                  for (int i = 0;
                                  i < loadedClassList.length;
                                  i++) {
                                    if (loadedClassList[i]
                                        .className
                                        .toString()
                                        .toLowerCase() ==
                                        cd.className
                                            .toString()
                                            .toLowerCase()) {
                                      //_classId = loadedClassList[i].classId;
                                      // classData = loadedClassList[i];
                                      _selectedSection = null;
                                      break;
                                    }
                                  }
                                });
                              },
                              child: Text(
                                cd.className,
                                style: const TextStyle(
                                  color: colorBlack,
                                  fontSize: 14,
                                ),
                              ),
                            );
                          }).toList(),
                        ),
                      ),
                    )
                ),
                gap(5.0),
                Flexible(child: CommonButton(
                  paddingHorizontal: 5,
                  cornersRadius: 50,
                  text: AppTags.submit,
                  onPressed: () {
                  },
                ))
              ],
            ).paddingOnly(left: 5.0,right: 10.0),
            Expanded(
              child: ListView.builder(
                  shrinkWrap: true,
                  itemCount: missedFollowupList.length,
                  padding: EdgeInsets.only(top: 10.sp),
                  itemBuilder: (BuildContext context, int index) {
                    AllFollowUp data = missedFollowupList[index];
                    return InkWell(
                      onTap: () {
                        Navigator.pushNamed(context,
                            LeadsViewScreen.routeName,
                            arguments:data.lId);
                      },
                        child: leadsCard(data, context));
                  }),
            ),
          ],
        ),
      ),
    );
  }

  Widget leadsCard(AllFollowUp data, BuildContext context) {
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
                      data.nextFollowupDate,
                      size: 12.sp,
                      maxLines: 1,
                    ).paddingOnly(left: 5),
                  ],
                ),
                SizedBox(
                  height: 5.h,
                ),
                rowValue(data.cTitle ?? "",data.nextFollowupTime),
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
                    // CommonText.regular("${data.daysAgo} days ago", size: 12.sp, color: Colors.black),
                    const Expanded(child: SizedBox()),
                    CommonText.regular(data.followupPriority, size: 12.sp, color: Colors.black),
                    gap(5.w),
                    Container(
                      margin:  const EdgeInsets.only(right: 5),
                      width: 10, // Adjust size
                      height: 10, // Adjust size
                      decoration:  BoxDecoration(
                        color: data.followupPriority == "Low" ? Colors.red : data.followupPriority == "Medium" ? Colors.yellow : data.followupPriority == "High" ? Colors.green : Colors.transparent, // Change color
                        shape: BoxShape.rectangle,
                      ),
                    ),
                  ],
                ),
                Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
                  Expanded(child: CommonText.regular(data.followupRemark, size: 12.sp, color: Colors.black)),
                  CommonText.regular(data.callStatus,
                      size: 12.sp, color: Colors.black, overflow: TextOverflow.fade),
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
