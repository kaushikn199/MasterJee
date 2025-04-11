import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:masterjee/constants.dart';
import 'package:masterjee/others/StorageHelper.dart';
import 'package:masterjee/screens/home/main_screen.dart';
import 'package:masterjee/screens/signup_screen.dart';
import 'package:masterjee/widgets/app_tags.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});
  static const routeName = 'sp';

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {

  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(milliseconds: 3000), () async {
       // Navigator.of(context).pushNamed(SignupScreen.routeName);
        if(await StorageHelper.isLoggedIn()){
          Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => const MainScreen()));
        }else{
          Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => const SignupScreen()));
        }

    });

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: colorWhite,
      body: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(100.r)),
                  border: Border.all(color: Colors.white, width: 5.r)),
              child: SizedBox(
                height: 100.sp,
                width: 100.sp,
                child: Padding(
                  padding: EdgeInsets.all(10.sp),
                  child: Image.asset(
                    AssetsUtils.logoIcon,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}