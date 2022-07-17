import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class MyLoad {
  
  bool isLoading = false;
  BuildContext? loadContext;

  static final MyLoad _instance = MyLoad.internal();

  MyLoad.internal();
  factory MyLoad() => _instance;

  showLoading({
    required BuildContext context,
    Function()? onDissmissCallback,
    Duration? autoDismiss,
  }) {
    isLoading = true;
    loadContext = context;
    showDialog(
        context: context,
        builder: (BuildContext context) {
          if (autoDismiss != null) {
            Future<void>.delayed(autoDismiss).then(
              (dynamic value) => hideLoading(),
            );
          }
          return _buildDialog;
        }).then(
      (dynamic value) => isLoading = false,
    );
  }

  hideLoading({Function()? onDissmissCallback}) {
    if (isLoading) {
      Navigator.of(loadContext!).pop();
    }
    isLoading = false;
    onDissmissCallback?.call();
  }

  Widget get _buildDialog => WillPopScope(
        onWillPop: () async => isLoading,
        child: Stack(
          alignment: AlignmentDirectional.center,
          children: [
            SizedBox(
              height: 150,
              width: 150,
              child: Lottie.asset('assets/lotties/loading.json'),
            ),
          ],
        ),
      );
}
