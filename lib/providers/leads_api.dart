import 'package:flutter/material.dart';
import 'package:masterjee/models/leads/add_camp_response.dart';
import 'package:masterjee/models/leads/add_lead_response.dart';
import 'package:masterjee/models/leads/campaign_leads_response.dart';
import 'package:masterjee/models/leads/campaign_response.dart';
import 'package:masterjee/models/leads/followup_response.dart';
import 'package:masterjee/models/leads/leads_response.dart';
import 'package:masterjee/models/leads/missed_leads_response.dart';
import 'package:masterjee/models/leads/save_lead_body.dart';
import 'package:masterjee/models/leads/view_leads_reasponse.dart';
import 'package:masterjee/models/ptm/grouped_students_response.dart';
import 'package:masterjee/others/ApiHelper.dart';

class LeadsApi with ChangeNotifier {
  Future<LeadResponse> getLeads(String userId) async {
    Map<String, dynamic> body = {
      'userId': userId,
    };
    print("body : ${body}");
    final responseData = await ApiHelper.post(ApiHelper.leads, body);
    print("responseData : ${responseData}");
    return LeadResponse.fromJson(responseData);
  }


  Future<CampaignResponse> campaign(String userId) async {
    Map<String, dynamic> body = {
      'userId': userId,
    };
    print("body : ${body}");
    final responseData = await ApiHelper.post(ApiHelper.campaign, body);
    print("responseData : ${responseData}");
    return CampaignResponse.fromJson(responseData);
  }

  Future<LeadResponse> takeLead(String userId,String lId) async {
    Map<String, dynamic> body = {
      'userId': userId,
      'lId': lId,
    };
    print("body : ${body}");
    final responseData = await ApiHelper.post(ApiHelper.takeLead, body);
    print("responseData : ${responseData}");
    return LeadResponse.fromJson(responseData);
  }

  Future<AddCampResponse> addCampaign(String userId) async {
    Map<String, dynamic> body = {
      'userId': userId,
    };
    print("body : ${body}");
    final responseData = await ApiHelper.post(ApiHelper.addCampaign, body);
    print("responseData : ${responseData}");
    return AddCampResponse.fromJson(responseData);
  }

  Future<CampaignResponse> startCampaign(String userId,String newCampId,String actCampId) async {
    Map<String, dynamic> body = {
      'userId': userId,
      'newCampId': newCampId,
      'actCampId': actCampId,
    };
    print("body : ${body}");
    final responseData = await ApiHelper.post(ApiHelper.startCampaign, body);
    print("responseData : ${responseData}");
    return CampaignResponse.fromJson(responseData);
  }

  Future<FollowupResponse> allFollowup(String userId) async {
    Map<String, dynamic> body = {
      'userId': userId,
    };
    print("body : ${body}");
    final responseData = await ApiHelper.post(ApiHelper.allFollowup, body);
    print("responseData : ${responseData}");
    return FollowupResponse.fromJson(responseData);
  }

  Future<MissedLeadsResponse> missedLeads(
      String userId,
      String fdate,
      String tdate,
      String mnumber) async {
    Map<String, dynamic> body = {
      'userId': userId,
      'fdate': fdate,
      'tdate': tdate,
      'mnumber': mnumber,
    };
    print("body : ${body}");
    final responseData = await ApiHelper.post(ApiHelper.missedLeads, body);
    print("responseData : ${responseData}");
    return MissedLeadsResponse.fromJson(responseData);
  }

  Future<MissedLeadsResponse> walkinLeads(String userId,String fdate,String tdate,String mnumber) async {
    Map<String, dynamic> body = {
      'userId': userId,
      'fdate': fdate,
      'tdate': tdate,
      'mnumber': mnumber,
    };
    print("body : ${body}");
    final responseData = await ApiHelper.post(ApiHelper.walkinLeads, body);
    print("responseData : ${responseData}");
    return MissedLeadsResponse.fromJson(responseData);
  }

  Future<CampaignLeadsResponse> campaignLeads(
      String userId, String actCampId) async {
    Map<String, dynamic> body = {'userId': userId, "actCampId": actCampId};
    print("body : ${body}");
    final responseData = await ApiHelper.post(ApiHelper.campaignLeads, body);
    print("responseData : ${responseData}");
    return CampaignLeadsResponse.fromJson(responseData);
  }

