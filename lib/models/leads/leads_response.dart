class LeadResponse {
  final String status;
  final String message;
  final String activeCampaign;
  final List<Campaign> campaigns;
  final List<Lead> openLeads;
  final List<MissedFollowup> missedFollowups;

  LeadResponse({
    required this.status,
    required this.message,
    required this.activeCampaign,
    required this.campaigns,
    required this.openLeads,
    required this.missedFollowups,
  });

  factory LeadResponse.fromJson(Map<String, dynamic> json) {
    return LeadResponse(
      status: json['status'] ?? '',
      message: json['message'] ?? '',
      activeCampaign: json['active_campaign'] ?? '',
      campaigns: (json['campaigns'] as List<dynamic>?)
          ?.map((e) => Campaign.fromJson(e))
          .toList() ??
          [],
      openLeads: (json['open_leads'] as List<dynamic>?)
          ?.map((e) => Lead.fromJson(e))
          .toList() ??
          [],
      missedFollowups: (json['missed_followups'] as List<dynamic>?)
          ?.map((e) => MissedFollowup.fromJson(e))
          .toList() ??
          [],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'status': status,
      'message': message,
      'active_campaign': activeCampaign,
      'campaigns': campaigns.map((e) => e.toJson()).toList(),
      'open_leads': openLeads.map((e) => e.toJson()).toList(),
      'missed_followups': missedFollowups.map((e) => e.toJson()).toList(),
    };
  }
}

class Campaign {
  final String campaignId;
  final String title;
  final String totalLeads;
  final bool isActive;

  Campaign({
    required this.campaignId,
    required this.title,
    required this.totalLeads,
    required this.isActive,
  });

  factory Campaign.fromJson(Map<String, dynamic> json) {
    return Campaign(
      campaignId: json['campaign_id'] ?? '',
      title: json['title'] ?? '',
      totalLeads: json['total_leads'] ?? '0',
      isActive: json['is_active'] ?? false,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'campaign_id': campaignId,
      'title': title,
      'total_leads': totalLeads,
      'is_active': isActive,
    };
  }
}

class MissedFollowup {
  final String leadId;
  final String name;
  final String campaign;
  final int daysAgo;
  final String followupRemark;
  final String nextFollowupDate;
  final String nextFollowupTime;
  final String followupPriority;
  final String priorityIcon;
  final String callStatus;

  MissedFollowup({
    required this.leadId,
    required this.name,
    required this.campaign,
    required this.daysAgo,
    required this.followupRemark,
    required this.nextFollowupDate,
    required this.nextFollowupTime,
    required this.followupPriority,
    required this.priorityIcon,
    required this.callStatus,
  });

  factory MissedFollowup.fromJson(Map<String, dynamic> json) {
    return MissedFollowup(
      leadId: json['lead_id'] ?? '',
      name: json['name'] ?? '',
      campaign: json['campaign'] ?? '',
      daysAgo: json['days_ago'] ?? 0,
      followupRemark: json['followup_remark'] ?? '',
      nextFollowupDate: json['next_followup_date'] ?? '',
      nextFollowupTime: json['next_followup_time'] ?? '',
      followupPriority: json['followup_priority'] ?? '',
      priorityIcon: json['priority_icon'] ?? '',
      callStatus: json['call_status'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'lead_id': leadId,
      'name': name,
      'campaign': campaign,
      'days_ago': daysAgo,
      'followup_remark': followupRemark,
      'next_followup_date': nextFollowupDate,
      'next_followup_time': nextFollowupTime,
      'followup_priority': followupPriority,
      'priority_icon': priorityIcon,
      'call_status': callStatus,
    };
  }
}

class Lead {
  final String leadId;
  final String name;
  final String fatherName;
  final String takeLeadUrl;

  Lead({
    required this.leadId,
    required this.name,
    required this.fatherName,
    required this.takeLeadUrl,
  });

  factory Lead.fromJson(Map<String, dynamic> json) {
    return Lead(
      leadId: json['lead_id'] ?? '',
      name: json['name'] ?? '',
      fatherName: json['father_name'] ?? '',
      takeLeadUrl: json['take_lead_url'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'lead_id': leadId,
      'name': name,
      'father_name': fatherName,
      'take_lead_url': takeLeadUrl,
    };
  }
}