import 'package:bloc_project/feature/article/presentation/article_bloc/article_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ResultList extends StatelessWidget {
  const ResultList({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ArticleBloc, ArticleState>(
      builder: (context, state) {
        if (state.isLoading) {
          return const Center(
            child: CircularProgressIndicator(
              strokeWidth: 2,
            ),
          );
        }else if (state.isError) {
          return const Center(child: Text('No Network',style: TextStyle(color: Colors.red),));
        }
         else if (state.articleList.isEmpty) {
          return const Center(child: Text('No Results'));
        }
        return Padding(
          padding: const EdgeInsets.all(16.0),
          child: ListView.separated(
              itemBuilder: (context, index) {
                final item = state.articleList[index];
                return Text(item.id.toString());
              },
              separatorBuilder: (context, index) => const Divider(),
              itemCount: state.articleList.length),
        );
      },
    );
  }
}
