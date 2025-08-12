class AddLeadResponse {
  final String status;
  final String message;
  final CampData data;
  final bool result;

  AddLeadResponse({
    required this.status,
    required this.message,
    required this.data,
    required this.result,
  });

  factory AddLeadResponse.fromJson(Map<String, dynamic> json) {
    return AddLeadResponse(
      status: json['status'] ?? "",
      message: json['message'] ?? "",
      data: CampData.fromJson(json['data'] ?? {}),
      result: json['result'] ?? false,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "status": status,
      "message": message,
      "data": data.toJson(),
      "result": result,
    };
  }
}

class CampData {
  final List<Camp> allCamp;
  final List<Source> allSource;

  CampData({
    required this.allCamp,
    required this.allSource,
  });

  factory CampData.fromJson(Map<String, dynamic> json) {
    return CampData(
      allCamp: (json['allCamp'] as List<dynamic>? ?? [])
          .map((e) => Camp.fromJson(e))
          .toList(),
      allSource: (json['allSource'] as List<dynamic>? ?? [])
          .map((e) => Source.fromJson(e))
          .toList(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "allCamp": allCamp.map((e) => e.toJson()).toList(),
      "allSource": allSource.map((e) => e.toJson()).toList(),
    };
  }
}

class Camp {
  final String cId;
  final String? ctId;
  final String? cpId;
  final String cTitle;
  final String cDescription;
  final String cDate;
  final String cBy;
  final String cManager;
  final dynamic cManagerData;
  final String cStatus;
  final dynamic otherInfo;
  final String? defaultShareMessage;

  Camp({
    required this.cId,
    this.ctId,
    this.cpId,
    required this.cTitle,
    required this.cDescription,
    required this.cDate,
    required this.cBy,
    required this.cManager,
    this.cManagerData,
    required this.cStatus,
    this.otherInfo,
    this.defaultShareMessage,
  });

  factory Camp.fromJson(Map<String, dynamic> json) {
    return Camp(
      cId: json['c_id'] ?? "",
      ctId: json['ct_id'],
      cpId: json['cp_id'],
      cTitle: json['c_title'] ?? "",
      cDescription: json['c_description'] ?? "",
      cDate: json['c_date'] ?? "",
      cBy: json['c_by'] ?? "",
      cManager: json['c_manager'] ?? "",
      cManagerData: json['c_manager_data'],
      cStatus: json['c_status'] ?? "",
      otherInfo: json['other_info'],
      defaultShareMessage: json['default_share_message'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "c_id": cId,
      "ct_id": ctId,
      "cp_id": cpId,
      "c_title": cTitle,
      "c_description": cDescription,
      "c_date": cDate,
      "c_by": cBy,
      "c_manager": cManager,
      "c_manager_data": cManagerData,
      "c_status": cStatus,
      "other_info": otherInfo,
      "default_share_message": defaultShareMessage,
    };
  }
}

class Source {
  final String id;
  final String source;
  final String description;

  Source({
    required this.id,
    required this.source,
    required this.description,
  });

  factory Source.fromJson(Map<String, dynamic> json) {
    return Source(
      id: json['id'] ?? "",
      source: json['source'] ?? "",
      description: json['description'] ?? "",
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "id": id,
      "source": source,
      "description": description,
    };
  }
}
