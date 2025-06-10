
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../constants.dart';

abstract class AppLoader {
  static const routeName = "/loading_dialog";

  static bool _isVisible = false;

  static void show(BuildContext context, {String? loadText}) {
    if (_isVisible) return;
    showDialog(
      context: context,
      useSafeArea: false,
      routeSettings: const RouteSettings(name: routeName),
      builder: (context) => WillPopScope(
        onWillPop: () => Future.value(false),
        child: Dialog(
          surfaceTintColor: Colors.transparent,
          backgroundColor: Colors.transparent,
          elevation: 0,
          insetPadding: EdgeInsets.zero,
          child: Center(
            child: Card(
              margin: const EdgeInsets.all(40),
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: Row(
                  children: [
                    SizedBox(
                        height: 35.sp,
                        child: const CircularProgressIndicator(
                            color: colorGreen)),
                    SizedBox(width: 20.sp),
                    Text(
                      loadText ?? "Loading...",
                      style: Theme.of(context).textTheme.displayLarge!.copyWith(
                          fontSize: 18.sp,
                          color: colorGreen,
                          fontWeight: FontWeight.bold),
                    )
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
    _isVisible = true;
  }

  static void dismiss(BuildContext context) {
    if (_isVisible) {
      Navigator.of(context).pop();
      _isVisible = false;
    }
  }
}