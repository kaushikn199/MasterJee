import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:masterjee/constants.dart';
import 'package:masterjee/models/user_leave_applications_info_response/leave_application_list_response.dart';
import 'package:masterjee/others/StorageHelper.dart';
import 'package:masterjee/providers/apply_leave_api.dart';
import 'package:masterjee/widgets/text.dart';
import 'package:provider/provider.dart';

class FaceAuthScreen extends StatefulWidget {
  const FaceAuthScreen({super.key});
  static const routeName = 'faceAuthScreen';

  @override
  State<FaceAuthScreen> createState() => _FaceAuthScreenState();
}

class _FaceAuthScreenState extends State<FaceAuthScreen> {
  late List<Lt> leaveTypeList = [];
  var _isLoading = true;

  @override
  void initState() {
    callAPiUserLeaveApplicationsInfo();
    super.initState();
  }


  Future<void> callAPiUserLeaveApplicationsInfo() async {
    setState(() {
      _isLoading = true;
    });
    try {
      UserLeaveApplicationsInfoResponse data = await Provider.of<ApplyLeaveApi>(
          context,
          listen: false)
          .getUserLeaveApplicationsInfo(
          StorageHelper.getStringData(StorageHelper.userIdKey).toString());
      if (data.data != null) {
        setState(() {
            _isLoading = false;
          leaveTypeList = data.data?.lt ?? [];
        });
        return;
      }else{
        setState(() {
          _isLoading = false;
        });
      }
    } catch (error) {
      setState(() {
        _isLoading = false;
      });
      print("error : ${error}");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
            if (leaveTypeList.isEmpty) {
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
                  itemCount: leaveTypeList.length,
                  padding: EdgeInsets.only(top: 10.sp),
                  itemBuilder: (BuildContext context, int index) {
                    return assignmentCard(leaveTypeList[index]);
                  }),
            );
          }),

        ],
      ),
    );
  }

  Widget assignmentCard(Lt data) {
    return Container(
      margin: EdgeInsets.only(bottom: 10.sp,left: 5,right: 5),
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
                rowValue("Type", data.type.toString()),
                gap(10.sp),
                rowValue("Alloted ", data.allotedLeave.toString()),
                gap(10.sp),
                rowValue("Taken ", data.takenLeave.toString()),
                gap(10.sp),
                rowValue("Remain ", data.pendingLeave.toString()),
              ],
            ),
          ),
        ],
      ),
    );
  }

  rowValue(String key, value) {
    return Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
      SizedBox(width: 100.sp, child: CommonText.medium(key, size: 12.sp, color: Colors.black)),
      SizedBox(width: 20.w),
      CommonText.medium(value, size: 14.sp, color: kDarkGreyColor, overflow: TextOverflow.fade),
    ]);
  }

}
