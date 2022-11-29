import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:bloc_project/feature/article/domain/model/search_result_model.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';

import '../../infrastructure/article_functions.dart';

part 'article_event.dart';
part 'article_state.dart';
part 'article_bloc.freezed.dart';

@injectable
class ArticleBloc extends Bloc<ArticleEvent, ArticleState> {
  ArticleFunctions articleFun;
  ArticleBloc(this.articleFun) : super(ArticleState.initial()) {
   on<SearchArticle>((event, emit) async {
    log('Article Bloc called');
     if (state.articleList.isNotEmpty) {
       emit(state.copyWith(isLoading: state.isLoading,articleList: state.articleList ));
       return;
     }
     emit(state.copyWith(isLoading: true,articleList: []));
     List<Datum> articleNewList = await articleFun.fetchArticleList(query: '');
     return emit(state.copyWith(isLoading: false,articleList:articleNewList));
   });
  }
}
