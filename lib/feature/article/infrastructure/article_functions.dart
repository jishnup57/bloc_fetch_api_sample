
import 'dart:developer';

import 'package:bloc_project/feature/article/domain/article_services.dart';
import 'package:bloc_project/feature/article/domain/model/search_result_model.dart';
import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';

@injectable
class ArticleFunctions implements ArticleService{
  @override
  Future<List<Datum>?> fetchArticleList({required String query})async {
    log("clicked");
    bool result = await InternetConnectionChecker().hasConnection;
    if (!result) {
      return null;
    }
    try {
      final response = await Dio(BaseOptions()).get(
       'https://api.kodeco.com/api/contents'
      );
      // log(response.data.toString());
      if (response.statusCode == 200 || response.statusCode == 201) {
       final result =  SearchResultModel.fromJson(response.data);
       return result.data;
      } else{
        log('===================================== SomeThing Wrong ====== ArticleService==================');
        return [];
      }
    } on DioError catch (e) {
      log('===================================== Dio Error ====== ArticleService==================');
      log(e.toString());
      return [];
      
    } catch (e) {
      log('===================================== catch Error ====== ArticleService==================');
      log(e.toString());
      return[];
    }
   
  }
  
}