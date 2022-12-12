import 'dart:developer';


import 'package:bloc_project/feature/article/domain/model/search_result_model.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
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
   on<Initialize>((event, emit) {
     return emit(state.copyWith(isLoading: true,articleList: [],isError: false));
   });
   on<SearchArticle>((event, emit) async {
    log('Article Bloc called');
    //  if (state.articleList.isNotEmpty) {
    //    emit(state.copyWith(isLoading: false,articleList: state.articleList ));
    //    return;
    //  }
     emit(state.copyWith(isLoading: true,articleList: state.articleList,isError: false));
     List<Datum>? articleNewList = await articleFun.fetchArticleList(query: event.query);
     if (articleNewList == null) {
       return emit(state.copyWith(isLoading: false,articleList:[],isError: true));
     }

     return emit(state.copyWith(isLoading: false,articleList:articleNewList,isError: false));
   });
  }
}
