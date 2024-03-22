import 'dart:io';

import 'package:articles_app/firebase/firebaseStorage.dart';
import 'package:articles_app/firebase/user_methods.dart';
import 'package:articles_app/generated/locale_keys.g.dart';
import 'package:articles_app/providers/user.dart';
import 'package:articles_app/utils/app_colors.dart';
import 'package:articles_app/utils/app_images.dart';
import 'package:articles_app/utils/app_strings.dart';
import 'package:articles_app/views/custom_widgets/customtextfield.dart';
import 'package:articles_app/views/custom_widgets/my_snackbar.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:toggle_switch/toggle_switch.dart';

import '../../custom_widgets/firebaseNetworkImage.dart';
import 'package:easy_localization/easy_localization.dart' as local;

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
  File? _imageFile;
  String? imagePath;
  final ImagePicker _imagePicker = ImagePicker();

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

  Future<void> _pickImage() async {
    final XFile? pickedFile =
        await _imagePicker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() {
        _imageFile = File(pickedFile.path);
        imagePath = pickedFile.path;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return loaded
        ? Stack(children: [
            InkWell(
              onTap: () => editProfileSheet(context),
              child: Padding(
                padding: EdgeInsets.only(left: 347.w, top: 47.h),
                child: const Icon(
                  Icons.edit,
                  color: kSecondaryTextColor,
                ),
              ),
            ),
            SingleChildScrollView(
              child: Container(
                  height: 560.h,
                  width: 357.w,
                  padding: EdgeInsets.only(top: 50.w),
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
                                    local.tr(LocaleKeys.chooseLanguage),
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
                                    initialLabelIndex: context.locale ==
                                            const Locale('fr', 'FR')
                                        ? 0
                                        : 1,
                                    totalSwitches: 2,
                                    activeBgColor: const [kPrimaryMainColor],
                                    activeFgColor: Colors.white,
                                    inactiveBgColor: kSecondaryTextColor,
                                    inactiveFgColor: kPrimaryMainColor,
                                    labels: const ['French', 'German'],
                                    onToggle: (index) async {
                                      if (index == 0) {
                                        final newLocale =
                                            context.supportedLocales[0];
                                        await context.setLocale(newLocale);
                                        Get.updateLocale(newLocale);
                                      } else if (index == 1) {
                                        final newLocale =
                                            context.supportedLocales[1];
                                        await context.setLocale(newLocale);
                                        Get.updateLocale(newLocale);
                                      }
                                      setState(() {});
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
                                          local.tr(LocaleKeys.chooseLanguage),
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
                                          local.tr(LocaleKeys.logout),
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
                          : ClipOval(
                              child: FirebaseNetworkImage(
                                imagePath: profile!,
                                width: 150.w,
                                height: 150.w,
                              ),
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
    final UserProvider userProvider =
        Provider.of<UserProvider>(context, listen: false);
    userProvider.clear();
    await FirebaseAuth.instance.signOut();
    Get.offAllNamed(kLoginRoute);
  }

  void editProfileSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return Padding(
          padding: const EdgeInsets.all(20),
          child: StatefulBuilder(
              builder: (BuildContext context, StateSetter setState) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  GestureDetector(
                    onTap: () async {
                      await _pickImage();
                      setState(() {});
                    },
                    child: Container(
                        width: 150,
                        height: 150,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: Colors.grey[200],
                        ),
                        child: _imageFile != null &&
                                _imageFile!.path.isNotEmpty &&
                                _imageFile!.path != ""
                            ? Container(
                                width: 150,
                                height: 150,
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: Colors.grey[200],
                                ),
                                child: ClipOval(
                                  child: Image.file(
                                    width: 150,
                                    height: 150,
                                    File(imagePath!),
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              )
                            : const Icon(Icons.add,
                                size: 50, color: Colors.blue)),
                  ),
                  const SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: () async {
                      await updateProfile();
                      Navigator.pop(context);
                      setState(() {
                        _imageFile = null;
                        imagePath = null;
                      });
                    },
                    child: const Text('Upload'),
                  ),
                ],
              ),
            );
          }),
        );
      },
    ).whenComplete(
      () => setState(
        () {
          _imageFile = null;
          imagePath = null;
        },
      ),
    );
  }

  Future<void> updateProfile() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? id = prefs.getString('userId');
    try {
      String? image = await uploadImage(_imageFile!);
      await UserMethods().updateProfile(id!, image);
      await prefs.setString('userProfile', image);
      await getUserData();
      setState(() {});
      SnackBarHelper.showSnackbar(context, local.tr(LocaleKeys.success));
    } catch (e) {
      SnackBarHelper.showSnackbar(context, local.tr(LocaleKeys.failure));
    }
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
                    Text(
                      local.tr(LocaleKeys.enterOldPass),
                      style: const TextStyle(
                        fontSize: 12.0,
                        color: kHintTextColor,
                      ),
                    ),
                    CustomTextField(
                      controller: oldPasswordController,
                      isPassword: true,
                      label: local.tr(LocaleKeys.oldPassword),
                    ),
                    const SizedBox(height: 10.0),
                    Text(
                      local.tr(LocaleKeys.enterNewPassword),
                      style: const TextStyle(
                        fontSize: 12.0,
                        color: kHintTextColor,
                      ),
                    ),
                    CustomTextField(
                      controller: newPasswordController,
                      isPassword: true,
                      label: local.tr(LocaleKeys.newPassword),
                    ),
                    const SizedBox(height: 10.0),
                    Text(
                      local.tr(LocaleKeys.confirmNewPassword),
                      style: const TextStyle(
                        fontSize: 12.0,
                        color: kHintTextColor,
                      ),
                    ),
                    CustomTextField(
                      controller: confirmPasswordController,
                      isPassword: true,
                      label: local.tr(LocaleKeys.enterConfirmNewPassword),
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
                          SnackBarHelper.showSnackbar(context,
                              local.tr(LocaleKeys.incorrectOldPassword));
                          return;
                        }

                        if (newPassword != confirmPassword) {
                          Navigator.pop(context);
                          SnackBarHelper.showSnackbar(
                              context, local.tr(LocaleKeys.passwordMismatch));
                          return;
                        }
                        changePassword(newPassword);
                        Navigator.pop(context);
                      },
                      child: Text(local.tr(LocaleKeys.changePassword)),
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
      SnackBarHelper.showSnackbar(
          context, local.tr(LocaleKeys.wrongOldPassEntered));
      return false;
    }
  }

  void changePassword(String newPassword) async {
    try {
      User? user = FirebaseAuth.instance.currentUser;
      if (user != null) {
        await user.updatePassword(newPassword);
        SnackBarHelper.showSnackbar(
            context, local.tr(LocaleKeys.passwordUpdateSuccess));
      } else {
        print('User not signed in');
      }
    } catch (e) {
      print('Error updating password: $e');
    }
  }
}
