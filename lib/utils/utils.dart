import 'package:flutter/material.dart';

class UtilsFun {
  ScaffoldFeatureController<SnackBar, SnackBarClosedReason> getErrorSnackbar(
      String message, BuildContext context) {
    final errorSnackbar = SnackBar(
      content: Text(
        message,
        style: const TextStyle(color: Colors.white),
      ),
      duration: const Duration(seconds: 2),
      backgroundColor: Colors.red,
    );
    return ScaffoldMessenger.of(context).showSnackBar(errorSnackbar);
  }

  ScaffoldFeatureController<SnackBar, SnackBarClosedReason> getSuccessSnackbar(
      String message, context) {
    final error_snackbar = SnackBar(
      content: Text(
        "${message}",
        style: TextStyle(color: Colors.white),
      ),
      duration: const Duration(seconds: 2),
      backgroundColor: Colors.green,
    );
    return ScaffoldMessenger.of(context).showSnackBar(error_snackbar);
  }

  String truncateDescptionWords(String text) {
    List<String> words = text.split(' ');
    if (words.length > 6) {
      return words.sublist(0, 6).join(' ') + '...';
    }
    return text;
  }

  String truncateTitleWords(String text) {
    List<String> words = text.split(' ');
    if (words.length > 6) {
      return words.sublist(0, 6).join(' ') + '...';
    }
    return text;
  }
}
