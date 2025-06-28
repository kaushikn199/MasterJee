import 'package:flutter/material.dart';
import 'package:get/get_utils/src/extensions/widget_extensions.dart';
import 'package:masterjee/constants.dart';
import 'package:masterjee/widgets/CommonButton.dart';
import 'package:masterjee/widgets/app_bar_two.dart';
import 'package:masterjee/widgets/app_tags.dart';

class AddScoreScreen extends StatefulWidget {
  const AddScoreScreen({super.key});

  static String routeName = 'addScoreScreen';


  @override
  State<AddScoreScreen> createState() => _AddScoreScreenState();
}

class _AddScoreScreenState extends State<AddScoreScreen> {
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
      body: SingleChildScrollView(
        child: SizedBox()
      ),
    );
  }
}
