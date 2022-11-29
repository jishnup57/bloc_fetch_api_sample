import 'package:bloc_project/feature/article/presentation/article_bloc/article_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ResultList extends StatelessWidget {
  const ResultList({super.key});

  @override
  Widget build(BuildContext context) {
    return  BlocBuilder<ArticleBloc, ArticleState>(
      builder: (context, state) {
        if (state.isLoading) {
          return const Center(child: CircularProgressIndicator(strokeWidth: 2,),);
        }
        else if(state.articleList.isEmpty){
          return const Center(child: Text('No Results'));
        }
        else {
          return Center(child: Text(state.articleList[0].id.toString()));
        }
      },
    );
  }
}
