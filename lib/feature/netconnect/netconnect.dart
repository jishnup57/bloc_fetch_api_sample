import 'dart:async';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:overlay_support/overlay_support.dart';

class NetConnectCheckUI extends StatefulWidget {
  const NetConnectCheckUI({super.key});

  @override
  State<NetConnectCheckUI> createState() => _NetConnectCheckUIState();
}

class _NetConnectCheckUIState extends State<NetConnectCheckUI> {
   bool hasInternet = false;
  ConnectivityResult result = ConnectivityResult.none;
  late StreamSubscription subscription;
  bool isAlertSet = false;
  @override
  void initState() {
    subscription = InternetConnectionChecker().onStatusChange.listen((status) {
      final hasInternet = status == InternetConnectionStatus.connected;
      print("Has internet : $hasInternet");
      if (!hasInternet && isAlertSet == false) {
        showDialogBox();
        setState(() {
          isAlertSet = true;
        });
      }
      setState(() {
        this.hasInternet = hasInternet;
      });
    });
    super.initState();
  }

  @override
  void dispose() {
    subscription.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
            body: hasInternet
                ? const Center(
                    child: Text("Connected"),
                  )
                : Center(
                    child: ElevatedButton(
                      onPressed: () async {
                        hasInternet =
                            await InternetConnectionChecker().hasConnection;

                        result = await Connectivity().checkConnectivity();

                        String text = hasInternet ? 'Internet' : 'No Internet';
                        Color bgColor = hasInternet ? Colors.green : Colors.red;
                        if (result == ConnectivityResult.mobile) {
                          showSimpleNotification(Text('$text: Mobile Network'),
                              background: bgColor);
                        } else if (result == ConnectivityResult.wifi) {
                          showSimpleNotification(Text('$text: wifi Network'),
                              background: bgColor);
                        } else {
                          showSimpleNotification(Text('$text: no Network'),
                              background: bgColor);
                        }
                      },
                      child: const Text('check internet'),
                    ),
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
                hasInternet =
                    await InternetConnectionChecker().hasConnection;
                if (!hasInternet) {
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

/**
 *            if (result == ConnectivityResult.mobile){
                Text('$text: Mobile Network')
              }else  if(result == ConnectivityResult.wifi){
Text('$text: Mobile Network')
              } else {

Text('$text: Mobile Network')
              }
 */