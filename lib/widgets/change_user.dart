import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:masterjee/constants.dart';
import 'package:masterjee/widgets/app_tags.dart';
import 'package:masterjee/widgets/text.dart';

class ChangeUser extends StatefulWidget {
  const ChangeUser(BuildContext context, {super.key});

  @override
  State<ChangeUser> createState() => _ChangeUserState();
}

class _ChangeUserState extends State<ChangeUser> {
  String? _selectedSubject;
  String? _selectedSubjectId;

  List<String> subjectData = [
    "PA-1",
    "Personal",
    "Sanskrit",
    "Kannada",
    "English"
  ];

  void _showLogoutDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) => _changeUserPopup(context),
    );
  }

  Widget _changeUserPopup(BuildContext context) {
    var widthSize = MediaQuery.of(context).size.width;
    return AlertDialog(
      surfaceTintColor: Colors.white,
      insetPadding: EdgeInsets.only(left: 10, right: 10),
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(10))),
      content: SizedBox(
        width: widthSize,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Text(
              "Choose Class Section",
              style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: Colors.blue),
            ),
            DropdownButton(
              hint: const Text('Exam Type', style: TextStyle(fontSize: 14, color: Colors.black54)),
              value: _selectedSubject,
              icon: const Card(
                elevation: 0.1,
                color: Colors.white,
                child: Icon(Icons.keyboard_arrow_down_outlined),
              ),
              underline: const SizedBox(),
              onChanged: (value) {
                setState(() {
                  _selectedSubject = value.toString();
                  _selectedSubjectId = subjectData.firstWhere(
                        (element) => element.toLowerCase() == value.toString().toLowerCase(),
                    orElse: () => "",
                  );
                });
              },
              isExpanded: true,
              items: subjectData.map((cd) {
                return DropdownMenuItem(
                  value: cd,
                  child: Text(
                    cd.toString(),
                    style: const TextStyle(
                      color: Colors.black,
                      fontSize: 14,
                    ),
                  ),
                );
              }).toList(),
            )
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Logout Example")),
      body: Center(
        child: ElevatedButton(
          onPressed: () => _showLogoutDialog(context),
          child: const Text("Show Logout Dialog"),
        ),
      ),
    );
  }
}
