import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:masterjee/constants.dart';
import 'package:masterjee/models/common_functions.dart';
import 'package:masterjee/models/exam/grades/GradesInfoResponse.dart';
import 'package:masterjee/others/StorageHelper.dart';
import 'package:masterjee/providers/exam_api.dart';
import 'package:masterjee/widgets/CommonButton.dart';
import 'package:masterjee/widgets/app_bar_two.dart';
import 'package:masterjee/widgets/app_tags.dart';
import 'package:masterjee/widgets/custom_form_field.dart';
import 'package:masterjee/widgets/text.dart';
import 'package:provider/provider.dart';

class EditUpdateGradeScreen extends StatefulWidget {
  const EditUpdateGradeScreen({super.key});

  static String routeName = 'editUpdateGradeScreen';

  @override
  State<EditUpdateGradeScreen> createState() => _EditUpdateGradeScreenState();
}

class _EditUpdateGradeScreenState extends State<EditUpdateGradeScreen> {
  final scaffoldKey = GlobalKey<ScaffoldState>();
  GlobalKey<FormState> globalFormKey = GlobalKey<FormState>();

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

  var _isLoading = false;
  ExamGradeData data = ExamGradeData();
  bool _isInitialized = false;
  String gradeId = "";

  List<Map<String, dynamic>> rangesData = [];

  @override
  void didChangeDependencies() {
    if (!_isInitialized) {
      gradeId = ModalRoute.of(context)?.settings.arguments as String? ?? "";
      callApiGradesInfo();
      _isInitialized = true;
    }
    super.didChangeDependencies();
  }

  Future<void> callApiSaveGrade() async {
    setState(() {
      _isLoading = true;
    });
    try {
      GradesInfoResponse data =
          await Provider.of<ExamApi>(context, listen: false).saveGrade(
              StorageHelper.getStringData(StorageHelper.userIdKey).toString(),
              gradeId,
              gradeNameController.text,
              descriptionController.text,
              rangesData);
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

  Future<void> callApiGradesInfo() async {
    setState(() {
      _isLoading = true;
    });
    try {
      GradesInfoResponse response =
          await Provider.of<ExamApi>(context, listen: false).gradesInfo(
              StorageHelper.getStringData(StorageHelper.userIdKey).toString(),
              gradeId);
      if (response.result) {
        setState(() {
          data = response.data ?? ExamGradeData();
          gradeNameController.text = data.name;
          descriptionController.text = data.description;
          _ensureSlotController(data.ranges.length);
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

  @override
  void initState() {
    _ensureSlotController(0);
    super.initState();
  }

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
          for (int i = 0; i < data.ranges.length; i++) {
            rangesData.add({
              "rangeId": data.ranges[i].id,
              "rname": rangeNameController[i].text,
              "rangeMini": minimumPercentageController[i].text,
              "rangeMax": maxPercentageController[i].text,
              "rangeDescription": description2Controller[i].text
            });
          }
          callApiSaveGrade();
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
        if (data.isBlank == true) {
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
                          children: List.generate(data.ranges.length, (index) {
                            return assignmentCard(data.ranges[index], index);
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
                                _ensureSlotController(data.ranges.length);
                                data.ranges.add(GradeRange());
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

  Widget assignmentCard(GradeRange data, int index) {
    rangeNameController[index].text = data.name;
    minimumPercentageController[index].text = data.minimumPercentage;
    maxPercentageController[index].text = data.maximumPercentage;
    description2Controller[index].text = data.description;
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
