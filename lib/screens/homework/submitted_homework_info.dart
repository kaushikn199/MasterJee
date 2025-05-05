import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get_utils/src/extensions/widget_extensions.dart';
import 'package:masterjee/constants.dart';
import 'package:masterjee/models/common_functions.dart';
import 'package:masterjee/models/homework_list/HomeworkListResponse.dart';
import 'package:masterjee/models/submitted_homework_info/submitted_homework_info.dart';
import 'package:masterjee/others/StorageHelper.dart';
import 'package:masterjee/providers/homework_api.dart';
import 'package:masterjee/widgets/CommonButton.dart';
import 'package:masterjee/widgets/app_bar_two.dart';
import 'package:masterjee/widgets/app_tags.dart';
import 'package:masterjee/widgets/custom_form_field.dart';
import 'package:masterjee/widgets/text.dart';
import 'package:provider/provider.dart';

class SubmittedHomeworkInfoScreen extends StatefulWidget {
  const SubmittedHomeworkInfoScreen({super.key});

  static String routeName = 'submittedHomeworkInfoScreen';

  @override
  State<SubmittedHomeworkInfoScreen> createState() =>
      _SubmittedHomeworkInfoScreenState();
}

class _SubmittedHomeworkInfoScreenState extends State<SubmittedHomeworkInfoScreen> {

  var _isLoading = true;
  late List<SubmittedHomeworkData> homeworkList = [];
  HomeworkData homeworkData = HomeworkData();

  Future<void> callApiSubmittedHomeworkInfo(String homeworkId) async {
    setState(() {
      _isLoading = true;
    });
    try {
      SubmittedHomeworkResponse data = await Provider.of<HomeworkApi>(context,
              listen: false)
          .getSubmittedHomeworkInfo(
              StorageHelper.getStringData(StorageHelper.userIdKey).toString(),
              homeworkId);
      if (data.result) {
        setState(() {
          homeworkList = data.data;
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
        _isLoading = false;
      });
    }
  }

  bool _isInitialized = false;

  Future<void> callApiSaveHomeworkScore(BuildContext context, String homeworkId,String studentId) async {
    setState(() {
      _isLoading = true;
    });
    try {
      SubmittedHomeworkResponse data = await Provider.of<HomeworkApi>(this.context,
              listen: false)
          .saveHomeworkScore(
              StorageHelper.getStringData(StorageHelper.userIdKey).toString(),
          homeworkId,
          studentId,
          _fromScoreController.text,
          _fromNoteController.text);
      if (data.result) {
        setState(() {
          _isLoading = false;
          _fromScoreController.text = '';
          _fromNoteController.text = '';
          Navigator.pop(context);
          callApiSubmittedHomeworkInfo(homeworkData.hwid!);
        });
        return;
      } else {
        setState(() {
          _isLoading = false;
        });
      }
    } catch (error) {
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (!_isInitialized) {
      homeworkData = ModalRoute.of(context)!.settings.arguments as HomeworkData;
      if (homeworkData.hwid != null) {
        callApiSubmittedHomeworkInfo(homeworkData.hwid!);
      }
      _isInitialized = true;
    }
  }

  final _fromScoreController = TextEditingController();
  final _fromNoteController = TextEditingController();

  Widget addScoreDialog(BuildContext context,SubmittedHomeworkData data) {
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
                gap(10.0),
                CommonText.semiBold('Evaluate homework',
                    size: 14.sp,
                    color: colorBlueText,
                    overflow: TextOverflow.fade),
                gap(20.0),
                CustomTextField(
                  keyboardType: TextInputType.number,
                  borderRadius: 10.0,
                  onTap: () {},
                  hintText: 'Enter Score',
                  isRequired: true,
                  validate: (value) {
                    if (value!.isEmpty) {
                      return 'Please enter score';
                    }
                    return null;
                  },
                  isReadonly: false,
                  controller: _fromScoreController,
                  onSave: (value) {
                    // _authData['email'] = value.toString();
                    _fromScoreController.text = value as String;
                  },
                ),
                gap(15.0),
                CustomTextField(
                  keyboardType: TextInputType.text,
                  borderRadius: 10.0,
                  onTap: () {},
                  hintText: 'Enter note',
                  isRequired: true,
                  validate: (value) {
                    if (value!.isEmpty) {
                      return 'Please enter note';
                    }
                    return null;
                  },
                  isReadonly: false,
                  controller: _fromNoteController,
                  onSave: (value) {
                    _fromNoteController.text = value as String;
                  },
                ),
                gap(20.0),
                CommonButton(
                  cornersRadius: 30,
                  text: AppTags.submit,
                  onPressed: () {
                    if (_fromScoreController.text == "") {
                      CommonFunctions.showWarningToast("Please enter score");
                    } else if (_fromNoteController.text == "") {
                      CommonFunctions.showWarningToast("Please enter note");
                    } else {
                      callApiSaveHomeworkScore(context,data.homeworkId ?? '',data.studentId ?? '');
                    }
                  },
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget viewDialog(BuildContext context,SubmittedHomeworkData data) {
    var widthSize = MediaQuery.of(context).size.width;
    var heightSize = MediaQuery.of(context).size.height * 0.50.sp;
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
            height: heightSize,
            child: Column(
              children: [
                gap(10.0),
                CommonText.semiBold('Homework detail',
                    size: 14.sp,
                    color: colorBlueText,
                    overflow: TextOverflow.fade),
                gap(20.0),
                Expanded(
                  child: ListView(
                    children: [
                      Column(
                        mainAxisSize: MainAxisSize.min,
                        children: <Widget>[
                          CommonText.medium(data.message ?? '',
                              size: 12.sp,
                              color: colorBlueText,
                              overflow: TextOverflow.fade),
                        ],
                      ),
                    ],
                  ),
                ),
                gap(20.0),
                CommonButton(
                  cornersRadius: 30,
                  text: "Download file",
                  onPressed: () {
                  },
                ),
              ],
            ),
          );
        },
      ),
    );
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarTwo(title: "Submitted Homework"),
      body: Container(
        color: Colors.white,
        child: Stack(
          children: [
            Builder(builder: (context) {
              if (homeworkList.isEmpty) {
                return Center(
                  child: SizedBox(
                    height: MediaQuery.of(context).size.height * .5,
                    child: const Center(
                      child: CircularProgressIndicator(),
                    ),
                  ),
                );
              }
              if (homeworkList.isEmpty) {
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
              return Padding(
                padding: EdgeInsets.symmetric(horizontal: 10.sp),
                child: ListView.builder(
                    shrinkWrap: true,
                    itemCount: homeworkList.length,
                    padding: EdgeInsets.only(top: 10.sp),
                    itemBuilder: (BuildContext context, int index) {
                      return contentCard(index, context);
                    }),
              );
            })
          ],
        ),
      ),
    );
  }

