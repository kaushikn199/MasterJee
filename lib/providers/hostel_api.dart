import 'dart:convert';
import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:masterjee/models/error_model.dart';
import 'package:masterjee/models/hostel/hostel.dart';
import 'package:masterjee/models/hostel/hostel_rooms.dart';
import 'package:masterjee/others/ApiHelper.dart';
import 'package:masterjee/others/StorageHelper.dart';

class HostelRooms with ChangeNotifier {
  Future<HostelData> getHostel() async {
    try {
      Map<String, String> body = {
        'userId': StorageHelper.getStringData(StorageHelper.userIdKey).toString(),
      };

      final responseData = await ApiHelper.post(ApiHelper.getHostels, body);
      return HostelData.fromJson(responseData);
    } catch (error) {
      rethrow;
    }
  }

  Future<HostelRoomsData> getHostelRooms() async {
    try {
      Map<String, String> body = {
        'userId': StorageHelper.getStringData(StorageHelper.userIdKey).toString(),
      };

      final responseData = await ApiHelper.post(ApiHelper.getHostelRooms, body);
      return HostelRoomsData.fromJson(responseData);
    } catch (error) {
      rethrow;
    }
  }

  Future<ErrorMessageModel> saveHostel( Map<String, String> body) async {
    try {
      final responseData = await ApiHelper.post(ApiHelper.saveHostel, body);
      return ErrorMessageModel.fromJson(responseData);
    } catch (error) {
      rethrow;
    }
  }
  Future<ErrorMessageModel> saveHostelRooms( Map<String, String> body) async {
    try {
      final responseData = await ApiHelper.post(ApiHelper.saveHostelRoom, body);
      return ErrorMessageModel.fromJson(responseData);
    } catch (error) {
      rethrow;
    }
  }

}
