import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get_utils/src/extensions/widget_extensions.dart';
import 'package:masterjee/constants.dart';
import 'package:masterjee/models/class_timetable/add_lesson_plan_response.dart';
import 'package:masterjee/widgets/CommonButton.dart';
import 'package:masterjee/widgets/app_tags.dart';
import 'package:masterjee/widgets/custom_form_field.dart';
import 'package:masterjee/widgets/text.dart';

class EditUpdateObservationScreen extends StatefulWidget {
  const EditUpdateObservationScreen({super.key});

  static String routeName = 'editUpdateObservationScreen';

  @override
  State<EditUpdateObservationScreen> createState() => _EditUpdateObservationScreenState();
}

class _EditUpdateObservationScreenState extends State<EditUpdateObservationScreen> {

  final scaffoldKey = GlobalKey<ScaffoldState>();
  GlobalKey<FormState> globalFormKey = GlobalKey<FormState>();

  late var observationNameController = TextEditingController();
  late var descriptionController = TextEditingController();

  List<int> resultData = [1];

  final List<TextEditingController> selectParameterController = [];
  final List<TextEditingController> maxMarkController = [];

  void _ensureSlotController(int index) {
    while (selectParameterController.length <= index) {
      selectParameterController.add(TextEditingController());
      maxMarkController.add(TextEditingController());
    }
  }
  String? _selectedLesson;
  String? _selectedTopic;
  List<Lesson> lessonsMainList = [];
  int _indexLesson = 0;

  @override
  void initState() {
    _ensureSlotController(0);
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      backgroundColor: colorGaryBG,
      bottomNavigationBar: CommonButton(
        paddingHorizontal: 7,
        cornersRadius: 10,
        text: AppTags.add,
        onPressed: () {
        },
      ).paddingOnly(bottom: 30, left: 10, right: 10),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Center(
              child: Form(
                key: globalFormKey,
                child: Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      CustomTextField(
                        hintText: 'Observation Name',
                        isReadonly: false,
                        controller: observationNameController,
                        keyboardType: TextInputType.name,
                        onSave: (value) {
                          observationNameController.text = value as String;
                        },
                      ),
                      gap(10.0),
                      CustomTextField(
                        maxLines: 2,
                        hintText: 'Description',
                        isReadonly: false,
                        controller: descriptionController,
                        keyboardType: TextInputType.name,
                        onSave: (value) {
                          descriptionController.text = value as String;
                        },
                      ),
                      Column(
                        children: List.generate(resultData.length, (index) {
                          return assignmentCard(resultData[index], index);
                        }),
                      ),
                      gap(10.0),
                      SizedBox(
                        width: 200,
                        child: CommonButton(
                          paddingHorizontal: 7,
                          paddingVertical: 9,
                          cornersRadius: 10,
                          text: "Add More",
                          onPressed: () {
                            setState(() {
                              _ensureSlotController(resultData.length);
                              resultData.add(1);
                            });
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget assignmentCard(int a, int index) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
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
              hint: const CommonText('Select parameter',
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
          hintText: 'Max mark',
          isReadonly: false,
          controller: maxMarkController[index],
          keyboardType: TextInputType.number,
          onSave: (value) {
            maxMarkController[index].text = value as String;
          },
        ),
      ],
    );
  }

}
