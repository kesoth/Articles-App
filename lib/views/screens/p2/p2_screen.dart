import 'package:articles_app/utils/app_colors.dart';
import 'package:articles_app/views/custom_widgets/custom_appbar.dart';
import 'package:articles_app/views/custom_widgets/custom_container.dart';
import 'package:articles_app/views/screens/p2/p2article_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class P2Screen extends StatefulWidget {
  const P2Screen({super.key});

  @override
  State<P2Screen> createState() => _P2ScreenState();
}

class _P2ScreenState extends State<P2Screen> {
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
                  const CustomContainer(
                      text: 'ARTICLE 4', containercolor: kContainer1Color),
                  SizedBox(
                    height: 38.h,
                  ),
                  InkWell(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const P2ArticleScreen()),
                      );
                    },
                    child: const CustomContainer(
                        text: 'ARTICLE 5', containercolor: kContainer2Color),
                  ),
                  SizedBox(
                    height: 38.h,
                  ),
                  const CustomContainer(
                      text: 'ARTICLE 6', containercolor: kContainer3Color),
                ]))));
  }
}
