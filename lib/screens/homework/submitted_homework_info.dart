import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:masterjee/constants.dart';
import 'package:masterjee/models/homework_list/HomeworkListResponse.dart';
import 'package:masterjee/models/submitted_homework_info/submitted_homework_info.dart';
import 'package:masterjee/others/StorageHelper.dart';
import 'package:masterjee/providers/homework_api.dart';
import 'package:masterjee/widgets/app_bar_two.dart';
import 'package:masterjee/widgets/text.dart';
import 'package:provider/provider.dart';

class SubmittedHomeworkInfoScreen extends StatefulWidget {
  const SubmittedHomeworkInfoScreen({super.key});

  static String routeName = 'submittedHomeworkInfoScreen';

  @override
  State<SubmittedHomeworkInfoScreen> createState() =>
      _SubmittedHomeworkInfoScreenState();
}

class _SubmittedHomeworkInfoScreenState
    extends State<SubmittedHomeworkInfoScreen> {

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

  @override
  Widget build(BuildContext context) {
   /* homeworkData = ModalRoute.of(context)!.settings.arguments as HomeworkData;
    print("homeworkData : ${homeworkData.hwid}");
    if(homeworkData.hwid != null) {
      callApiSubmittedHomeworkInfo(homeworkData.hwid ?? "");
    }*/
    return Scaffold(
      appBar: AppBarTwo(title: "Submitted HomeWork"),
      body: Container(
        color: Colors.white,
        child: Builder(builder: (context) {
          if (_isLoading) {
            SizedBox(
              height: MediaQuery.of(context).size.height * .5,
              child: const Center(
                child: CircularProgressIndicator(),
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
        }),
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
            rowValue("Student ", "${homeworkList[index].firstname ?? ""} ${homeworkList[index].lastname ?? ""}"),
            rowValue("Score", homeworkList[index].evlMarks ?? '-'),
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
