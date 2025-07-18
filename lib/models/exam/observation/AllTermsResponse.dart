class TermListResponse {
  final String status;
  final String message;
  final List<TermData> data;
  final bool result;

  TermListResponse({
    this.status = "",
    this.message = "",
    this.data = const [],
    this.result = false,
  });

  factory TermListResponse.fromJson(Map<String, dynamic> json) {
    return TermListResponse(
      status: json['status'] ?? "",
      message: json['message'] ?? "",
      result: json['result'] ?? false,
      data: (json['data'] as List<dynamic>?)
          ?.map((e) => TermData.fromJson(e))
          .toList() ??
          [],
    );
  }
}

class TermData {
  final String id;
  final String name;
  final String termCode;
  final String description;
  final String createdBy;
  final String createdAt;

  TermData({
    this.id = "",
    this.name = "",
    this.termCode = "",
    this.description = "",
    this.createdBy = "",
    this.createdAt = "",
  });

  factory TermData.fromJson(Map<String, dynamic> json) {
    return TermData(
      id: json['id'] ?? "",
      name: json['name'] ?? "",
      termCode: json['term_code'] ?? "",
      description: json['description'] ?? "",
      createdBy: json['created_by'] ?? "",
      createdAt: json['created_at'] ?? "",
    );
  }
}
