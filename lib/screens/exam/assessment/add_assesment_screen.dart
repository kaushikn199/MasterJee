import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get_utils/src/extensions/widget_extensions.dart';
import 'package:masterjee/constants.dart';
import 'package:masterjee/models/common_functions.dart';
import 'package:masterjee/models/exam/assesment/assessment_info/AssessmentInfoResponse.dart';
import 'package:masterjee/others/StorageHelper.dart';
import 'package:masterjee/providers/exam_api.dart';
import 'package:masterjee/widgets/CommonButton.dart';
import 'package:masterjee/widgets/app_bar_two.dart';
import 'package:masterjee/widgets/app_tags.dart';
import 'package:masterjee/widgets/custom_form_field.dart';
import 'package:masterjee/widgets/text.dart';
import 'package:provider/provider.dart';

class AddAssessmentScreen extends StatefulWidget {
  const AddAssessmentScreen({super.key});

  static String routeName = 'addAssessmentScreen';

  @override
  State<AddAssessmentScreen> createState() => _AddAssessmentScreenState();
}

class _AddAssessmentScreenState extends State<AddAssessmentScreen> {
  var _isLoading = false;
  late var assessmentNameController = TextEditingController();
  late var descriptionController = TextEditingController();

  final List<TextEditingController> assessTypeController = [];
  final List<TextEditingController> codeController = [];
  final List<TextEditingController> maxMarksController = [];
  final List<TextEditingController> passPercentController = [];

  void _ensureSlotController(int index) {
    while (assessTypeController.length <= index) {
      assessTypeController.add(TextEditingController());
      codeController.add(TextEditingController());
      maxMarksController.add(TextEditingController());
      passPercentController.add(TextEditingController());
    }
  }

  List<int> data = [];
  List<Map<String, String>> assessTypeData = [];

  Future<void> callApiSaveAssessment() async {
    setState(() {
      _isLoading = true;
    });
    try {
      AssessmentInfoResponse data =
          await Provider.of<ExamApi>(context, listen: false).saveAssessment(
              StorageHelper.getStringData(StorageHelper.userIdKey).toString(),
              "",
              assessmentNameController.text,
              descriptionController.text,
              assessTypeData);
      if (data.result) {
        setState(() {
          _isLoading = false;
          CommonFunctions.showWarningToast(data.message);
          Navigator.of(context).pop(true);
        });
        return;
      } else {
        setState(() {
          CommonFunctions.showWarningToast(data.message);
          _isLoading = false;
        });
      }
    } catch (error) {
      print("error : ${error}");
      setState(() {
        CommonFunctions.showWarningToast(error.toString());
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarTwo(title: AppTags.assesment),
      backgroundColor: colorGaryBG,
      bottomNavigationBar: CommonButton(
        paddingHorizontal: 7,
        cornersRadius: 10,
        text: AppTags.add,
        onPressed: () {
          if (assessmentNameController.text == "") {
            CommonFunctions.showWarningToast("Please assessment Name");
          } else if (descriptionController.text == "") {
            CommonFunctions.showWarningToast("Please enter description");
          } else {
            for (int i = 0; i < data.length; i++) {
              assessTypeData.add({
                "typeId": "",
                "assessType": assessTypeController[i].text,
                "assessCode": codeController[i].text,
                "assessMaxMarks": maxMarksController[i].text,
                "assessPassPercent": passPercentController[i].text
              });
            }
            callApiSaveAssessment();
          }
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
                        hintText: 'Assessment Name',
                        isReadonly: false,
                        controller: assessmentNameController,
                        keyboardType: TextInputType.name,
                        onSave: (value) {
                          assessmentNameController.text = value as String;
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
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        gap(10.0),
        CustomTextField(
          hintText: 'Assessment type',
          isReadonly: false,
          controller: assessTypeController[index],
          keyboardType: TextInputType.name,
          onSave: (value) {
            assessTypeController[index].text = value as String;
          },
        ),
        gap(10.0),
        CustomTextField(
          hintText: 'Code',
          isReadonly: false,
          controller: codeController[index],
          keyboardType: TextInputType.text,
          onSave: (value) {
            codeController[index].text = value as String;
          },
        ),
        gap(10.0),
        CustomTextField(
          hintText: 'Max marks',
          isReadonly: false,
          controller: maxMarksController[index],
          keyboardType: TextInputType.number,
          onSave: (value) {
            maxMarksController[index].text = value as String;
          },
        ),
        gap(10.0),
        CustomTextField(
          hintText: 'Passing percentage',
          isReadonly: false,
          controller: passPercentController[index],
          keyboardType: TextInputType.number,
          onSave: (value) {
            passPercentController[index].text = value as String;
          },
        ),
      ],
    );
  }
}
