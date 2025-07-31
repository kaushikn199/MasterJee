import 'package:flutter/material.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:masterjee/constants.dart';
import 'package:masterjee/models/exam/grades/GradesInfoResponse.dart';

import 'package:masterjee/widgets/CommonButton.dart';
import 'package:masterjee/widgets/app_bar_two.dart';
import 'package:masterjee/widgets/app_tags.dart';
import 'package:masterjee/widgets/custom_form_field.dart';
import 'package:masterjee/widgets/text.dart';

class AddGradesScreen extends StatefulWidget {
  const AddGradesScreen({super.key});

  static String routeName = 'addGradesScreen';

  @override
  State<AddGradesScreen> createState() => _AddGradesScreenState();
}

class _AddGradesScreenState extends State<AddGradesScreen> {

  var _isLoading = false;

  late var gradeNameController = TextEditingController();
  late var descriptionController = TextEditingController();

  final List<TextEditingController> rangeNameController = [];
  final List<TextEditingController> minimumPercentageController = [];
  final List<TextEditingController> maxPercentageController = [];
  final List<TextEditingController> description2Controller = [];

  void _ensureSlotController(int index) {
    while (rangeNameController.length <= index) {
      rangeNameController.add(TextEditingController());
      minimumPercentageController.add(TextEditingController());
      maxPercentageController.add(TextEditingController());
      description2Controller.add(TextEditingController());
    }
  }

  List<int> data = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarTwo(title: AppTags.grades),
      backgroundColor: colorGaryBG,
      bottomNavigationBar: CommonButton(
        paddingHorizontal: 7,
        cornersRadius: 10,
        text: AppTags.add,
        onPressed: () {
        },
      ).paddingOnly(bottom: 30, left: 10, right: 10),
      body: Builder(builder: (context) {
        if (_isLoading) {
          return SizedBox(
            height: MediaQuery.of(context).size.height * .5,
            child: const Center(
              child: CircularProgressIndicator(),
            ),
          );
        }
        return SingleChildScrollView(
          child: Column(
            children: [
              Center(
                child: Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      CustomTextField(
                        hintText: 'Grade Name',
                        isReadonly: false,
                        controller: gradeNameController,
                        keyboardType: TextInputType.name,
                        onSave: (value) {
                          gradeNameController.text = value as String;
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
                        children: List.generate(data.length, (index) {
                          return assignmentCard(index);
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
                              _ensureSlotController(data.length);
                              data.add(0);
                            });
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        );
      }),
    );
  }

  Widget assignmentCard(int index) {
   /* rangeNameController[index].text = data.name;
    minimumPercentageController[index].text = data.minimumPercentage;
    maxPercentageController[index].text = data.maximumPercentage;
    description2Controller[index].text = data.description;*/
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        gap(10.0),
        CustomTextField(
          hintText: 'Range Name',
          isReadonly: false,
          controller: rangeNameController[index],
          keyboardType: TextInputType.name,
          onSave: (value) {
            rangeNameController[index].text = value as String;
          },
        ),
        gap(10.0),
        CustomTextField(
          hintText: 'Minimum Percentage',
          isReadonly: false,
          controller: minimumPercentageController[index],
          keyboardType: TextInputType.number,
          onSave: (value) {
            minimumPercentageController[index].text = value as String;
          },
        ),
        gap(10.0),
        CustomTextField(
          hintText: 'Max Percentage',
          isReadonly: false,
          controller: maxPercentageController[index],
          keyboardType: TextInputType.number,
          onSave: (value) {
            maxPercentageController[index].text = value as String;
          },
        ),
        gap(10.0),
        CustomTextField(
          hintText: 'Description',
          isReadonly: false,
          controller: description2Controller[index],
          keyboardType: TextInputType.number,
          onSave: (value) {
            description2Controller[index].text = value as String;
          },
        ),
      ],
    );
  }


}