  Widget contentCard(int index, BuildContext context) {
    return InkWell(
      onTap: () {
        //Navigator.pushNamed(context, HomeworkScreen.routeName);
      },
      child: Container(
        margin: const EdgeInsets.only(bottom: 15),
        padding: EdgeInsets.all(10.sp),
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
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            rowValue("Student ",
                "${homeworkList[index].firstname ?? ""} ${homeworkList[index].lastname ?? ""}"),
            rowValue("Score", homeworkList[index].evlMarks ?? '-'),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                InkWell(
                  onTap: () {
                    showDialog(
                      context: context,
                      builder: (ctx) => viewDialog(context,homeworkList[index]),
                    );
                  },
                  child: CommonText.medium("View",
                          size: 12.sp,
                          decoration: TextDecoration.underline,
                          color: colorGreen,
                          overflow: TextOverflow.fade)
                      .paddingOnly(right: 80, left: 10, top: 10, bottom: 10),
                ),
                InkWell(
                  onTap: () {
                    _fromScoreController.text = '';
                    _fromNoteController.text = '';
                    showDialog(
                      context: context,
                      builder: (ctx) => addScoreDialog(context,homeworkList[index]),
                    );
                  },
                  child: CommonText.medium("Evaluate",
                          size: 12.sp,
                          decoration: TextDecoration.underline,
                          color: colorGreen,
                          overflow: TextOverflow.fade)
                      .paddingOnly(left: 10, right: 40, top: 10, bottom: 10),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}

rowValue(String key, value) {
  return Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
    SizedBox(
        width: 100.sp,
        child: CommonText.medium(key, size: 12.sp, color: Colors.black)),
    SizedBox(width: 20.w),
    CommonText.medium(value,
        size: 12.sp, color: kDarkGreyColor, overflow: TextOverflow.fade),
  ]);
}
