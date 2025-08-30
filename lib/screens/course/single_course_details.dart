import 'dart:convert';
import 'dart:io';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter/material.dart';
import 'package:masterjee/constants.dart';
import 'package:masterjee/models/common_functions.dart';
import 'package:masterjee/models/course/course_model.dart';
import 'package:masterjee/models/course/single_course_model.dart';
import 'package:masterjee/others/StorageHelper.dart';
import 'package:masterjee/providers/course_api.dart';
import 'package:masterjee/screens/course/section_widget.dart';
import 'package:masterjee/widgets/app_bar_two.dart';
import 'package:masterjee/widgets/app_tags.dart';
import 'package:masterjee/widgets/from_network.dart';
import 'package:masterjee/widgets/from_vimeo_id.dart';
import 'package:masterjee/widgets/from_youtube.dart';
import 'package:masterjee/widgets/text.dart';
import 'package:provider/provider.dart';

class SingleCourseDetailScreen extends StatefulWidget {
  SingleCourseDetailScreen({super.key, required this.course});

  Courses course;

  @override
  // ignore: library_private_types_in_public_api
  _SingleCourseDetailScreenState createState() => _SingleCourseDetailScreenState();
}

class _SingleCourseDetailScreenState extends State<SingleCourseDetailScreen> with SingleTickerProviderStateMixin {
  var _isInit = true;
  var _isLoading = false;
  SingleCourseModule loadedCourseDetail = SingleCourseModule();
  int? selected;
  var _isLoadingRating = false;

  List<String> stringList = [];

