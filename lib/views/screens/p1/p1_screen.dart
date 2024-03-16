import 'package:articles_app/utils/app_colors.dart';
import 'package:articles_app/utils/app_strings.dart';
import 'package:articles_app/views/custom_widgets/custom_appbar.dart';
import 'package:articles_app/views/custom_widgets/custom_container.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class P1Screen extends StatefulWidget {
  const P1Screen({super.key});

  @override
  State<P1Screen> createState() => _P1ScreenState();
}

class _P1ScreenState extends State<P1Screen> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
            backgroundColor: kBackgroundColor,
            body: SingleChildScrollView(
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                  const CustomappBar(
                    text: 'P1',
                    showBackButton: false,
                  ),
                  SizedBox(
                    height: 70.h,
                  ),
                  InkWell(
                    onTap: () {
                      Get.toNamed(kP1ArticlesRoute);
                     
                    },
                    child: const CustomContainer(
                        text: 'ARTICLE 1', containercolor: kContainer1Color),
                  ),
                  SizedBox(
                    height: 38.h,
                  ),
                  const CustomContainer(
                      text: 'ARTICLE 2', containercolor: kContainer2Color),
                  SizedBox(
                    height: 38.h,
                  ),
                  const CustomContainer(
                      text: 'ARTICLE 3', containercolor: kContainer3Color),
                ]))));
  }
}
