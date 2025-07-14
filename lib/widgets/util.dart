import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:masterjee/constants.dart';
import 'package:masterjee/models/common_functions.dart';
import 'package:masterjee/widgets/text.dart';

buildMaintenancePopupDialog(BuildContext context) {
  return AlertDialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(5.sp))),
      contentPadding: EdgeInsets.all(10.sp),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          CommonText.semiBold('Site is under Maintenance', size: 14.sp),
        ],
      ));
}

buildPopupDialog(BuildContext context, items) {
  return AlertDialog(
    title: const Text('Notifying'),
    content: const Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text('Do you wish to remove this course?'),
      ],
    ),
    actions: <Widget>[
      MaterialButton(
        onPressed: () {
          Navigator.of(context).pop();
        },
        textColor: Theme.of(context).primaryColor,
        child: const Text(
          'No',
          style: TextStyle(color: Colors.red),
        ),
      ),
      MaterialButton(
        onPressed: () {

        },
        textColor: Theme.of(context).primaryColor,
        child: const Text(
          'Yes',
          style: TextStyle(color: Colors.green),
        ),
      ),
    ],
  );
}


extension $DateTimeExtension on DateTime {
  String toLocalString([String format = "yyyy-MM-dd hh:mm a"]) {
    var strDate = DateFormat(format).format(toLocal());
    return strDate;
  }

  String toUtcString([String format = "yyyy-MM-dd hh:mm a"]) {
    var strDate = DateFormat(format).format(toUtc());
    return strDate;
  }

  String toLocalDateString([String format = "yyyy-MM-dd"]) {
    var strDate = DateFormat(format).format(toLocal());
    return strDate;
  }

  String toLocalYMDDateString([String format = "yyyy/MM/dd"]) {
    var strDate = DateFormat(format).format(toLocal());
    return strDate;
  }

  String toLocalMnyDateString([String format = "MMM dd, yyyy"]) {
    var strDate = DateFormat(format).format(toLocal());
    return strDate;
  }

  String toLocalDMMYYDateString([String format = "dd MMMM yyyy"]) {
    var strDate = DateFormat(format).format(toLocal());
    return strDate;
  }

  String toLocalDMYDateString([String format = "dd-MM-yyyy"]) {
    var strDate = DateFormat(format).format(toLocal());
    return strDate;
  }

  String toLocalDMMYDateString([String format = "dd-MMM-yyyy"]) {
    var strDate = DateFormat(format).format(toLocal());
    return strDate;
  }

  String toLocalMDateString([String format = "MMMM"]) {
    var strDate = DateFormat(format).format(toLocal());
    return strDate;
  }

  String toLocalTimeString([String format = "hh:mm a"]) {
    var strDate = DateFormat(format).format(toLocal());
    return strDate;
  }

  String toUTCTimeString([String format = "hh:mm a"]) {
    var strDate = DateFormat(format).format(toUtc());
    return strDate;
  }

  String toLocal24TimeString([String format = "HH:mm"]) {
    var strDate = DateFormat(format).format(toLocal());
    return strDate;
  }

  String toLocal12TimeString([String format = "hh:mm a"]) {
    var strDate = DateFormat(format).format(toLocal());
    return strDate;
  }

  bool get isToday {
    var now = DateTime.now();
    return day == now.day && month == now.month && year == now.year;
  }

  bool isSameDay(DateTime dateTime) {
    return day == dateTime.day && month == dateTime.month && year == dateTime.year;
  }
}

DateTime fromLocalYMDDateString(String date, [String format = "yyyy/MM/dd"]) {
  DateTime tempDate = DateFormat(format).parse(date);
  return tempDate;
}
DateTime fromLocalYMDDateTimeString(String date, [String format = "yyyy-MM-dd hh:mm:ss"]) {
  DateTime tempDate = DateFormat(format).parse(date);
  return tempDate;
}

DateTime fromLocalDDMMMYYYDateString(String date, [String format = "dd-MMM-yyyy"]) {
  DateTime tempDate = DateFormat(format).parse(date);
  return tempDate;
}

DateTime fromLocalYMMDateString(String date, [String format = "yyyy-MM-dd"]) {
  DateTime tempDate = DateFormat(format).parse(date);
  return tempDate;
}


