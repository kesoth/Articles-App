import 'package:articles_app/utils/app_colors.dart';
import 'package:articles_app/utils/app_images.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:toggle_switch/toggle_switch.dart';

class Profile extends StatelessWidget {
  const Profile({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(children: [
      Container(
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
                      'UserNames',
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
                      'username@gmail.com',
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
                                'username@gmail.com',
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
                          Row(
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
                          SizedBox(
                            height: 27.h,
                          ),
                          Row(
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
              child: Image.asset(kProfileImage),
            ),
          ]))
    ]);
  }
}
