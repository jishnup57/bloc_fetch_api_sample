import 'dart:async';
import 'package:bloc_project/feature/article/presentation/article_bloc/article_bloc.dart';
import 'package:bloc_project/feature/article/presentation/widgets/result_list.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:connectivity/connectivity.dart';

class ArticleListScreen extends StatefulWidget {
  const ArticleListScreen({Key? key}) : super(key: key);

  @override
  State<ArticleListScreen> createState() => _ArticleListScreenState();
}

class _ArticleListScreenState extends State<ArticleListScreen> {
  late StreamSubscription subscription;
  var isDeviceConnected = false;
  bool isAlertSet = false;
  @override
  void initState() {
    // getConnectivity();
    super.initState();
  }

  getConnectivity() {
    subscription = Connectivity()
        .onConnectivityChanged
        .listen((ConnectivityResult result) async {
      // if(result != ConnectivityResult.none) {
      isDeviceConnected = await InternetConnectionChecker().hasConnection;
      // }
      if (!isDeviceConnected && isAlertSet == false) {
        showDialogBox();
        setState(() {
          isAlertSet = true;
        });
      }
    });
  }

  @override
  void dispose() {
    subscription.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      getConnectivity();
      context.read<ArticleBloc>().add(const SearchArticle(query: ''));
    },);
    // 1
    return Scaffold(
      appBar: AppBar(title: const Text('Articles')),
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
                    child: IconButton(
                        onPressed: () {}, icon: const Icon(Icons.search)))
              ],
            ),
          ),
          Expanded(
              // 3
              //child: ResultList(),

              child: BlocBuilder<ArticleBloc, ArticleState>(
            builder: (context, state) {
              if (state.isLoading) {
                return const Center(
                  child: CircularProgressIndicator(
                    strokeWidth: 2,
                  ),
                );
              // } else if (state.isError) {
              //   return  Center(
              //       child: showDialogBox());
              } else if (state.articleList.isEmpty) {
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
          )

              //
              )
        ],
      ),
    );
  }

  showDialogBox() {
    return showCupertinoDialog(
      context: context,
      builder: (context) => CupertinoAlertDialog(
        title: const Text('No connection'),
        content: const Text('Please check your internet connection'),
        actions: [
          TextButton(
              onPressed: () async {
                Navigator.pop(context, 'Cancel');
                setState(() => isAlertSet = false);
                isDeviceConnected =
                    await InternetConnectionChecker().hasConnection;
                if (!isDeviceConnected) {
                  showDialogBox();
                  setState(() => isAlertSet = true);
                }
              },
              child: const Text('Ok')),
        ],
      ),
    );
  }
}
