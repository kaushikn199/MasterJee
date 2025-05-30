import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:masterjee/constants.dart';
import 'package:masterjee/widgets/text.dart';

class CampaignListScreen extends StatefulWidget {
  const CampaignListScreen({super.key});

  @override
  State<CampaignListScreen> createState() => _CampaignListScreenState();
}

class _CampaignListScreenState extends State<CampaignListScreen> {
  var _isLoading = false;
  List<int> resultData = [1, 2, 3, 4, 5, 6, 7, 8];

  /*Future<void> callApiDuesReport() async {
    try {
      DuesReportResponse data =
      await Provider.of<DuesReport>(context, listen: false).getDuesReport(
          StorageHelper.getStringData(StorageHelper.userIdKey).toString(),
          StorageHelper.getStringData(StorageHelper.classIdKey).toString(),
          StorageHelper.getStringData(StorageHelper.sectionIdKey).toString()
      );
      if (data.result) {
        setState(() {
          duesReportList = data.data;
          _isLoading = false;
        });
        return;
      }else{
        setState(() {
          _isLoading = false;
        });
      }
    } catch (error) {}
  }*/

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
          height: double.infinity,
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
                        margin: EdgeInsets.all(7.sp),
                        decoration: BoxDecoration(
                          color: kSecondBackgroundColor,
                          borderRadius: BorderRadius.circular(7.r),
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
                              padding: const EdgeInsets.all(10.0),
                              child: Row(
                                children: [
                                  Icon(Icons.spatial_audio_off_outlined),
                                  gap(10.0),
                                  CommonText.semiBold("My camp",size: 12.sp),
                                  Expanded(child: SizedBox()),
                                  Icon(Icons.person_rounded),
                                  CommonText.medium("0",size: 12.sp),
                                  gap(10.0),
                                ],
                              ),
                            )
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
      SizedBox(
          width: 80.sp,
          child: CommonText.medium(key, size: 14.sp, color: Colors.black)),
      SizedBox(width: 20.w),
      CommonText.medium(value,
          size: 14.sp, color: kDarkGreyColor, overflow: TextOverflow.fade),
    ]);
  }
}
