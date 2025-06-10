import 'dart:io';
import 'dart:isolate';

import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:masterjee/constants.dart';
import 'package:masterjee/models/common_functions.dart';
import 'package:open_file_plus/open_file_plus.dart';
import 'package:path/path.dart' as pName;
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';

class DownloadFileController extends GetxController {
  RxString localPath = "".obs;
  final ReceivePort _port = ReceivePort();
  RxBool isLoading = false.obs;
  RxInt isDownloadedId = 0.obs;

  @override
  void onInit() {
    isLoading(false);
    isDownloadedId(0);
    _prepareSaveDir();
    super.onInit();
  }

  Future<void> _prepareSaveDir() async {
    localPath((await _getSavedDir()) ?? "");
    final savedDir = Directory(localPath.value);
    if (!savedDir.existsSync()) {
      await savedDir.create();
    }
  }

  openFile(filePath) async {
    OpenFile.open(filePath);
  }

  Future<bool> checkPermission() async {
    if (Platform.isIOS) {
      return true;
    }

    if (Platform.isAndroid) {
      final info = await DeviceInfoPlugin().androidInfo;
      if (info.version.sdkInt > 28) {
        return true;
      }

      final status = await Permission.storage.status;
      if (status == PermissionStatus.granted) {
        return true;
      }

      final result = await Permission.storage.request();
      return result == PermissionStatus.granted;
    }

    throw StateError('unknown platform');
  }

  requestDownload(link) async {
    isLoading(true);
    var response = await http.get(Uri.parse(link));
    String fileName = pName.basename(getPathFromUrl(Uri.parse(link)));
    String filePath = "${localPath.value}/$fileName";
    File file = File(filePath);
    await file.writeAsBytes(response.bodyBytes);
    if (response.statusCode == 200) {
      openFile(filePath);
    } else {
      CommonFunctions.showWarningToast("Can't able to download this file");
    }
    isDownloadedId(0);
    isLoading(false);
  }

  Future<String> requestFileDownload(link) async {
    var response = await http.get(Uri.parse(link));
    String fileName = pName.basename(getPathFromUrl(Uri.parse(link)));
    String filePath = "${localPath.value}/$fileName";
    File file = File(filePath);
    await file.writeAsBytes(response.bodyBytes);
    isDownloadedId(0);
    if (response.statusCode == 200) {
      return filePath;
    } else {
      return "";
    }
  }

  getPathFromUrl(Uri url) {
    return url.path;
  }

  Future<String?> _getSavedDir() async {
    String? externalStorageDirPath;
    if (Platform.isIOS) {
      externalStorageDirPath = (await getApplicationDocumentsDirectory()).absolute.path;
    } else {
      var dir = await getExternalStorageDirectory();
      if (dir != null) {
        externalStorageDirPath = dir.path;
      }
    }
    return externalStorageDirPath;
  }

  Widget popup(context) {
    var widthSize = MediaQuery.of(context).size.width - 30.sp;
    return AlertDialog(
      surfaceTintColor: Colors.white,
      backgroundColor: Colors.white,
      insetPadding: EdgeInsets.only(left: 30.sp, right: 30.sp),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(10.sp))),
      content: Builder(builder: (context) {
        return SizedBox(
          width: widthSize,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Padding(
                padding: EdgeInsets.only(top: 10.sp, bottom: 15.sp),
                child: Center(
                  child: SizedBox(
                    child: CircularProgressIndicator(
                      color: colorGreen,
                      strokeWidth: 5.sp,
                    ),
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(top: 10.sp, bottom: 15.sp),
                child: Align(
                  alignment: Alignment.center,
                  child: Text(
                    "Downloading....",
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 12.sp, color: Colors.black, fontWeight: FontWeight.bold),
                  ),
                ),
              ),
            ],
          ),
        );
      }),
    );
  }
}
