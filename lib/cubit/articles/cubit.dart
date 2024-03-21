// article_cubit.dart
import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import '../../models/article.dart';

part 'state.dart';
part './data_provider.dart';
part './repository.dart';

class ArticleCubit extends Cubit<ArticleState> {
  final ArticleRepository repository = ArticleRepository();

  ArticleCubit() : super(ArticleInitial());

  Future<void> getAllArticles(String type) async {
    try {
      emit(ArticleLoading());
      List<Article> articles = await repository.getAllArticles();
      if (type == 'p1') {
        articles = articles.where((article) => article.type == 'p1').toList();
        emit(ArticleLoadSuccess(articles: articles));
      } else if (type == 'p2') {
        articles = articles.where((article) => article.type == 'p2').toList();
        emit(ArticleLoadSuccess(articles: articles));
      } else {
        emit(ArticleLoadSuccess(articles: articles));
      }
    } catch (e) {
      emit(ArticleLoadFailure(message: e.toString()));
    }
  }

  Future<void> getAllArticlesRegarlessType() async {
    try {
      emit(ArticleLoading());
      List<Article> articles = await repository.getAllArticles();
      emit(ArticleLoadSuccess(articles: articles));
    } catch (e) {
      emit(ArticleLoadFailure(message: e.toString()));
    }
  }

  Future<void> uploadArticle(Article article) async {
    try {
      await repository.uploadArticle(article);
      getAllArticles(article.type);
    } catch (e) {
      emit(ArticleLoadFailure(message: e.toString()));
    }
  }
}
