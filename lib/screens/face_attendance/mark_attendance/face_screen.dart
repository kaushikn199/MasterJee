import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:masterjee/screens/face_attendance/camera_view.dart';
import 'package:masterjee/screens/face_attendance/mark_attendance/face_controller.dart';
import 'package:masterjee/screens/face_attendance/mark_attendance/multi_face_screen.dart';
import 'package:masterjee/screens/face_attendance/scanning_animation/animated_view.dart';
import 'package:masterjee/widgets/CommonButton.dart';
import 'package:masterjee/widgets/app_bar_two.dart';
import 'package:masterjee/widgets/app_tags.dart';

class AuthenticateFaceView extends StatelessWidget {
  AuthenticateFaceView({super.key});

  final faceController = Get.put(FaceController());

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      top: false,
      child: Scaffold(
        appBar: AppBarTwo(title: AppTags.faceAuthScreenTitle),
        body: LayoutBuilder(
          builder: (context, constrains) => Container(
            width: double.infinity,
            decoration: const BoxDecoration(
              color: Colors.white,
            ),
            child: Obx(() {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Stack(
                    children: [
                      Padding(
                        padding: EdgeInsets.only(left: faceController.isMatching.value ? 0.17.sw : 0),
                        child: CameraView(
                            onImage: (image) {
                              faceController.setImage(image);
                            },
                            onInputImage: faceController.onInputImage),
                      ),
                      if (faceController.isMatching.value)
                        Align(
                          alignment: Alignment.center,
                          child: Padding(
                            padding: EdgeInsets.only(top: 20.sp),
                            child: const AnimatedView(),
                          ),
                        ),
                    ],
                  ),
                  const Spacer(),
                  if (!faceController.canAuthenticate.value)
                    CommonButton(
                      text: "Mark Multiple Face",
                      onPressed: () {
                        Get.to(AuthenticateMultiFaceView());
                      },
                    ),
                  if (faceController.canAuthenticate.value)
                    CommonButton(
                      text: "Mark Attendance",
                      onPressed: () {
                        faceController.fetchUsersAndMatchFace();
                      },
                    ),
                  SizedBox(height: 10.sp),
                ],
              );
            }),
          ),
        ),
      ),
    );
  }
}
