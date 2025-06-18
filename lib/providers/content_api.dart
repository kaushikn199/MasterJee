import 'package:flutter/material.dart';
import 'package:masterjee/models/content/content_model.dart';
import 'package:masterjee/others/ApiHelper.dart';
import 'package:masterjee/others/StorageHelper.dart';

class ContentProvider with ChangeNotifier {

  List<ContentModel> _contents = [];

  List<ContentModel> get contents => _contents;

  fetchContents() async {
    Map<String, dynamic> body = {
      'userId':   StorageHelper.getStringData(StorageHelper.userIdKey).toString(),
    };
    print("body : ${body}");
    final responseData = await ApiHelper.post(ApiHelper.getContent, body);
    print("responseData : ${responseData}");
    final List<dynamic> contentList = responseData['data'];
     _contents = contentList.map((e) => ContentModel.fromJson(e)).toList();
  }
}