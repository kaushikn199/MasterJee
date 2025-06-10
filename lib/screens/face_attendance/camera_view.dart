import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_mlkit_face_detection/google_mlkit_face_detection.dart';
import 'package:image_picker/image_picker.dart';
import 'package:masterjee/widgets/text.dart';
import 'package:permission_handler/permission_handler.dart';

import '../../constants.dart';

class CameraView extends StatefulWidget {
  const CameraView(
      {Key? key, required this.onImage, required this.onInputImage})
      : super(key: key);

  final Function(Uint8List image) onImage;
  final Function(InputImage inputImage) onInputImage;

  @override
  State<CameraView> createState() => _CameraViewState();
}

class _CameraViewState extends State<CameraView> {
  File? _image;
  ImagePicker? _imagePicker;

  @override
  void initState() {
    super.initState();
    _imagePicker = ImagePicker();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SizedBox(height: 0.025.sh),
        _image != null
            ? CircleAvatar(
                radius: 0.15.sh,
                backgroundColor: colorGreen,
                backgroundImage: FileImage(_image!),
              )
            : CircleAvatar(
                radius: 0.15.sh,
                backgroundColor: colorGreen,
                child: Icon(
                  Icons.camera_alt,
                  size: 0.09.sh,
                  color: const Color(0xff2E2E2E),
                ),
              ),
        GestureDetector(
          onTap: _getImage,
          child: Container(
            width: 60,
            height: 60,
            margin: const EdgeInsets.only(top: 44, bottom: 20),
            decoration: const BoxDecoration(
              gradient: RadialGradient(
                stops: [0.4, 0.5, 1],
                colors: [
                  scaffoldTopGradientClr,
                  colorGreen,
                  scaffoldTopGradientClr,
                ],
              ),
              shape: BoxShape.circle,
            ),
          ),
        ),
        Text(
          "Click here to capture face",
          style: TextStyle(
            fontSize: 14,
            color: Colors.black87.withOpacity(0.6),
          ),
        ),
      ],
    );
  }

  Future _getImage() async {
    await Permission.camera.request();
    setState(() {
      _image = null;
    });
    final pickedFile = await _imagePicker?.pickImage(
      source: ImageSource.camera,
      maxWidth: 400,
      maxHeight: 400,
      // imageQuality: 50,
    );
    if (pickedFile != null) {
      _setPickedFile(pickedFile);
    }
    setState(() {});
  }

  Future _setPickedFile(XFile? pickedFile) async {
    final path = pickedFile?.path;
    if (path == null) {
      return;
    }
    setState(() {
      _image = File(path);
    });

    Uint8List imageBytes = _image!.readAsBytesSync();
    widget.onImage(imageBytes);

    InputImage inputImage = InputImage.fromFilePath(path);
    widget.onInputImage(inputImage);
  }
}

class MultiCameraView extends StatefulWidget {
  MultiCameraView({Key? key, required this.onImage, this.isLoading = false})
      : super(key: key);

  final Function(Uint8List image, InputImage inputImage) onImage;
  bool isLoading;

  @override
  State<MultiCameraView> createState() => _MultiCameraViewState();
}

class _MultiCameraViewState extends State<MultiCameraView> {
  File? _image;
  ImagePicker? _imagePicker;

  @override
  void initState() {
    super.initState();
    _imagePicker = ImagePicker();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        GestureDetector(
          onTap: _getImage,
          child: _image != null
              ? CircleAvatar(
                  radius: 0.15.sh,
                  backgroundColor: colorGreen,
                  backgroundImage: FileImage(_image!),
                )
              : CircleAvatar(
                  radius: 0.15.sh,
                  backgroundColor: colorGreen,
                  child: CommonText.regular(
                    "Add \nFace",
                    size: 12.sp,
                    color: const Color(0xff2E2E2E),
                  ),
                ),
        ),
        if (widget.isLoading)
          Center(
            child: SizedBox(
              height: 0.15.sh,
              width: 0.15.sh,
              child: CircularProgressIndicator(
                color: colorGreen,
                strokeWidth: 5.sp,
              ),
            ),
          ),
      ],
    );
  }

  Future _getImage() async {
    await Permission.camera.request();
    setState(() {
      _image = null;
    });
    final pickedFile = await _imagePicker?.pickImage(
      source: ImageSource.camera,
      maxWidth: 400,
      maxHeight: 400,
      // imageQuality: 50,
    );
    if (pickedFile != null) {
      _setPickedFile(pickedFile);
    }
    setState(() {});
  }

  Future _setPickedFile(XFile? pickedFile) async {
    final path = pickedFile?.path;
    if (path == null) {
      return;
    }
    setState(() {
      _image = File(path);
    });

    Uint8List imageBytes = _image!.readAsBytesSync();

    InputImage inputImage = InputImage.fromFilePath(path);
    widget.onImage(imageBytes, inputImage);
  }
}
