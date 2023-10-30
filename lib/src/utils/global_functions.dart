import 'package:audio_service/audio_service.dart';
import 'package:flutter/material.dart';
void showMsg(BuildContext context, String msg,{int? second}) =>
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        backgroundColor: Colors.red,
        content: Text(msg),
        duration:  Duration(
          seconds: second ?? 1,
        ),
      ),
    );
void showErrorDialog(BuildContext context, String message) {
  showDialog(
    context: context,
    builder: (context) {
      return AlertDialog(
        title: const Text('Validation Error'),
        content: Text(message),
        actionsAlignment: MainAxisAlignment.center,
        actions: [
          ElevatedButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: const Text('OK'),
          ),
        ],
      );
    },
  );
}

void clearQueue(AudioHandler audioHandler) {
  while (audioHandler.queue.value.isNotEmpty) {
    audioHandler.removeQueueItemAt(0);
  }
}

