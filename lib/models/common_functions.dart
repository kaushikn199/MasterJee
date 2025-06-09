import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:masterjee/constants.dart';
// import 'package:fluttertoast/fluttertoast.dart';

class CommonFunctions {
  static void showErrorDialog(String message, BuildContext context) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('An Error Occurred!'),
        content: Text(message, style: const TextStyle(color: Colors.red)),
        actions: <Widget>[
          MaterialButton(
            child: const Text('Okay'),
            onPressed: () {
              Navigator.of(ctx).pop();
            },
          )
        ],
      ),
    );
  }

  static void showSuccessToast(String message) {
    Fluttertoast.showToast(
        msg: message,
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 2,
        backgroundColor: colorGreen,
        textColor: kToastTextColor
        ,
        fontSize: 16.0);
  }

  static void showNoDataFoundToast() {
    Fluttertoast.showToast(
        msg: "No Data Found",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 2,
        backgroundColor: Colors.black12,
        textColor: Colors.black,
        fontSize: 16.0);
  }

  static void showWarningToast(String message) {
    Fluttertoast.showToast(
        msg: message,
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 2,
        backgroundColor: colorBlack,
        textColor: kToastTextColor,
        fontSize: 16.0);
  }
}
