import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AuthController extends GetxController {
  GlobalKey<ScaffoldState> scaffoldKeyLogin = GlobalKey<ScaffoldState>();
  GlobalKey<ScaffoldState> scaffoldKeySignUp = GlobalKey<ScaffoldState>();

  TabController? tabController;
  TextEditingController name = TextEditingController(),
      loginEmail = TextEditingController(),
      loginPassword = TextEditingController(),
      signupEmail = TextEditingController(),
      signupFullName = TextEditingController(),
      signupPassword = TextEditingController(),
      signupconfirmPassword = TextEditingController();
  RxBool isHidePassword = true.obs;
  RxBool isHideConfirmPassword = true.obs;
  @override
  void onInit() {
    super.onInit();
  }
}
