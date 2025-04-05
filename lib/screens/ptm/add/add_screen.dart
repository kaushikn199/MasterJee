import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:masterjee/constants.dart';
import 'package:masterjee/widgets/app_bar_two.dart';
import 'package:masterjee/widgets/app_tags.dart';
import 'package:masterjee/widgets/custom_form_field.dart';
import 'package:masterjee/widgets/text.dart';

import '../../../widgets/CommonButton.dart';

class AddScreen extends StatefulWidget {
  const AddScreen({super.key});

  static String routeName = 'AddScreen';

  @override
  State<AddScreen> createState() => _AddScreenState();
}

class _AddScreenState extends State<AddScreen> {
  DateTime? _selectedFromDate;
  final _fromDateController = TextEditingController();
  final _fromStartTimeController = TextEditingController();
  final _fromEndTimeController = TextEditingController();
  List<int> resultData = [1];
  TextEditingController _timeController = TextEditingController();


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: colorGaryBG,
      appBar: AppBarTwo(title: AppTags.add),
      body: Container(
        height: double.infinity,
        color: kBackgroundColor,
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
              controller: _fromDateController,
              onSave: (value) {
                // _authData['email'] = value.toString();
                _fromDateController.text = value as String;
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
              controller: _fromDateController,
              onSave: (value) {
                // _authData['email'] = value.toString();
                _fromDateController.text = value as String;
              },
            ).paddingOnly(top: 10),
            Flexible(
              child: ListView.builder(
                  shrinkWrap: true,
                  itemCount: resultData.length,
                  padding: EdgeInsets.only(top: 10.sp),
                  itemBuilder: (BuildContext context, int index) {
                    return assignmentCard(resultData[index], false);
                  }),
            ),
            SizedBox(
              width: 200,
              child:
              CommonButton(
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
            ),
            CustomTextField(
              borderRadius: 10.0,
              onTap: () {},
              hintText: 'Remark',
              isRequired: true,
              maxLines: 2,
              validate: (value) {
                if (value!.isEmpty) {
                  return 'Please enter remark';
                }
                return null;
              },
              isReadonly: false,
              onSave: (value) {
                // _authData['email'] = value.toString();
                _fromDateController.text = value as String;
              },
            ).paddingOnly(top: 10),
            SizedBox(height: 10,),
            CommonButton(
              cornersRadius: 30,
              text: AppTags.submit,
              onPressed: () {
                setState(() {
                  resultData.add(1);
                });
              },
            ),
            SizedBox(height: 10,)

          ],
        ).paddingOnly(left: 10, right: 10),
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
          CommonText.medium("Time slot",textAlign: TextAlign.start,
              size: 14.sp, color: kDarkGreyColor, overflow: TextOverflow.fade),
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
              // _authData['email'] = value.toString();
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
              // _authData['email'] = value.toString();
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
        _fromDateController.text = pickedDate.toLocalDMYDateString();
      });
    }
  }

  Future<void> _selectStartTime(BuildContext context) async {
    final TimeOfDay? pickedTime = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    );

    if (pickedTime != null) {
      setState(() {
        // Format time as "hh:mm AM/PM"
        final formattedTime = pickedTime.format(context);
        _timeController.text = formattedTime;
        _fromStartTimeController.text = formattedTime;
      });
    }
  }

  Future<void> _selectEndTime(BuildContext context) async {
    final TimeOfDay? pickedTime = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    );

    if (pickedTime != null) {
      setState(() {
        // Format time as "hh:mm AM/PM"
        final formattedTime = pickedTime.format(context);
        _timeController.text = formattedTime;
        _fromEndTimeController.text = formattedTime;
      });
    }
  }

}
