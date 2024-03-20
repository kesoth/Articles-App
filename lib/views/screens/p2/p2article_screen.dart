import 'package:articles_app/utils/app_colors.dart';
import 'package:articles_app/utils/app_images.dart';
import 'package:articles_app/views/custom_widgets/custom_appbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../models/article.dart';
import '../../custom_widgets/firebaseNetworkImage.dart';
import '../../custom_widgets/viewPdf.dart';

class P2ArticleScreen extends StatefulWidget {
  final Article article;
  P2ArticleScreen({super.key, required this.article});

  @override
  State<P2ArticleScreen> createState() => _P2ArticleScreenState();
}

class _P2ArticleScreenState extends State<P2ArticleScreen> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: kBackgroundColor,
        body: SingleChildScrollView(
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.center, children: [
            InkWell(
              onTap: () {
                Navigator.pop(context);
              },
              child: CustomappBar(text: widget.article.title),
            ),
            SizedBox(
              height: 10.h,
            ),
            !widget.article.isPDF
                ? FirebaseNetworkImage(
                    imagePath: widget.article.file,
                    width: 380.w,
                    height: 390.w,
                    fit: BoxFit.cover,
                  )
                : const SizedBox(),
            !widget.article.isPDF
                ? Align(
                    alignment: Alignment.topLeft,
                    child: Padding(
                      padding: EdgeInsets.only(left: 15.w, top: 20.w),
                      child: Text(
                        widget.article.description,
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 16.sp,
                          fontFamily: 'Inter',
                          fontWeight: FontWeight.w400,
                          height: 1.7,
                          letterSpacing: 0.9,
                        ),
                      ),
                    ),
                  )
                : ConstrainedBox(
                    constraints: BoxConstraints(maxHeight: 600),
                    child: MyPdfViewer(pdfPath: widget.article.file),
                  ),
            widget.article.isPDF
                ? const Center(
                    child: Text(
                      "Swipe left to move to next page",
                      style: TextStyle(color: kHintTextColor),
                    ),
                  )
                : const SizedBox(),
          ]),
        ),
      ),
    );
  }
}
