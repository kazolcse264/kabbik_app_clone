import 'package:flutter/widgets.dart';
import 'dart:convert';
Future<void> readAudio(BuildContext context, List<dynamic> audioList) async {
    final value = await DefaultAssetBundle.of(context).loadString('json/audio.json');
    audioList.addAll(json.decode(value));
}
