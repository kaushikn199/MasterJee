import 'package:masterjee/models/user_model.dart';

class UsersListModel {
  List<StuInfo>? stuInfo;
  StfInfo? stfInfo;
  GeoInfo? geoInfo;

  UsersListModel({
    this.stuInfo,
    this.stfInfo,
    this.geoInfo,
  });

  factory UsersListModel.fromJson(Map<String, dynamic> json) => UsersListModel(
        stuInfo: json["stuInfo"] == null
            ? []
            : List<StuInfo>.from(
                json["stuInfo"]!.map((x) => StuInfo.fromJson(x))),
        stfInfo:
            json["stfInfo"] == null ? null : StfInfo.fromJson(json["stfInfo"]),
        geoInfo:
            json["geoInfo"] == null ? null : GeoInfo.fromJson(json["geoInfo"]),
      );

  Map<String, dynamic> toJson() => {
        "stuInfo": stuInfo == null
            ? []
            : List<dynamic>.from(stuInfo!.map((x) => x.toJson())),
        "stfInfo": stfInfo?.toJson(),
        "geoInfo": geoInfo?.toJson(),
      };
}

class GeoInfo {
  dynamic lat;
  dynamic lng;

  GeoInfo({
    this.lat,
    this.lng,
  });

  factory GeoInfo.fromJson(Map<String, dynamic> json) => GeoInfo(
        lat: json["lat"],
        lng: json["lng"],
      );

  Map<String, dynamic> toJson() => {
        "lat": lat,
        "lng": lng,
      };
}

class StfInfo {
  String? id;
  String? belongTo;
  String? image;
  String? name;
  FaceFeatures? faceFeatures;

  StfInfo({
    this.id,
    this.belongTo,
    this.image,
    this.name,
    this.faceFeatures,
  });

  factory StfInfo.fromJson(Map<String, dynamic> json) => StfInfo(
        id: json["id"],
        belongTo: json["belong_to"],
        image: json["image"],
        name: json["name"],
        faceFeatures: FaceFeatures.fromJson(json["face_features"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "belong_to": belongTo,
        "image": image,
        "name": name,
        'face_features': faceFeatures?.toJson() ?? {},
      };
}

class StuInfo {
  String? studentId;
  String? id;
  String? name;
  FaceFeatures? faceFeatures;
  dynamic image;

  StuInfo({
    this.studentId,
    this.id,
    this.name,
    this.faceFeatures,
    this.image,
  });

  factory StuInfo.fromJson(Map<String, dynamic> json) => StuInfo(
        studentId: json["student_id"],
        id: json["id"],
        name: json["firstname"],
        faceFeatures: FaceFeatures.fromJson(json["face_features"]),
        image: json["image"],
      );

  Map<String, dynamic> toJson() => {
        "student_id": studentId,
        "id": id,
        "firstname": name,
        "face_features": faceFeatures,
        'face_features': faceFeatures?.toJson() ?? {},
        "image": image,
      };
}
