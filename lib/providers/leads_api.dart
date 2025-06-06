
import 'package:flutter/material.dart';
import 'package:masterjee/models/leads/campaign_leads_response.dart';
import 'package:masterjee/models/leads/followup_response.dart';
import 'package:masterjee/models/leads/leads_response.dart';
import 'package:masterjee/models/leads/missed_leads_response.dart';
import 'package:masterjee/models/leads/view_leads_reasponse.dart';
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



  Future<ViewLeadsResponse> leadsView(String userId,String lId) async {
    Map<String, dynamic> body = {'userId': userId,"lId":lId};
    print("body : ${body}");
    final responseData = await ApiHelper.post(ApiHelper.leadsView, body);
    print("responseData : ${responseData}");
    return ViewLeadsResponse.fromJson(responseData);
  }

  Future<ViewLeadsResponse> saveFollowUp(
      String userId,
      String classId,
      String cId,
      String lId,
      String fr,
      String nfd,
      String nft,
      String cs,
      String level) async {
    Map<String, dynamic> body = {
      'userId': userId,
      "classId":classId,
      "cId":cId,
      "lId":lId,
      "fr":fr,
      "nfd":nfd,
      "nft":nft,
      "cs":cs,
      "level":level};
    print("body : ${body}");
    final responseData = await ApiHelper.post(ApiHelper.saveFollowUp, body);
    print("responseData : ${responseData}");
    return ViewLeadsResponse.fromJson(responseData);
  }

  Future<ViewLeadsResponse> saveLeadTransfer(
      String userId,
      String tlid,
      String tcid,
      String transferTo,
      String level) async {
    Map<String, dynamic> body = {
      'userId': userId,
      "tlid":tlid,
      "tcid":tcid,
      "transferTo":transferTo,
      "level":level};
    print("body : ${body}");
    final responseData = await ApiHelper.post(ApiHelper.saveLeadTransfer, body);
    print("responseData : ${responseData}");
    return ViewLeadsResponse.fromJson(responseData);
  }

}

