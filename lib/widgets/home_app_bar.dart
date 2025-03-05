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
  // ignore: library_private_types_in_public_api
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
      /*title: Builder(
        builder: (context) {
          if (isLoading) {
            return SizedBox();
          }
          // saveImageUrlToSharedPref(snapshot.data.darkLogo);
          return Image.asset(AssetsUtils.logoIcon,height: 27.sp,)*//*CachedNetworkImage(
            imageUrl: url!.toStrin.g(),
            fit: BoxFit.contain,
            height: 27.sp,
          )*//*;
        },
      ),*/
      backgroundColor: Colors.white,
      actions: <Widget>[
        // IconButton(
        //   icon: const Icon(
        //     Icons.notifications_none_rounded,
        //     color: kSecondaryColor,
        //   ),
        //   onPressed: () => {},
        // ),
      ],
    );
  }
}
