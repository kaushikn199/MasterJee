class GMeetResponse {
  GMeetResponse({
    required this.status,
    required this.message,
    required this.data,
    required this.result,
  });

  final String status;
  final String message;
  final List<GMeetData> data;
  final bool result;

  factory GMeetResponse.fromJson(Map<String, dynamic> json){
    return GMeetResponse(
      status: json["status"] ?? "",
      message: json["message"] ?? "",
      data: json["data"] == null ? [] : List<GMeetData>.from(json["data"]!.map((x) => GMeetData.fromJson(x))),
      result: json["result"] ?? false,
    );
  }

  Map<String, dynamic> toJson() => {
    "status": status,
    "message": message,
    "data": data.map((x) => x.toJson()).toList(),
    "result": result,
  };

}

class GMeetData {
  GMeetData({
    required this.id,
    required this.purpose,
    required this.staffId,
    required this.createdId,
    required this.title,
    required this.date,
    required this.type,
    required this.apiData,
    required this.duration,
    required this.subject,
    required this.url,
    required this.sessionId,
    required this.description,
    required this.timezone,
    required this.status,
    required this.createdAt,
    required this.gmeetSectionId,
    required this.createBystaffid,
    required this.forCreatstaffid,
    required this.totalViewers,
    required this.createByName,
    required this.createBySurname,
    required this.forCreateName,
    required this.forCreateSurname,
    required this.createByRoleName,
    required this.createForRoleName,
  });

  final String id;
  final String purpose;
  final String staffId;
  final String createdId;
  final String title;
  final String? date;
  final String type;
  final String apiData;
  final String duration;
  final dynamic subject;
  final String url;
  final String sessionId;
  final String description;
  final String timezone;
  final String status;
  final String? createdAt;
  final String gmeetSectionId;
  final String createBystaffid;
  final String forCreatstaffid;
  final String totalViewers;
  final String createByName;
  final String createBySurname;
  final String forCreateName;
  final String forCreateSurname;
  final String createByRoleName;
  final String createForRoleName;

  factory GMeetData.fromJson(Map<String, dynamic> json){
    return GMeetData(
      id: json["id"] ?? "",
      purpose: json["purpose"] ?? "",
      staffId: json["staff_id"] ?? "",
      createdId: json["created_id"] ?? "",
      title: json["title"] ?? "",
      date: json["date"] ?? "",
      type: json["type"] ?? "",
      apiData: json["api_data"] ?? "",
      duration: json["duration"] ?? "",
      subject: json["subject"],
      url: json["url"] ?? "",
      sessionId: json["session_id"] ?? "",
      description: json["description"] ?? "",
      timezone: json["timezone"] ?? "",
      status: json["status"] ?? "",
      createdAt: json["created_at"] ?? "",
      gmeetSectionId: json["gmeet_section_id"] ?? "",
      createBystaffid: json["create_bystaffid"] ?? "",
      forCreatstaffid: json["for_creatstaffid"] ?? "",
      totalViewers: json["total_viewers"] ?? "",
      createByName: json["create_by_name"] ?? "",
      createBySurname: json["create_by_surname"] ?? "",
      forCreateName: json["for_create_name"] ?? "",
      forCreateSurname: json["for_create_surname"] ?? "",
      createByRoleName: json["create_by_role_name"] ?? "",
      createForRoleName: json["create_for_role_name"] ?? "",
    );
  }

  Map<String, dynamic> toJson() => {
    "id": id,
    "purpose": purpose,
    "staff_id": staffId,
    "created_id": createdId,
    "title": title,
    "date": date,
    "type": type,
    "api_data": apiData,
    "duration": duration,
    "subject": subject,
    "url": url,
    "session_id": sessionId,
    "description": description,
    "timezone": timezone,
    "status": status,
    "created_at": createdAt,
    "gmeet_section_id": gmeetSectionId,
    "create_bystaffid": createBystaffid,
    "for_creatstaffid": forCreatstaffid,
    "total_viewers": totalViewers,
    "create_by_name": createByName,
    "create_by_surname": createBySurname,
    "for_create_name": forCreateName,
    "for_create_surname": forCreateSurname,
    "create_by_role_name": createByRoleName,
    "create_for_role_name": createForRoleName,
  };

}
