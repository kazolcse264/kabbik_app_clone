import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:kabbik_ui_clone/src/utils/global_functions.dart';
class ErrorHandler {
  static void handleError(BuildContext context, dynamic error, {String? message, StackTrace? stackTrace}) {
    if (kDebugMode) {
      // In debug mode, print the error and stack trace to the console
      print('Error: $error');
      if (stackTrace != null) {
        print('Stack trace:\n$stackTrace');
      }
    } else {
      // In release mode, you could log errors to a service or display a user-friendly error message
      // Example: logToAnalyticsService(error, stackTrace);
      // Example: showErrorDialog(message ?? 'An error occurred');
      showMsg(context, message ?? 'An error occurred');
    }
  }
}