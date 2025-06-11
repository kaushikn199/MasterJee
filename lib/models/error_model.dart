class ErrorModel {
  late String message;

  ErrorModel({this.message = ""});
  ErrorModel.fromJson(Map<String, dynamic> json) {
    message = json['message'] ?? "";
  }
  Map<String, dynamic> toJson() {
    final json = <String, dynamic>{};
    json['message'] = message;
    return json;
  }
}

class ErrorMessageModel {
  String? message;
  String? status;

  ErrorMessageModel({this.message, this.status});
  ErrorMessageModel.fromJson(Map<String, dynamic> json) {
    status = json['status'] ?? "";
    message = json['message'] ?? "";
  }
  Map<String, dynamic> toJson() {
    final json = <String, dynamic>{};
    json['status'] = status;
    json['message'] = message;
    return json;
  }
}

class SuccessTempleteData {
  String? status;
  String? message;
  Data? data;
  bool? result;

  SuccessTempleteData({
    this.status,
    this.message,
    this.data,
    this.result,
  });

  factory SuccessTempleteData.fromJson(Map<String, dynamic> json) => SuccessTempleteData(
    status: json["status"],
    message: json["message"],
    data: json["data"] == null ? null : Data.fromJson(json["data"]),
    result: json["result"],
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "message": message,
    "data": data?.toJson(),
    "result": result,
  };
}

class Data {
  String? status;
  String? fileUrl;

  Data({
    this.status,
    this.fileUrl,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    status: json["status"],
    fileUrl: json["fileUrl"],
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "fileUrl": fileUrl,
  };
}
