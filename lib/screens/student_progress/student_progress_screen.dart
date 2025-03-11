import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get/get_common/get_reset.dart';
import 'package:masterjee/constants.dart';
import 'package:masterjee/screens/student_progress/marksheet_screen.dart';
import 'package:masterjee/screens/student_progress/overall_screen.dart';
import 'package:masterjee/widgets/app_bar_two.dart';
import 'package:masterjee/widgets/app_tags.dart';
import 'package:masterjee/widgets/text.dart';

class StudentProgressScreen extends StatefulWidget {
  const StudentProgressScreen({super.key});

  static String routeName = 'StudentProgressScreen';

  @override
  State<StudentProgressScreen> createState() => _StudentProgressScreenState();
}

class _StudentProgressScreenState extends State<StudentProgressScreen> {

  var _isLoading = false;
  List<String> resultData = [AppTags.overall.toString(), AppTags.markSheet.toString()];

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarTwo(title: AppTags.studentProgress),
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
            if (resultData.isEmpty) {
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
              padding: EdgeInsets.symmetric(horizontal: 10.sp,vertical: 10.sp),
              child: ListView.builder(
                  shrinkWrap: true,
                  itemCount: resultData.length,
                  padding: EdgeInsets.only(top: 10.sp),
                  itemBuilder: (BuildContext context, int index) {
                    return InkWell(splashColor: Colors.transparent,
                    child: assignmentCard(resultData[index], false).paddingOnly(top: 5,bottom: 10),onTap: () {
                      if(resultData[index] == AppTags.overall){
                        print(AppTags.overall);
                        Navigator.pushNamed(context,OverallScreen.routeName);
                      }else if(resultData[index] == AppTags.markSheet){
                        Navigator.pushNamed(context,MarkSheetScreen.routeName);
                      }
                    },);
                  }),
            );
          }),

        ],
      ),
    );
  }


  Widget assignmentCard(String value, bool isClosed) {
    return Container(
      decoration: BoxDecoration(
        color: kSecondBackgroundColor,
        borderRadius: BorderRadius.circular(7.r),
        boxShadow: const [
          BoxShadow(
            color: Colors.grey,
            spreadRadius: -2.0,
            blurRadius: 4.0,
          ),
        ],
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.only(left: 15.sp,right: 15.sp,top: 10.sp,bottom: 10.sp),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CommonText.semiBold(value, size: 14.sp, color: colorBlack, overflow: TextOverflow.fade,textAlign: TextAlign.start,),
              ],
            ),
          ),
        ],
      ),
    );
  }

}
