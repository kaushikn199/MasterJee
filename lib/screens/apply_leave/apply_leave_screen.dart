import 'package:file_picker_pro/file_data.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:masterjee/constants.dart';
import 'package:masterjee/models/common_functions.dart';
import 'package:masterjee/models/leave_application_list_response/leave_application_list_response.dart';
import 'package:masterjee/models/subordinate_staff/subordinate_staff.dart';
import 'package:masterjee/models/user_leave_applications_info_response/leave_application_list_response.dart';
import 'package:masterjee/others/StorageHelper.dart';
import 'package:masterjee/providers/apply_leave_api.dart';
import 'package:masterjee/widgets/CommonButton.dart';
import 'package:masterjee/widgets/app_bar_two.dart';
import 'package:masterjee/widgets/app_tags.dart';
import 'package:masterjee/widgets/custom_form_field.dart';
import 'package:masterjee/widgets/text.dart';
import 'package:provider/provider.dart';

class ApplyLeaveScreen extends StatefulWidget {
  const ApplyLeaveScreen({super.key});

  static String routeName = 'applyLeaveScreen';

  @override
  State<ApplyLeaveScreen> createState() => _ApplyLeaveScreenState();
}

class _ApplyLeaveScreenState extends State<ApplyLeaveScreen> {
  bool _isEditLoading = false;
  var _isLoading = false;

  FileData imageFile = FileData();
  DateTime _selectedDate = DateTime.now();
  DateTime? _selectedFromDate;
  DateTime? _selectedToDate;
  final formKey = GlobalKey<FormState>();
  final _reasonController = TextEditingController();
  final _applyDateController = TextEditingController();
  final _fromDateController = TextEditingController();
  final _toDateController = TextEditingController();
  late List<StfLeave> stfLeaveList = [];
  late List<StuLeave> stuLeaveList = [];
  late List<Lt> leaveTypeList = [];
  late List<SubordinateStaffData> applyList = [];

  String? _selectedApplyUser;
  String? _selectedApplyUserId;

  String? _selectedLeaveType;
  int _selectedLeavePos = 0;

  String selectedStaffValue = '';

  @override
  void initState() {
    print("initState");
    callAPiUserLeaveApplicationsInfo().then(
      (value) {
        callAPiLeaveApplicationForApproval();
      },
    );
    callAPiSubordinateStaff();
    super.initState();
  }

  Future<void> callAPiLeaveApplicationForApproval() async {
    setState(() {
      _isLoading = true;
    });
    try {
      LeaveApplicationListResponse data = await Provider.of<ApplyLeaveApi>(
              context,
              listen: false)
          .getLeaveApplicationForApproval(
              StorageHelper.getStringData(StorageHelper.userIdKey).toString(),
              StorageHelper.getStringData(StorageHelper.classIdKey).toString(),
              StorageHelper.getStringData(StorageHelper.sectionIdKey)
                  .toString());
      if (data.data != null) {
        setState(() {
          stfLeaveList = data.data?.stfLeave ?? [];
          stuLeaveList = data.data?.stuLeave ?? [];
          _isLoading = false;
        });
        return;
      } else {
        setState(() {
          _isLoading = false;
        });
      }
    } catch (error) {
      print("error : ${error}");
    }
  }

  Future<void> callAPiUserLeaveApplicationsInfo() async {
    try {
      UserLeaveApplicationsInfoResponse data = await Provider.of<ApplyLeaveApi>(
              context,
              listen: false)
          .getUserLeaveApplicationsInfo(
              StorageHelper.getStringData(StorageHelper.userIdKey).toString());
      if (data.data != null) {
        setState(() {
          leaveTypeList = data.data?.lt ?? [];
        });
        return;
      }
    } catch (error) {
      print("error : ${error}");
    }
  }

