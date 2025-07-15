import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get/get_utils/src/extensions/widget_extensions.dart';
import 'package:masterjee/constants.dart';
import 'package:masterjee/models/class_timetable/add_lesson_plan_response.dart';
import 'package:masterjee/models/common_functions.dart';
import 'package:masterjee/models/exam/ObservationResponse.dart';
import 'package:masterjee/models/exam/observation/ObservationInfoResponse.dart';
import 'package:masterjee/others/StorageHelper.dart';
import 'package:masterjee/providers/exam_api.dart';
import 'package:masterjee/widgets/CommonButton.dart';
import 'package:masterjee/widgets/app_bar_two.dart';
import 'package:masterjee/widgets/app_tags.dart';
import 'package:masterjee/widgets/custom_form_field.dart';
import 'package:masterjee/widgets/text.dart';
import 'package:provider/provider.dart';

class EditUpdateObservationScreen extends StatefulWidget {
  const EditUpdateObservationScreen({super.key});

  static String routeName = 'editUpdateObservationScreen';

  @override
  State<EditUpdateObservationScreen> createState() => _EditUpdateObservationScreenState();
}

class _EditUpdateObservationScreenState extends State<EditUpdateObservationScreen> {

  bool _isInitialized = false;
  late ObservationModel observationModel;
  late List<ObservationParamModel> paramsList;
  var _isLoading = false;

  late List<Parameter> parameterList;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (!_isInitialized) {
      observationModel = ModalRoute.of(context)!.settings.arguments as ObservationModel ;
      if (observationModel != null && observationModel.id != null) {
        callApiAllObservationInfo();
        observationNameController.text = observationModel.name;
        descriptionController.text = observationModel.description;
        selectParameterController = [];
        maxMarkController = [];
        paramsList = observationModel.params;
        _ensureSlotController(paramsList.length);
      }
      _isInitialized = true;
    }
  }

  late List<TextEditingController> selectParameterController = [];
  late List<TextEditingController> maxMarkController = [];

  Future<void> callApiAllObservationInfo() async {
    setState(() {
      _isLoading = true;
    });
    try {
      ObservationInfoResponse data =
      await Provider.of<ExamApi>(context, listen: false).observationInfo(
          StorageHelper.getStringData(StorageHelper.userIdKey).toString(),
          observationModel.id);
      if (data.result) {
        setState(() {
          parameterList = data.data.parameters ?? [];
          _isLoading = false;


        });
        return;
      } else {
        setState(() {
          _isLoading = false;
        });
      }
    } catch (error) {
      setState(() {
        print("callApiAllObservationInfo_error : $error");
        _isLoading = false;
      });
    }
  }

  final scaffoldKey = GlobalKey<ScaffoldState>();
  GlobalKey<FormState> globalFormKey = GlobalKey<FormState>();

  late var observationNameController = TextEditingController();
  late var descriptionController = TextEditingController();

  //List<int> resultData = [1];



  void _ensureSlotController(int index) {
    while (selectParameterController.length <= index) {
      selectParameterController.add(TextEditingController());
      maxMarkController.add(TextEditingController());
    }
  }
  List<Lesson> lessonsMainList = [];
  int _indexLesson = 0;

  List<Map<String, String>> parametersData = [];

  Future<void> callApiSaveAssessment() async {
    setState(() {
      _isLoading = true;
    });
    try {
      ObservationInfoResponse data =
      await Provider.of<ExamApi>(context, listen: false).saveObservation(
          StorageHelper.getStringData(StorageHelper.userIdKey).toString(),
        observationModel.id,
        observationNameController.text,
        descriptionController.text,
        parametersData,
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
  void initState() {
    //_ensureSlotController(0);
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarTwo(title: AppTags.observation),
      backgroundColor: colorGaryBG,
      bottomNavigationBar: CommonButton(
        paddingHorizontal: 7,
        cornersRadius: 10,
        text: AppTags.add,
        onPressed: () {
          for (int i = 0; i < paramsList.length; i++) {
           // if(paramsList[i].selectedParamId != null) {
              parametersData.add({
                "prmvlId": paramsList[i].pvid , //observationInfo - parameters - id
                "paramId": paramsList[i].cbseObservationParameterId?? "0", //allObservation - params - id
                "paramMaxMarks": maxMarkController[i].text
              });
           // }
          }
          print(jsonEncode(parametersData));

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
        if (observationModel == null || observationModel.isBlank == true) {
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
                        children: List.generate(paramsList.length, (index) {
                          return assignmentCard(paramsList[index], index);
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
                              _ensureSlotController(paramsList.length + 1);
                              paramsList.add(ObservationParamModel());


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

  Widget assignmentCard(ObservationParamModel a, int index) {
    maxMarkController[index].text = a.maximumMarks.toString();
  //  paramsList[index].selectedParam = paramsList[index].pname ?? "";
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
            child:
            DropdownButton(
              hint: const CommonText('Select parameter',
                  size: 14, color: Colors.black54),
              value:  parameterList.any((e) => e.name == paramsList[index].selectedParam)
    ? paramsList[index].selectedParam
        : null,
              icon: const Card(
                elevation: 0.1,
                color: colorWhite,
                child: Icon(Icons.keyboard_arrow_down_outlined),
              ),
              underline: const SizedBox(),
              onChanged: (value) {
                setState(() {
                  //observationModel.params[index].selectedParam = null;
                  paramsList[index].selectedParam = value;
                  print("selectedParam :  ${paramsList[index].selectedParam}");
                });
              },
              isExpanded: true,
              items: parameterList.map((cd) {
                return DropdownMenuItem(
                  value: cd.name,
                  onTap: () {
                    setState(() {
                    //  _selectedLesson = cd.name;
                     // observationModel.params[index].selectedParam = null;
                      paramsList[index].selectedParam = cd.name;
                      paramsList[index].cbseObservationParameterId = cd.id;
                      print("id : ${cd.id}");
                      print("name : ${cd.name}");
                      print("description : ${cd.description}");
                      print("createdAt : ${cd.createdAt}");
                      /*for (int i = 0; i < parameterList.length; i++) {
                        if (parameterList[i].id == cd.id) {
                          _indexLesson = i;
                          //_selectedTopic = null;
                          //_selectedLessonId = lessonsMainList[i].id;
                          break;
                        }
                      }*/
                      print("selectedParam_0 :  ${paramsList[index].selectedParam}");
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
