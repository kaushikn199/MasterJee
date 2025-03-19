import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:masterjee/constants.dart';
import 'package:masterjee/screens/student_behaviour/comment_screen.dart';
import 'package:masterjee/widgets/CommonButton.dart';
import 'package:masterjee/widgets/app_bar_two.dart';
import 'package:masterjee/widgets/app_tags.dart';
import 'package:masterjee/widgets/text.dart';
import 'package:masterjee/widgets/util.dart';

class ViewScreen extends StatefulWidget {
  const ViewScreen({super.key});

  static String routeName = 'ViewScreen';

  @override
  State<ViewScreen> createState() => _ViewScreenState();
}

class _ViewScreenState extends State<ViewScreen> {

  var _isLoading = false;
  List<int> resultData = [1, 2, 3, 4, 5];
  final commentController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarTwo(title: AppTags.view),
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
              padding: EdgeInsets.symmetric(horizontal: 10.sp),
              child: ListView.builder(
                  shrinkWrap: true,
                  itemCount: resultData.length,
                  padding: EdgeInsets.only(top: 10.sp),
                  itemBuilder: (BuildContext context, int index) {
                    return InkWell(child: assignmentCard(resultData[index], false),
                      onTap: () {
                        Navigator.pushNamed(
                            context, CommentScreen.routeName);
                      },);
                  }),
            );
          }),

        ],
      ),
    );
  }

  Widget assignmentCard(int a, bool isClosed) {
    return Container(
      margin: EdgeInsets.only(bottom: 20.sp),
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
        children: [
          Padding(
            padding: EdgeInsets.all(20.sp),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
                  Expanded( child: CommonText.bold("Theft", size: 14.sp, color: Colors.black)),
                  SizedBox(width: 20.w),
                  CommonText.medium("Point : 10", size: 13.sp, color: kDarkGreyColor, overflow: TextOverflow.fade),
                ]),
                const SizedBox(
                  height: 10,
                ),
                Container(
                  color: colorGaryLine,
                  width: double.infinity,
                  height: 1.h,
                ),
                const SizedBox(
                  height: 10,
                ),
                CommonText.medium(AppTags.clickHereToViewMoreComments,size: 10.sp, color: kDarkGreyColor, overflow: TextOverflow.fade),
                const SizedBox(
                  height: 10,
                ),
                TextFormField(
                  style: const TextStyle(fontSize: 14),
                  keyboardType: TextInputType.name,
                  maxLines: 3,
                  decoration: getInputDecoration(
                    'Write comment here...',
                    null,
                      kSecondBackgroundColor,
                    Colors.white
                  ),
                  validator: (input) {
                    if (input == null){
                      return "Please enter name";
                    }else{
                      return "";
                    }
                  },
                  onSaved: (value) {
                  },
                ),
                const SizedBox(
                  height: 10,
                ),
                SizedBox(
                  width: double.infinity,
                  child: _isLoading
                      ? const Center(child: CircularProgressIndicator())
                      : CommonButton(
                    cornersRadius: 30,
                        text: AppTags.submit,
                        onPressed: () {
                        },
                      ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  rowValue(String key, value) {
    return Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
      Expanded( child: CommonText.medium(key, size: 12.sp, color: Colors.black)),
      SizedBox(width: 20.w),
      CommonText.medium(value, size: 14.sp, color: kDarkGreyColor, overflow: TextOverflow.fade),
    ]);
  }

}
