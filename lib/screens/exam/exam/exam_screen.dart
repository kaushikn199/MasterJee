import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get_utils/src/extensions/widget_extensions.dart';
import 'package:masterjee/constants.dart';
import 'package:masterjee/screens/exam/exam/add_score_screen.dart';
import 'package:masterjee/screens/exam/exam/add_subject_screen.dart';
import 'package:masterjee/widgets/CommonButton.dart';
import 'package:masterjee/widgets/app_tags.dart';
import 'package:masterjee/widgets/text.dart';

class ExamScreen extends StatefulWidget {
  const ExamScreen({super.key});

  static String routeName = 'examScreen';

  @override
  State<ExamScreen> createState() => _ExamScreenState();
}

class _ExamScreenState extends State<ExamScreen> {
  var _isLoading = false;
  late List<int> followupList = [0, 1, 2, 3, 4, 5, 6, 7, 8];

  @override
  Widget build(BuildContext context) {
    if (_isLoading) {
      return SizedBox(
        height: MediaQuery.of(context).size.height * .5,
        child: const Center(
          child: CircularProgressIndicator(),
        ),
      );
    }
    if (followupList.isEmpty) {
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
    return Container(
      height: double.infinity,
      color: kBackgroundColor,
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 10.sp),
        child: ListView.builder(
            shrinkWrap: true,
            itemCount: followupList.length,
            padding: EdgeInsets.only(top: 10.sp),
            itemBuilder: (BuildContext c, int index) {
              int data = followupList[index];
              return InkWell(
                  onTap: () {
                    //Navigator.push(context);
                  },
                  child: leadsCard(data, context));
            }),
      ),
    );
  }

  Widget leadsCard(int data, BuildContext context) {
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
          Padding(
            padding: EdgeInsets.all(10.sp),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Flexible(
                      child: Container(
                        decoration: const BoxDecoration(
                            borderRadius: BorderRadius.all(Radius.circular(5)),
                            color: colorGaryText),
                        child: CommonText.regular(
                                "Chapter Wise Weekly Test(Februar-2024)",
                                size: 10.sp,
                                color: Colors.white,
                                overflow: TextOverflow.fade)
                            .paddingOnly(left: 5, right: 5, bottom: 2, top: 2),
                      ),
                    ),
                    gap(10.w),
                    Container(
                      decoration: const BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(5)),
                          color: colorGaryText),
                      child: CommonText.regular("Term 1",
                              size: 10.sp,
                              color: Colors.white,
                              overflow: TextOverflow.fade)
                          .paddingOnly(left: 5, right: 5, bottom: 2, top: 2),
                    ),
                  ],
                ),
                SizedBox(
                  height: 5.h,
                ),
                CommonText.medium("Chapter Wise Weekly Test",
                    size: 13.sp,
                    color: Colors.black,
                    overflow: TextOverflow.fade),
                gap(15.0),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    InkWell(
                      onTap: () {
                        showCustomStudentDialog();
                      },
                      child: SvgPicture.asset(
                        colorFilter: const ColorFilter.mode(
                          Colors.black,
                          BlendMode.srcIn,
                        ),
                        AssetsUtils.tag,
                        width: 15.sp,
                        height: 15.sp,
                      ).paddingAll(10),
                    ),
                    InkWell(
                      onTap: () {
                        Navigator.of(context).pushNamed(AddSubjectScreen.routeName);
                      },
                      child: SvgPicture.asset(
                        colorFilter: const ColorFilter.mode(
                          Colors.black,
                          BlendMode.srcIn,
                        ),
                        AssetsUtils.book,
                        width: 15.sp,
                        height: 15.sp,
                      ).paddingAll(10),
                    ),
                    InkWell(
                      onTap: () {
                        showCustomSubjectDialog();
                      },
                      child: SvgPicture.asset(
                        colorFilter: const ColorFilter.mode(
                          Colors.black,
                          BlendMode.srcIn,
                        ),
                        AssetsUtils.news,
                        width: 15.sp,
                        height: 15.sp,
                      ).paddingAll(10),
                    ),
                    InkWell(
                      onTap: () {

                      },
                      child: SvgPicture.asset(
                        colorFilter: const ColorFilter.mode(
                          Colors.black,
                          BlendMode.srcIn,
                        ),
                        AssetsUtils.calendar,
                        width: 15.sp,
                        height: 15.sp,
                      ).paddingAll(10),
                    ),
                    InkWell(
                      onTap: () {},
                      child: SvgPicture.asset(
                        colorFilter: const ColorFilter.mode(
                          Colors.black,
                          BlendMode.srcIn,
                        ),
                        AssetsUtils.newspaper,
                        width: 15.sp,
                        height: 15.sp,
                      ).paddingAll(10),
                    ),
                    InkWell(
                      onTap: () {},
                      child: SvgPicture.asset(
                        colorFilter: const ColorFilter.mode(
                          Colors.black,
                          BlendMode.srcIn,
                        ),
                        AssetsUtils.delete,
                        width: 15.sp,
                        height: 15.sp,
                      ).paddingAll(10),
                    )
                  ],
                )
              ],
            ),
          ),
        ],
      ),
    );
  }

  rowValue(String key, value) {
    return Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
      SizedBox(
          width: 80.sp,
          child: CommonText.regular(key, size: 12.sp, color: Colors.black)),
      const Expanded(child: SizedBox()),
      CommonText.regular(value,
          size: 12.sp, color: Colors.black, overflow: TextOverflow.fade),
    ]);
  }

  List<Map<String, dynamic>> items = [
    {'id': 1, 'name': '918772 Aishwarya', 'isChecked': false},
    {'id': 2, 'name': '78299 Dhanashree', 'isChecked': false},
    {'id': 3, 'name': '12365 Eshwar L', 'isChecked': false},
  ];

  List<Map<String, dynamic>> items1 = [
    {'date': "2024-02-16", 'name': 'business management', 'isChecked': false},
    {'date': "	2024-02-05", 'name': 'Science', 'isChecked': false},
  ];

  bool _isChecked = true;

  void showCustomStudentDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          insetPadding: EdgeInsets.zero,
          child: LayoutBuilder(
            builder: (context, constraints) {
              return Container(
                width: MediaQuery.of(context).size.width - 30.sp,
                padding: const EdgeInsets.all(16),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Checkbox(
                              value: _isChecked,
                              onChanged: (bool? value) {
                                setState(() {
                                  _isChecked = value ?? false;
                                });
                              },
                              checkColor: Colors.white,
                              activeColor: Colors.green,
                            ),
                            CommonText.bold(
                              'All',
                              size: 14.sp,
                              color: colorBlack,
                              overflow: TextOverflow.fade,
                            ),
                          ],
                        ),
                        gap(50.w),
                        CommonText.bold('Student',
                            size: 14.sp,
                            color: colorBlack,
                            overflow: TextOverflow.fade),
                      ],
                    ),
                    ListView.builder(
                        shrinkWrap: true,
                        itemCount: items.length,
                        itemBuilder: (BuildContext context, int index) {
                          return InkWell(
                              onTap: () {
                                //Navigator.push(context);
                              },
                              child: studentRow(items[index])
                          );
                        }),
                    gap(50.w),
                    CommonButton(
                      cornersRadius: 30,
                      text: AppTags.add,
                      onPressed: () {
                        setState(() {
                        });
                      },
                    ).paddingOnly(left: 15,right: 15,bottom: 10) ,
                  ],
                ),
              );
            },
          ),
        );
      },
    );
  }

  Widget studentRow(Map<String, dynamic> data){
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        gap(8.0),
        Transform.scale(
          scale: 0.85,
          child: Checkbox(
            value: _isChecked,
            onChanged: (bool? value) {
              setState(() {
                _isChecked = value ?? false;
              });
            },
            checkColor: Colors.white,
            activeColor: Colors.green,
            materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
            visualDensity: VisualDensity.compact,
          ),
        ),
        const SizedBox(width: 80,height: 0,),
        CommonText.medium(
          data['name'],
          size: 14.sp,
          color: colorBlack,
          overflow: TextOverflow.fade,
        ),
      ],
    );
  }

  void showCustomSubjectDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          insetPadding: EdgeInsets.zero,
          child: LayoutBuilder(
            builder: (context, constraints) {
              return Container(
                width: MediaQuery.of(context).size.width - 30.sp,
                padding: const EdgeInsets.only(left: 16,right: 16,top: 16,bottom: 25),
                child: ListView.builder(
                    shrinkWrap: true,
                    itemCount: items1.length,
                    itemBuilder: (BuildContext context, int index) {
                      return InkWell(
                          onTap: () {
                            //Navigator.push(context);
                          },
                          child: subjectRow(items1[index],context)
                      );
                    }),
              );
            },
          ),
        );
      },
    );
  }

  Widget subjectRow(Map<String, dynamic> data,BuildContext c){
    return InkWell(
      onTap: () {
        Navigator.of(c).pop();
        Navigator.of(context).pushNamed(AddScoreScreen.routeName);
      },
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Flexible(
            fit: FlexFit.tight,
            flex: 1,
            child: CommonText.medium(
              data["name"],
              size: 14.sp,
              color: colorBlack,
              overflow: TextOverflow.fade,
            ),
          ),
          CommonText.medium(
            data["date"],
            size: 14.sp,
            color: colorBlack,
            overflow: TextOverflow.fade,
          ),
          gap(10.0),
          SvgPicture.asset(
            colorFilter: const ColorFilter.mode(
              Colors.black,
              BlendMode.srcIn,
            ),
            AssetsUtils.news,
            width: 15.sp,
            height: 15.sp,
          )
        ],
      ).paddingOnly(top: 10),
    );
  }

}