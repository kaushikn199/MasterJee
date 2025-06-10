import 'dart:convert';
import 'dart:typed_data';
import 'package:flutter_face_api/face_api.dart' as regula;
import 'package:get/get.dart';
import 'package:google_mlkit_face_detection/google_mlkit_face_detection.dart';
import 'package:location/location.dart';
import 'package:masterjee/models/common_functions.dart';
import 'package:masterjee/models/user_model.dart';
import 'package:masterjee/models/users_info.dart';
import 'package:masterjee/others/StorageHelper.dart';
import 'package:masterjee/providers/attendance_api.dart';
import 'package:masterjee/screens/face_attendance/extract_view.dart';

class FaceController extends GetxController {
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
  RxBool isStaff = false.obs;
  RxInt trialNumber = 1.obs;
  var arguments = Get.arguments;
  RxString staffId = "".obs;
  RxString classId = "".obs;
  RxString sectionId = "".obs;
  RxString sessionId = "".obs;
  Rx<UsersListModel> userData = UsersListModel().obs;
  Rx<UserModel> matchedUser = UserModel().obs;

  @override
  void onInit() {
    staffId(StorageHelper.getStringData(StorageHelper.userIdKey).toString());
    classId(StorageHelper.getStringData(StorageHelper.classIdKey).toString());
    sectionId(StorageHelper.getStringData(StorageHelper.sectionIdKey).toString());
    sessionId(StorageHelper.getStringData(StorageHelper.sessionIdKey).toString());
    super.onInit();
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
        CommonFunctions.showWarningToast("your location not matched with school location");
      }
    } else {
      faceAttendance(int.parse(matchedUser.value.id.toString()), false);
    }
  }

  onInputImage(inputImage) async {
    isMatching(true);
    faceFeatures = await extractFaceFeatures(inputImage, faceDetector);
    isMatching(false);
    if (faceFeatures == null) {
      canAuthenticate(false);
      CommonFunctions.showWarningToast("Face not found in image.");
    }
  }

  Future setImage(Uint8List imageToAuthenticate) async {
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
        matchedUser(user.first);
      } else {
        faceMatched = false;
      }
    }
    if (faceMatched) {
      if (matchedUser.value.id == userData.value.stfInfo!.id) {
        checkLocation();
      } else {
        faceAttendance(int.parse(matchedUser.value.id.toString()), true);
      }
    } else {
      if (trialNumber.value == 4) {
        trialNumber(1);
        CommonFunctions.showWarningToast("Face doesn't match. Please try again.");
      } else if (trialNumber.value == 3) {
        isMatching(false);
        trialNumber++;
      } else {
        trialNumber++;
        CommonFunctions.showWarningToast("Face doesn't match. Please try again.");
      }
    }
  }

  fetchUsersAndMatchFace() async {
    isMatching(true);
    Map<String, dynamic> data = {
      "staff_id": staffId.value,
      "class_id": classId.value,
      "section_id": sectionId.value,
      "session_id": sessionId.value
    };

    await ClassAttendanceApi.getUsers(data).then((value) {
      isMatching(false);
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
      CommonFunctions.showWarningToast(
          "No Users Registered, Make sure users are registered first before Authenticating.");
    }
  }
}