  Future<UserLeaveApplicationsInfoResponse?> updateStaffLeaveStaus(
      String staffLeaveId, String staffLeaveAction) async {
    setState(() {
      _isLoading = true;
    });
    try {
      UserLeaveApplicationsInfoResponse data =
          await Provider.of<ApplyLeaveApi>(context, listen: false)
              .updateStaffLeaveStaus(
                  StorageHelper.getStringData(StorageHelper.userIdKey)
                      .toString(),
                  staffLeaveId,
                  staffLeaveAction);

      setState(() {
        _isLoading = false;
      });

      if (data.result) {
        return data;
      } else {
        return null;
      }
    } catch (error) {
      print("error : $error");
      setState(() {
        _isLoading = false;
      });
      return null;
    }
  }

  Future<UserLeaveApplicationsInfoResponse?> updateStudentLeaveStaus(
      String leaveId, String leaveAction) async {
    setState(() {
      _isLoading = true;
    });
    try {
      UserLeaveApplicationsInfoResponse data =
          await Provider.of<ApplyLeaveApi>(context, listen: false)
              .updateStudentLeaveStaus(
                  StorageHelper.getStringData(StorageHelper.userIdKey)
                      .toString(),
                  leaveId,
                  leaveAction);

      setState(() {
        _isLoading = false;
      });

      if (data.result) {
        return data;
      } else {
        return null;
      }
    } catch (error) {
      print("error : $error");
      setState(() {
        _isLoading = false;
      });
      return null;
    }
  }

  Future<void> callAPiSubordinateStaff() async {
    try {
      SubordinateStaffResponse data = await Provider.of<ApplyLeaveApi>(context,
              listen: false)
          .getSubordinateStaff(
              StorageHelper.getStringData(StorageHelper.userIdKey).toString());
      if (data.data != null) {
        setState(() {
          applyList = data.data ?? [];
        });
        return;
      }
    } catch (error) {
      print("error : ${error}");
    }
  }

  Future<void> saveLeaveApplication(
      String userId,
      String staffId,
      String leaveTypeId,
      String fromDate,
      String toDate,
      String reason,
      String pendingLeave) async {
    setState(() {
      _isLoading = true;
    });
    try {
      UserLeaveApplicationsInfoResponse data =
          await Provider.of<ApplyLeaveApi>(context, listen: false)
              .saveLeaveApplication(userId, staffId, leaveTypeId, fromDate,
                  toDate, reason, pendingLeave);
      setState(() {
        _isLoading = false;
      });
      if (data.data != null) {
        setState(() {});
        return;
      }
    } catch (error) {
      print("error : ${error}");
      setState(() {
        _isLoading = false;
      });
    }
    setState(() {
      _isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarTwo(title: AppTags.applyLeave),
      floatingActionButton: FloatingActionButton(
        shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(50.sp)),
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
        if (stfLeaveList.isEmpty) {
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
        return SingleChildScrollView(
          child: Column(
            children: [
              ListView.builder(
                  shrinkWrap: true,
                  itemCount: stuLeaveList.length,
                  physics: NeverScrollableScrollPhysics(),
                  padding: EdgeInsets.only(top: 10.sp),
                  itemBuilder: (BuildContext context, int index) {
                    return Column(
                      children: [studentLeaveContainer(stuLeaveList[index])],
                    );
                  }),
              ListView.builder(
                  shrinkWrap: true,
                  itemCount: stfLeaveList.length,
                  physics: NeverScrollableScrollPhysics(),
                  padding: EdgeInsets.only(top: 10.sp),
                  itemBuilder: (BuildContext context, int index) {
                    return Column(
                      children: [stafLeaveContainer(stfLeaveList[index])],
                    );
                  }),
            ],
          ),
        );
      }),
    );
  }

