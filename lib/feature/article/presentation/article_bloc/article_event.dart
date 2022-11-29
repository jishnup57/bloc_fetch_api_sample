part of 'article_bloc.dart';

@freezed
class ArticleEvent with _$ArticleEvent {
  const factory ArticleEvent.initialize() = Initialize;
  const factory ArticleEvent.searchArticle({
    required String query,
  }) = SearchArticle;
}