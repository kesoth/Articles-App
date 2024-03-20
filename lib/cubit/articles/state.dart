part of 'cubit.dart';

abstract class ArticleState extends Equatable {
  const ArticleState();

  @override
  List<Object> get props => [];
}

class ArticleInitial extends ArticleState {}

class ArticleLoading extends ArticleState {}

class ArticleLoadSuccess extends ArticleState {
  final List<Article> articles;

  const ArticleLoadSuccess({required this.articles});

  @override
  List<Object> get props => [articles];
}

class ArticleLoadFailure extends ArticleState {
  final String message;

  const ArticleLoadFailure({required this.message});

  @override
  List<Object> get props => [message];
}
