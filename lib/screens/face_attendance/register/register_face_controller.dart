import 'dart:convert';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter_face_api/face_api.dart' as regula;
import 'package:get/get.dart';
import 'package:google_mlkit_face_detection/google_mlkit_face_detection.dart';
import 'package:masterjee/models/common_functions.dart';
import 'package:masterjee/models/user_model.dart';
import 'package:masterjee/models/users_info.dart';
import 'package:masterjee/others/StorageHelper.dart';
import 'package:masterjee/providers/attendance_api.dart';
import 'package:masterjee/screens/face_attendance/extract_view.dart';
import 'package:masterjee/screens/home/main_screen.dart';

class RegisterFaceController extends GetxController {
  final FaceDetector faceDetector = FaceDetector(
    options: FaceDetectorOptions(
      enableLandmarks: true,
      performanceMode: FaceDetectorMode.accurate,
    ),
  );
  FaceFeatures? faceFeatures;
  var image1 = regula.MatchFacesImage();
  var image2 = regula.MatchFacesImage();
  String similarity = "";
  RxBool canAuthenticate = false.obs;
  List<UserModel> usersInfo = [];
  List<dynamic> usersList = [];
  RxBool userExists = false.obs;
  RxBool isMatching = false.obs;
  RxInt trialNumber = 1.obs;
  var arguments = Get.arguments;
  RxString classId = "".obs;
  RxString sectionId = "".obs;
  RxString sessionId = "".obs;
  Rx<UsersListModel> userData = UsersListModel().obs;
  RxString id = "".obs;
  RxString belongTo = "".obs;

  @override
  void onInit() {
    id(StorageHelper.getStringData(StorageHelper.userIdKey).toString());
    belongTo(StorageHelper.getStringData(StorageHelper.userIdKey).toString());
    classId(StorageHelper.getStringData(StorageHelper.classIdKey).toString());
    sectionId(StorageHelper.getStringData(StorageHelper.sectionIdKey).toString());
    sessionId(StorageHelper.getStringData(StorageHelper.sessionIdKey).toString());
    super.onInit();
  }

  Future registerFaceAuth() async {
    isMatching(true);
    Map<String, dynamic> data = {
      "belong_to": belongTo.toString(),
      "id": id.toString(),
      "image": image2.bitmap,
      "face_features": faceFeatures!.toJson()
    };
    await ClassAttendanceApi.registerFace(data).then((value) {
      isMatching(false);
      if (value.status != "success") {
        CommonFunctions.showWarningToast("Something went wrong.");
      } else {
        Get.back();
        Navigator.of(Get.context!).pushAndRemoveUntil(MaterialPageRoute(builder: (context) => const MainScreen()),(v){
          return false;
        });
        // Get.offAll(Routes.homeScreen);
        CommonFunctions.showSuccessToast(value.message ?? "");
      }
    });
  }

  onInputImage(inputImage) async {
    isMatching(true);
    faceFeatures = await extractFaceFeatures(inputImage, faceDetector);
    isMatching(false);
    if (faceFeatures == null) {
      canAuthenticate(false);
      CommonFunctions.showWarningToast("Face not found in image");
    }
  }

  setImage(Uint8List imageToAuthenticate) async {
    image2.bitmap = base64Encode(imageToAuthenticate);
    image2.imageType = regula.ImageType.PRINTED;
    canAuthenticate(true);
  }

  matchFaces() async {
    bool faceMatched = false;
    for (List user in usersList) {
      image1.bitmap = (user.first as UserModel).image;
      image1.imageType = regula.ImageType.PRINTED;

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
      } else {
        faceMatched = false;
      }
    }
    if (faceMatched) {
      CommonFunctions.showWarningToast(
          "You can't add this face to this user because its already registered with another");
    } else {
      registerFaceAuth();
    }
  }

  fetchUsersAndMatchFace() async {
    isMatching(true);
    Map<String, dynamic> data = {
      "staff_id": id.value,
      "class_id": classId.value,
      "section_id": sectionId.value,
      "session_id": sessionId.value
    };
    await ClassAttendanceApi.getUsers(data).then((value) {
      isMatching(false);
      userData(value);
      for (var element in userData.value.stuInfo!) {
        if (element.id != id.toString()) {
          usersInfo.add(
              UserModel(id: element.id, image: element.image, name: element.name, faceFeatures: element.faceFeatures));
        }
      }
      if (userData.value.stfInfo != null) {
        if (userData.value.stfInfo!.id != id.toString()) {
          usersInfo.add(UserModel(
              id: userData.value.stfInfo!.id,
              image: userData.value.stfInfo!.image,
              name: userData.value.stfInfo!.name,
              faceFeatures: userData.value.stfInfo!.faceFeatures));
        }
      }
    });
    if (usersInfo.isNotEmpty) {
      usersList.clear();
      for (var user in usersInfo) {
        double similarity = compareFaces(faceFeatures!, user.faceFeatures!);
        if (similarity >= 0.8 && similarity <= 1.5) {
          usersList.add([user, similarity]);
        }
      }
      usersList.sort((a, b) => (((a.last as double) - 1).abs()).compareTo(((b.last as double) - 1).abs()));
      matchFaces();
    } else {
      registerFaceAuth();
    }
  }
}

FaceFeatures getFeature(String data) {
  Map<String, dynamic> v = data as Map<String, dynamic>;
  return FaceFeatures.fromJson(v);
}
