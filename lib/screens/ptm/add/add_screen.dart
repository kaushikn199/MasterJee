import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:masterjee/constants.dart';
import 'package:masterjee/models/common_functions.dart';
import 'package:masterjee/models/ptm/ptm_response.dart';
import 'package:masterjee/others/StorageHelper.dart';
import 'package:masterjee/providers/ptm_api.dart';
import 'package:masterjee/widgets/app_bar_two.dart';
import 'package:masterjee/widgets/app_tags.dart';
import 'package:masterjee/widgets/custom_form_field.dart';
import 'package:masterjee/widgets/text.dart';
import 'package:provider/provider.dart';

import '../../../widgets/CommonButton.dart';

class AddScreen extends StatefulWidget {
  const AddScreen({super.key});

  static String routeName = 'AddScreen';

  @override
  State<AddScreen> createState() => _AddScreenState();
}

class _AddScreenState extends State<AddScreen> {
  late String startTime;
  late String endTime;
  DateTime? _selectedFromDate;
  final _titleController = TextEditingController();
  final _dateController = TextEditingController();
  final _fromStartTimeController = TextEditingController();
  final _fromEndTimeController = TextEditingController();
  final _remarkController = TextEditingController();
  List<int> resultData = [1];
  var _isLoading = false;

  Future<void> callApiSavePtm() async {
    setState(() {
      _isLoading = true;
    });
    try {
      PtmResponse data = await Provider.of<PtmApi>(context, listen: false)
          .savePtm(
              StorageHelper.getStringData(StorageHelper.userIdKey).toString(),
              _titleController.text,
              _dateController.text,
              _remarkController.text,
              startTime,
              endTime);
      if (data.result) {
        setState(() {
          _isLoading = false;
          _titleController.text = "";
          _dateController.text = "";
          _fromStartTimeController.text = "";
          _fromEndTimeController.text = "";
          _remarkController.text = "";
          startTime = "";
          endTime = "";
          CommonFunctions.showWarningToast(data.message);
        });
        return;
      } else {
        setState(() {
          _isLoading = false;
        });
      }
    } catch (error) {
      print("error : ${error}");
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: colorGaryBG,
      appBar: AppBarTwo(title: AppTags.add),
      body: Container(
        height: double.infinity,
        color: kBackgroundColor,
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CustomTextField(
                borderRadius: 10.0,
                onTap: () {},
                hintText: 'Title',
                isRequired: true,
                validate: (value) {
                  if (value!.isEmpty) {
                    return 'Please enter title';
                  }
                  return null;
                },
                isReadonly: false,
                controller: _titleController,
                onSave: (value) {
                  // _authData['email'] = value.toString();
                  _titleController.text = value as String;
                },
              ).paddingOnly(top: 10),
              CustomTextField(
                borderRadius: 10.0,
                onTap: () {
                  _selectFromDate(context);
                },
                hintText: 'Date',
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
                controller: _dateController,
                onSave: (value) {
                  _dateController.text = value as String;
                },
              ).paddingOnly(top: 10),
              // Replace ListView.builder
              Column(
                children: List.generate(resultData.length, (index) {
                  return assignmentCard(resultData[index], false)
                      .paddingOnly(top: 10.sp);
                }),
              ),
              /*SizedBox(
                width: 200,
                child: CommonButton(
                  paddingHorizontal: 7,
                  paddingVertical: 9,
                  cornersRadius: 10,
                  text: AppTags.addMoreSlot,
                  onPressed: () {
                    setState(() {
                      resultData.add(1);
                    });
                  },
                ),
              ),*/
              CustomTextField(
                borderRadius: 10.0,
                onTap: () {},
                hintText: 'Remark',
                isRequired: true,
                maxLines: 2,
                controller: _remarkController,
                validate: (value) {
                  if (value!.isEmpty) {
                    return 'Please enter remark';
                  }
                  return null;
                },
                isReadonly: false,
                onSave: (value) {
                  _remarkController.text = value as String;
                },
              ).paddingOnly(top: 10),
              const SizedBox(
                height: 30,
              ),
              _isLoading
                  ? const CircularProgressIndicator()
                  : CommonButton(
                      cornersRadius: 30,
                      text: AppTags.submit,
                      onPressed: () {
                        if (_titleController.text.isEmpty) {
                          CommonFunctions.showWarningToast(
                              "Please enter title");
                        } else if (_dateController.text.isEmpty) {
                          CommonFunctions.showWarningToast("Please enter date");
                        } else if (_remarkController.text.isEmpty) {
                          CommonFunctions.showWarningToast(
                              "Please enter remark");
                        } else {
                          callApiSavePtm();
                        }
                      },
                    ),
              const SizedBox(
                height: 10,
              )
            ],
          ).paddingOnly(left: 10, right: 10),
        ),
      ),
    );
  }

  Widget assignmentCard(int a, bool isClosed) {
    return Container(
      margin: EdgeInsets.only(bottom: 20.sp),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CommonText.medium("Time slot",
              textAlign: TextAlign.start,
              size: 14.sp,
              color: kDarkGreyColor,
              overflow: TextOverflow.fade),
          CustomTextField(
            borderRadius: 10.0,
            onTap: () {
              _selectStartTime(context);
            },
            hintText: 'Start Time',
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
            controller: _fromStartTimeController,
            onSave: (value) {
              _fromStartTimeController.text = value as String;
            },
          ).paddingOnly(top: 10),
          CustomTextField(
            borderRadius: 10.0,
            onTap: () {
              _selectEndTime(context);
            },
            hintText: 'End Time',
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
            controller: _fromEndTimeController,
            onSave: (value) {
              _fromEndTimeController.text = value as String;
            },
          ).paddingOnly(top: 10),
        ],
      ),
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
        _dateController.text = pickedDate.toLocalDMYDateString();
        print("_dateController : ${_dateController.text}");
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
        _fromStartTimeController.text = pickedTime.format(context);
        print("_fromStartTimeController : $formattedTime");
      });
    }
  }

  Future<void> _selectEndTime(BuildContext context) async {
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
        // final formattedTime = pickedTime.format(context);
        endTime = formattedTime;
        _fromEndTimeController.text = pickedTime.format(context);
        print("_fromEndTimeController : ${_fromEndTimeController.text}");
      });
    }
  }
}
