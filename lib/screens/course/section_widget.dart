import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:masterjee/constants.dart';
import 'package:masterjee/screens/download_controller/download_controller.dart';
import 'package:masterjee/widgets/from_network.dart';
import 'package:masterjee/widgets/from_vimeo_id.dart';
import 'package:masterjee/widgets/from_youtube.dart';

import '../../models/course/single_course_model.dart';

class SectionListItem extends StatefulWidget {
  final Lesson? section;
  final String courseId;

  const SectionListItem({Key? key, @required this.section, required this.courseId}) : super(key: key);

  @override
  State<SectionListItem> createState() => _SectionListItemState();
}

class _SectionListItemState extends State<SectionListItem> {

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          width: double.infinity,
          padding: const EdgeInsets.symmetric(horizontal: 5.0, vertical: 10),
          child: Row(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 4.0),
                child: Icon(
                  getLessonIcon(widget.section!),
                  size: 14,
                  color: Colors.black45,
                ),
              ),
              Expanded(
                child: Text(getLessonTitle(widget.section ?? null),
                    style: const TextStyle(fontSize: 14, color: Colors.black45)),
              ),
                InkWell(
                  onTap: () {
                    lessonAction(widget.section!);
                  },
                  child: const Row(
                    children: [
                      Icon(
                        Icons.remove_red_eye_outlined,
                        size: 15,
                        color: kDeepBlueColor,
                      ),
                      Text(
                        ' View    ',
                        style: TextStyle(
                          color: kDeepBlueColor,
                        ),
                      ),
                    ],
                  ),
                ),
            ],
          ),
        ),
        Divider(color: Colors.grey, thickness: 0.4.sp),
      ],
    );
  }

  final DownloadFileController downloadController = Get.put(DownloadFileController());

  void lessonAction(Lesson lesson) async {
    if (lesson.lessonType == 'video') {
      print("yes");
      Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => PlayVideoFromYoutube(courseId: 0, lessonId: 0, videoUrl: lesson.videoUrl??""),
          ));
    }else{
      downloadController.requestDownload(lesson.downloadUrl.toString());
    }
  }


IconData getLessonIcon(Lesson? lesson) {
  // print(lessonType);
  if (lesson?.lessonType == 'video') {
    return Icons.play_arrow;
  }  else {
    return Icons.attach_file;
  }
}

String getLessonTitle(Lesson? lesson) {
  // print(lessonType);

  return lesson?.lessonTitle ?? "";
}

}
