import 'package:articles_app/utils/app_colors.dart';
import 'package:articles_app/utils/app_images.dart';
import 'package:articles_app/views/custom_widgets/custom_appbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class P2ArticleScreen extends StatelessWidget {
  const P2ArticleScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
            backgroundColor: kBackgroundColor,
            body: SingleChildScrollView(
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                  const CustomappBar(text: 'Article 5'),
                  SizedBox(
                    height: 37.h,
                  ),
                  Image.asset(kArticle2),
                  SizedBox(
                    height: 57.h,
                  ),
                  Text(
                    'Looking forward to hearing from you. looking\nLooking forward to hearing from you. looking\nLooking forward to hearing from you. looking\nLooking forward to hearing from you. looking\nLooking forward to hearing from you. looking\nLooking forward to hearing from you. looking\nLooking forward to hearing from you. looking\nLooking forward to hearing from you. looking\nLooking forward to hearing from you. looking\nLooking forward to hearing from you. looking\nLooking forward to hearing from you. looking\nLooking forward to hearing from you. looking',
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 16.sp,
                      fontFamily: 'Inter',
                      fontWeight: FontWeight.w400,
                      height: 1.7,
                      letterSpacing: 0.9,
                    ),
                  )
                ]))));
  }
}
