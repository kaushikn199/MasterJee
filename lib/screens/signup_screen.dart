import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:masterjee/constants.dart';
import 'package:masterjee/screens/home/main_screen.dart';
import 'package:masterjee/widgets/app_tags.dart';
import 'package:masterjee/widgets/custom_form_field.dart';
import 'package:masterjee/widgets/text.dart';

import 'forgot_password_screen.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});

  static const routeName = '/signup';

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  GlobalKey<FormState> globalFormKey = GlobalKey<FormState>();

  bool hidePassword = true;
  bool _isLoading = false;
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final scaffoldKey = GlobalKey<ScaffoldState>();

  InputDecoration getInputDecoration(String hintext, IconData iconData) {
    return InputDecoration(
      enabledBorder: const OutlineInputBorder(
        borderRadius: BorderRadius.all(Radius.circular(12.0)),
        borderSide: BorderSide(color: Colors.white, width: 2),
      ),
      focusedBorder: const OutlineInputBorder(
        borderRadius: BorderRadius.all(Radius.circular(12.0)),
        borderSide: BorderSide(color: Colors.white, width: 2),
      ),
      border: const OutlineInputBorder(
        borderSide: BorderSide(color: Colors.white),
        borderRadius: BorderRadius.all(
          Radius.circular(12.0),
        ),
      ),
      focusedErrorBorder: const OutlineInputBorder(
        borderRadius: BorderRadius.all(Radius.circular(12.0)),
        borderSide: BorderSide(color: Color(0xFFF65054)),
      ),
      errorBorder: const OutlineInputBorder(
        borderRadius: BorderRadius.all(Radius.circular(12.0)),
        borderSide: BorderSide(color: Color(0xFFF65054)),
      ),
      filled: true,
      prefixIcon: Icon(
        iconData,
        color: kTextLowBlackColor,
      ),
      hintStyle: const TextStyle(color: Colors.black54, fontSize: 14),
      hintText: hintext,
      fillColor: kBackgroundColor,
      contentPadding: const EdgeInsets.symmetric(vertical: 18, horizontal: 15),
    );
  }

  Future<void> _submit() async {
    if (!globalFormKey.currentState!.validate()) {
      // Invalid!
      return;
    }
    globalFormKey.currentState!.save();
    Navigator.pushNamedAndRemoveUntil(context, '/Main', (r) => false);

   /* setState(() {
      _isLoading = true;
    });*/
   /* try {
      // Log user in
      await Provider.of<Auth>(context, listen: false).login(
        _authData['username'].toString(),
        _authData['password'].toString(),
      );

      // ignore: use_build_context_synchronously
      Navigator.pushNamedAndRemoveUntil(context, '/home', (r) => false);
      CommonFunctions.showSuccessToast('Login Successful');
    } on HttpException {
      var errorMsg = 'Auth failed';
      CommonFunctions.showErrorDialog(errorMsg, context);
    } catch (error) {
      // print(error);
      const errorMsg = 'Could not authenticate!';
      CommonFunctions.showErrorDialog(errorMsg, context);
    }
    setState(() {
      _isLoading = false;
    });*/
  }


  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      backgroundColor: colorGaryBG,
      appBar: AppBar(
        key: scaffoldKey,
        elevation: 0,
        backgroundColor: colorGaryBG,
        automaticallyImplyLeading: false, // Hides the back button
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Center(
              child: Form(
                key: globalFormKey,
                child: Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: Card(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                    elevation: 0,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        const SizedBox(
                          height: 25,
                        ),
                        CircleAvatar(
                          radius: 50,
                          backgroundColor: colorGaryBG,
                          child: Image.asset(
                            AssetsUtils.logoIcon,
                            height: 70,
                          ),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        const Text(
                          'Log in',
                          style: TextStyle(
                            fontSize: 22,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                        const SizedBox(height: 20),
                        const Align(
                          alignment: Alignment.centerLeft,
                          child: Padding(
                            padding: EdgeInsets.only(left: 17.0, bottom: 5.0),
                            child: Text(
                              'Email',
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                          ),
                        ),
                        Padding(
                          padding:
                          const EdgeInsets.only(left: 15.0, top: 0.0, right: 15.0, bottom: 8.0),
                          child: TextFormField(
                            style: const TextStyle(fontSize: 14),
                            decoration: getInputDecoration(
                              'Email',
                              Icons.email_outlined,
                            ),
                            controller: _emailController,
                            keyboardType: TextInputType.emailAddress,
                            validator: (input) =>
                            !RegExp(r"[a-z0-9!#$%&'*+/=?^_`{|}~-]+(?:\.[a-z0-9!#$%&'*+/=?^_`{|}~-]+)*@(?:[a-z0-9](?:[a-z0-9-]*[a-z0-9])?\.)+[a-z0-9](?:[a-z0-9-]*[a-z0-9])?")
                                .hasMatch(input!)
                                ? "Email Id should be valid"
                                : null,
                            onSaved: (value) {
                             // _authData['email'] = value.toString();
                             // _emailController.text = value as String;
                            },
                          ),
                        ),
                        const SizedBox(height: 10),
                        const Align(
                          alignment: Alignment.centerLeft,
                          child: Padding(
                            padding: EdgeInsets.only(left: 17.0, bottom: 5.0),
                            child: Text(
                              'Password',
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                          ),
                        ),
                        Padding(
                          padding:
                          const EdgeInsets.only(left: 15.0, top: 0.0, right: 15.0, bottom: 4.0),
                          child: TextFormField(
                            style: const TextStyle(color: Colors.black),
                            keyboardType: TextInputType.text,
                            controller: _passwordController,
                            onSaved: (input) {
                             // _authData['password'] = input.toString();
                             // _passwordController.text = input as String;
                            },
                            validator: (input) => input!.length < 3
                                ? "Password should be more than 3 characters"
                                : null,
                            obscureText: hidePassword,
                            decoration: InputDecoration(
                              enabledBorder: const OutlineInputBorder(
                                borderRadius: BorderRadius.all(Radius.circular(12.0)),
                                borderSide: BorderSide(color: Colors.white, width: 2),
                              ),
                              focusedBorder: const OutlineInputBorder(
                                borderRadius: BorderRadius.all(Radius.circular(12.0)),
                                borderSide: BorderSide(color: Colors.white, width: 2),
                              ),
                              border: const OutlineInputBorder(
                                borderSide: BorderSide(color: Colors.white),
                                borderRadius: BorderRadius.all(
                                  Radius.circular(12.0),
                                ),
                              ),
                              filled: true,
                              hintStyle: const TextStyle(color: Colors.black54, fontSize: 14),
                              hintText: "password",
                              fillColor: kBackgroundColor,
                              contentPadding:
                              const EdgeInsets.symmetric(vertical: 18, horizontal: 15),
                              prefixIcon: const Icon(
                                Icons.lock_outlined,
                                color: kTextLowBlackColor,
                              ),
                              suffixIcon: IconButton(
                                onPressed: () {
                                  setState(() {
                                    hidePassword = !hidePassword;
                                  });
                                },
                                color: kTextLowBlackColor,
                                icon: Icon(hidePassword
                                    ? Icons.visibility_off_outlined
                                    : Icons.visibility_outlined),
                              ),
                            ),
                          ),
                        ),
                        InkWell(
                          onTap: () {
                            Navigator.of(context).pushNamed(ForgotPassword.routeName);
                          },
                          child: const Padding(
                            padding: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                            child: Align(
                              alignment: Alignment.centerRight,
                              child: Text(
                                'Forget Password?',
                                style: TextStyle(color: kSecondaryColor),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          width: double.infinity,
                          child: _isLoading
                              ? const Center(child: CircularProgressIndicator())
                              : Padding(
                            padding: const EdgeInsets.all(15.0),
                            child: MaterialButton(
                              elevation: 0,
                              color: colorGreen,
                              onPressed: _submit,
                              padding:
                              const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadiusDirectional.circular(10),
                                // side: const BorderSide(color: kRedColor),
                              ),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: const [
                                  Text(
                                    'Log In',
                                    style: TextStyle(
                                      fontSize: 16,
                                      color: Colors.white,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(height: 20),
                      ],
                    ),
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 15, right: 15),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    'Do not have an account?',
                    style: TextStyle(
                      color: kTextLowBlackColor,
                      fontSize: 15,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                  InkWell(
                    onTap: () {
                      //Navigator.of(context).pushNamed(SignUpScreen.routeName);
                    },
                    child: const Text(
                      ' Sign up',
                      style: TextStyle(
                        fontSize: 17,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );


    /*Scaffold(
        backgroundColor: colorGaryBG,
        body: SingleChildScrollView(
          child: Form(
            key: globalFormKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Container(
                  width: double.infinity,
                  decoration: const BoxDecoration(
                      borderRadius: BorderRadius.only(
                          bottomLeft: Radius.circular(25),
                          bottomRight: Radius.circular(25)),
                      color: colorGreen),
                  child: CommonText.bold(
                    textAlign: TextAlign.center,
                    AppTags.signIn,
                    size: 16.sp,
                    color: colorWhite,
                  ).paddingOnly(top: 70, bottom: 20),
                ),
                SvgPicture.asset(
                  width: double.infinity,
                  height: MediaQuery.of(context).size.height / 3,
                  'assets/images/ic_signup_image.svg',
                  fit: BoxFit.cover,
                ).paddingOnly(top: 10),
                CommonText.semiBold(
                  textAlign: TextAlign.center,
                  AppTags.letSignIn,
                  size: 24.sp,
                  color: colorBlack,
                ).paddingOnly(top: 10),
                const SizedBox(
                  width: double.infinity,
                  height: 1,
                  child: DecoratedBox(
                    decoration: BoxDecoration(color: colorGaryLine),
                  ),
                ).paddingOnly(left: 20, right: 20, top: 20),
                CustomTextField(
                  hintText: 'User email',
                  isRequired: true,
                  controller: _emailController,
                  keyboardType: TextInputType.emailAddress,
                  validate: (input) =>
                      !RegExp(r"[a-z0-9!#$%&'*+/=?^_`{|}~-]+(?:\.[a-z0-9!#$%&'*+/=?^_`{|}~-]+)*@(?:[a-z0-9](?:[a-z0-9-]*[a-z0-9])?\.)+[a-z0-9](?:[a-z0-9-]*[a-z0-9])?")
                              .hasMatch(input!)
                          ? "Email Id should be valid"
                          : null,
                  onSave: (value) {
                    // _authData['email'] = value.toString();
                    _emailController.text = value as String;
                  },
                ).paddingOnly(left: 20, right: 20, top: 25),
                CustomTextField(
                  obscureText: true,
                  maxLines: 1,
                  hintText: 'Password',
                  isRequired: true,
                  controller: _passwordController,
                  keyboardType: TextInputType.text,
                  validate: (input) {
                    if (input!.isEmpty) {
                      return 'Password cannot be empty';
                    }
                    return null;
                  },
                  onSave: (value) {
                    // _authData['email'] = value.toString();
                    _passwordController.text = value as String;
                  },
                ).paddingOnly(left: 20, right: 20, top: 10),
                SizedBox(
                  height: 30.h,
                ),
                MaterialButton(
                  onPressed: () {
                    if (globalFormKey.currentState!.validate()) {
                      Navigator.of(context).pushNamed(MainScreen.routeName);
                    }
                  },
                  color: colorGreen,
                  textColor: Colors.black,
                  padding:
                      const EdgeInsets.symmetric(horizontal: 135, vertical: 13),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30.0),
                    // side: const BorderSide(color: kRedColor),
                  ),
                  child: CommonText.bold(
                    textAlign: TextAlign.center,
                    AppTags.signIn,
                    size: 16.sp,
                    color: colorWhite,
                  ),
                ),
                SizedBox(
                  height: 12.h,
                ),
              ],
            ),
          ),
        ));*/
  }
}
