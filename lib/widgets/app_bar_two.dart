
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:masterjee/widgets/text.dart';
import '../constants.dart';

class CustomAppBarTwo extends StatefulWidget implements PreferredSizeWidget {
  @override
  final Size preferredSize;

  const CustomAppBarTwo({Key? key})
      : preferredSize = const Size.fromHeight(50.0),
        super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _CustomAppBarTwoState createState() => _CustomAppBarTwoState();
}

class _CustomAppBarTwoState extends State<CustomAppBarTwo> {
  String? url;
  bool isLoading = false;

  fetchMyLogo() async {
    setState(() {
      isLoading = true;
    });
    url = "";
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
      elevation: 0.3,
      iconTheme: const IconThemeData(
        color: kSecondaryColor, //change your color here
      ),
      centerTitle: true,
      title: Builder(
        builder: (context) {
          if (isLoading) {
            return SizedBox();
          }
          // saveImageUrlToSharedPref(snapshot.data.darkLogo);
          return CachedNetworkImage(
            imageUrl: url!.toString(),
            fit: BoxFit.contain,
            height: 27,
          );
        },
      ),
      backgroundColor: Colors.white,
    );
  }
}

class AppBarTwo extends StatelessWidget implements PreferredSizeWidget {
  @override
  final Size preferredSize;
  AppBarTwo({Key? key, required this.title, this.actions})
      : preferredSize = const Size.fromHeight(50.0),
        super(key: key);
  String title;
  List<Widget>? actions;

  @override
  Widget build(BuildContext context) {
    return AppBar(
        elevation: 2,
        iconTheme: const IconThemeData(
          color: kDarkButtonBg, //change your color here
        ),
        centerTitle: true,
        title: CommonText.bold(title, color: kDarkButtonBg, size: 18.sp),
        backgroundColor: Colors.white,
        actions: actions);
  }
}