deletePopupDialog(BuildContext context, type) {
  return AlertDialog(
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(10.sp))),
    contentPadding: EdgeInsets.all(20.sp),
    title: CommonText.semiBold('Notifying', size: 14.sp),
    content: Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text('Do you wish to remove this $type?'),
      ],
    ),
    actions: <Widget>[
      MaterialButton(
        onPressed: () {
          Navigator.of(context).pop(false);
        },
        textColor: Theme.of(context).primaryColor,
        child: const Text(
          'No',
          style: TextStyle(color: Colors.red),
        ),
      ),
      MaterialButton(
        onPressed: () {
          Navigator.of(context).pop(true);
        },
        textColor: Theme.of(context).primaryColor,
        child: const Text(
          'Yes',
          style: TextStyle(color: Colors.green),
        ),
      ),
    ],
  );
}

submitExamPopupDialog(BuildContext context) {
  return AlertDialog(
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(10.sp))),
    contentPadding: EdgeInsets.all(20.sp),
    title: CommonText.semiBold('Submit', size: 14.sp),
    content: const Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text('Are you sure, you want to submit your exam?'),
      ],
    ),
    actions: <Widget>[
      MaterialButton(
        onPressed: () {
          Navigator.of(context).pop(false);
        },
        textColor: Theme.of(context).primaryColor,
        child: const Text(
          'No',
          style: TextStyle(color: Colors.red),
        ),
      ),
      MaterialButton(
        onPressed: () {
          Navigator.of(context).pop(true);
        },
        textColor: Theme.of(context).primaryColor,
        child: const Text(
          'Yes',
          style: TextStyle(color: Colors.green),
        ),
      ),
    ],
  );
}

buildPopupDialogWishList(BuildContext context, isWishlisted, id, msg) {
  return AlertDialog(
    title: const Text('Notifying'),
    content: Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        msg ? const Text('Do you want remove it?') : const Text('Do you want to add it?'),
      ],
    ),
    actions: <Widget>[
      MaterialButton(
        onPressed: () {
          Navigator.of(context).pop();
        },
        textColor: Theme.of(context).primaryColor,
        child: const Text(
          'No',
          style: TextStyle(color: Colors.red),
        ),
      ),
      MaterialButton(
        onPressed: () {
          Navigator.of(context).pop();
          var msg = isWishlisted ? 'Remove from Wishlist' : 'Added to Wishlist';
          CommonFunctions.showSuccessToast(msg);
        },
        textColor: Theme.of(context).primaryColor,
        child: const Text(
          'Yes',
          style: TextStyle(color: Colors.green),
        ),
      ),
    ],
  );
}

Widget statusBadge(String status, Color backColor) {
  Color textColor = Colors.white;
  return Container(
    padding: EdgeInsets.symmetric(vertical: 4.sp, horizontal: 8.sp),
    decoration: BoxDecoration(color: backColor, borderRadius: BorderRadius.all(Radius.circular(4.r))),
    child: Row(
      children: [
        CommonText.semiBold(
          status,
          color: textColor,
          size: 14.sp,
        ),
      ],
    ),
  );
}
InputDecoration getInputDecoration(
    String hintText, [
      IconData? iconData,
      Color color = Colors.white,
      Color fillColor = kBackgroundColor,
    ]) {
  return InputDecoration(
    enabledBorder: OutlineInputBorder(
      borderRadius: BorderRadius.all(Radius.circular(12.0)),
      borderSide: BorderSide(color: color, width: 2),
    ),
    focusedBorder: OutlineInputBorder(
      borderRadius: BorderRadius.all(Radius.circular(12.0)),
      borderSide: BorderSide(color: color, width: 2),
    ),
    border: OutlineInputBorder(
      borderSide: BorderSide(color: color),
      borderRadius: BorderRadius.all(
        Radius.circular(12.0),
      ),
    ),
    focusedErrorBorder: OutlineInputBorder(
      borderRadius: BorderRadius.all(Radius.circular(12.0)),
      borderSide: BorderSide(color: Color(0xFFF65054)),
    ),
    errorBorder: OutlineInputBorder(
      borderRadius: BorderRadius.all(Radius.circular(12.0)),
      borderSide: BorderSide(color: Color(0xFFF65054)),
    ),
    filled: true,
    prefixIcon: iconData != null
        ? Icon(
      iconData,
      color: kTextLowBlackColor,
    )
        : null,
    hintStyle: TextStyle(
      color: Colors.black54,
      fontSize: 14,
    ),
    hintText: hintText,
    fillColor: fillColor,
    contentPadding: EdgeInsets.symmetric(
      vertical: 18,
      horizontal: 15,
    ),
  );
}