  void getData(cntx, {bool isRefresh = false}) {
    if (!_isInit && !isRefresh) return;
    setState(() {
      _isLoading = isRefresh ? false : true;
    });
    Provider.of<CourseApi>(context, listen: false)
        .getSingleMyCourses(StorageHelper.getStringData(StorageHelper.userIdKey).toString(), widget.course.id.toString())
        .then((value) {
      setState(() {
        loadedCourseDetail = value;
        // stringList = loadedCourseDetail.courseDetail!.outcomes != ""
        //     ? jsonDecode(loadedCourseDetail.courseDetail!.outcomes ?? "")
        //     .cast<String>()
        //     : [];
        _isLoading = false;
      });
    });
    setState(() {
      _isInit = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    getData(context);
    return Scaffold(
      appBar: AppBarTwo(title: "Course Details"),
      backgroundColor: kBackgroundColor,
      body: _isLoading
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: Stack(
                      fit: StackFit.loose,
                      alignment: Alignment.center,
                      clipBehavior: Clip.none,
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(12.r),
                          child: Container(
                            alignment: Alignment.center,
                            height: MediaQuery.of(context).size.height / 3.3,
                            decoration: BoxDecoration(
                                color: Colors.white,
                                border: Border.all(color: Colors.grey, width: 0.2.r),
                                borderRadius: BorderRadius.circular(12.r),
                                image: DecorationImage(
                                  fit: BoxFit.cover,
                                  image: NetworkImage(
                                    '${widget.course.courseThumbnail}',
                                  ),
                                )),
                          ),
                        ),
                        ClipOval(
                          child: InkWell(
                            onTap: () {
                              if (widget.course.courseProvider == 'vimeo') {
                                String vimeoVideoId = widget.course.courseUrl!.split('/').last;
                                // _showVimeoModal(context, vimeoVideoId);
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            PlayVideoFromVimeoId(courseId: 0, vimeoVideoId: vimeoVideoId)));
                              } else if (widget.course.courseProvider == 'html5' ||
                                  widget.course.courseProvider == "s3_bucket") {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => PlayVideoFromNetwork(
                                          courseId: 0, videoUrl: widget.course.courseUrl!)),
                                );
                              } else {
                                if (widget.course.courseProvider!.isEmpty) {
                                  CommonFunctions.showSuccessToast('Video url not provided');
                                } else {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => PlayVideoFromYoutube(
                                            courseId: 0, videoUrl: widget.course.courseUrl!),
                                      ));
                                }
                              }
                            },
                            child: widget.course.courseUrl == null ||
                                widget.course.courseUrl == ""
                                ? const SizedBox()
                                : Container(
                                    width: 45,
                                    height: 45,
                                    decoration: const BoxDecoration(
                                      color: Colors.white,
                                      boxShadow: [kDefaultShadow],
                                    ),
                                    child: Padding(
                                      padding: const EdgeInsets.all(5.0),
                                      child: Image.asset(
                                        'assets/images/play.png',
                                        fit: BoxFit.contain,
                                      ),
                                    ),
                                  ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 15),
                    child: RichText(
                      textAlign: TextAlign.left,
                      text: TextSpan(
                        text: loadedCourseDetail.data!.title,
                        style: const TextStyle(fontSize: 20, color: Colors.black),
                      ),
                    ),
                  ),
                  // Padding(
                  //   padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
                  //   child: CustomText(
                  //     text: loadedCourseDetail.data!.description ?? "",
                  //     fontSize: 14,
                  //     fontWeight: FontWeight.w400,
                  //     colors: kTextColor,
                  //   ),
                  // ),
                  Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    padding: EdgeInsets.symmetric(horizontal: 15.sp, vertical: 10.sp),
                    margin: EdgeInsets.all(10.sp),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Expanded(
                              flex: 1,
                              child: CommonText.medium(
                                // '${courseData!.classSection}',
                                "",
                                size: 12.sp,
                                color: Colors.black54,
                              ),
                            ),
                            Row(
                              children: [
                                Icon(
                                  Icons.access_time_filled_sharp,
                                  size: 15.sp,
                                  color: Colors.black54,
                                ),
                                CommonText.medium(
                                  ' 5 hrs',
                                  size: 12.sp,
                                  color: Colors.black54,
                                ),
                              ],
                            ),
                          ],
                        ),
                        gap(10.sp),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            // SizedBox(
                            //   height: 36.sp,
                            //   width: 36.sp,
                            //   child: ClipRRect(
                            //     borderRadius: const BorderRadius.all(
                            //       Radius.circular(100),
                            //     ),
                            //     child: CachedNetworkImage(
                            //       imageUrl: courseData!.instructorImage.toString(),
                            //       placeholder: (context, url) => const CircularProgressIndicator(),
                            //       errorWidget: (context, url, error) => Image.asset(
                            //         AssetsUtils.personImage,
                            //         fit: BoxFit.cover,
                            //       ),
                            //     ),
                            //   ),
                            // ),
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                CommonText.bold(
                                  "${loadedCourseDetail.data!.dataClass}  ",
                                  size: 13.sp,
                                  color: Colors.black54,
                                ),
                              ],
                            ),
                            Padding(
                              padding: EdgeInsets.only(left: 10.sp),
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  CommonText.bold(
                                    "${loadedCourseDetail.data!.teacher!.employeeId}  ",
                                    size: 13.sp,
                                    color: Colors.black54,
                                  ),
                                  CommonText.bold(
                                    "${loadedCourseDetail.data!.teacher!.name}",
                                    size: 13.sp,
                                    color: Colors.black54,
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                        gap(10.sp),
                        CommonText.bold(
                          "Description",
                          size: 13.sp,
                          color: Colors.black54,
                        ),
                        CommonText.medium(widget.course.description ?? "",
                            size: 13.sp, color: Colors.black, overflow: TextOverflow.fade),
                        gap(15.0),
                      ],
                    ),
                  ),
                  SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: <Widget>[
                        // Padding(
                        //   padding: const EdgeInsets.symmetric(horizontal: 10),
                        //   child: Card(
                        //     elevation: 0,
                        //     shape: RoundedRectangleBorder(
                        //       borderRadius: BorderRadius.circular(10),
                        //     ),
                        //     child: Column(
                        //       children: [
                        //         Container(
                        //           width: double.infinity,
                        //           height: 250.sp,
                        //           padding: const EdgeInsets.only(right: 10, left: 10, top: 0, bottom: 10),
                        //           child: TabViewDetails(
                        //             titleText: 'What you will learn',
                        //             listText: stringList,
                        //           ),
                        //         ),
                        //       ],
                        //     ),
                        //   ),
                        // ),
                        const Padding(
                          padding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                          child: CommonText.medium(
                            'Course Curriculum',
                            size: 20,
                            color: kDarkGreyColor,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 15.0),
                          child: ListView.builder(
                            key: Key('builder ${selected.toString()}'),
                            //attention
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            itemCount: loadedCourseDetail.data!.sections!.length,
                            itemBuilder: (ctx, index) {
                              final section = loadedCourseDetail.data!.sections![index];
                              int lessonCount = section.lessons!.length;
                              return Card(
                                elevation: 0.3,
                                child: ExpansionTile(
                                  key: Key(index.toString()),
                                  //attention
                                  initiallyExpanded: true,
                                  shape: const Border(),
                                  onExpansionChanged: ((newState) {
                                    if (newState) {
                                      setState(() {
                                        selected = index;
                                      });
                                    } else {
                                      setState(() {
                                        selected = -1;
                                      });
                                    }
                                  }),
                                  //attention
                                  title: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.symmetric(vertical: 5.0),
                                        child: Row(
                                          children: [
                                            Expanded(
                                              flex: 1,
                                              child: Align(
                                                alignment: Alignment.centerLeft,
                                                child: CommonText.medium(
                                                  section.sectionTitle??"",
                                                  size: 10,
                                                  color: kTimeColor,
                                                ),
                                              ),
                                            ),
                                            const SizedBox(
                                              width: 10.0,
                                            ),
                                            Expanded(
                                              flex: 1,
                                              child: Container(
                                                decoration: BoxDecoration(
                                                  color: kLessonBackColor,
                                                  borderRadius: BorderRadius.circular(3),
                                                ),
                                                padding: const EdgeInsets.symmetric(
                                                  vertical: 5.0,
                                                ),
                                                child: Align(
                                                  alignment: Alignment.center,
                                                  child: Container(
                                                    decoration: BoxDecoration(
                                                      color: kLessonBackColor,
                                                      borderRadius: BorderRadius.circular(3),
                                                    ),
                                                    child: CommonText.medium(
                                                       '$lessonCount Lessons',
                                                      size: 10,
                                                      color: kDarkGreyColor,
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ),
                                            const Expanded(flex: 2, child: Text("")),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                  children: [
                                    ListView.builder(
                                      shrinkWrap: true,
                                      physics: const NeverScrollableScrollPhysics(),
                                      itemBuilder: (ctx, index) {
                                        return SectionListItem(
                                          section: section.lessons![index],
                                          courseId: widget.course.id.toString(),
                                        );
                                      },
                                      itemCount: section.lessons!.length,
                                    ),
                                  ],
                                ),
                              );
                            },
                          ),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
    );
  }
}
