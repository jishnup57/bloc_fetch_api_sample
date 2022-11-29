import 'package:bloc_project/feature/article/presentation/article_bloc/article_bloc.dart';
import 'package:bloc_project/feature/article/presentation/article_view.dart';
import 'package:bloc_project/feature/injectable/di.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

Future<void> main() async {
  await configureInjection();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => getIt<ArticleBloc>()),
      ],
      child: MaterialApp(
        title: 'Flutter Demo',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
       home: const ArticleListScreen(),
      ),
    );
  }
}
