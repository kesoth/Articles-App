import 'package:articles_app/providers/user.dart';
import 'package:articles_app/utils/app_colors.dart';
import 'package:articles_app/utils/app_images.dart';
import 'package:articles_app/utils/app_strings.dart';
import 'package:articles_app/views/custom_widgets/customtextfield.dart';
import 'package:articles_app/views/custom_widgets/my_snackbar.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:toggle_switch/toggle_switch.dart';

import '../../custom_widgets/firebaseNetworkImage.dart';

class Profile extends StatefulWidget {
  const Profile({super.key});

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  String? name;
  String? email;
  String? profile;
  bool loaded = false;
  @override
  void initState() {
    super.initState();
    getUserData();
  }

  Future<void> getUserData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      name = prefs.getString('userName');
      email = prefs.getString('userEmail');
      profile = prefs.getString('userProfile');
      loaded = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    return loaded
        ? Stack(children: [
            SingleChildScrollView(
              child: Container(
                  height: 560.h,
                  width: 357.w,
                  color: Colors.transparent,
                  child: Stack(children: [
                    Positioned(
                      top: 75,
                      child: Container(
                        width: 357.w,
                        height: 532.h,
                        decoration: ShapeDecoration(
                          color: Colors.white,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(5.r),
                          ),
                          shadows: [
                            BoxShadow(
                              color: kTextFieldColor,
                              blurRadius: 4.r,
                              offset: const Offset(0, 1),
                              spreadRadius: 0,
                            ),
                          ],
                        ),
                        child: Column(
                          children: [
                            SizedBox(
                              height: 80.h,
                            ),
                            Text(
                              name!,
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 24.sp,
                                fontFamily: 'Inter',
                                fontWeight: FontWeight.w600,
                                height: 0,
                              ),
                            ),
                            SizedBox(
                              height: 7.h,
                            ),
                            Text(
                              email!,
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                color: kSecondaryTextColor,
                                fontSize: 14.sp,
                                fontFamily: 'Inter',
                                fontWeight: FontWeight.w500,
                                height: 0,
                              ),
                            ),
                            SizedBox(
                              height: 36.h,
                            ),
                            Container(
                              width: 332.w,
                              decoration: ShapeDecoration(
                                shape: RoundedRectangleBorder(
                                  side: BorderSide(
                                    width: 1.w,
                                    strokeAlign: BorderSide.strokeAlignCenter,
                                    color: kSecondaryTextColor,
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(
                              height: 25.h,
                            ),
                            Padding(
                              padding: EdgeInsets.only(left: 36.w),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'Choose language',
                                    style: TextStyle(
                                      color: kSecondaryTextColor,
                                      fontSize: 12.sp,
                                      fontFamily: 'Inter',
                                      fontWeight: FontWeight.w500,
                                      height: 0,
                                    ),
                                  ),
                                  SizedBox(
                                    height: 10.h,
                                  ),
                                  ToggleSwitch(
                                    minWidth: 150.w,
                                    minHeight: 35.h,
                                    initialLabelIndex: 0,
                                    totalSwitches: 2,
                                    activeBgColor: const [kPrimaryMainColor],
                                    activeFgColor: Colors.white,
                                    inactiveBgColor: kSecondaryTextColor,
                                    inactiveFgColor: kPrimaryMainColor,
                                    labels: const ['French', 'German'],
                                    onToggle: (index) {
                                      print('switched to: $index');
                                    },
                                  ),
                                  SizedBox(
                                    height: 22.h,
                                  ),
                                  Row(
                                    children: [
                                      const Icon(
                                        Icons.mail,
                                        color: kSecondaryTextColor,
                                      ),
                                      SizedBox(
                                        width: 42.w,
                                      ),
                                      Text(
                                        email!,
                                        style: TextStyle(
                                          color: kSecondaryTextColor,
                                          fontSize: 12.sp,
                                          fontFamily: 'Inter',
                                          fontWeight: FontWeight.w500,
                                          height: 0,
                                        ),
                                      )
                                    ],
                                  ),
                                  SizedBox(
                                    height: 27.h,
                                  ),
                                  InkWell(
                                    onTap: () =>
                                        _showChangePasswordBottomSheet(context),
                                    child: Row(
                                      children: [
                                        const Icon(
                                          Icons.lock,
                                          color: kSecondaryTextColor,
                                        ),
                                        SizedBox(
                                          width: 42.w,
                                        ),
                                        Text(
                                          'Change password',
                                          style: TextStyle(
                                            color: kSecondaryTextColor,
                                            fontSize: 12.sp,
                                            fontFamily: 'Inter',
                                            fontWeight: FontWeight.w500,
                                            height: 0,
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                  SizedBox(
                                    height: 27.h,
                                  ),
                                  InkWell(
                                    onTap: () => _signOut(),
                                    child: Row(
                                      children: [
                                        const Icon(
                                          Icons.logout,
                                          color: kSecondaryTextColor,
                                        ),
                                        SizedBox(
                                          width: 42.w,
                                        ),
                                        Text(
                                          'logout',
                                          style: TextStyle(
                                            color: kSecondaryTextColor,
                                            fontSize: 12.sp,
                                            fontFamily: 'Inter',
                                            fontWeight: FontWeight.w500,
                                            height: 0,
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                    Positioned(
                      top: 1.h,
                      left: 100.w,
                      child: profile == null || profile == ""
                          ? Image.asset(kProfileImage)
                          : FirebaseNetworkImage(
                              imagePath: profile!,
                              width: 150.w,
                              height: 150.w,
                            ),
                    ),
                  ])),
            )
          ])
        : Center(
            child: Container(
              child: const CircularProgressIndicator(),
            ),
          );
  }

  Future<void> _signOut() async {
    // SharedPreferences prefs = await SharedPreferences.getInstance();
    // prefs.clear();
    final UserProvider userProvider =
        Provider.of<UserProvider>(context, listen: false);
    userProvider.clear();
    await FirebaseAuth.instance.signOut();
    Get.offAllNamed(kLoginRoute);
  }

  void _showChangePasswordBottomSheet(BuildContext context) {
    TextEditingController oldPasswordController = TextEditingController();
    TextEditingController newPasswordController = TextEditingController();
    TextEditingController confirmPasswordController = TextEditingController();

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (BuildContext context) {
        return Padding(
          padding:
              EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
          child: StatefulBuilder(
            builder: (BuildContext context, StateSetter setState) {
              return Container(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Enter old password:',
                      style: TextStyle(
                        fontSize: 12.0,
                        color: kHintTextColor,
                      ),
                    ),
                    CustomTextField(
                      controller: oldPasswordController,
                      isPassword: true,
                      label: 'Old password',
                    ),
                    const SizedBox(height: 10.0),
                    const Text(
                      'Enter new password:',
                      style: TextStyle(
                        fontSize: 12.0,
                        color: kHintTextColor,
                      ),
                    ),
                    CustomTextField(
                      controller: newPasswordController,
                      isPassword: true,
                      label: 'New password',
                    ),
                    const SizedBox(height: 10.0),
                    const Text(
                      'Confirm new password:',
                      style: TextStyle(
                        fontSize: 12.0,
                        color: kHintTextColor,
                      ),
                    ),
                    CustomTextField(
                      controller: confirmPasswordController,
                      isPassword: true,
                      label: 'Confirm new Password',
                    ),
                    const SizedBox(height: 10.0),
                    ElevatedButton(
                      onPressed: () async {
                        String oldPassword = oldPasswordController.text;
                        String newPassword = newPasswordController.text;
                        String confirmPassword = confirmPasswordController.text;

                        bool isOldPasswordValid =
                            await _validateOldPassword(oldPassword);
                        if (!isOldPasswordValid) {
                          SnackBarHelper.showSnackbar(
                              context, "Incorrect old password");
                          return;
                        }

                        if (newPassword != confirmPassword) {
                          Navigator.pop(context);
                          SnackBarHelper.showSnackbar(context,
                              'New password and confirm password do not match');
                          return;
                        }
                        changePassword(newPassword);
                        Navigator.pop(context);
                      },
                      child: const Text('Change Password'),
                    ),
                  ],
                ),
              );
            },
          ),
        );
      },
    );
  }

  Future<bool> _validateOldPassword(String oldPassword) async {
    try {
      UserCredential userCredential =
          await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: FirebaseAuth.instance.currentUser!.email!,
        password: oldPassword,
      );
      return true;
    } catch (e) {
      Navigator.pop(context);
      SnackBarHelper.showSnackbar(context, "Wrong old password entered");
      return false;
    }
  }

  void changePassword(String newPassword) async {
    try {
      User? user = FirebaseAuth.instance.currentUser;
      if (user != null) {
        await user.updatePassword(newPassword);
        SnackBarHelper.showSnackbar(context, "Password Updated successfully");
      } else {
        print('User not signed in');
      }
    } catch (e) {
      print('Error updating password: $e');
    }
  }
}
