import 'package:articles_app/utils/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomButton extends StatelessWidget {
  final String text;
  const CustomButton({super.key, required this.text});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 347.w,
      height: 51.h,
      decoration: ShapeDecoration(
        color: kPrimaryMainColor,
        shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.r)),
      ),
      child: Center(
          child: Text(
        text,
        style: TextStyle(
          color: kPrimaryTextColor,
          fontSize: 16.sp,
          fontFamily: 'Inter',
          fontWeight: FontWeight.w700,
          height: 0,
        ),
      )),
    );
  }
}
