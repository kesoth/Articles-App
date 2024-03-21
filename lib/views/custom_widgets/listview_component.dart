import 'dart:math';
import 'package:articles_app/models/article.dart';
import 'package:articles_app/utils/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../screens/p1/p1article_screen.dart';
import '../screens/p2/p2article_screen.dart';

class ListViewComponent extends StatefulWidget {
  final String text;
  final List<Article> articles;
  final double containerWidth;
  final double container1Width;
  final Color maincontainercolor;

  const ListViewComponent({
    super.key,
    required this.text,
    required this.articles,
    required this.containerWidth,
    required this.container1Width,
    required this.maincontainercolor,
  });

  @override
  State<ListViewComponent> createState() => _ListViewComponentState();
}

class _ListViewComponentState extends State<ListViewComponent> {
  Color getRandomContainerColor() {
    final List<Color> containerColors = [
      kContainer1Color,
      kContainer2Color,
      kContainer3Color,
      kContainer4Color,
    ];
    final Random random = Random();
    final int randomIndex = random.nextInt(containerColors.length);
    return containerColors[randomIndex];
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(10.w),
      width: widget.containerWidth,
      height: 163.h,
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
              height: 90.h,
              decoration: ShapeDecoration(
                color: kBackgroundColor,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.r),
                ),
              ),
              child: widget.articles.isEmpty
                  ? const Center(
                      child: Text(
                        "No Articles",
                        style: TextStyle(
                          color: kHintTextColor,
                        ),
                      ),
                    )
                  : ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: widget.articles.length,
                      itemBuilder: (BuildContext context, int index) {
                        final Article article = widget.articles[index];
                        return Padding(
                          padding: EdgeInsets.symmetric(horizontal: 10.w),
                          child: InkWell(
                            onTap: () {
                              article.type == 'p1'
                                  ? Navigator.of(context).push(
                                      MaterialPageRoute(
                                        builder: (context) =>
                                            P1ArticleScreen(article: article),
                                      ),
                                    )
                                  : Navigator.of(context).push(
                                      MaterialPageRoute(
                                        builder: (context) =>
                                            P2ArticleScreen(article: article),
                                      ),
                                    );
                            },
                            child: Container(
                              width: 104.w,
                              height: 30.h,
                              margin: EdgeInsets.symmetric(vertical: 10.w),
                              decoration: ShapeDecoration(
                                color: getRandomContainerColor(),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10.r),
                                ),
                              ),
                              child: Padding(
                                padding: EdgeInsets.all(10.w),
                                child: Center(
                                  child: Text(
                                    article.title,
                                    style: TextStyle(
                                      color: kPrimaryTextColor,
                                      fontSize: 13.sp,
                                      fontFamily: 'Inter',
                                      fontWeight: FontWeight.w500,
                                      height: 0,
                                    ),
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        );
                      },
                    ),
            ),
          ],
        ),
      ),
    );
  }
}
