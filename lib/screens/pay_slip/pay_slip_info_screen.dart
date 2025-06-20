import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:masterjee/constants.dart';
import 'package:masterjee/models/pay_slip/pay_slip_info.dart';
import 'package:masterjee/others/StorageHelper.dart';
import 'package:masterjee/providers/pay_slip_api.dart';
import 'package:masterjee/widgets/app_bar_two.dart';
import 'package:masterjee/widgets/app_tags.dart';
import 'package:masterjee/widgets/text.dart';
import 'package:provider/provider.dart';

class PaySlipInfoScreen extends StatefulWidget {
  const PaySlipInfoScreen({super.key});

  static const routeName = 'paySlipInfoScreen';

  @override
  State<PaySlipInfoScreen> createState() => _PaySlipInfoScreenState();
}

class _PaySlipInfoScreenState extends State<PaySlipInfoScreen> {

  var _isLoading = true;
  late List<Allowance> allowancePosList = [];
  late List<Allowance> allowanceNegList = [];
  bool _isInitialized = false;
  String? payslipId;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (!_isInitialized) {
      payslipId = ModalRoute.of(context)!.settings.arguments as String?;
      if (payslipId != null) {
        callApiGetPayslipInfo();
      }
      _isInitialized = true;
    }
  }
  late PaySlipDetails paySlipDetails;
  Future<void> callApiGetPayslipInfo() async {
    setState(() {
      _isLoading = true;
    });
    try {
      PaySlipInfoResponse data =
          await Provider.of<PaySlipApi>(context, listen: false).getPayslipInfo(
              StorageHelper.getStringData(StorageHelper.userIdKey).toString(),
              payslipId!);
      if (data.result) {
        setState(() {
          paySlipDetails = (data.data?.payslipData)!;
          allowancePosList = data.data?.allowancePos ?? [] ;
          allowanceNegList = data.data?.allowanceNeg ?? [] ;
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
      appBar: AppBarTwo(title: AppTags.paySlip),
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
            if (paySlipDetails == null) {
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
              child: ListView(

                children: [
                  gap(20.0),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      CommonText.semiBold("Payslip For The Period Of ${paySlipDetails.month} ${paySlipDetails.year}",
                          size: 14.sp,
                          color: colorBlack,
                          overflow: TextOverflow.fade)
                    ],
                  ),
                  gap(10.0),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      CommonText.regular("Payslip #",
                          size: 12.sp,
                          color: kDarkGreyColor,
                          overflow: TextOverflow.fade),
                      CommonText.regular("Payment Date: ${paySlipDetails.paymentDate}",
                          size: 12.sp,
                          color: kDarkGreyColor,
                          overflow: TextOverflow.fade)
                    ],
                  ),
                  gap(1.0),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      CommonText.regular("Staff id ${paySlipDetails.staffId}",
                          size: 12.sp,
                          color: kDarkGreyColor,
                          overflow: TextOverflow.fade),
                      CommonText.regular("Name ${paySlipDetails.name}",
                          size: 12.sp,
                          color: kDarkGreyColor,
                          overflow: TextOverflow.fade)
                    ],
                  ),
                  gap(1.0),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      CommonText.regular("Designation ${paySlipDetails.designation}",
                          size: 12.sp,
                          color: kDarkGreyColor,
                          overflow: TextOverflow.fade),

                    ],
                  ),
                  gap(10.0),
                  const Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      CommonText.bold(
                          "Earning",
                          size: 14,
                          color: colorBlack),
                      CommonText.bold(
                          "Amount (₹)",
                          size: 14,
                          color: colorBlack),
                    ],
                  ),
                  ListView.builder(
                      physics: NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      itemCount: allowancePosList.length,
                      itemBuilder: (BuildContext context, int index) {
                        return Container(
                          margin: const EdgeInsets.only(left: 1,right: 1,top: 5,bottom: 5),
                          padding: EdgeInsets.all(10.sp),
                          decoration: BoxDecoration(
                            color: kSecondBackgroundColor,
                            borderRadius: BorderRadius.circular(10.r),
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  CommonText.regular(
                                      allowancePosList[index].allowanceType,
                                      size: 14,
                                      color: colorBlack),
                                  CommonText.regular(
                                      allowancePosList[index].amount,
                                      size: 14,
                                      color: colorBlack),
                                ],
                              )

                            ],
                          ),
                        );
                      }),
                  gap(5.0),
                   Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const CommonText.semiBold(
                          "Total",
                          size: 14,
                          color: colorBlack),
                      CommonText.semiBold(
                          "${getTotalAllowanceAmount(allowancePosList)}",
                          size: 14,
                          color: colorBlack),
                    ],
                  ),
                  gap(40.0),
                  const Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      CommonText.bold(
                          "Deduction",
                          size: 14,
                          color: colorBlack),
                      CommonText.bold(
                          "Amount (₹)",
                          size: 14,
                          color: colorBlack),
                    ],
                  ),
                  ListView.builder(
                      physics: const NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      itemCount: allowanceNegList.length,
                      itemBuilder: (BuildContext context, int index) {
                        return Container(
                          margin: const EdgeInsets.only(left: 1,right: 1,top: 5,bottom: 5),
                          padding: EdgeInsets.all(10.sp),
                          decoration: BoxDecoration(
                            color: kSecondBackgroundColor,
                            borderRadius: BorderRadius.circular(10.r),
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  CommonText.regular(
                                      allowanceNegList[index].allowanceType,
                                      size: 14,
                                      color: colorBlack),
                                  CommonText.regular(
                                      allowanceNegList[index].amount,
                                      size: 14,
                                      color: colorBlack),
                                ],
                              )

                            ],
                          ),
                        );
                      }),
                  gap(5.0),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const CommonText.semiBold(
                          "Total",
                          size: 14,
                          color: colorBlack),
                      CommonText.semiBold(
                          "${getTotalAllowanceAmount(allowanceNegList)}",
                          size: 14,
                          color: colorBlack),
                    ],
                  ),
                  gap(40.0),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const CommonText.bold(
                          "Payment Mode",
                          size: 14,
                          color: colorBlack),
                      CommonText.regular(paySlipDetails.paymentMode,
                          size: 14,
                          color: kDarkGreyColor),
                    ],
                  ),
                  gap(10.0),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                       const CommonText.bold(
                          "Transaction/Cheque No.",
                          size: 14,
                          color: colorBlack),
                      CommonText.regular(paySlipDetails.transactionId ?? "",
                          size: 14,
                          color: kDarkGreyColor),
                    ],
                  ),
                  gap(10.0),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const CommonText.bold(
                          "Basic Salary (₹)",
                          size: 14,
                          color: colorBlack),
                      CommonText.regular(paySlipDetails.basicSalary ?? "",
                          size: 14,
                          color: kDarkGreyColor),
                    ],
                  ),
                  gap(10.0),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const CommonText.bold(
                          "Gross Salary (₹)	",
                          size: 14,
                          color: colorBlack),
                      CommonText.regular(paySlipDetails.netSalary ?? "",
                          size: 14,
                          color: kDarkGreyColor),
                    ],
                  ),
                  gap(10.0),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const CommonText.bold(
                          "Net Salary (₹)	",
                          size: 14,
                          color: colorBlack),
                      CommonText.regular(paySlipDetails.netSalary ?? "",
                          size: 14,
                          color: kDarkGreyColor),
                    ],
                  ),
                  gap(50.0),
                ],
              ),
            );
          }),
        ],
      ),
    );
  }

  double getTotalAllowanceAmount(List<Allowance> list) {
    double total = 0;
    for (var item in list) {
      total += double.tryParse(item.amount) ?? 0;
    }
    return total;
  }

}