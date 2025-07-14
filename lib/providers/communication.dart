import 'dart:convert';
import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:masterjee/models/communication/communication_model.dart';
import 'package:masterjee/models/error_model.dart';
import 'package:masterjee/models/hostel/hostel.dart';
import 'package:masterjee/models/hostel/hostel_rooms.dart';
import 'package:masterjee/others/ApiHelper.dart';
import 'package:masterjee/others/StorageHelper.dart';

class CommunicationProvider with ChangeNotifier {
  Future<CommunicationLogs> getLogs() async {
    try {
      Map<String, String> body = {
        'userId': StorageHelper.getStringData(StorageHelper.userIdKey).toString(),
        'classId': StorageHelper.getStringData(StorageHelper.classIdKey).toString(),
        'sectionId': StorageHelper.getStringData(StorageHelper.sessionIdKey).toString(),
      };

      final responseData = await ApiHelper.post(ApiHelper.getCommunicationLogs, body);
      return CommunicationLogs.fromJson(responseData);
    } catch (error) {
      rethrow;
    }
  }

  Future<NoticeLogs> getNotice() async {
    try {
      Map<String, String> body = {
        'userId': StorageHelper.getStringData(StorageHelper.userIdKey).toString(),
      };

      final responseData = await ApiHelper.post(ApiHelper.getNotices, body);
      return NoticeLogs.fromJson(responseData);
    } catch (error) {
      rethrow;
    }
  }

  Future<ErrorMessageModel> saveNotice(Map<String, String> body, File? file) async {
    try {
      final responseData = await ApiHelper.postImageDataWithBody(ApiHelper.sendNotice, body, file, type: "file");
      return ErrorMessageModel.fromJson(responseData);
    } catch (error) {
      rethrow;
    }
  }

  Future<ErrorMessageModel> saveCommunication(Map<String, String> body, File? file) async {
    try {
      final responseData = await ApiHelper.postImageDataWithBody(ApiHelper.saveCommunication, body, file, type: "file");
      return ErrorMessageModel.fromJson(responseData);
    } catch (error) {
      rethrow;
    }
  }

  Future<ErrorMessageModel> saveHostelRooms(Map<String, String> body) async {
    try {
      final responseData = await ApiHelper.post(ApiHelper.saveHostelRoom, body);
      return ErrorMessageModel.fromJson(responseData);
    } catch (error) {
      rethrow;
    }
  }
}
