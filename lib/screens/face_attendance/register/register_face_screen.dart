import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:masterjee/models/user_model.dart';
import 'package:masterjee/screens/face_attendance/camera_view.dart';
import 'package:masterjee/screens/face_attendance/register/register_face_controller.dart';
import 'package:masterjee/screens/face_attendance/scanning_animation/animated_view.dart';
import 'package:masterjee/widgets/CommonButton.dart';
import 'package:masterjee/widgets/app_bar_two.dart';
import 'package:masterjee/widgets/app_tags.dart';

class RegisterFaceScreen extends StatelessWidget {
  RegisterFaceScreen({super.key});

  final faceController = Get.put(RegisterFaceController());

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      top: false,
      child: Scaffold(
        appBar: AppBarTwo(title: AppTags.registerFaceScreenTitle),
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
                  // const CustomAppBar(title: AppTags.registerFaceScreenTitle),
                  Stack(
                    children: [
                      Padding(
                        padding: EdgeInsets.only(
                            left:
                                faceController.isMatching.value ? 0.17.sw : 0),
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
                  if (faceController.canAuthenticate.value)
                    CommonButton(
                      text:"Register Face",
                      onPressed: () {
                        faceController.registerFaceAuth();
                      },
                    ),
                ],
              );
            }),
          ),
        ),
      ),
    );
  }

  double compareFaces(FaceFeatures face1, FaceFeatures face2) {
    double distEar1 = euclideanDistance(face1.rightEar!, face1.leftEar!);
    double distEar2 = euclideanDistance(face2.rightEar!, face2.leftEar!);

    double ratioEar = distEar1 / distEar2;

    double distEye1 = euclideanDistance(face1.rightEye!, face1.leftEye!);
    double distEye2 = euclideanDistance(face2.rightEye!, face2.leftEye!);

    double ratioEye = distEye1 / distEye2;

    double distCheek1 = euclideanDistance(face1.rightCheek!, face1.leftCheek!);
    double distCheek2 = euclideanDistance(face2.rightCheek!, face2.leftCheek!);

    double ratioCheek = distCheek1 / distCheek2;

    double distMouth1 = euclideanDistance(face1.rightMouth!, face1.leftMouth!);
    double distMouth2 = euclideanDistance(face2.rightMouth!, face2.leftMouth!);

    double ratioMouth = distMouth1 / distMouth2;

    double distNoseToMouth1 =
        euclideanDistance(face1.noseBase!, face1.bottomMouth!);
    double distNoseToMouth2 =
        euclideanDistance(face2.noseBase!, face2.bottomMouth!);

    double ratioNoseToMouth = distNoseToMouth1 / distNoseToMouth2;

    double ratio =
        (ratioEye + ratioEar + ratioCheek + ratioMouth + ratioNoseToMouth) / 5;

    return ratio;
  }

// A function to calculate the Euclidean distance between two points
  double euclideanDistance(Points p1, Points p2) {
    final sqr =
        math.sqrt(math.pow((p1.x! - p2.x!), 2) + math.pow((p1.y! - p2.y!), 2));
    return sqr;
  }
}
