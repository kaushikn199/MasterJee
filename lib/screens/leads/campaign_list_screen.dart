import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:masterjee/constants.dart';
import 'package:masterjee/widgets/app_bar_two.dart';
import 'package:masterjee/widgets/text.dart';

class CampaignListScreen extends StatefulWidget {
  const CampaignListScreen({super.key});

  @override
  State<CampaignListScreen> createState() => _CampaignListScreenState();
}

class _CampaignListScreenState extends State<CampaignListScreen> {

  var _isLoading = false;
  List<int> resultData = [1,2,3,4,5,6,7,8];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(50.sp)),
        backgroundColor: colorGreen,
        onPressed: () {
         // _showBottomSheet(context, false);
        },
        child: const Icon(Icons.add, color: Colors.white, size: 28),
      ),
      body: Builder(builder: (context) {
        if (_isLoading) {
          return SizedBox(
            height: MediaQuery.of(context).size.height * .5,
            child: const Center(
              child: CircularProgressIndicator(),
            ),
          );
        }

        return Container(
                     color: kBackgroundColor,

          child: Stack(
            children: [
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 10.sp),
                child: ListView.builder(
                    shrinkWrap: true,
                    itemCount: resultData.length,
                    padding: EdgeInsets.only(top: 10.sp),
                    itemBuilder: (BuildContext context, int index) {
                      return Container(
                        margin: EdgeInsets.all(10.sp),
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
                            Container(
                              width: double.maxFinite,
                              padding: EdgeInsets.symmetric(horizontal: 10.sp, vertical: 10.sp),
                              decoration: BoxDecoration(
                                  borderRadius:
                                  BorderRadius.only(topRight: Radius.circular(10.r), topLeft: Radius.circular(10.r)),
                                  color: kToastTextColor),
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    "My camp",
                                    style: TextStyle(
                                      fontSize: 14.sp,
                                      fontWeight: FontWeight.w700,
                                    ),
                                  ),

                                ],
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.all(14.sp),
                              child: Column(
                                children: [
                                  Row(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      Expanded(
                                        child: Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            rowValue(
                                                "Date",
                                                "12/02/2024"),
                                            gap(5.sp),
                                            rowValue(
                                                "Join user",
                                                "02"),
                                          ],
                                        ),
                                      ),
                                      gap(5.sp),
                                      /*Column(
                                        crossAxisAlignment: CrossAxisAlignment.end,
                                        children: [
                                          Container(
                                              padding: EdgeInsets.symmetric(vertical: 4.sp, horizontal: 8.sp),
                                              decoration: BoxDecoration(
                                                  color: colorGreen,
                                                  borderRadius: BorderRadius.all(Radius.circular(4.r))),
                                              child: CommonText.semiBold(
                                                   "Approved",
                                                  color: Colors.white,
                                                  size: 12.sp)),
                                        ],
                                      ),*/
                                    ],
                                  ),
                                  gap(5.sp),
                                  //rowValue("Reason",  "not well"),
                                ],
                              ),
                            ),
                          ],
                        ),
                      );
                    }),
              ),
            ],
          ),
        );
      }),
    );
  }

  rowValue(String key, value) {
    return Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
      SizedBox(width: 80.sp, child: CommonText.medium(key, size: 14.sp, color: Colors.black)),
      SizedBox(width: 20.w),
      CommonText.medium(value, size: 14.sp, color: kDarkGreyColor, overflow: TextOverflow.fade),
    ]);
  }

}
