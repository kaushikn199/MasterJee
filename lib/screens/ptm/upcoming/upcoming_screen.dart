import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:masterjee/constants.dart';
import 'package:masterjee/models/ptm/get_ptm_List_response.dart';
import 'package:masterjee/others/StorageHelper.dart';
import 'package:masterjee/providers/ptm_api.dart';
import 'package:masterjee/widgets/app_bar_two.dart';
import 'package:masterjee/widgets/app_tags.dart';
import 'package:masterjee/widgets/text.dart';
import 'package:provider/provider.dart';

class UpcomingScreen extends StatefulWidget {
  const UpcomingScreen({super.key});

  static String routeName = 'UpcomingScreen';

  @override
  State<UpcomingScreen> createState() => _UpcomingScreenState();
}

class _UpcomingScreenState extends State<UpcomingScreen> {

  var _isLoading = false;
  List<PTMData> ptmList = [];


  @override
  void initState() {
    callApiGetPtmList();
    super.initState();
  }

  Future<void> callApiGetPtmList() async {
    setState(() {
      _isLoading = true;
    });
    try {
      PtmListResponse data = await Provider.of<PtmApi>(context, listen: false)
          .getPtmList(
          StorageHelper.getStringData(StorageHelper.userIdKey).toString());
      if (data.result) {
        setState(() {
          ptmList =
              data.data.where((ptm) => ptm.ptmTitle.trim().isNotEmpty).toList();
          _isLoading = false;
        });
        return;
      } else {
        setState(() {
          _isLoading = false;
        });
      }
    } catch (error) {
      print("callApiGetPtmList : $error");
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarTwo(title: AppTags.upcoming),
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
            if (ptmList.isEmpty) {
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
                  itemCount: ptmList.length,
                  padding: EdgeInsets.only(top: 10.sp),
                  itemBuilder: (BuildContext context, int index) {
                    return assignmentCard(ptmList[index], false);
                  }),
            );
          }),

        ],
      ),
    );
  }

  Widget assignmentCard(PTMData ptmData, bool isClosed) {
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
            padding: EdgeInsets.all(10.sp),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    CommonText.bold(ptmData.ptmTitle, size: 14.sp, color: kDarkGreyColor, overflow: TextOverflow.fade),
                    CommonText.regular(ptmData.fromDate, size: 10.sp, color: kDarkGreyColor, overflow: TextOverflow.fade),
                  ],
                ),
                gap(10.00),
                CommonText.medium(ptmData.remark,
                    size: 11.sp, color: kDarkGreyColor, overflow: TextOverflow.fade),
                gap(10.0),
                ptmData.schedule.isNotEmpty ? Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Expanded(child: CommonText.bold('Student ', size: 13.sp, color: kDarkGreyColor, overflow: TextOverflow.fade)),
                Expanded(child: CommonText.bold('Slot', size: 13.sp, color: kDarkGreyColor, overflow: TextOverflow.fade)),
              ],
            ) : const SizedBox(),
                ListView.builder(
                    physics: const NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    itemCount: ptmData.schedule.length,
                    itemBuilder: (BuildContext context, int index) {
                      return studentList(ptmData.schedule[index]);
                    }),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget studentList(Schedule data) {
    return Container(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.only(top: 5,bottom: 5),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Expanded(child: CommonText.medium('${data.admissionNo} - ${data.firstname} ${data.lastname}', size: 12.sp, color: kDarkGreyColor, overflow: TextOverflow.fade)),
                Expanded(child: CommonText.medium('${data.timeFrom} To ${data.timeTo}', size: 12.sp, color: kDarkGreyColor, overflow: TextOverflow.fade)),
              ],
            ),
          ),
        ],
      ),
    );
  }



}
