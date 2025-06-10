import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';
import 'dart:ui' as ui;

import 'package:flutter/material.dart';
import 'package:flutter_face_api/face_api.dart' as regula;
import 'package:get/get.dart';
import 'package:google_mlkit_face_detection/google_mlkit_face_detection.dart';
import 'package:image/image.dart' as img;
import 'package:image_picker/image_picker.dart';
import 'package:location/location.dart';
import 'package:masterjee/models/common_functions.dart';
import 'package:masterjee/models/user_model.dart';
import 'package:masterjee/models/users_info.dart';
import 'package:masterjee/others/StorageHelper.dart';
import 'package:masterjee/providers/attendance_api.dart';
import 'package:masterjee/screens/face_attendance/extract_view.dart';
import 'package:masterjee/widgets/app_loader.dart';
import 'package:permission_handler/permission_handler.dart'as p;

class MultiFaceController extends GetxController {
  final FaceDetector faceDetector = FaceDetector(
    options: FaceDetectorOptions(
      enableLandmarks: true,
      performanceMode: FaceDetectorMode.accurate,
    ),
  );

  // FaceFeatures? faceFeatures;
  RxList<FaceFeatures> faceFeaturesList = <FaceFeatures>[].obs;
  RxList<Uint8List> imageList = <Uint8List>[].obs;
  var image1 = regula.MatchFacesImage();
  var image2 = regula.MatchFacesImage();
  String similarity = "";
  RxBool canAuthenticate = false.obs;
  List<UserModel> usersInfo = [];
  List<dynamic> usersList = [];
  RxBool userExists = false.obs;
  RxBool isMatching = false.obs;
  RxBool multiAt = false.obs;
  RxBool isStaff = false.obs;
  RxBool isLoading = false.obs;
  RxInt trialNumber = 1.obs;
  var arguments = Get.arguments;
  RxString staffId = "".obs;
  RxString classId = "".obs;
  RxString sectionId = "".obs;
  RxString sessionId = "".obs;
  Rx<UsersListModel> userData = UsersListModel().obs;
  Rx<UserModel> matchedUser = UserModel().obs;
  Rx<File>? imageFile;
  RxList<Face> faces = <Face>[].obs;
  Rx<ui.Image>? image;

  @override
  void onInit() {
    imageFile = null;
    faces.clear();
    image = null;
    imageList.clear();
    faceFeaturesList.clear();
    staffId(StorageHelper.getStringData(StorageHelper.userIdKey).toString());
    classId(StorageHelper.getStringData(StorageHelper.classIdKey).toString());
    sectionId(StorageHelper.getStringData(StorageHelper.sectionIdKey).toString());
    sessionId(StorageHelper.getStringData(StorageHelper.sessionIdKey).toString());
    super.onInit();
  }

  clearData() {
    imageFile = null;
    faces.clear();
    image = null;
    imageList.clear();
    faceFeaturesList.clear();
  }

  Future faceAttendance(int id, bool isStudent) async {
    isMatching(true);
    Map<String, dynamic> data = {"id": id};
    if (isStudent) {
      data = {"id": id, "belong_to": "student"};
    }
    await ClassAttendanceApi.markFaceAttendance(data).then((value) {
      isMatching(false);
      if (value.status != "success") {
        CommonFunctions.showWarningToast("Something went wrong.");
      } else {
        Get.back();
        CommonFunctions.showSuccessToast("Attendance marked successfully");
      }
    });
  }

  Future checkLocation() async {
    Location location = Location();
    PermissionStatus permission;
    permission = await location.hasPermission();
    if (permission == PermissionStatus.denied) {
      permission = await location.requestPermission();
      if (permission == PermissionStatus.denied) {
        return Future.error('Location permissions are denied');
      }
    }
    if (userData.value.geoInfo != null && userData.value.geoInfo!.lat != null) {
      isMatching(true);
      LocationData position = await location.getLocation();
      isMatching(false);
      LocationPoint location1 = LocationPoint(position.latitude!, position.longitude!);
      LocationPoint location2 =
          LocationPoint(double.parse(userData.value.geoInfo!.lat), double.parse(userData.value.geoInfo!.lng));
      double distance = calculateDistance(location1, location2);
      if (distance <= 100) {
        faceAttendance(int.parse(matchedUser.value.id.toString()), false);
      } else {
        isMatching(false);
        CommonFunctions.showWarningToast("your location not matched with school location");
      }
    } else {
      faceAttendance(int.parse(matchedUser.value.id.toString()), false);
    }
  }

