import 'package:articles_app/utils/app_colors.dart';
import 'package:articles_app/views/custom_widgets/custom_appbar.dart';
import 'package:articles_app/views/custom_widgets/listview_component.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          backgroundColor: kBackgroundColor,
          body: SingleChildScrollView(
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                const CustomappBar(
                  text: 'Welcome',
                  showBackButton: false,
                ),
                Padding(
                  padding: EdgeInsets.only(left: 20.w, top: 74.h),
                  child: ListViewComponent(
                    text: 'New Articles from P1',
                    containerWidth: 300.w,
                    container1Width: 267.w,
                    maincontainercolor: kPrimaryMainColor,
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(left: 20.w, top: 25.h),
                  child: ListViewComponent(
                    text: 'Summary P1',
                    containerWidth: 387.w,
                    container1Width: 352.w,
                    maincontainercolor: kPrimaryMainColor,
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(left: 20.w, top: 25.h),
                  child: ListViewComponent(
                    text: 'Summary P2',
                    containerWidth: 387.w,
                    container1Width: 352.w,
                    maincontainercolor: kContainer1Color,
                  ),
                ),
              ]))),
    );
  }
}
