import 'package:articles_app/utils/app_colors.dart';
import 'package:articles_app/utils/app_images.dart';
import 'package:articles_app/utils/app_strings.dart';
import 'package:articles_app/views/custom_widgets/custom_appbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

class P3Screen extends StatefulWidget {
  const P3Screen({super.key});

  @override
  State<P3Screen> createState() => _P3ScreenState();
}

class _P3ScreenState extends State<P3Screen> {
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
                    text: 'P3',
                    showBackButton: false,
                  ),
                  SizedBox(
                    height: 40.h,
                  ),
                  InkWell(
                    onTap: () {
                      Get.toNamed(kP3ArticlesRoute);
                    },
                    child: SizedBox(
                      width: 220.w,
                      height: 160.h,
                      child: Stack(
                        children: [
                          Image.asset(kFolder),
                          Positioned(
                            top: 70,
                            left: 0,
                            right: 0,
                            child: Text(
                              'Articles',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 22.sp,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 40.h,
                  ),
                  InkWell(
                    onTap: () {
                      Get.toNamed(kP3TitlesRoute);
                    },
                    child: SizedBox(
                      width: 220.w,
                      height: 160.h,
                      child: Stack(
                        children: [
                          Image.asset(kFolder),
                          Positioned(
                            top: 70,
                            left: 0,
                            right: 0,
                            child: Text(
                              'Title',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 22.sp,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 40.h,
                  ),
                  InkWell(
                    onTap: () {
                      Get.toNamed(kP3GalleryRoute);
                    },
                    child: SizedBox(
                      width: 220.w,
                      height: 160.h,
                      child: Stack(
                        children: [
                          Image.asset(kFolder),
                          Positioned(
                            top: 70,
                            left: 0,
                            right: 0,
                            child: Text(
                              'Photos',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 22.sp,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ]))));
  }
}
