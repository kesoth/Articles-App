import 'package:articles_app/utils/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomappBar extends StatefulWidget {
  final String text;
  final bool showBackButton;
  const CustomappBar(
      {super.key, required this.text, this.showBackButton = true});

  @override
  State<CustomappBar> createState() => _CustomappBarState();
}

class _CustomappBarState extends State<CustomappBar> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 430.w,
      height: 100.h,
      decoration: const BoxDecoration(color: kPrimaryMainColor),
      child: Row(
        children: [
          if (widget.showBackButton)
            IconButton(
              icon: const Icon(Icons.arrow_back),
              color: kBackgroundColor,
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          Expanded(
            child: Align(
              alignment: !widget.showBackButton
                  ? Alignment.center
                  : Alignment.centerLeft,
              child: Text(
                widget.text,
                style: TextStyle(
                  color: kPrimaryTextColor,
                  fontSize: 20.sp,
                  fontFamily: 'Inter',
                  fontWeight: FontWeight.w700,
                  height: 0,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
