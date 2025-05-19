import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:masterjee/constants.dart';
import 'package:masterjee/models/student_behavior/student_behavior_response.dart';
import 'package:masterjee/models/student_behaviour_rank/student_behaviour_rank_response.dart';
import 'package:masterjee/others/StorageHelper.dart';
import 'package:masterjee/providers/student_behavior_api.dart';
import 'package:masterjee/screens/student_behaviour/view_screen.dart';
import 'package:masterjee/widgets/app_bar_two.dart';
import 'package:masterjee/widgets/app_tags.dart';
import 'package:masterjee/widgets/text.dart';
import 'package:provider/provider.dart';

class BehaviourScreen extends StatefulWidget {
  const BehaviourScreen({super.key});

  static String routeName = 'BehaviourScreen';

  @override
  State<BehaviourScreen> createState() => _BehaviourScreenState();
}

class _BehaviourScreenState extends State<BehaviourScreen> {

  var _isLoading = false;
  late List<StudentBehaviorRankData> studentBehaviorList = [];

  @override
  void initState() {
    callApiStudentBehaviour();
    super.initState();
  }

  Future<void> callApiStudentBehaviour() async {
    setState(() {
      _isLoading = true;
    });
    try {
      StudentBehaviourRankResponse data = await Provider.of<StudentBehaviorApi>(context,
          listen: false).studentBehaviourRank(
          StorageHelper.getStringData(StorageHelper.userIdKey).toString(),
          StorageHelper.getStringData(StorageHelper.classIdKey).toString(),
          StorageHelper.getStringData(StorageHelper.sectionIdKey).toString());
      if (data.result ?? false) {
        setState(() {
          studentBehaviorList = data.data ?? [];
          _isLoading = false;
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
      appBar: AppBarTwo(title: AppTags.behaviour),
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
            if (studentBehaviorList.isEmpty) {
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
                  itemCount: studentBehaviorList.length,
                  padding: EdgeInsets.only(top: 10.sp),
                  itemBuilder: (BuildContext context, int index) {
                    return InkWell(child: assignmentCard(studentBehaviorList[index]),
                    onTap: () {
                      Navigator.pushNamed(context,
                          ViewScreen.routeName ,
                          arguments:studentBehaviorList[index].sInfo?.id);
                    },);
                  }),
            );
          }),

        ],
      ),
    );
  }

  Widget assignmentCard(StudentBehaviorRankData data) {
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
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.all(15.sp),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CommonText.semiBold(
                    "${data.sInfo?.admissionNo} - ${data.sInfo?.firstname} ${data.sInfo?.lastname}",
                    size: 12.sp,
                    color: kDarkGreyColor,
                    overflow: TextOverflow.fade),
                gap(10.0),
                rowValue("Points  ",": ${data.points}"),
                gap(5.0),
                rowValue("Rank  ",": ${data.rank}"),

              ],
            ),
          ),
        ],
      ),
    );
  }

  rowValue(String key, value) {
    return Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
      SizedBox(width: 50,child: CommonText.medium(key, size: 12.sp, color: Colors.black),),
      CommonText.medium(value, size: 14.sp, color: kDarkGreyColor, overflow: TextOverflow.fade),
    ]);
  }

}
