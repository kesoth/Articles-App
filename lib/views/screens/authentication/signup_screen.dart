import 'package:articles_app/firebase/user_methods.dart';
import 'package:articles_app/generated/locale_keys.g.dart';
import 'package:articles_app/utils/app_colors.dart';
import 'package:articles_app/utils/app_images.dart';
import 'package:articles_app/utils/app_strings.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:articles_app/views/custom_widgets/custom_button.dart';
import 'package:articles_app/views/custom_widgets/customtextfield.dart';

import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../custom_widgets/my_snackbar.dart';
import 'package:easy_localization/easy_localization.dart' as local;

class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _fullnameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmpasswordController =
      TextEditingController();
  final FirebaseAuth _auth = FirebaseAuth.instance;
  bool success = false;

  String? _validateEmail(String? value) {
    if (value == null || value.isEmpty) {
      return 'Email is required';
    } else if (!RegExp(r'^[\w-]+(\.[\w-]+)*@([\w-]+\.)+[a-zA-Z]{2,7}$')
        .hasMatch(value)) {
      return 'Enter a valid email address';
    }
    return null;
  }

  String? _validateTextField(String? value) {
    if (value == null || value.isEmpty) {
      return 'all fields required';
    }
    return null;
  }

  String? _validatePassword(String? value) {
    if (value == null || value.isEmpty) {
      return 'Password is required';
    } else if (value.length < 6) {
      return 'Password must be at least 6 characters long';
    }
    return null;
  }

  bool _validateFields() {
    return (_validateEmail(_emailController.text) == null &&
        _validatePassword(_passwordController.text) == null &&
        _validatePassword(_confirmpasswordController.text) == null &&
        _validateTextField(_fullnameController.text) == null &&
        (_passwordController.text == _confirmpasswordController.text));
  }

  Future<void> signUp() async {
    try {
      await _auth.createUserWithEmailAndPassword(
        email: _emailController.text,
        password: _passwordController.text,
      );
      UserMethods()
          .addUserData(_emailController.text, _fullnameController.text);
      setState(() {
        success = true;
      });
    } catch (e) {
      print("error signing up $e");
    }
  }

  void signUpSuccess() {
    SnackBarHelper.showSnackbar(context, local.tr(LocaleKeys.signUpSuccess));
  }

  void signUpfail() {
    SnackBarHelper.showSnackbar(context, local.tr(LocaleKeys.signUpFail));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kBackgroundColor,
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              width: 430.w,
              height: 323.h,
              decoration: const ShapeDecoration(
                gradient: LinearGradient(
                  begin: Alignment(0.00, -1.00),
                  end: Alignment(0, 1),
                  colors: [kGradientColor1, kGradientColor2],
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(40),
                    bottomRight: Radius.circular(40),
                  ),
                ),
              ),
              child: Column(
                children: [
                  SizedBox(
                    height: 62.h,
                  ),
                  Image.asset(kAppLogo),
                  SizedBox(
                    height: 34.h,
                  ),
                  Text(
                    local.tr(LocaleKeys.signUp),
                    style: TextStyle(
                      color: kPrimaryTextColor,
                      fontSize: 24.sp,
                      fontFamily: 'Inter',
                      fontWeight: FontWeight.w600,
                      height: 0,
                    ),
                  )
                ],
              ),
            ),
            SizedBox(
              height: 91.h,
            ),
            CustomTextField(
              label: local.tr(LocaleKeys.email),
              controller: _emailController,
            ),
            SizedBox(
              height: 26.h,
            ),
            CustomTextField(
              label: local.tr(LocaleKeys.fullName),
              controller: _fullnameController,
            ),
            SizedBox(
              height: 26.h,
            ),
            CustomTextField(
              label: local.tr(LocaleKeys.password),
              controller: _passwordController,
              isPassword: true,
            ),
            SizedBox(
              height: 26.h,
            ),
            CustomTextField(
              label: local.tr(LocaleKeys.confirmPassword),
              controller: _confirmpasswordController,
              isPassword: true,
            ),
            SizedBox(
              height: 48.h,
            ),
            InkWell(
              onTap: () async {
                try {
                  if (_validateFields()) {
                    await signUp();
                    if (success) {
                      signUpSuccess();
                      Get.offAndToNamed(kLoginRoute);
                    } else {
                      signUpfail();
                    }
                  } else {
                    SnackBarHelper.showSnackbar(
                        context, local.tr(LocaleKeys.enterValidFields));
                  }
                } catch (e) {
                  print("sign up failed");
                }
              },
              child: CustomButton(
                text: local.tr(LocaleKeys.signUp).toUpperCase(),
              ),
            ),
            SizedBox(
              height: 19.h,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  local.tr(LocaleKeys.haveAccount),
                  style: TextStyle(
                    color: kHintTextColor,
                    fontSize: 12.sp,
                    fontFamily: 'Inter',
                    fontWeight: FontWeight.w500,
                    height: 0,
                  ),
                ),
                InkWell(
                  onTap: () {
                    Get.offAndToNamed(kLoginRoute);
                  },
                  child: Text(
                    local.tr(LocaleKeys.signIn),
                    style: TextStyle(
                      color: kPrimaryMainColor,
                      fontSize: 12.sp,
                      fontFamily: 'Inter',
                      fontWeight: FontWeight.w500,
                      height: 0,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
