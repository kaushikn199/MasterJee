import 'dart:ui' as ui;

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_mlkit_face_detection/google_mlkit_face_detection.dart';
import 'package:masterjee/constants.dart';
import 'package:masterjee/widgets/CommonButton.dart';
import 'package:masterjee/widgets/app_bar_two.dart';
import 'package:masterjee/widgets/app_tags.dart';
import 'multi_face_controller.dart';

class AuthenticateMultiFaceView extends StatelessWidget {
  AuthenticateMultiFaceView({super.key});

  final faceController = Get.put(MultiFaceController());

  final FaceDetector faceDetector = FaceDetector(
    options: FaceDetectorOptions(
      enableLandmarks: true,
      performanceMode: FaceDetectorMode.accurate,
    ),
  );

  @override
  Widget build(BuildContext context) {
    faceController.clearData();
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
                  children: [
                    const SizedBox(height: 20),
                    (faceController.faces.isNotEmpty &&
                            faceController.isLoading.isFalse)
                        ? SizedBox(
                            height: 200.sp,
                            width: 200.sp,
                            child: FittedBox(
                              fit: BoxFit.contain,
                              child: SizedBox(
                                width: faceController.image!.value.width
                                    .toDouble(),
                                height: faceController.image!.value.height
                                    .toDouble(),
                                child: CustomPaint(
                                  painter: FacePainter(
                                      faceController.image!.value,
                                      faceController.faces),
                                ),
                              ),
                            ),
                          )
                        : Container(
                            height: 200.sp,
                            width: 200.sp,
                            decoration: BoxDecoration(
                                border: Border.all(
                                  color: colorGreen,
                                  width: 1.sp,
                                ),
                                borderRadius: BorderRadius.circular(10.r)),
                            child: Center(
                              child: Icon(
                                Icons.camera_alt,
                                size: 50.sp,
                                color: const Color(0xff2E2E2E),
                              ),
                            )),
                    const SizedBox(height: 20),
                    Padding(
                      padding: const EdgeInsets.all(30),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          GestureDetector(
                            onTap: () {
                              faceController.loadImage(true);
                            },
                            child: const Icon(
                              Icons.camera_alt,
                              size: 30,
                            ),
                          ),
                          GestureDetector(
                            onTap: () {
                              faceController.loadImage(false);
                            },
                            child: const Icon(
                              Icons.image,
                              size: 30,
                            ),
                          ),
                        ],
                      ),
                    ),
                    const Text("Capture photo from camera or gallery"),
                    const Spacer(),
                    if (faceController.faces.isNotEmpty &&
                        faceController.isLoading.isFalse)
                      CommonButton(
                        cornersRadius: 30,
                        text: "Mark Attendance",
                        onPressed: () {
                faceController.markAtt();
                        },
                      ).paddingOnly(left: 15, right: 15, bottom: 30),
                    const SizedBox(height: 20),
                  ],
                );
              })),
        ),
      ),
    );
  }
}

// paint the face
class FacePainter extends CustomPainter {
  final ui.Image image;
  final List<Face> faces;
  final List<Rect> rects = [];

  FacePainter(this.image, this.faces) {
    for (var i = 0; i < faces.length; i++) {
      rects.add(faces[i].boundingBox);
    }
  }

  @override
  void paint(ui.Canvas canvas, ui.Size size) {
    final Paint paint = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = 3.0
      ..color = Colors.red;

    canvas.drawImage(image, Offset.zero, Paint());
    for (var i = 0; i < faces.length; i++) {
      canvas.drawRect(rects[i], paint);
    }
  }

  @override
  bool shouldRepaint(FacePainter oldDelegate) {
    return image != oldDelegate.image || faces != oldDelegate.faces;
  }
}