  studentLeaveContainer(StuLeave data) {
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
                borderRadius: BorderRadius.only(
                    topRight: Radius.circular(10.r),
                    topLeft: Radius.circular(10.r)),
                color: kToastTextColor),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Student Leave",
                  style: TextStyle(
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: EdgeInsets.all(14.sp),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CommonText.semiBold(
                    "${data.firstname ?? ""} ${data.lastname ?? ""}",
                    color: colorBlack,
                    size: 12.sp),
                ListView.builder(
                    shrinkWrap: true,
                    itemCount: data.studentsLeave.length,
                    physics: NeverScrollableScrollPhysics(),
                    padding: EdgeInsets.only(top: 10.sp),
                    itemBuilder: (BuildContext context, int index) {
                      return Column(
                        children: [
                          Row(
                            children: [
                              Expanded(
                                  child: rowValue("Leave type",
                                      data.studentsLeave[index].reason)),
                              InkWell(
                                child: Container(
                                    padding: EdgeInsets.symmetric(
                                        vertical: 4.sp, horizontal: 8.sp),
                                    decoration: BoxDecoration(
                                        color:
                                            (data.studentsLeave[index].status ==
                                                    "")
                                                ? colorGaryText
                                                : (data.studentsLeave[index]
                                                            .status ==
                                                        "1")
                                                    ? colorGreen
                                                    : (data.studentsLeave[index]
                                                                .status ==
                                                            "2")
                                                        ? Colors.red
                                                        : colorGaryText,
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(4.r))),
                                    child: CommonText.semiBold(
                                        (data.studentsLeave[index].status == "")
                                            ? "Pending"
                                            : (data.studentsLeave[index]
                                                        .status ==
                                                    "1")
                                                ? "Approve"
                                                : (data.studentsLeave[index]
                                                            .status ==
                                                        "2")
                                                    ? "Denied"
                                                    : "",
                                        color: Colors.white,
                                        size: 12.sp)),
                                onTap: () {
                                  selectedStaffValue = "";
                                  showDialog(
                                    context: context,
                                    builder: (BuildContext context) =>
                                        selectStatusPopup(
                                      context,
                                      () {
                                        //approved
                                        //disapproved

                                        print(
                                            "studentLeaveContainer : ${selectedStaffValue}");
                                        updateStudentLeaveStaus(
                                                data.studentsLeave[index].id,
                                                selectedStaffValue == "approved"
                                                    ? "1"
                                                    : selectedStaffValue ==
                                                            "disapproved"
                                                        ? "2"
                                                        : "0")
                                            .then(
                                          (value) {
                                            if (value?.result ?? false) {
                                              setState(() {
                                                data.studentsLeave[index]
                                                        .status =
                                                    selectedStaffValue ==
                                                            "approved"
                                                        ? "1"
                                                        : selectedStaffValue ==
                                                                "disapproved"
                                                            ? "2"
                                                            : "0";
                                              });
                                            }
                                          },
                                        );
                                      },
                                    ),
                                  );
                                },
                              ),
                            ],
                          ),
                          gap(5.sp),
                          rowValue("From Date",
                              data.studentsLeave[index].fromDate.toString()),
                          gap(5.sp),
                          rowValue("To Date",
                              data.studentsLeave[index].toDate.toString()),
                          gap(5.sp),
                          rowValue("Reason", data.studentsLeave[index].reason),
                          gap(20.sp),
                        ],
                      );
                    }),
              ],
            ),
          ),
        ],
      ),
    );
  }

  stafLeaveContainer(StfLeave data) {
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
                borderRadius: BorderRadius.only(
                    topRight: Radius.circular(10.r),
                    topLeft: Radius.circular(10.r)),
                color: kToastTextColor),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Staff Leave",
                  style: TextStyle(
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: EdgeInsets.all(14.sp),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CommonText.semiBold(data.name, color: colorBlack, size: 12.sp),
                ListView.builder(
                    shrinkWrap: true,
                    itemCount: data.staffLeave.length,
                    physics: NeverScrollableScrollPhysics(),
                    padding: EdgeInsets.only(top: 10.sp),
                    itemBuilder: (BuildContext context, int index) {
                      return Column(
                        children: [
                          Row(
                            children: [
                              Expanded(
                                  child: rowValue(
                                      "Leave type",
                                      getLeaveType(
                                          data.staffLeave[index].leaveTypeId ??
                                              ""))),
                              InkWell(
                                child: Container(
                                    padding: EdgeInsets.symmetric(
                                        vertical: 4.sp, horizontal: 8.sp),
                                    decoration: BoxDecoration(
                                        color: (data.staffLeave[index].status ==
                                                "")
                                            ? colorGaryText
                                            : (data.staffLeave[index].status ==
                                                    "approved")
                                                ? colorGreen
                                                : (data.staffLeave[index]
                                                            .status ==
                                                        "disapproved")
                                                    ? Colors.red
                                                    : colorGaryText,
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(4.r))),
                                    child: CommonText.semiBold(
                                        //disapproved
                                        (data.staffLeave[index].status == "")
                                            ? "Pending"
                                            : (data.staffLeave[index].status ==
                                                    "approved")
                                                ? "Approve"
                                                : (data.staffLeave[index]
                                                            .status ==
                                                        "disapproved")
                                                    ? "Denied"
                                                    : "",
                                        color: Colors.white,
                                        size: 12.sp)),
                                onTap: () {
                                  selectedStaffValue = "";
                                  showDialog(
                                    context: context,
                                    builder: (BuildContext context) =>
                                        selectStatusPopup(
                                      context,
                                      () {
                                        updateStaffLeaveStaus(
                                                data.staffLeave[index].id,
                                                selectedStaffValue)
                                            .then(
                                          (value) {
                                            print("value : ${value}");
                                            if (value?.result ?? false) {
                                              setState(() {
                                                print(
                                                    "selectedValue : $selectedStaffValue");
                                                data.staffLeave[index].status =
                                                    selectedStaffValue;
                                              });
                                            }
                                          },
                                        );
                                      },
                                    ),
                                  );
                                },
                              ),
                            ],
                          ),
                          gap(5.sp),
                          rowValue("From Date",
                              data.staffLeave[index].leaveFrom.toString()),
                          gap(5.sp),
                          rowValue("To Date",
                              data.staffLeave[index].leaveTo.toString()),
                          gap(5.sp),
                          rowValue(
                              "Remark", data.staffLeave[index].employeeRemark),
                          gap(20.sp),
                        ],
                      );
                    }),
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
          child: CommonText.medium(key, size: 14.sp, color: Colors.black)),
      SizedBox(width: 20.w),
      Flexible(
        child: CommonText.medium(value,
            size: 14.sp, color: kDarkGreyColor, overflow: TextOverflow.fade),
      ),
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

  String? getLeaveType(String leaveTypeId) {
    for (int i = 0; i < leaveTypeList.length; i++) {
      if (leaveTypeList[i].leaveTypeId == leaveTypeId) {
        return leaveTypeList[i].type;
      }
    }
    return null;
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
                          CommonText.bold("Add Leave", size: 18.sp),
                          GestureDetector(
                              onTap: () {
                                Navigator.pop(context);
                              },
                              child: const Icon(Icons.close,
                                  color: Colors.black, size: 24))
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
                          padding: const EdgeInsets.symmetric(
                              horizontal: 10, vertical: 2),
                          child: DropdownButton(
                            hint: const CommonText('Applying for',
                                size: 14, color: Colors.black54),
                            value: _selectedApplyUser,
                            icon: const Card(
                              elevation: 0.1,
                              color: colorWhite,
                              child: Icon(Icons.keyboard_arrow_down_outlined),
                            ),
                            underline: const SizedBox(),
                            onChanged: (value) {
                              setState(() {
                                _selectedApplyUser = null;
                                _selectedApplyUser = value.toString();
                                for (int i = 0; i < applyList.length; i++) {
                                  if (applyList[i]
                                          .name
                                          .toString()
                                          .toLowerCase() ==
                                      value.toString().toLowerCase()) {
                                    _selectedApplyUserId =
                                        applyList[i].name.toString();
                                    break;
                                  }
                                }
                              });
                            },
                            isExpanded: true,
                            items: applyList.map((cd) {
                              return DropdownMenuItem(
                                value: cd.name,
                                onTap: () {
                                  setState(() {
                                    _selectedApplyUser = cd.name;
                                    for (int i = 0; i < applyList.length; i++) {
                                      if (applyList[i]
                                              .name
                                              .toString()
                                              .toLowerCase() ==
                                          cd.toString().toLowerCase()) {
                                        _selectedApplyUserId =
                                            applyList[i].employeeId.toString();
                                        break;
                                      }
                                    }
                                  });
                                },
                                child: Text(
                                  cd.name.toString(),
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
                          padding: const EdgeInsets.symmetric(
                              horizontal: 10, vertical: 2),
                          child: DropdownButton(
                            hint: const CommonText('Select leave type...',
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
                                for (int i = 0; i < leaveTypeList.length; i++) {
                                  if (leaveTypeList[i]
                                          .type
                                          .toString()
                                          .toLowerCase() ==
                                      value.toString().toLowerCase()) {
                                    _selectedLeavePos =  i;
                                        i;
                                    break;
                                  }
                                }
                              });
                            },
                            isExpanded: true,
                            items: leaveTypeList.map((cd) {
                              return DropdownMenuItem(
                                value: cd.type,
                                onTap: () {
                                  setState(() {
                                    for (int i = 0;
                                        i < leaveTypeList.length;
                                        i++) {
                                      if (leaveTypeList[i]
                                              .type
                                              .toString()
                                              .toLowerCase() ==
                                          cd.type.toString().toLowerCase()) {
                                        _selectedLeavePos = i;
                                            i;
                                        break;
                                      }
                                    }
                                  });
                                },
                                child: Text(
                                  cd.type.toString(),
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
                                  checkValidation();
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

  checkValidation() {
    if (_selectedApplyUser == null) {
      CommonFunctions.showWarningToast("Please select applying for user name");
    } else if (_selectedLeaveType == null) {
      CommonFunctions.showWarningToast("Please select leave type");
    } else if (_fromDateController.text == "") {
      CommonFunctions.showWarningToast("Please select from date");
    } else if (_toDateController.text == "") {
      CommonFunctions.showWarningToast("Please select to date");
    } else if (_reasonController.text == "") {
      CommonFunctions.showWarningToast("Please enter leave reason");
    } else {
      saveLeaveApplication(
        StorageHelper.getStringData(StorageHelper.userIdKey).toString(),
          leaveTypeList[_selectedLeavePos].staffId.toString(),
          leaveTypeList[_selectedLeavePos].leaveTypeId.toString(),
          _fromDateController.text.toString(),
        _toDateController.text.toString(),
        _reasonController.text.toString(),
        leaveTypeList[_selectedLeavePos].pendingLeave.toString());
    }
  }

  Widget selectStatusPopup(BuildContext context, VoidCallback? onTap) {
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
                gap(20.0),
                RadioListTile<String>(
                  activeColor: colorGreen,
                  title: CommonText.medium("Approve", size: 12.sp),
                  value: 'approved',
                  groupValue: selectedStaffValue,
                  onChanged: (value) {
                    setState(() {
                      selectedStaffValue = value!;
                    });
                  },
                ),
                RadioListTile<String>(
                  title: CommonText.medium("Deny", size: 12.sp),
                  value: 'disapproved',
                  activeColor: colorGreen,
                  // <-- Set your desired selection color here
                  groupValue: selectedStaffValue,
                  onChanged: (value) {
                    setState(() {
                      selectedStaffValue = value!;
                    });
                  },
                ),
                gap(20.0),
                CommonButton(
                  cornersRadius: 30,
                  text: AppTags.submit,
                  onPressed: () {
                    if (selectedStaffValue != "") {
                      onTap!();
                      Navigator.of(context).pop();
                    } else {
                      CommonFunctions.showSuccessToast("Please Select any one");
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