  Future<CampaignLeadsResponse> saveCampaign(
      String userId,
      String ctId,
      String cpId,
      String cTitle,
      String cDescription) async {
    Map<String, dynamic> body = {
      'userId': userId,
      "ctId": ctId,
      "cpId": cpId,
      "cTitle": cTitle,
      "cDescription": cDescription,
    };
    print("body : ${body}");
    final responseData = await ApiHelper.post(ApiHelper.saveCampaign, body);
    print("responseData : ${responseData}");
    return CampaignLeadsResponse.fromJson(responseData);
  }



  Future<ViewLeadsResponse> leadsView(String userId, String lId) async {
    Map<String, dynamic> body = {'userId': userId, "lId": lId};
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
      "classId": classId,
      "cId": cId,
      "lId": lId,
      "fr": fr,
      "nfd": nfd,
      "nft": nft,
      "cs": cs,
      "level": level
    };
    print("body : ${body}");
    final responseData = await ApiHelper.post(ApiHelper.saveFollowUp, body);
    print("responseData : ${responseData}");
    return ViewLeadsResponse.fromJson(responseData);
  }

  Future<ViewLeadsResponse> saveLeadTransfer(String userId, String tlid,
      String tcid, String transferTo, String level) async {
    Map<String, dynamic> body = {
      'userId': userId,
      "tlid": tlid,
      "tcid": tcid,
      "transferTo": transferTo,
      "level": level
    };
    print("body : ${body}");
    final responseData = await ApiHelper.post(ApiHelper.saveLeadTransfer, body);
    print("responseData : ${responseData}");
    return ViewLeadsResponse.fromJson(responseData);
  }

  Future<GroupedStudentsResponse> saveLead(SaveLeadBody data) async {
    Map<String, dynamic> body = {
      "userId": data.userId,
      "lId": data.lId,
      "cId": data.cId,
      "lName": data.lName,
      "lDob": data.lDob,
      "lCaste": data.lCaste,
      "lSubCaste": data.lSubCaste,
      "lBloodGroup": data.lBloodGroup,
      "lReligion": data.lReligion,
      "lMotherTongue": data.lMotherTongue,
      "lFatherName": data.lFatherName,
      "lFatherPhone": data.lFatherPhone,
      "lFatherQualification": data.lFatherQualification,
      "lMotherName": data.lMotherName,
      "lMotherPhone": data.lMotherPhone,
      "lMotherQualification": data.lMotherQualification,
      "lGuradianName": data.lGuradianName,
      "lGuardianPhone": data.lGuardianPhone,
      "lClass": data.lClass,
      "lEnrolledCourse": data.lEnrolledCourse,
      "lElectiveSubjects": data.lElectiveSubjects,
      "lAddress": data.lAddress,
      "lLocation": data.lLocation,
      "lPhoneNumber": data.lPhoneNumber,
      "lAlternativePhone": data.lAlternativePhone,
      "lEmergencyContactNo": data.lEmergencyContactNo,
      "lEmail": data.lEmail,
      "lSource": data.lSource,
      "lResources": data.lResources,
      "lat": data.lat,
      "lng": data.lng,
      "lGender": data.lGender,
      "lAadharNo": data.lAadharNo
    };
    print("body : $body");
    final responseData = await ApiHelper.post(ApiHelper.saveLead, body);
    print("saveLead : $responseData");
    return GroupedStudentsResponse.fromJson(responseData);
  }

  Future<AddLeadResponse> addLead(String userId) async {
    Map<String, dynamic> body = {
      'userId': userId
    };
    print("body : ${body}");
    final responseData = await ApiHelper.post(ApiHelper.addLead, body);
    print("responseData : ${responseData}");
    return AddLeadResponse.fromJson(responseData);
  }

  Future<AddLeadResponse> importLead(String userId,String file) async {
    Map<String, dynamic> body = {
      'userId': userId,
      'file': file
    };
    print("body : ${body}");
    final responseData = await ApiHelper.post(ApiHelper.importLead, body);
    print("responseData : ${responseData}");
    return AddLeadResponse.fromJson(responseData);
  }

}