  onInputImage() async {}

  Future markAtt() async {
    faceFeaturesList.clear();
    imageList.clear();
    for (var element in faces) {
      await extractFaceFeaturesFromList(element).then((value) {
        if (value != null) {
          faceFeaturesList.add(value);
        }
      });
      await extractFaceBytes(element).then((value) {
        if (value != null) {
          imageList.add(value);
        }
      });
    }
    fetchUsersAndMatchFaceOneByOne();
  }

  loadImage(bool isCamera) async {
    try {
      isLoading(true);
      await p.Permission.camera.request();
      var file = await ImagePicker().pickImage(source: isCamera ? ImageSource.camera : ImageSource.gallery);
      final InputImage inputImage = InputImage.fromFile(File(file!.path));
      final List<Face> faceList = await faceDetector.processImage(inputImage);
      imageFile = File(file.path).obs;
      faces(faceList);
      final data = await File(file.path).readAsBytes();
      await decodeImageFromList(data).then((value) {
        image = value.obs;
      });
      isLoading(false);
    } catch (e) {
      isLoading(false);
      CommonFunctions.showWarningToast("Something went wrong try again");
    }
  }

  Future<Uint8List?> extractFaceBytes(Face face) async {
    Uint8List bytes = imageFile!.value.readAsBytesSync();
    final image = img.decodeImage(bytes);
    if (image == null) {
      return null;
    }
    final faceRect = face.boundingBox;
    final faceImage = img.copyCrop(
      image,
      x: faceRect.left.toInt(),
      y: faceRect.top.toInt(),
      width: faceRect.width.toInt(),
      height: faceRect.height.toInt(),
    );
    return Uint8List.fromList(img.encodePng(faceImage));
  }

  matchFaces(Uint8List imageToAuthenticate) async {
    bool faceMatched = false;
    for (List user in usersList) {
      image1.bitmap = (user.first as UserModel).image;
      image1.imageType = regula.ImageType.PRINTED;
      image2.bitmap = base64Encode(imageToAuthenticate);
      image2.imageType = regula.ImageType.PRINTED;
      //Face comparing logic.
      var request = regula.MatchFacesRequest();
      request.images = [image1, image2];
      dynamic value = await regula.FaceSDK.matchFaces(jsonEncode(request));

      var response = regula.MatchFacesResponse.fromJson(json.decode(value));
      dynamic str = await regula.FaceSDK.matchFacesSimilarityThresholdSplit(jsonEncode(response!.results), 0.75);

      var split = regula.MatchFacesSimilarityThresholdSplit.fromJson(json.decode(str));
      similarity =
          split!.matchedFaces.isNotEmpty ? (split.matchedFaces[0]!.similarity! * 100).toStringAsFixed(2) : "error";

      if (similarity != "error" && double.parse(similarity) > 80.00) {
        faceMatched = true;
        matchedUser(user.first);
      } else {
        faceMatched = false;
      }
    }
    if (faceMatched) {
      if (matchedUser.value.id == userData.value.stfInfo!.id) {
        await checkLocation();
      } else {
        await faceAttendance(int.parse(matchedUser.value.id.toString()), true);
      }
    } else {
      CommonFunctions.showWarningToast("Face doesn't match. Please try again.");
    }
  }

  RxInt indexList = 0.obs;

  fetchUsersAndMatchFaceOneByOne() async {
    isMatching(true);
    Map<String, dynamic> data = {
      "staff_id": staffId.value,
      "class_id": classId.value,
      "section_id": sectionId.value,
      "session_id": sessionId.value
    };
    await ClassAttendanceApi.getUsers(data).then((value) {
        isMatching(false);
        AppLoader.dismiss(Get.context!);
        userData(value);
        for (var element in userData.value.stuInfo!) {
          usersInfo.add(
              UserModel(id: element.id, image: element.image, name: element.name, faceFeatures: element.faceFeatures));
        }
        if (userData.value.stfInfo != null) {
          if (userData.value.stfInfo!.faceFeatures != null) {
            usersInfo.add(UserModel(
                id: userData.value.stfInfo!.id,
                image: userData.value.stfInfo!.image,
                name: userData.value.stfInfo!.name,
                faceFeatures: userData.value.stfInfo!.faceFeatures));
          }
        }
    });
    if (usersInfo.isNotEmpty) {
      for (int i = 0; i < imageList.length; i++) {
        await fetchUsersAndMatchFace(faceFeaturesList[i], imageList[i]);
      }
      AppLoader.dismiss(Get.context!);
    } else {
      AppLoader.dismiss(Get.context!);
      CommonFunctions.showWarningToast("No Users Registered, Make sure users are registered first before Authenticating.");
    }
  }

