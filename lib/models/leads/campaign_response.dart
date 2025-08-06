class CampaignResponse {
  final String status;
  final String message;
  final List<CampaignModel> data;
  final bool result;

  CampaignResponse({
    required this.status,
    required this.message,
    required this.data,
    required this.result,
  });

  factory CampaignResponse.fromJson(Map<String, dynamic> json) {
    return CampaignResponse(
      status: json['status'] ?? '',
      message: json['message'] ?? '',
      data: (json['data'] as List<dynamic>?)
          ?.map((e) => CampaignModel.fromJson(e))
          .toList() ??
          [],
      result: json['result'] ?? false,
    );
  }
}

class CampaignModel {
  final String lcId;
  final String? cId;
  final String staffId;
  final String level;
  final String? ctId;
  final String? cpId;
  final String? cTitle;
  final String? cDescription;
  final String? cDate;
  final String? cBy;
  final String? cManager;
  final dynamic cManagerData;
  final String? cStatus;
  final dynamic otherInfo;
  final String? defaultShareMessage;

  CampaignModel({
    required this.lcId,
    this.cId,
    required this.staffId,
    required this.level,
    this.ctId,
    this.cpId,
    this.cTitle,
    this.cDescription,
    this.cDate,
    this.cBy,
    this.cManager,
    this.cManagerData,
    this.cStatus,
    this.otherInfo,
    this.defaultShareMessage,
  });

  factory CampaignModel.fromJson(Map<String, dynamic> json) {
    return CampaignModel(
      lcId: json['lc_id'] ?? '',
      cId: json['c_id'],
      staffId: json['staff_id'] ?? '',
      level: json['level'] ?? '',
      ctId: json['ct_id'],
      cpId: json['cp_id'],
      cTitle: json['c_title'],
      cDescription: json['c_description'],
      cDate: json['c_date'],
      cBy: json['c_by'],
      cManager: json['c_manager'],
      cManagerData: json['c_manager_data'],
      cStatus: json['c_status'],
      otherInfo: json['other_info'],
      defaultShareMessage: json['default_share_message'],
    );
  }
}
