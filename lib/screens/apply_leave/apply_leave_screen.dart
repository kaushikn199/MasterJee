import 'package:file_picker_pro/file_data.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:masterjee/constants.dart';
import 'package:masterjee/widgets/CommonButton.dart';
import 'package:masterjee/widgets/app_bar_two.dart';
import 'package:masterjee/widgets/app_tags.dart';
import 'package:masterjee/widgets/custom_form_field.dart';
import 'package:masterjee/widgets/text.dart';
import 'package:masterjee/widgets/util.dart';

class ApplyLeaveScreen extends StatefulWidget {
  const ApplyLeaveScreen({super.key});

  static String routeName = 'applyLeaveScreen';

  @override
  State<ApplyLeaveScreen> createState() => _ApplyLeaveScreenState();
}

class _ApplyLeaveScreenState extends State<ApplyLeaveScreen> {

  bool _isEditLoading = false;
  var _isLoading = false;
  List<int> resultData = [1,1,1,1,1,1,1,1];
  FileData imageFile = FileData();
  DateTime _selectedDate = DateTime.now();
  DateTime? _selectedFromDate;
  DateTime? _selectedToDate;
  final formKey = GlobalKey<FormState>();
  final _reasonController = TextEditingController();
  final _applyDateController = TextEditingController();
  final _fromDateController = TextEditingController();
  final _toDateController = TextEditingController();


  String? _selectedLeaveType;
  String? _selectedLeaveTypeId;

  List<String> leaveTypeData = [
    "self",
    "9 - Pavani",
  ];

  String? _selectedApplyingFor;
  String? _selectedApplyingForId;

