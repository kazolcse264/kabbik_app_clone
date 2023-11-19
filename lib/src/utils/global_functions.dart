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

void showSingleTextFieldInputDialog({
  required BuildContext context,
  required String title,
  String positiveButton = 'OK',
  String negativeButton = 'CLOSE',
  required Function(String) onSubmit,
}) {
  final textController = TextEditingController();
  showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(title),
        content: Padding(
          padding: const EdgeInsets.all(8),
          child: TextField(
            controller: textController,
            decoration: InputDecoration(
              border: const OutlineInputBorder(),
              hintText: 'Enter $title',
            ),
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text(negativeButton, style: const TextStyle(color: Colors.red),),
          ),
          TextButton(
            onPressed: () {
              if (textController.text.isEmpty) return;
              final value = textController.text;
              Navigator.pop(context);
              onSubmit(value);
            },
            child: Text(positiveButton, style: const TextStyle(color: Colors.green),),
          ),
        ],
      ));
}

