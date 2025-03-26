import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:masterjee/widgets/app_tags.dart';
import '../constants.dart';

class CustomHomeAppBar extends StatefulWidget implements PreferredSizeWidget {
  @override
  final Size preferredSize;

  CustomHomeAppBar({Key? key})
      : preferredSize = const Size.fromHeight(50.0),
        super(key: key);

  @override
  _CustomHomeAppBarState createState() => _CustomHomeAppBarState();
}

class _CustomHomeAppBarState extends State<CustomHomeAppBar> with TickerProviderStateMixin {
  bool isClicked = false;
  String? url;
  bool isLoading = false;

  fetchMyLogo() async {
    setState(() {
      isLoading = true;
    });
    //url = LocalDatabase.schoolLogo;
    setState(() {
      isLoading = false;
    });
  }

  @override
  void initState() {
    fetchMyLogo();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return AppBar(
      elevation: 0,
      iconTheme: const IconThemeData(
        color: kSecondaryColor, //change your color here
      ),
      leading: IconButton(
        onPressed: () {
          Scaffold.of(context).openDrawer();
        },
        icon: const Icon(Icons.menu),
      ),
      centerTitle: true,
      backgroundColor: Colors.white,
      actions: const <Widget>[
      ],
    );
  }
}