  List<String> applyingForData = [
    "Sick leave",
    "Casual leave",
    "Marriage leave",
    "Paid leave",
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarTwo(title: AppTags.applyLeave),
      floatingActionButton: FloatingActionButton(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(50.sp)),
        backgroundColor: colorGreen,
        tooltip: AppTags.applyLeave,
        onPressed: () {
          _showBottomSheet(context, false);
        },
        child: const Icon(Icons.add, color: Colors.white, size: 28),
      ),
      body: Builder(builder: (context) {
        if (_isLoading) {
          return SizedBox(
            height: MediaQuery.of(context).size.height * .5,
            child: const Center(
              child: CircularProgressIndicator(),
            ),
          );
        }
        if (resultData.isEmpty) {
          return Center(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.hourglass_empty_outlined, size: 100.sp),
                CommonText.medium('No Record Found', size: 16.sp, color: kDarkGreyColor, overflow: TextOverflow.fade),
              ],
            ),
          );
        }
        return Stack(
          children: [
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 10.sp),
              child: ListView.builder(
                  shrinkWrap: true,
                  itemCount: resultData.length,
                  padding: EdgeInsets.only(top: 10.sp),
                  itemBuilder: (BuildContext context, int index) {
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
                          Container(
                            width: double.maxFinite,
                            padding: EdgeInsets.symmetric(horizontal: 10.sp, vertical: 10.sp),
                            decoration: BoxDecoration(
                                borderRadius:
                                BorderRadius.only(topRight: Radius.circular(10.r), topLeft: Radius.circular(10.r)),
                                color: kToastTextColor),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  "Apply data",
                                  style: TextStyle(
                                    fontSize: 14.sp,
                                    fontWeight: FontWeight.w700,
                                  ),
                                ),
                                Row(
                                  children: [
                                      Container(
                                        padding: const EdgeInsets.all(0),
                                        margin: const EdgeInsets.all(0),
                                        height: 25.sp,
                                        width: 25.sp,
                                        decoration: BoxDecoration(
                                          color: kDarkGreyColor,
                                          borderRadius: BorderRadius.circular(5.r),
                                        ),
                                        child: IconButton(
                                          color: Colors.white,
                                          iconSize: 12.sp,
                                          icon: const Icon(Icons.download),
                                          onPressed: () {
                                          },
                                        ),
                                      ),
                                    gap(10.sp),
                                      Container(
                                        padding: const EdgeInsets.all(0),
                                        margin: const EdgeInsets.all(0),
                                        height: 25.sp,
                                        width: 25.sp,
                                        decoration: BoxDecoration(
                                          color: kDarkButtonBg,
                                          borderRadius: BorderRadius.circular(5.r),
                                        ),
                                        child: IconButton(
                                          color: Colors.white,
                                          iconSize: 12.sp,
                                          icon: const Icon(Icons.edit),
                                          onPressed: () {
                                            _showBottomSheet(context, true);
                                          },
                                        ),
                                      ),
                                    gap(10.sp),
                                      Container(
                                        padding: const EdgeInsets.all(0),
                                        margin: const EdgeInsets.all(0),
                                        height: 25.sp,
                                        width: 25.sp,
                                        decoration: BoxDecoration(
                                          color: kRedColor,
                                          borderRadius: BorderRadius.circular(5),
                                        ),
                                        child: IconButton(
                                          color: Colors.white,
                                          iconSize: 12.sp,
                                          icon: const Icon(Icons.delete),
                                          onPressed: () {
                                            showDialog(
                                              context: context,
                                              builder: (BuildContext context) => deletePopupDialog(context, "Leave"),
                                            ).then((v) {

                                            });
                                            // print('Clicked on delete icon');
                                          },
                                        ),
                                      ),
                                  ],
                                )
                              ],
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.all(14.sp),
                            child: Column(
                              children: [
                                Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Expanded(
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          rowValue(
                                              "Applying","Self"),
                                          gap(5.sp),
                                          rowValue(
                                              "Leave type","Sick leave"),
                                          gap(5.sp),
                                          rowValue(
                                              "From Date","10/28/2024"),
                                          gap(5.sp),
                                          rowValue(
                                              "To Date","10/28/2024"),
                                        ],
                                      ),
                                    ),
                                    gap(5.sp),
                                    Column(
                                      crossAxisAlignment: CrossAxisAlignment.end,
                                      children: [
                                         Container(
                                            padding: EdgeInsets.symmetric(vertical: 4.sp, horizontal: 8.sp),
                                            decoration: BoxDecoration(
                                                color: colorGreen,
                                                borderRadius: BorderRadius.all(Radius.circular(4.r))),
                                            child: CommonText.semiBold(
                                               "Approved",
                                                color: Colors.white,
                                                size: 12.sp)),
                                      ],
                                    ),
                                  ],
                                ),
                                gap(5.sp),
                                rowValue("Reason", "Not well"),
                              ],
                            ),
                          ),
                        ],
                      ),
                    );
                  }),
            ),
          ],
        );
      }),
    );
  }

  rowValue(String key, value) {
    return Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
      SizedBox(width: 80.sp, child: CommonText.medium(key, size: 14.sp, color: Colors.black)),
      SizedBox(width: 20.w),
      CommonText.medium(value, size: 14.sp, color: kDarkGreyColor, overflow: TextOverflow.fade),
    ]);
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
      });
    }
  }

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

  void _showBottomSheet(BuildContext context, bool isEdit) {
    showModalBottomSheet(
      backgroundColor: kSecondBackgroundColor,
      context: context,
      isScrollControlled: true,
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(
            top: Radius.circular(12.r),
            bottom: Radius.circular(12.r),
          )),
      builder: (BuildContext context) {
        return SingleChildScrollView(
          child: StatefulBuilder(builder: (context, setState) {
            return Padding(
              padding: EdgeInsets.only(
                bottom: MediaQuery.of(context).viewInsets.bottom,
              ),
              child: Container(
                padding: const EdgeInsets.all(16.0),
                child: Form(
                  key: formKey,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                        CommonText.bold("Add Leave",size:18.sp ),
                          GestureDetector(onTap: () {
                                Navigator.pop(context);
                              },
                              child: const Icon(Icons.close, color: Colors.black, size: 24))
                        ],
                      ),
                      gap(10.sp),
                      Card(
                        elevation: 0.1,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20.sp),
                        ),
                        color: colorWhite,
                        child: Padding(
                          padding:
                          const EdgeInsets.symmetric(horizontal: 10, vertical: 2),
                          child: DropdownButton(
                            hint: const CommonText('Applying for',
                                size: 14, color: Colors.black54),
                            value: _selectedLeaveType,
                            icon: const Card(
                              elevation: 0.1,
                              color: colorWhite,
                              child: Icon(Icons.keyboard_arrow_down_outlined),
                            ),
                            underline: const SizedBox(),
                            onChanged: (value) {
                              setState(() {
                                _selectedLeaveType = null;
                                _selectedLeaveType = value.toString();
                                for (int i = 0; i < leaveTypeData.length; i++) {
                                  if (leaveTypeData[i].toString().toLowerCase() ==
                                      value.toString().toLowerCase()) {
                                    _selectedLeaveTypeId = leaveTypeData[i].toString();
                                    break;
                                  }
                                }
                              });
                            },
                            isExpanded: true,
                            items: leaveTypeData.map((cd) {
                              return DropdownMenuItem(
                                value: cd,
                                onTap: () {
                                  setState(() {
                                    _selectedLeaveType = cd;
                                    for (int i = 0; i < leaveTypeData.length; i++) {
                                      if (leaveTypeData[i].toString().toLowerCase() ==
                                          cd.toString().toLowerCase()) {
                                        _selectedLeaveTypeId = leaveTypeData[i].toString();
                                        break;
                                      }
                                    }
                                  });
                                },
                                child: Text(
                                  cd.toString(),
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
                      gap(10.sp),
                      Card(
                        elevation: 0.1,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20.sp),
                        ),
                        color: colorWhite,
                        child: Padding(
                          padding:
                          const EdgeInsets.symmetric(horizontal: 10, vertical: 2),
                          child: DropdownButton(
                            hint: const CommonText('Select leave type...',
                                size: 14, color: Colors.black54),
                            value: _selectedApplyingFor,
                            icon: const Card(
                              elevation: 0.1,
                              color: colorWhite,
                              child: Icon(Icons.keyboard_arrow_down_outlined),
                            ),
                            underline: const SizedBox(),
                            onChanged: (value) {
                              setState(() {
                                _selectedApplyingFor = null;
                                _selectedApplyingFor = value.toString();
                                for (int i = 0; i < applyingForData.length; i++) {
                                  if (applyingForData[i].toString().toLowerCase() ==
                                      value.toString().toLowerCase()) {
                                    _selectedApplyingForId = applyingForData[i].toString();
                                    break;
                                  }
                                }
                              });
                            },
                            isExpanded: true,
                            items: applyingForData.map((cd) {
                              return DropdownMenuItem(
                                value: cd,
                                onTap: () {
                                  setState(() {
                                    _selectedApplyingForId = cd;
                                    for (int i = 0; i < applyingForData.length; i++) {
                                      if (applyingForData[i].toString().toLowerCase() ==
                                          cd.toString().toLowerCase()) {
                                        _selectedApplyingForId = applyingForData[i].toString();
                                        break;
                                      }
                                    }
                                  });
                                },
                                child: Text(
                                  cd.toString(),
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
                      gap(10.sp), // Date Picker
                      Row(
                        children: [
                          Expanded(
                            child: CustomTextField(
                              onTap: () {
                                _selectFromDate(context);
                              },
                              hintText: 'From Date',
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
                              controller: _fromDateController,
                              onSave: (value) {
                                // _authData['email'] = value.toString();
                                _fromDateController.text = value as String;
                              },
                            ),
                          ),
                          gap(5.sp),
                          // Date Picker
                          Expanded(
                            child: CustomTextField(
                              onTap: () {
                                _selectToDate(context);
                              },
                              hintText: 'To Date',
                              isRequired: true,
                              prefixIcon: const Icon(
                                Icons.date_range_outlined,
                                color: kTextLowBlackColor,
                              ),
                              validate: (value) {
                                if (value!.isEmpty) {
                                  return 'Apply Date cannot be empty';
                                }
                                return null;
                              },
                              isReadonly: true,
                              controller: _toDateController,
                              onSave: (value) {
                                // _authData['email'] = value.toString();
                                _toDateController.text = value as String;
                              },
                            ),
                          ),
                        ],
                      ),
                      gap(10.sp),
                      CustomTextField(
                        hintText: 'Reason',
                        controller: _reasonController,
                        prefixIcon: const Icon(
                          Icons.tag_sharp,
                          color: kTextLowBlackColor,
                        ),
                        keyboardType: TextInputType.text,
                        validate: (value) {
                          if (value!.isEmpty) {
                            return 'Reason cannot be empty';
                          }
                          return null;
                        },
                        onSave: (value) {
                          // _authData['email'] = value.toString();
                          _reasonController.text = value as String;
                        },
                      ),
                      gap(10.sp),
                      // Submit Button
                      SizedBox(
                        width: double.infinity,
                        child: _isEditLoading
                            ? const Center(child: CircularProgressIndicator())
                            : CommonButton(
                          cornersRadius: 30,
                          text: AppTags.submit,
                          onPressed: () {
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            );
          }),
        );
      },
    );
  }

}
