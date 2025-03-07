import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
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
