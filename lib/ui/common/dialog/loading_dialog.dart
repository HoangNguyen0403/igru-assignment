// Flutter imports:
import 'package:flutter/material.dart';

// Project imports:
import '../../../config/navigation_util.dart';

class LoadingDialog {
  static void get hideLoadingDialog {
    if (_dialogIsVisible(NavigationUtil.currentContext!)) {
      Navigator.of(NavigationUtil.currentContext!).pop();
    }
  }

  static bool _dialogIsVisible(BuildContext context) {
    bool isVisible = false;
    Navigator.popUntil(context, (route) {
      isVisible = route is PopupRoute;

      return !isVisible;
    });

    return isVisible;
  }

  static void showLoadingDialog(BuildContext context) {
    final alert = AlertDialog(
      content: Row(
        children: [
          const CircularProgressIndicator(),
          Container(
            margin: const EdgeInsets.only(left: 15),
            child: const Text("Loading..."),
          ),
        ],
      ),
    );
    if (!_dialogIsVisible(context)) {
      showDialog(
        barrierDismissible: false,
        context: context,
        builder: (BuildContext context) {
          return alert;
        },
      );
    }
  }
}
