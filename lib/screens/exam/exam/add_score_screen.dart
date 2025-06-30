import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get_utils/src/extensions/widget_extensions.dart';
import 'package:masterjee/constants.dart';
import 'package:masterjee/models/dues_report_response/DuesReportResponse.dart';
import 'package:masterjee/widgets/CommonButton.dart';
import 'package:masterjee/widgets/app_bar_two.dart';
import 'package:masterjee/widgets/app_tags.dart';
import 'package:masterjee/widgets/custom_form_field.dart';
import 'package:masterjee/widgets/text.dart';

class AddScoreScreen extends StatefulWidget {
  const AddScoreScreen({super.key});

  static String routeName = 'addScoreScreen';

  @override
  State<AddScoreScreen> createState() => _AddScoreScreenState();
}

class _AddScoreScreenState extends State<AddScoreScreen> {

  var _isLoading = false;
  late List<int> duesReportList = [0,1,2,3];
  late var nameController = TextEditingController();
  late var notesController = TextEditingController();

  late var theoryMarkController = TextEditingController();
  late var practicalMarkController = TextEditingController();
  late var assignmentMarkController = TextEditingController();

  @override
  void initState() {
   nameController.text = "011 - Bhavya J";
    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBarTwo(title: AppTags.addScore),
        backgroundColor: colorGaryBG,
        bottomNavigationBar: CommonButton(
          paddingHorizontal: 7,
          cornersRadius: 10,
          text: AppTags.submit,
          onPressed: () {},
        ).paddingOnly(bottom: 30, left: 10, right: 10),
        body: Stack(
          children: [
            Builder(builder: (context) {
              if (_isLoading) {
                return SizedBox(
                  height: MediaQuery.of(context).size.height * .5,
                  child: const Center(
                    child: CircularProgressIndicator(),
                  ),
                );
              }
              if (duesReportList.isEmpty) {
                return Center(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.hourglass_empty_outlined, size: 100.sp),
                      CommonText.medium('No Record Found', size: 16.sp, color: kDarkGreyColor, overflow: TextOverflow.fade),
                    ],
                  ),
                );
              }
              return Padding(
                padding: EdgeInsets.symmetric(horizontal: 10.sp),
                child: ListView.builder(
                    shrinkWrap: true,
                    itemCount: duesReportList.length,
                    padding: EdgeInsets.only(top: 10.sp),
                    itemBuilder: (BuildContext context, int index) {
                      return assignmentCard(duesReportList[index],index);
                    }),
              );
            })
          ],
        ));
  }

  Widget assignmentCard(int data,int size) {
    return Container(
      margin: EdgeInsets.only(bottom: 20.sp),
      child: Column(
        children: [
          CustomTextField(
            hintText: 'Name',
            isReadonly: true,
            controller: nameController,
            keyboardType: TextInputType.name,
            onSave: (value) {
              nameController.text = value as String;
            },
          ),
          gap(10.0),
          CustomTextField(
            hintText: 'Notes',
            isReadonly: false,
            controller: notesController,
            keyboardType: TextInputType.name,
            onSave: (value) {
              notesController.text = value as String;
            },
          ),
          ListView.builder(
              shrinkWrap: true,
              itemCount: size,
              padding: EdgeInsets.only(top: 10.sp),
              itemBuilder: (BuildContext context, int index) {
                return cart(duesReportList[index]);
              })
        ],
      ),
    );
  }

  Widget cart(int data) {
    return Container(
      margin: EdgeInsets.only(bottom: 10.sp),
      child: Column(
        children: [
          CustomTextField(
            hintText: 'Theory - Max score : 100',
            isReadonly: false,
            controller: theoryMarkController,
            keyboardType: TextInputType.name,
            onSave: (value) {
              theoryMarkController.text = value as String;
            },
          ),
         /* CustomTextField(
            hintText: 'Practical - Max score : 100',
            isReadonly: false,
            controller: practicalMarkController,
            keyboardType: TextInputType.name,
            onSave: (value) {
              practicalMarkController.text = value as String;
            },
          ),
          CustomTextField(
            hintText: 'Assignment - Max score : 75',
            isReadonly: false,
            controller: assignmentMarkController,
            keyboardType: TextInputType.name,
            onSave: (value) {
              assignmentMarkController.text = value as String;
            },
          ),*/
        ],
      ),
    );
  }

}
