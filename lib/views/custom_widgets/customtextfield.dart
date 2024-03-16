import 'package:articles_app/utils/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomTextField extends StatefulWidget {
  final String label;
  final TextEditingController controller;
  final bool isPassword;
  
  const CustomTextField({
    Key? key,
    required this.label,
    required this.controller,
    this.isPassword = false,
    
  }) : super(key: key);

  @override
  State<CustomTextField> createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {
  bool _isObscured = true;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 347.w,
      height: 51.h,
      decoration: BoxDecoration(
        color: kBackgroundColor,
        borderRadius: BorderRadius.circular(10.r),
      ),
      child: TextField(
        controller: widget.controller,
        obscureText: _isObscured && widget.isPassword,
        keyboardType: widget.isPassword
            ? TextInputType.visiblePassword
            : TextInputType.text,
        cursorColor: const Color(0xFF979595),
        style: const TextStyle(
          color: Color(0xFF979595),
        ),
        decoration: InputDecoration(
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(
              width: 1.w,
              color: kTextFieldColor,
            ),
            borderRadius: BorderRadius.circular(10.r),
          ),
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(
              width: 1.w,
              color: kTextFieldColor,
            ),
            borderRadius: BorderRadius.circular(10.r),
          ),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(4.r),
          ),
          hintText: widget.label,
          hintStyle: TextStyle(
            color: kHintTextColor,
            fontSize: 14.sp,
            fontFamily: 'Inter',
            fontWeight: FontWeight.w500,
          ),
          suffixIcon: widget.isPassword
              ? IconButton(
                  onPressed: () {
                    setState(() {
                      _isObscured = !_isObscured;
                    });
                  },
                  icon: Icon(
                    _isObscured ? Icons.visibility : Icons.visibility_off,
                    color: kHintTextColor,
                  ),
                )
              : null,
        ),
      ),
    );
  }
}
