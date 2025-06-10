import 'dart:math' as math;
import 'dart:math';

import 'package:google_mlkit_face_detection/google_mlkit_face_detection.dart';
import 'package:masterjee/models/user_model.dart';


Future<FaceFeatures?> extractFaceFeatures(
    InputImage inputImage, FaceDetector faceDetector) async {
  try {
    List<Face> faceList = await faceDetector.processImage(inputImage);
    Face face = faceList.first;

    FaceFeatures faceFeatures = FaceFeatures(
      rightEar: Points(
          x: (face.landmarks[FaceLandmarkType.rightEar])?.position.x,
          y: (face.landmarks[FaceLandmarkType.rightEar])?.position.y),
      leftEar: Points(
          x: (face.landmarks[FaceLandmarkType.leftEar])?.position.x,
          y: (face.landmarks[FaceLandmarkType.leftEar])?.position.y),
      rightMouth: Points(
          x: (face.landmarks[FaceLandmarkType.rightMouth])?.position.x,
          y: (face.landmarks[FaceLandmarkType.rightMouth])?.position.y),
      leftMouth: Points(
          x: (face.landmarks[FaceLandmarkType.leftMouth])?.position.x,
          y: (face.landmarks[FaceLandmarkType.leftMouth])?.position.y),
      rightEye: Points(
          x: (face.landmarks[FaceLandmarkType.rightEye])?.position.x,
          y: (face.landmarks[FaceLandmarkType.rightEye])?.position.y),
      leftEye: Points(
          x: (face.landmarks[FaceLandmarkType.leftEye])?.position.x,
          y: (face.landmarks[FaceLandmarkType.leftEye])?.position.y),
      rightCheek: Points(
          x: (face.landmarks[FaceLandmarkType.rightCheek])?.position.x,
          y: (face.landmarks[FaceLandmarkType.rightCheek])?.position.y),
      leftCheek: Points(
          x: (face.landmarks[FaceLandmarkType.leftCheek])?.position.x,
          y: (face.landmarks[FaceLandmarkType.leftCheek])?.position.y),
      noseBase: Points(
          x: (face.landmarks[FaceLandmarkType.noseBase])?.position.x,
          y: (face.landmarks[FaceLandmarkType.noseBase])?.position.y),
      bottomMouth: Points(
          x: (face.landmarks[FaceLandmarkType.bottomMouth])?.position.x,
          y: (face.landmarks[FaceLandmarkType.bottomMouth])?.position.y),
    );

    return faceFeatures;
    // Handle the result
  } catch (e) {
    return null;
    // Handle the error
  }
}

Future<FaceFeatures?> extractFaceFeaturesFromList(Face face) async {
  try {
    FaceFeatures faceFeatures = FaceFeatures(
      rightEar: Points(
          x: (face.landmarks[FaceLandmarkType.rightEar])?.position.x,
          y: (face.landmarks[FaceLandmarkType.rightEar])?.position.y),
      leftEar: Points(
          x: (face.landmarks[FaceLandmarkType.leftEar])?.position.x,
          y: (face.landmarks[FaceLandmarkType.leftEar])?.position.y),
      rightMouth: Points(
          x: (face.landmarks[FaceLandmarkType.rightMouth])?.position.x,
          y: (face.landmarks[FaceLandmarkType.rightMouth])?.position.y),
      leftMouth: Points(
          x: (face.landmarks[FaceLandmarkType.leftMouth])?.position.x,
          y: (face.landmarks[FaceLandmarkType.leftMouth])?.position.y),
      rightEye: Points(
          x: (face.landmarks[FaceLandmarkType.rightEye])?.position.x,
          y: (face.landmarks[FaceLandmarkType.rightEye])?.position.y),
      leftEye: Points(
          x: (face.landmarks[FaceLandmarkType.leftEye])?.position.x,
          y: (face.landmarks[FaceLandmarkType.leftEye])?.position.y),
      rightCheek: Points(
          x: (face.landmarks[FaceLandmarkType.rightCheek])?.position.x,
          y: (face.landmarks[FaceLandmarkType.rightCheek])?.position.y),
      leftCheek: Points(
          x: (face.landmarks[FaceLandmarkType.leftCheek])?.position.x,
          y: (face.landmarks[FaceLandmarkType.leftCheek])?.position.y),
      noseBase: Points(
          x: (face.landmarks[FaceLandmarkType.noseBase])?.position.x,
          y: (face.landmarks[FaceLandmarkType.noseBase])?.position.y),
      bottomMouth: Points(
          x: (face.landmarks[FaceLandmarkType.bottomMouth])?.position.x,
          y: (face.landmarks[FaceLandmarkType.bottomMouth])?.position.y),
    );

    return faceFeatures;
    // Handle the result
  } catch (e) {
    return null;
    // Handle the error
  }
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

double calculateDistance(LocationPoint location1, LocationPoint location2) {
  const double earthRadius = 6371000; // in meters

  double lat1Rad = degreesToRadians(location1.latitude);
  double lat2Rad = degreesToRadians(location2.latitude);
  double deltaLatRad =
      degreesToRadians(location2.latitude - location1.latitude);
  double deltaLonRad =
      degreesToRadians(location2.longitude - location1.longitude);

  double a = sin(deltaLatRad / 2) * sin(deltaLatRad / 2) +
      cos(lat1Rad) * cos(lat2Rad) * sin(deltaLonRad / 2) * sin(deltaLonRad / 2);
  double c = 2 * atan2(sqrt(a), sqrt(1 - a));

  double distance = earthRadius * c;
  return distance;
}

double degreesToRadians(double degrees) {
  return degrees * pi / 180;
}

class LocationPoint {
  final double latitude;
  final double longitude;

  LocationPoint(this.latitude, this.longitude);
}
