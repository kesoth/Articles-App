import 'package:articles_app/utils/app_colors.dart';
import 'package:articles_app/views/custom_widgets/custom_appbar.dart';
import 'package:articles_app/views/custom_widgets/listview_component.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../cubit/articles/cubit.dart';
import '../../../models/article.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getArticles();
  }

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
              BlocBuilder<ArticleCubit, ArticleState>(
                builder: (context, state) {
                  if (state is ArticleLoadSuccess) {
                    final articlesNew = state.articles
                        .where((article) => article.type == 'p1')
                        .take(3)
                        .toList();
                    final articlesP1 = state.articles
                        .where((article) => article.type == 'p1')
                        .toList();
                    final articlesP2 = state.articles
                        .where((article) => article.type == 'p2')
                        .toList();
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: EdgeInsets.only(left: 20.w, top: 74.h),
                          child: ListViewComponent(
                            text: 'New Articles from P1',
                            containerWidth: 300.w,
                            container1Width: 267.w,
                            maincontainercolor: kPrimaryMainColor,
                            articles: articlesNew,
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(left: 20.w, top: 25.h),
                          child: ListViewComponent(
                            text: 'Summary P1',
                            containerWidth: 387.w,
                            container1Width: 352.w,
                            maincontainercolor: kPrimaryMainColor,
                            articles: articlesP1,
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(left: 20.w, top: 25.h),
                          child: ListViewComponent(
                            text: 'Summary P2',
                            containerWidth: 387.w,
                            container1Width: 352.w,
                            maincontainercolor: kContainer1Color,
                            articles: articlesP2,
                          ),
                        ),
                      ],
                    );
                  } else if (state is ArticleLoading) {
                    return const Center(child: CircularProgressIndicator());
                  } else if (state is ArticleLoadFailure) {
                    return const Center(
                      child: Text('Failed to load articles'),
                    );
                  } else {
                    return Container();
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> getArticles() async {
    ArticleCubit cubit = BlocProvider.of<ArticleCubit>(context);
    try {
      await cubit.getAllArticlesRegarlessType();
    } catch (e) {
      print("Error getting article$e");
    }
  }
}
