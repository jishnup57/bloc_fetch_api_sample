part of 'article_bloc.dart';

@freezed
class ArticleState with _$ArticleState {
  const factory ArticleState({
    required List<Datum> articleList,
    required bool isLoading,
  }) = _ArticleState;
  factory ArticleState.initial() => const ArticleState(
        articleList: [],
        isLoading: false,
      );
}
