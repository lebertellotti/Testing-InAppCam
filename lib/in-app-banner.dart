import 'package:flutter/material.dart';

class BannerAlert extends StatelessWidget {
  final String message;
  BannerAlert({required this.message});

  @override
  Widget build(BuildContext context) {
    return SnackBar(
      content: Text(message),
      duration: Duration(seconds: 15),
      behavior: SnackBarBehavior.floating,
      action: SnackBarAction(
        label: 'Close',
        onPressed: () {
          ScaffoldMessenger.of(context).hideCurrentSnackBar();
        },
      ),
    );
  }
}
