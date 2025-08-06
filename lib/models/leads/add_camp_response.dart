class AddCampResponse {
  final String status;
  final String message;
  final CampData data;
  final bool result;

  AddCampResponse({
    required this.status,
    required this.message,
    required this.data,
    required this.result,
  });

  factory AddCampResponse.fromJson(Map<String, dynamic> json) {
    return AddCampResponse(
      status: json['status'] ?? '',
      message: json['message'] ?? '',
      data: CampData.fromJson(json['data'] ?? {}),
      result: json['result'] ?? false,
    );
  }
}

class CampData {
  final List<CampType> allCampType;
  final List<Promoter> allPromoters;

  CampData({
    required this.allCampType,
    required this.allPromoters,
  });

  factory CampData.fromJson(Map<String, dynamic> json) {
    return CampData(
      allCampType: (json['allCampType'] as List<dynamic>?)
          ?.map((e) => CampType.fromJson(e))
          .toList() ??
          [],
      allPromoters: (json['allPromoters'] as List<dynamic>?)
          ?.map((e) => Promoter.fromJson(e))
          .toList() ??
          [],
    );
  }
}

class CampType {
  final String ctId;
  final String ctTitle;
  final String ctDescription;
  final String ctStatus;

  CampType({
    required this.ctId,
    required this.ctTitle,
    required this.ctDescription,
    required this.ctStatus,
  });

  factory CampType.fromJson(Map<String, dynamic> json) {
    return CampType(
      ctId: json['ct_id'] ?? '',
      ctTitle: json['ct_title'] ?? '',
      ctDescription: json['ct_description'] ?? '',
      ctStatus: json['ct_status'] ?? '',
    );
  }
}

class Promoter {
  final String cpId;
  final String promoterName;
  final String promoterInstitute;
  final String promoterDesignation;
  final String promoterContactNo;
  final String promoterAlternateContactNo;
  final String promoterAddress;
  final String promoterOtherData;
  final String promoterCommission;
  final String promoterCommissionType;
  final String promoterStatus;

  Promoter({
    required this.cpId,
    required this.promoterName,
    required this.promoterInstitute,
    required this.promoterDesignation,
    required this.promoterContactNo,
    required this.promoterAlternateContactNo,
    required this.promoterAddress,
    required this.promoterOtherData,
    required this.promoterCommission,
    required this.promoterCommissionType,
    required this.promoterStatus,
  });

  factory Promoter.fromJson(Map<String, dynamic> json) {
    return Promoter(
      cpId: json['cp_id'] ?? '',
      promoterName: json['promoter_name'] ?? '',
      promoterInstitute: json['promoter_institute'] ?? '',
      promoterDesignation: json['promoter_designation'] ?? '',
      promoterContactNo: json['promoter_contact_no'] ?? '',
      promoterAlternateContactNo: json['promoter_alternate_contact_no'] ?? '',
      promoterAddress: json['promoter_address'] ?? '',
      promoterOtherData: json['promoter_other_data'] ?? '',
      promoterCommission: json['promoter_commission'] ?? '',
      promoterCommissionType: json['promoter_commission_type'] ?? '',
      promoterStatus: json['promoter_status'] ?? '',
    );
  }
}
