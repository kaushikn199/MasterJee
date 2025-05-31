
import 'package:flutter/material.dart';
import 'package:masterjee/models/leads/campaign_leads_response.dart';
import 'package:masterjee/models/leads/followup_response.dart';
import 'package:masterjee/models/leads/leads_response.dart';
import 'package:masterjee/models/leads/missed_leads_response.dart';
import 'package:masterjee/others/ApiHelper.dart';

class LeadsApi with ChangeNotifier {

  Future<LeadResponse> getLeads(String userId) async {
    Map<String, dynamic> body = {'userId': userId,};
    print("body : ${body}");
    final responseData = await ApiHelper.post(ApiHelper.leads, body);
    print("responseData : ${responseData}");
    return LeadResponse.fromJson(responseData);
  }

  Future<FollowupResponse> allFollowup(String userId) async {
    Map<String, dynamic> body = {'userId': userId,};
    print("body : ${body}");
    final responseData = await ApiHelper.post(ApiHelper.allFollowup, body);
    print("responseData : ${responseData}");
    return FollowupResponse.fromJson(responseData);
  }

  Future<MissedLeadsResponse> missedLeads(String userId) async {
    Map<String, dynamic> body = {'userId': userId,};
    print("body : ${body}");
    final responseData = await ApiHelper.post(ApiHelper.missedLeads, body);
    print("responseData : ${responseData}");
    return MissedLeadsResponse.fromJson(responseData);
  }

  Future<MissedLeadsResponse> walkinLeads(String userId) async {
    Map<String, dynamic> body = {'userId': userId,};
    print("body : ${body}");
    final responseData = await ApiHelper.post(ApiHelper.walkinLeads, body);
    print("responseData : ${responseData}");
    return MissedLeadsResponse.fromJson(responseData);
  }


  Future<CampaignLeadsResponse> campaignLeads(String userId,String actCampId) async {
    Map<String, dynamic> body = {'userId': userId,"actCampId":actCampId};
    print("body : ${body}");
    final responseData = await ApiHelper.post(ApiHelper.campaignLeads, body);
    print("responseData : ${responseData}");
    return CampaignLeadsResponse.fromJson(responseData);
  }

}

