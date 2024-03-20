// article_data_provider.dart

part of './cubit.dart';

class ArticleDataProvider {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<List<Article>> getAllArticles() async {
    try {
      final querySnapshot = await _firestore.collection('articles').get();
      return querySnapshot.docs
          .map((doc) => Article.fromMap(doc.data()))
          .toList();
    } catch (e) {
      throw Exception('Error getting articles: $e');
    }
  }

  Future<void> uploadArticle(Article article) async {
    try {
      final CollectionReference articlesRef =
          FirebaseFirestore.instance.collection('articles');
      final QuerySnapshot collectionSnapshot = await articlesRef.limit(1).get();
      if (collectionSnapshot.docs.isEmpty) {
        await articlesRef.doc().set({
          'title': article.title,
          'description': article.description,
          'isPDF': article.isPDF,
          'file': article.file,
          'type': article.type,
        });
      } else {
        await articlesRef.add(article.toMap());
      }
    } catch (e) {
      throw Exception('Error uploading article: $e');
    }
  }
}
