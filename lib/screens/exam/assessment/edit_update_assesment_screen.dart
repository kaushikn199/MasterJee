import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:masterjee/constants.dart';
import 'package:masterjee/models/common_functions.dart';
import 'package:masterjee/models/exam/assesment/AssessmentModel.dart';
import 'package:masterjee/models/exam/assesment/AssessmentTypeModel.dart';
import 'package:masterjee/models/exam/assesment/assessment_info/AssessmentInfoResponse.dart';
import 'package:masterjee/models/exam/observation/ObservationInfoResponse.dart';
import 'package:masterjee/others/StorageHelper.dart';
import 'package:masterjee/providers/exam_api.dart';
import 'package:masterjee/widgets/CommonButton.dart';
import 'package:masterjee/widgets/app_bar_two.dart';
import 'package:masterjee/widgets/app_tags.dart';
import 'package:masterjee/widgets/custom_form_field.dart';
import 'package:masterjee/widgets/text.dart';
import 'package:provider/provider.dart';

class EditUpdateAssessmentScreen extends StatefulWidget {
  const EditUpdateAssessmentScreen({super.key});

  static String routeName = 'editUpdateAssessmentScreen';

  @override
  State<EditUpdateAssessmentScreen> createState() =>
      _EditUpdateAssessmentScreenState();
}

class _EditUpdateAssessmentScreenState
    extends State<EditUpdateAssessmentScreen> {
  final scaffoldKey = GlobalKey<ScaffoldState>();
  GlobalKey<FormState> globalFormKey = GlobalKey<FormState>();

  late var gradeNameController = TextEditingController();
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

  var _isLoading = false;
  AssessmentModel data = AssessmentModel();
  bool _isInitialized = false;
  String assessmentId = "";

  @override
  void didChangeDependencies() {
    if (!_isInitialized) {
      assessmentId =
          ModalRoute.of(context)?.settings.arguments as String? ?? "";
      callApiAssessmentInfo();
      _isInitialized = true;
    }
    super.didChangeDependencies();
  }

  Future<void> callApiAssessmentInfo() async {
    setState(() {
      _isLoading = true;
    });
    try {
      AssessmentInfoResponse response =
          await Provider.of<ExamApi>(context, listen: false).assessmentInfo(
              StorageHelper.getStringData(StorageHelper.userIdKey).toString(),
              assessmentId);
      if (response.result) {
        setState(() {
          data = response.data;
          gradeNameController.text = data.name;
          descriptionController.text = data.description;
          _ensureSlotController(data.types.length);
          _isLoading = false;
        });
        return;
      } else {
        setState(() {
          _isLoading = false;
        });
      }
    } catch (error) {
      print("callApiAssessmentInfo : ${error}");
      setState(() {
        _isLoading = false;
      });
    }
  }

  List<Map<String, String>> assessTypeData = [];

  Future<void> callApiSaveAssessment() async {
    setState(() {
      _isLoading = true;
    });
    try {
      AssessmentInfoResponse data =
      await Provider.of<ExamApi>(context, listen: false).saveAssessment(
        StorageHelper.getStringData(StorageHelper.userIdKey).toString(),
        assessmentId,
        gradeNameController.text,
        descriptionController.text,
        assessTypeData
      );
      if (data.result) {
        setState(() {
          _isLoading = false;

          CommonFunctions.showWarningToast(data.message);
          Navigator.of(context).pop(true);
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
      appBar: AppBarTwo(title: AppTags.assesment),
      backgroundColor: colorGaryBG,
      bottomNavigationBar: CommonButton(
        paddingHorizontal: 7,
        cornersRadius: 10,
        text: AppTags.add,
        onPressed: () {
          for (int i = 0; i < data.types.length; i++) {
            assessTypeData.add({
                "typeId": data.types[i].id,
                "assessType": assessTypeController[i].text,
                "assessCode": codeController[i].text,
                "assessMaxMarks": maxMarksController[i].text,
                "assessPassPercent": passPercentController[i].text
            });
          }
          callApiSaveAssessment();
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
        if (data == null || data.isBlank == true) {
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
                          hintText: 'Assessment Name',
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
                          children: List.generate(data.types.length, (index) {
                            return assignmentCard(data.types[index], index);
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
                                _ensureSlotController(data.types.length);
                                data.types.add(AssessmentTypeModel());
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
        );
      }),
    );
  }

  Widget assignmentCard(AssessmentTypeModel a, int index) {
    assessTypeController[index].text = a.name;
    codeController[index].text = a.code;
    maxMarksController[index].text = a.maximumMarks;
    passPercentController[index].text = a.passPercentage;
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
