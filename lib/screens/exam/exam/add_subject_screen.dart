import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get_utils/src/extensions/widget_extensions.dart';
import 'package:intl/intl.dart';
import 'package:masterjee/constants.dart';
import 'package:masterjee/models/class_timetable/add_lesson_plan_response.dart';
import 'package:masterjee/widgets/CommonButton.dart';
import 'package:masterjee/widgets/app_bar_two.dart';
import 'package:masterjee/widgets/app_tags.dart';
import 'package:masterjee/widgets/custom_form_field.dart';
import 'package:masterjee/widgets/text.dart';

class AddSubjectScreen extends StatefulWidget {
  const AddSubjectScreen({super.key});
  static String routeName = 'addSubjectScreen';

  @override
  State<AddSubjectScreen> createState() => _AddSubjectScreenState();
}

class _AddSubjectScreenState extends State<AddSubjectScreen> {

  GlobalKey<FormState> globalFormKey = GlobalKey<FormState>();

  String? _selectedLesson;
  String? _selectedTopic;
  List<Lesson> lessonsMainList = [];
  int _indexLesson = 0;

  DateTime? _selectedFromDate;
  final _fromDateController = TextEditingController();

  late String startTime;
  final _fromStartTimeControllers = TextEditingController();

  final _durationController = TextEditingController();

  final roomController = TextEditingController();

  List<Map<String, dynamic>> items = [
    {'id': 1, 'name': 'Theory', 'isChecked': false},
    {'id': 2, 'name': 'Assignment', 'isChecked': false},
    {'id': 3, 'name': 'Practical', 'isChecked': false},
  ];
  bool _isChecked = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarTwo(title: AppTags.addSubject),
      backgroundColor: colorGaryBG,
      bottomNavigationBar: CommonButton(
        paddingHorizontal: 7,
        cornersRadius: 10,
        text: AppTags.add,
        onPressed: () {},
      ).paddingOnly(bottom: 30, left: 10, right: 10),
      body: SingleChildScrollView(
        child: Column(
          children: [
            gap(10.0),
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
                  hint: const CommonText('Select...',
                      size: 14, color: Colors.black54),
                  value: _selectedLesson,
                  icon: const Card(
                    elevation: 0.1,
                    color: colorWhite,
                    child: Icon(
                        Icons.keyboard_arrow_down_outlined),
                  ),
                  underline: const SizedBox(),
                  onChanged: (value) {
                    setState(() {
                      _selectedLesson = null;
                      _selectedLesson = value.toString();
                      _selectedTopic = null;
                    });
                  },
                  isExpanded: true,
                  items: lessonsMainList.map((cd) {
                    return DropdownMenuItem(
                      value: cd.id,
                      onTap: () {
                        setState(() {
                          _selectedLesson = cd.name;
                          for (int i = 0;
                          i < lessonsMainList.length;
                          i++) {
                            if (lessonsMainList[i].id ==
                                cd.id) {
                              _indexLesson = i;
                              _selectedTopic = null;
                              //_selectedLessonId = lessonsMainList[i].id;
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
            gap(10.0),
            CustomTextField(
              onTap: () {
                _selectFromDate(context);
              },
              hintText: 'Select date',
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
            gap(10.0),
            CustomTextField(
              onTap: () {
                _selectStartTime(context);
              },
              hintText: 'Time',
              isRequired: true,
              prefixIcon: const Icon(
                Icons.date_range_outlined,
                color: kTextLowBlackColor,
              ),
              isReadonly: true,
              controller: _fromStartTimeControllers,
              onSave: (value) {
                _fromStartTimeControllers.text = value as String;
              },
            ),
            gap(10.0),
            CustomTextField(
              keyboardType: TextInputType.number,
              hintText: 'Duration',
              isRequired: true,
              isReadonly: false,
              controller: _durationController,
              onSave: (value) {
                _durationController.text = value as String;
              },
            ),
            gap(10.0),
            CustomTextField(
              keyboardType: TextInputType.number,
              hintText: 'Room',
              isRequired: true,
              isReadonly: false,
              controller: roomController,
              onSave: (value) {
                roomController.text = value as String;
              },
            ),
            gap(10.0),
            ListView.builder(
                shrinkWrap: true,
                itemCount: items.length,
                itemBuilder: (BuildContext context, int index) {
                  return InkWell(
                      onTap: () {
                        //Navigator.push(context);
                      },
                      child: studentRow(items[index])
                  );
                }),
          ],
        ).paddingOnly(left: 10,right: 10),
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
        _fromStartTimeControllers.text = startTime;
        print("_fromStartTimeController : ${_fromStartTimeControllers.text}");
      });
    }
  }

  Widget studentRow(Map<String, dynamic> data){
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        gap(8.0),
        Transform.scale(
          scale: 0.85,
          child: Checkbox(
            value: _isChecked,
            onChanged: (bool? value) {
              setState(() {
                _isChecked = value ?? false;
              });
            },
            checkColor: Colors.white,
            activeColor: Colors.green,
            materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
            visualDensity: VisualDensity.compact,
          ),
        ),
        const SizedBox(width: 30,height: 0,),
        CommonText.medium(
          data['name'],
          size: 14.sp,
          color: colorBlack,
          overflow: TextOverflow.fade,
        ),
      ],
    );
  }

}