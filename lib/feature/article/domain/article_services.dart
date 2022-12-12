

import 'package:bloc_project/feature/article/domain/model/search_result_model.dart';

abstract class ArticleService {
  Future<List<Datum>?> fetchArticleList({required String query});
}