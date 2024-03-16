import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomContainer extends StatefulWidget {
  final String text;
  final Color containercolor;
  const CustomContainer(
      {super.key, required this.text, required this.containercolor});

  @override
  State<CustomContainer> createState() => _CustomContainerState();
}

class _CustomContainerState extends State<CustomContainer> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 320.w,
      height: 50.h,
      decoration: ShapeDecoration(
        color: widget.containercolor,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
      ),
      child: Center(
        child: Text(
          widget.text,
          style: TextStyle(
            color: Colors.white,
            fontSize: 20.sp,
            fontFamily: 'Inter',
            fontWeight: FontWeight.w700,
            height: 0,
          ),
        ),
      ),
    );
  }
}
