import 'package:articles_app/utils/app_colors.dart';
import 'package:articles_app/views/custom_widgets/custom_appbar.dart';
import 'package:articles_app/views/screens/account/profile_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AccountScreen extends StatelessWidget {
  const AccountScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          backgroundColor: kPrimaryTextColor,
          body: SingleChildScrollView(
              child: Column(children: [
            const CustomappBar(
              text: 'Account',
              showBackButton: false,
            ),
            Padding(
                padding: EdgeInsets.only(left: 347.w, top: 47.h),
                child: const Icon(
                  Icons.edit,
                  color: kSecondaryTextColor,
                )),
            const Profile(),
          ]))),
    );
  }
}
