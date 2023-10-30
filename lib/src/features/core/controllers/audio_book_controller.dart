import 'dart:async';
import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';


class AudioBookProvider extends ChangeNotifier {
  double _timeStretchFactor = 1.0;

  double get timeStretchFactor => _timeStretchFactor;

  void setTimeStretchFactor(double factor) {
    _timeStretchFactor = factor;
    notifyListeners();
  }

  //works good

  late SharedPreferences _preferences;
  static const String playbackPositionsKey = 'playbackPositions';
  Map<String, int> playbackPositions = {};

  Future<void> initialize() async {
    _preferences = await SharedPreferences.getInstance();
    final playbackPositionsJson = _preferences.getString(playbackPositionsKey);
    if (playbackPositionsJson != null) {
      final Map<String, dynamic> playbackPositionsMap =
          json.decode(playbackPositionsJson);
      playbackPositions =
          playbackPositionsMap.map((key, value) => MapEntry(key, value as int));
      notifyListeners();
    }
  }

  int? getPosition(String id) {
    return playbackPositions[id];
  }

  void setPosition(String id, int position) {
    playbackPositions[id] = position;

    _savePlaybackPositions();
    if (kDebugMode) {
      print(playbackPositions);
    }
    notifyListeners();
  }

  void _savePlaybackPositions() {
    final playbackPositionsJson = json.encode(playbackPositions);
    _preferences.setString(playbackPositionsKey, playbackPositionsJson);
  }
}
