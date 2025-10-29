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
import 'package:quill_html_editor_v2/quill_html_editor_v2.dart';

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
          .walkinLeads(StorageHelper.getStringData(StorageHelper.userIdKey),
          _fromDateController.text,
          _toDateController.text,
          mobileNumberController.text);
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
  final mobileNumberController = TextEditingController();
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
      return Container(
        height: double.infinity,
        color: kBackgroundColor,
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 10.sp),
          child: Column(
            children: [
              // Row 1: From Date & To Date
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
              ).paddingOnly(left: 10.0, right: 10.0),

              // Row 2: Mobile Number & Submit
              Row(
                children: [
                  Flexible(
                    child: CustomTextField(
                      keyboardType: TextInputType.number,
                      hintText: 'Mobile number',
                      isRequired: true,
                      controller: mobileNumberController,
                      onSave: (value) {
                        mobileNumberController.text = value as String;
                      },
                    ),
                  ),
                  gap(5.0),
                  Flexible(
                    child: CommonButton(
                      paddingHorizontal: 5,
                      cornersRadius: 50,
                      text: AppTags.submit,
                      onPressed: () {
                        callApiWalkinLeads();
                      },
                    ),
                  )
                ],
              ).paddingOnly(left: 5.0, right: 10.0),

              // Row 3: Loader / No Data / List
              Expanded(
                child: _isLoading
                    ? const Center(
                  child: CircularProgressIndicator(),
                )
                    : missedFollowupList.isEmpty
                    ? Center(
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
                )
                    : ListView.builder(
                  shrinkWrap: true,
                  itemCount: missedFollowupList.length,
                  padding: EdgeInsets.only(top: 10.sp),
                  itemBuilder: (BuildContext context, int index) {
                    AllFollowUp data = missedFollowupList[index];
                    return InkWell(
                      onTap: () {
                        Navigator.pushNamed(
                          context,
                          LeadsViewScreen.routeName,
                          arguments: data.lId,
                        );
                      },
                      child: leadsCard(data, context),
                    );
                  },
                ),
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
