class LeadResponse {
  final String status;
  final String message;
  final String activeCampaign;
  final List<Campaign> campaigns;
  final List<dynamic> openLeads;
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
      status: json['status'],
      message: json['message'],
      activeCampaign: json['active_campaign'],
      campaigns: (json['campaigns'] as List)
          .map((e) => Campaign.fromJson(e))
          .toList(),
      openLeads: json['open_leads'] ?? [],
      missedFollowups: (json['missed_followups'] as List)
          .map((e) => MissedFollowup.fromJson(e))
          .toList(),
    );
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
      campaignId: json['campaign_id'],
      title: json['title'],
      totalLeads: json['total_leads'],
      isActive: json['is_active'],
    );
  }
}

class MissedFollowup {
  final String leadId;
  final String name;
  final String? campaign;
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
    this.campaign,
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
      leadId: json['lead_id']  ?? "",
      name: json['name']  ?? "",
      campaign: json['campaign']  ?? "",
      daysAgo: json['days_ago'] ?? 0,
      followupRemark: json['followup_remark'] ?? "",
      nextFollowupDate: json['next_followup_date'] ?? "",
      nextFollowupTime: json['next_followup_time'] ?? "",
      followupPriority: json['followup_priority'] ?? '',
      priorityIcon: json['priority_icon'] ?? '',
      callStatus: json['call_status'] ?? '',
    );
  }
}