class AllStudentsTemplateResponse {
  String? status;
  String? message;
  List<Template>? data;
  bool? result;

  AllStudentsTemplateResponse({
    this.status,
    this.message,
    this.data,
    this.result,
  });

  factory AllStudentsTemplateResponse.fromJson(Map<String, dynamic> json) => AllStudentsTemplateResponse(
    status: json["status"],
    message: json["message"],
    data: json["data"] == null ? [] : List<Template>.from(json["data"]!.map((x) => Template.fromJson(x))),
    result: json["result"],
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "message": message,
    "data": data == null ? [] : List<dynamic>.from(data!.map((x) => x.toJson())),
    "result": result,
  };
}

class Data {
  List<Template>? data;

  Data({
    this.data,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    data: json["data"] == null ? [] : List<Template>.from(json["data"]!.map((x) => Template.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "data": data == null ? [] : List<dynamic>.from(data!.map((x) => x.toJson())),
  };
}

class Template {
  String? id;
  String? name;

  Template({
    this.id,
    this.name,
  });

  factory Template.fromJson(Map<String, dynamic> json) => Template(
    id: json["id"],
    name: json["name"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
  };
}