  fetchUsersAndMatchFace(FaceFeatures faceFeatures, Uint8List imageToAuthenticate) async {
    usersList.clear();
    for (var user in usersInfo) {
      double similarity = compareFaces(faceFeatures, user.faceFeatures!);
      if (similarity >= 0.8 && similarity <= 1.5) {
        usersList.add([user, similarity]);
      }
    }
    usersList.sort((a, b) => (((a.last as double) - 1).abs()).compareTo(((b.last as double) - 1).abs()));
    matchFaces(imageToAuthenticate);
  }
}

// class MultiFaceController extends GetxController {
//   final FaceDetector faceDetector = FaceDetector(
//     options: FaceDetectorOptions(
//       enableLandmarks: true,
//       performanceMode: FaceDetectorMode.accurate,
//     ),
//   );
//   // FaceFeatures? faceFeatures;
//   RxList<FaceFeatures> faceFeaturesList = <FaceFeatures>[].obs;
//   RxList<Uint8List> imageList = <Uint8List>[].obs;
//   var image1 = regula.MatchFacesImage();
//   var image2 = regula.MatchFacesImage();
//   String similarity = "";
//   RxBool canAuthenticate = false.obs;
//   List<UserModel> usersInfo = [];
//   List<dynamic> usersList = [];
//   RxBool userExists = false.obs;
//   RxBool isMatching = false.obs;
//   RxBool multiAt = false.obs;
//   RxBool isStaff = false.obs;
//   RxInt trialNumber = 1.obs;
//   var arguments = Get.arguments;
//   RxString staffId = "".obs;
//   RxString classId = "".obs;
//   RxString sectionId = "".obs;
//   RxString sessionId = "".obs;
//   Rx<UsersListModel> userData = UsersListModel().obs;
//   Rx<UserModel> matchedUser = UserModel().obs;
//
//   @override
//   void onInit() {
//     imageList.clear();
//     faceFeaturesList.clear();
//     staffId(Get.arguments[0].toString());
//     classId(Get.arguments[1].toString());
//     sectionId(Get.arguments[2].toString());
//     sessionId(Get.arguments[3].toString());
//     super.onInit();
//   }
//
//   Future faceAttendance(int id, bool isStudent) async {
//     isMatching(true);
//     Map<String, dynamic> data = {"id": id};
//     if (isStudent) {
//       data = {"id": id, "belong_to": "student"};
//     }
//     await Repository.markFaceAttendance(data).then((value) {
//       value.fold((l) {
//         isMatching(false);
//         showFailedMsg(message: l.message, duration: 1);
//       }, (r) {
//         isMatching(false);
//         Get.back();
//         showSuccessMsg(message: "Attendance marked successfully", duration: 1);
//       });
//     });
//   }
//
//   Future checkLocation() async {
//     bool serviceEnabled;
//     LocationPermission permission;
//     serviceEnabled = await Geolocator.isLocationServiceEnabled();
//     if (!serviceEnabled) {
//       return Future.error('Location services are disabled.');
//     }
//     permission = await Geolocator.checkPermission();
//     if (permission == LocationPermission.denied) {
//       permission = await Geolocator.requestPermission();
//       if (permission == LocationPermission.denied) {
//         return Future.error('Location permissions are denied');
//       }
//     }
//     if (userData.value.geoInfo != null && userData.value.geoInfo!.lat != null) {
//       isMatching(true);
//       Position position = await Geolocator.getCurrentPosition(
//           desiredAccuracy: LocationAccuracy.high);
//       isMatching(false);
//
//       Location location1 = Location(position.latitude, position.longitude);
//       Location location2 = Location(double.parse(userData.value.geoInfo!.lat),
//           double.parse(userData.value.geoInfo!.lng));
//       double distance = calculateDistance(location1, location2);
//       if (distance <= 100) {
//         faceAttendance(int.parse(matchedUser.value.id.toString()), false);
//       } else {
//         showFailedMsg(
//             message: "your location not matched with school location");
//       }
//     } else {
//       faceAttendance(int.parse(matchedUser.value.id.toString()), false);
//     }
//   }
//
//   onInputImage(inputImage, int index) async {}
//
//   Future addImage(
//       Uint8List imageToAuthenticate, InputImage inputImage, int index) async {
//     isMatching(true);
//     FaceFeatures? faceFeatures =
//     await extractFaceFeatures(inputImage, faceDetector);
//     isMatching(false);
//     if (faceFeatures == null) {
//       canAuthenticate(false);
//       showFailedMsg(message: "Face not found in image");
//     } else {
//       canAuthenticate(true);
//       imageList.insert(index, imageToAuthenticate);
//       faceFeaturesList.insert(index, faceFeatures);
//     }
//   }
//
//   matchFaces(Uint8List imageToAuthenticate) async {
//     bool faceMatched = false;
//     for (List user in usersList) {
//       image1.bitmap = (user.first as UserModel).image;
//       image1.imageType = regula.ImageType.PRINTED;
//       image2.bitmap = base64Encode(imageToAuthenticate);
//       image2.imageType = regula.ImageType.PRINTED;
//       //Face comparing logic.
//       var request = regula.MatchFacesRequest();
//       request.images = [image1, image2];
//       dynamic value = await regula.FaceSDK.matchFaces(jsonEncode(request));
//
//       var response = regula.MatchFacesResponse.fromJson(json.decode(value));
//       dynamic str = await regula.FaceSDK.matchFacesSimilarityThresholdSplit(
//           jsonEncode(response!.results), 0.75);
//
//       var split =
//       regula.MatchFacesSimilarityThresholdSplit.fromJson(json.decode(str));
//       similarity = split!.matchedFaces.isNotEmpty
//           ? (split.matchedFaces[0]!.similarity! * 100).toStringAsFixed(2)
//           : "error";
//
//       if (similarity != "error" && double.parse(similarity) > 80.00) {
//         faceMatched = true;
//         matchedUser(user.first);
//       } else {
//         faceMatched = false;
//       }
//     }
//     if (faceMatched) {
//       if (matchedUser.value.id == userData.value.stfInfo!.id) {
//         await checkLocation();
//       } else {
//         await faceAttendance(int.parse(matchedUser.value.id.toString()), true);
//       }
//       Get.back();
//     } else {
//       Get.back();
//       showFailedMsg(
//           message: "Face doesn't match. Please try again.", duration: 1);
//     }
//   }
//
//   RxInt indexList = 0.obs;
//   fetchUsersAndMatchFaceOneByOne() async {
//     showLoader(Get.context!);
//     isMatching(true);
//     Map<String, dynamic> data = {
//       "staff_id": staffId.value,
//       "class_id": classId.value,
//       "section_id": sectionId.value,
//       "session_id": sessionId.value
//     };
//     await Repository.getUsers(data).then((value) {
//       value.fold((l) {
//         isMatching(false);
//         Get.back();
//         showFailedMsg(message: l.message);
//       }, (r) {
//         userData(r);
//         for (var element in userData.value.stuInfo!) {
//           usersInfo.add(UserModel(
//               id: element.id,
//               image: element.image,
//               name: element.name,
//               faceFeatures: element.faceFeatures));
//         }
//         if (userData.value.stfInfo != null) {
//           if (userData.value.stfInfo!.faceFeatures != null) {
//             usersInfo.add(UserModel(
//                 id: userData.value.stfInfo!.id,
//                 image: userData.value.stfInfo!.image,
//                 name: userData.value.stfInfo!.name,
//                 faceFeatures: userData.value.stfInfo!.faceFeatures));
//           }
//         }
//       });
//     });
//     if (usersInfo.isNotEmpty) {
//       indexList(0);
//       for (int i = 0; i < imageList.length; i++) {
//         indexList(i + 1);
//         await fetchUsersAndMatchFace(faceFeaturesList[i], imageList[i]);
//       }
//     } else {
//       indexList(0);
//       Get.back();
//       showFailedMsg(
//         message:
//         "No Users Registered, Make sure users are registered first before Authenticating.",
//       );
//     }
//   }
//
//   fetchUsersAndMatchFace(
//       FaceFeatures faceFeatures, Uint8List imageToAuthenticate) async {
//     usersList.clear();
//     for (var user in usersInfo) {
//       double similarity = compareFaces(faceFeatures, user.faceFeatures!);
//       if (similarity >= 0.8 && similarity <= 1.5) {
//         usersList.add([user, similarity]);
//       }
//     }
//     usersList.sort((a, b) => (((a.last as double) - 1).abs())
//         .compareTo(((b.last as double) - 1).abs()));
//     matchFaces(imageToAuthenticate);
//   }
// }
