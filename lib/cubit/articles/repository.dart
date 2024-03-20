// article_repository.dart
part of 'cubit.dart';

class ArticleRepository {
  final ArticleDataProvider dataProvider = ArticleDataProvider();

  Future<List<Article>> getAllArticles() async {
    try {
      return await dataProvider.getAllArticles();
    } catch (e) {
      throw Exception('Error fetching articles: $e');
    }
  }

  Future<void> uploadArticle(Article article) async {
    try {
      await dataProvider.uploadArticle(article);
    } catch (e) {
      throw Exception('Error uploading article: $e');
    }
  }
}
