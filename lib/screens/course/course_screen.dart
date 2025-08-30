import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get_utils/src/extensions/widget_extensions.dart';
import 'package:masterjee/constants.dart';
import 'package:masterjee/models/common_functions.dart';
import 'package:masterjee/models/course/course_model.dart';
import 'package:masterjee/others/StorageHelper.dart';
import 'package:masterjee/providers/course_api.dart';
import 'package:masterjee/screens/assesment/assesment_screen.dart';
import 'package:masterjee/screens/course/reports_screen.dart';
import 'package:masterjee/screens/exam/assessment/assesment_screen.dart';
import 'package:masterjee/screens/exam/exam/exam_screen.dart';
import 'package:masterjee/screens/exam/grades/grades_screen.dart';
import 'package:masterjee/screens/exam/observation/observation_screen.dart';
import 'package:masterjee/screens/exam/schedule/schedule_screen.dart';
import 'package:masterjee/widgets/CommonButton.dart';
import 'package:masterjee/widgets/app_bar_two.dart';
import 'package:masterjee/widgets/app_tags.dart';
import 'package:masterjee/widgets/custom_form_field.dart';
import 'package:masterjee/widgets/text.dart';
import 'package:provider/provider.dart';

import 'course_list.dart';

class CourseMainScreen extends StatefulWidget {
  const CourseMainScreen({super.key});

  static String routeName = 'courseMainScreen';


  @override
  State<CourseMainScreen> createState() => _CourseMainScreenState();
}

class _CourseMainScreenState extends State<CourseMainScreen> with WidgetsBindingObserver, SingleTickerProviderStateMixin{

  bool _isLoading = false;
  List<int> contentData = [];
  int selectedIndex = 0;

  @override
  void initState() {
    super.initState();
  }

  late var categoryNameController = TextEditingController();

  Future<void> callApiSaveCategory(BuildContext cnt) async {
     setState(() {
      _isLoading = true;
    });
    try {
      SuccessData data = await Provider.of<CourseApi>(context, listen: false)
          .saveCategory(
        StorageHelper.getStringData(StorageHelper.userIdKey).toString(),
        categoryNameController.text,
      );
      if (data.status == "success") {
        setState(() {
          _isLoading = false;
          categoryNameController.text = "";
          Navigator.pop(cnt);
          CommonFunctions.showSuccessToast(data.message??"");
        });
        return;
      } else {
        setState(() {
          _isLoading = false;
          CommonFunctions.showWarningToast(data.message??"Something went wrong");
        });
      }
    } catch (error) {
      print("callApi_error : $error");
      /*setState(() {
        _isLoading = false;
      });*/
    }
  }


  void showCategoryDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          insetPadding: EdgeInsets.zero,
          child: LayoutBuilder(
            builder: (context, constraints) {
              return Container(
                decoration: BoxDecoration(
                  color: kBackgroundColor, // background color
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(
                    color: Colors.transparent,
                    width: 0,
                  ),
                ),
                width: MediaQuery.of(context).size.width - 30.sp,
                padding: const EdgeInsets.all(16),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    CustomTextField(
                      borderRadius: 5,
                      hintText: 'Category',
                      isReadonly: false,
                      controller: categoryNameController,
                      keyboardType: TextInputType.name,
                      onSave: (value) {
                        categoryNameController.text = value as String;
                      },
                    ),
                    CustomTextField(
                      borderRadius: 5,
                      hintText: 'Category',
                      isReadonly: false,
                      controller: categoryNameController,
                      keyboardType: TextInputType.name,
                      onSave: (value) {
                        categoryNameController.text = value as String;
                      },
                    ),
                    gap(10.0),
                    _isLoading ? const CircularProgressIndicator():
                    CommonButton(
                      cornersRadius: 30,
                      text: AppTags.add,
                      onPressed: () {
                        setState(() {
                          callApiSaveCategory(context);
                        });
                      },
                    ).paddingOnly(left: 15,right: 15,bottom: 10) ,
                  ],
                ),
              );
            },
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBarTwo(title: AppTags.course),
        body: Container(
          color: kBackgroundColor,
          child: Builder(builder: (context) {
            return Stack(
              children: [
                Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          InkWell(
                            onTap: () {
                              showCategoryDialog();
                            },
                            child: Container(
                              decoration: BoxDecoration(
                                color: colorGreen,
                                border: Border.all(color: colorGreen, width: 1),
                                // Border color and width
                                borderRadius: BorderRadius.circular(20), // Rounded corners
                              ),
                              child: const CommonText.medium("Category",
                                  size: 13, color: colorWhite)
                                  .paddingOnly(top: 5, bottom: 5, left: 30, right: 30),
                            ),
                          ).paddingOnly(left: 20,bottom: 10),
                          InkWell(
                            onTap: () {
                              Navigator.pushNamed(context, CourseReportsScreen.routeName);
                            },
                            child: Container(
                              decoration: BoxDecoration(
                                color: colorGreen,
                                border: Border.all(color: colorGreen, width: 1),
                                // Border color and width
                                borderRadius: BorderRadius.circular(20), // Rounded corners
                              ),
                              child: const CommonText.medium("Reports",
                                  size: 13, color: colorWhite)
                                  .paddingOnly(top: 5, bottom: 5, left: 30, right: 30),
                            ),
                          ).paddingOnly(left: 20,bottom: 10),
                        ],
                      ),
                      const Expanded(
                        child: CourseListScreen(),
                      ),
                    ]),
              ],
            );
          }),
        ));
  }
}
