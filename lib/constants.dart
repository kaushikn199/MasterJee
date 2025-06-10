// ignore_for_file: constant_identifier_names
import 'dart:collection';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:url_launcher/url_launcher.dart';

const BASE_URL = 'https://one2.in/cycode/cincharge/api/';
const IMAGE_URL = 'https://one2.in/p99/';

// list of colors that we use in our app
const colorWhite = Color(0xFFFFFFFF);
const colorGreen = Color(0xFF189C06);
const colorBlack = Color(0xFF15131c);
const colorGaryLine = Color(0xFFE5E5E5);
const colorGaryBG = Color(0xFFf7f9fa);
const colorGaryText = Color(0xFF686868);
const colorBlueText = Color(0xFF337ab7);
const kTextLowBlackColor = Colors.black38;
const kBackgroundColor = Color(0xFFF5F9FA);
const kSecondaryColor = Color(0xFF808080);
const kRedColor = Color(0xFFEC5252);
const kDarkButtonBg = Color(0xFF273546);
const kToastTextColor = Color(0xFFEEEEEE);
const kSecondBackgroundColor = Color(0xFFF5F9FF);
const kDarkGreyColor = Color(0xFF757575);
const kYellowColor = Color(0xFFDCB300);
const kDeepBlueColor = Color(0xFF594CF5);
const Color scaffoldTopGradientClr = Color(0xff1ec209);
const Color overlayContainerClr = Color(0xff2E2E2E);
const Color scaffoldBottomGradientClr = Color(0xffb1fba7);

const kDefaultInputBorder = OutlineInputBorder(
  borderRadius: BorderRadius.all(Radius.circular(12.0)),
  borderSide: BorderSide(color: Colors.white, width: 2),
);

const kDefaultFocusInputBorder = OutlineInputBorder(
  borderRadius: BorderRadius.all(Radius.circular(12.0)),
  borderSide: BorderSide(color: colorWhite, width: 2),
);
const kDefaultFocusErrorBorder = OutlineInputBorder(
  borderSide: BorderSide(color: colorWhite),
  borderRadius: BorderRadius.all(Radius.circular(12.0)),
);

// our default Shadow
const kDefaultShadow = BoxShadow(
  offset: Offset(20, 10),
  blurRadius: 20,
  color: Colors.black12, // Black color with 12% opacity
);

enum CoursesPageData {
  Category,
  Filter,
  Search,
  All,
}

enum HomeworkListType{
   upcoming,
   closed
}


void launchPhoneDialer(String? phoneNumber) async {
  final Uri phoneUri = Uri(scheme: 'tel', path: phoneNumber);

  if (await canLaunchUrl(phoneUri)) {
    await launchUrl(phoneUri);
  } else {
    throw 'Could not launch dialer for $phoneNumber';
  }
}

void openWhatsApp(String phoneNumber) async {
  final Uri whatsappUri = Uri.parse("https://wa.me/91$phoneNumber");

  if (await canLaunchUrl(whatsappUri)) {
    await launchUrl(whatsappUri, mode: LaunchMode.externalApplication);
  } else {
    throw 'Could not open WhatsApp for $phoneNumber';
  }
}

void openEmailApp(String email) async {
  final Uri emailUri = Uri(
    scheme: 'mailto',
    path: email,
    query: '', // You can add subject & body like: 'subject=Hello&body=Hi there'
  );

  if (await canLaunchUrl(emailUri)) {
    await launchUrl(emailUri);
  } else {
    throw 'Could not launch email app for $email';
  }
}

String formatTime(String time) {
  final inputFormat = DateFormat.Hm(); // "09:00"
  final outputFormat = DateFormat.jm(); // "09:00 AM"

  final parsedTime = inputFormat.parse(time);
  return outputFormat.format(parsedTime);
}




String formatFollowUpDate(String date, String time) {
  DateTime dateTime = DateTime.parse('$date $time');
  return DateFormat('dd MMMM yyyy hh:mm a').format(dateTime);
}

SizedBox gap(d) => SizedBox(height: d, width: d);

Size designSize(context) => MediaQuery.of(context).size.width < 450 ? const Size(360, 690) : const Size(768, 1024);

extension CapExtension on String {
  String get inCaps => length > 0 ? '${this[0].toUpperCase()}${substring(1)}' : '';

  String get capitalizeFirstOfEach => replaceAll(RegExp(' +'), ' ').split(" ").map((str) => str.inCaps).join(" ");
}

extension $DateTimeExtension on DateTime {
  String toLocalString([String format = "yyyy-MM-dd HH:mm:ss"]) {
    var strDate = DateFormat(format).format(toLocal());
    return strDate;
  }

  String toUtcString([String format = "yyyy-MM-dd HH:mm:ss"]) {
    var strDate = DateFormat(format).format(toUtc());
    return strDate;
  }

  String toLocalDateString([String format = "MM/dd/yyyy"]) {
    var strDate = DateFormat(format).format(toLocal());
    return strDate;
  }

  String toLocalYMDDateString([String format = "yyyy/MM/dd"]) {
    var strDate = DateFormat(format).format(toLocal());
    return strDate;
  }

  String toAPIYMDDateString([String format = "yyyy-MM-dd"]) {
    var strDate = DateFormat(format).format(toLocal());
    return strDate;
  }

  String toLocalMYYDateString([String format = "MMMM-yyyy"]) {
    var strDate = DateFormat(format).format(toLocal());
    return strDate.toUpperCase();
  }

  String toLocalMnyDateString([String format = "MMM dd, yyyy"]) {
    var strDate = DateFormat(format).format(toLocal());
    return strDate;
  }

  String toLocalDMYDateString([String format = "yyyy-MM-dd"]) {
    var strDate = DateFormat(format).format(toLocal());
    return strDate;
  }

  String toLocalMDYDateString([String format = "MM/dd/yyyy"]) {
    var strDate = DateFormat(format).format(toLocal());
    return strDate;
  }

  String toLocalMDYDateTimeString([String format = "MM/dd/yyyy hh:mm a"]) {
    var strDate = DateFormat(format).format(toLocal());
    return strDate;
  }

  String toLocalTimeString([String format = "hh:mm a"]) {
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

String formatDateString(String inputDate, String inputFormat, String outputFormat) {
  try {
    final dateTime = DateFormat(inputFormat).parse(inputDate);
    return DateFormat(outputFormat).format(dateTime);
  } catch (e) {
    return 'Invalid date';
  }
}




extension TimeExtension on String {
  String get fromLocalTimeDateString {
    String date = "2024-10-10 $this";
    DateTime tempDate = DateFormat('yyyy-MM-dd HH:mm').parse(date);
    return tempDate.toLocalTimeString();
  }
}



class Event {
  final String title;

  const Event(this.title);

  @override
  String toString() => title;
}

final kToday = DateTime.now();
final kFirstDay = DateTime(kToday.year, kToday.month - 3, kToday.day);
final kLastDay = DateTime(kToday.year, kToday.month + 20, kToday.day);

int getHashCode(DateTime key) {
  return key.day * 1000000 + key.month * 10000 + key.year;
}
