import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:masterjee/constants.dart';
import 'package:masterjee/models/student_behaviour_view/BehaviourViewResponse.dart';
import 'package:masterjee/others/StorageHelper.dart';
import 'package:masterjee/providers/student_behavior_api.dart';
import 'package:masterjee/screens/student_behaviour/view_screen.dart';
import 'package:masterjee/widgets/app_bar_two.dart';
import 'package:masterjee/widgets/app_tags.dart';
import 'package:masterjee/widgets/text.dart';
import 'package:provider/provider.dart';

class CommentScreen extends StatefulWidget {
  const CommentScreen({super.key});

  static String routeName = 'CommentScreen';

  @override
  State<CommentScreen> createState() => _CommentScreenState();
}

class _CommentScreenState extends State<CommentScreen> {

  var _isLoading = false;
  late List<IncidentData> incidentList = [];
  late IncidentData incidentData;
  bool _isInitialized = false;

  @override
  void initState() {
    super.initState();
  }

  Future<void> callApiStudentBehaviourView(String studentId) async {
    setState(() {
      _isLoading = true;
    });
    try {
      BehaviourViewResponse data = await Provider.of<StudentBehaviorApi>(context,
          listen: false).studentBehaviourView(
          StorageHelper.getStringData(StorageHelper.userIdKey).toString(),
          studentId);
      if (data.result) {
        setState(() {
          incidentList = data.data.incidentData;
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
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (!_isInitialized) {
      incidentData = ModalRoute.of(context)!.settings.arguments as IncidentData;
      //callApiStudentBehaviourView(incidentData.!);
      _isInitialized = true;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarTwo(title: AppTags.comments),
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
            if (incidentList.isEmpty) {
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
                  itemCount: incidentList.length,
                  padding: EdgeInsets.only(top: 10.sp),
                  itemBuilder: (BuildContext context, int index) {
                    return InkWell(child: assignmentCard(incidentList[index]),
                      onTap: () {
                        Navigator.pushNamed(context,
                            CommentScreen.routeName,
                            arguments: incidentList[index]);
                      },);
                  }),
            );
          }),
        ],
      ),
    );
  }

  Widget assignmentCard(IncidentData data) {
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
                  Expanded(child:
                  CommonText.bold("Raj ${data.point}",
                      size: 14.sp,
                      color: Colors.black)),
                  SizedBox(width: 20.w),
                  CommonText.medium("10-10-2024", size: 12.sp, color: kDarkGreyColor, overflow: TextOverflow.fade),
                ]),
                gap(10.sp),
            CommonText.regular("It’s important to report cases of theft on campus so that the"
                " university or school can increase security where needed. They could also consider "
                "other options to combat incidents of theft, such as lockers.",
                size: 13.sp, color: kDarkGreyColor, overflow: TextOverflow.fade)
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
