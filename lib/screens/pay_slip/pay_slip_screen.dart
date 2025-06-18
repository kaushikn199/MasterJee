import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:masterjee/constants.dart';
import 'package:masterjee/models/pay_slip/pay_slip_response.dart';
import 'package:masterjee/others/StorageHelper.dart';
import 'package:masterjee/providers/pay_slip_api.dart';
import 'package:masterjee/widgets/app_bar_two.dart';
import 'package:masterjee/widgets/app_tags.dart';
import 'package:masterjee/widgets/text.dart';
import 'package:provider/provider.dart';

class PaySlipScreen extends StatefulWidget {
  const PaySlipScreen({super.key});
  static const routeName = 'paySlipScreen';

  @override
  State<PaySlipScreen> createState() => _PaySlipScreenState();
}

class _PaySlipScreenState extends State<PaySlipScreen> {

  var _isLoading = true;
  late List<PaySlipData> paySlipList = [];

  @override
  void initState() {
    callApiAllPayslip();
    super.initState();
  }

  Future<void> callApiAllPayslip() async {
    try {
      PaySlipResponse data =
      await Provider.of<PaySlipApi>(context, listen: false).getAllPayslip(
          StorageHelper.getStringData(StorageHelper.userIdKey).toString());
      if (data.result ?? false) {
        setState(() {
          paySlipList = data.data ?? [];
          _isLoading = false;
        });
        return;
      }else{
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
            if (paySlipList.isEmpty) {
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
                  itemCount: paySlipList.length,
                  padding: EdgeInsets.only(top: 10.sp),
                  itemBuilder: (BuildContext context, int index) {
                    return assignmentCard(paySlipList[index]);
                  }),
            );
          }),

        ],
      ),
    );
  }


  Widget assignmentCard(PaySlipData data) {
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
                rowValue("Month", formatMMMMYYYYDate(data.paymentDate ?? "")),
                gap(10.sp),
                rowValue("Amount ", data.basic),
                gap(10.sp),
                rowValue("Status ", data.status),
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
