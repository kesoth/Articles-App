import 'package:articles_app/utils/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ListViewComponent extends StatefulWidget {
  final String text;
  final double containerWidth;
  final double container1Width;
  final Color maincontainercolor;
  const ListViewComponent(
      {super.key,
      required this.text,
      required this.containerWidth,
      required this.container1Width,
      required this.maincontainercolor});

  @override
  State<ListViewComponent> createState() => _ListViewComponentState();
}

class _ListViewComponentState extends State<ListViewComponent> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: widget.containerWidth,
      height: 133.h,
      decoration: ShapeDecoration(
        color: widget.maincontainercolor,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20.r),
        ),
      ),
      child: Padding(
        padding: EdgeInsets.only(left: 16.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: 14.h,
            ),
            Text(
              widget.text,
              style: TextStyle(
                color: kPrimaryTextColor,
                fontSize: 14.sp,
                fontFamily: 'Inter',
                fontWeight: FontWeight.w500,
              ),
            ),
            SizedBox(
              height: 11.h,
            ),
            Container(
              width: widget.container1Width,
              height: 75.h,
              decoration: ShapeDecoration(
                color: kBackgroundColor,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.r),
                ),
              ),
              child: ListView(
                scrollDirection: Axis.horizontal,
                shrinkWrap: true,
                children: <Widget>[
                  SizedBox(
                    width: 10.w,
                  ),
                  Container(
                    width: 104.w,
                    height: 30.h,
                    decoration: ShapeDecoration(
                      color: kContainer1Color,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.r),
                      ),
                    ),
                    child: Center(
                      child: Text(
                        'ARTICLE 1',
                        style: TextStyle(
                          color: kPrimaryTextColor,
                          fontSize: 13.sp,
                          fontFamily: 'Inter',
                          fontWeight: FontWeight.w500,
                          height: 0,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 20.w,
                  ),
                  Container(
                    width: 104.w,
                    height: 30.h,
                    decoration: ShapeDecoration(
                      color: kContainer2Color,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.r),
                      ),
                    ),
                    child: Center(
                      child: Text(
                        'ARTICLE 2',
                        style: TextStyle(
                          color: kPrimaryTextColor,
                          fontSize: 13.sp,
                          fontFamily: 'Inter',
                          fontWeight: FontWeight.w500,
                          height: 0,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 20.w,
                  ),
                  Container(
                    width: 104.w,
                    height: 30.h,
                    decoration: ShapeDecoration(
                      color: kContainer3Color,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.r),
                      ),
                    ),
                    child: Center(
                      child: Text(
                        'ARTICLE 3',
                        style: TextStyle(
                          color: kPrimaryTextColor,
                          fontSize: 13.sp,
                          fontFamily: 'Inter',
                          fontWeight: FontWeight.w500,
                          height: 0,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
