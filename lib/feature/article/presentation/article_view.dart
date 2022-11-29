import 'package:bloc_project/feature/article/infrastructure/article_functions.dart';
import 'package:bloc_project/feature/article/presentation/article_bloc/article_bloc.dart';
import 'package:bloc_project/feature/article/presentation/widgets/result_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ArticleListScreen extends StatelessWidget {

  const ArticleListScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // 1
    return Scaffold(
      appBar: AppBar(
          title: const Text(
              'Articles'
          )
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  flex: 6,
                  child: TextField(
                    decoration: const InputDecoration(
                        border: OutlineInputBorder(), hintText: 'Search ...'),
                    onChanged: (query) {
                         // 2
                    },
                  ),
                ),
                Expanded(
                  flex: 1,
                  child: IconButton(onPressed: (){
                    context.read<ArticleBloc>().add(const SearchArticle());
                  }, icon: const Icon(Icons.search)))
              ],
            ),
          ),
         const Expanded(
            // 3
            child:ResultList(),
          )
        ],
      ),
    );
  }

  
}
