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
