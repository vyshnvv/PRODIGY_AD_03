import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';

class TimerProvider with ChangeNotifier {
  late Timer _timer;
  int _hrs = 0;
  int _mins = 0;
  int _secs = 0;
  int _ms = 0;
  bool _isNew = true;
  bool _isRunning = false;
  bool _pauseTimer = false;
  bool _resumeTimer = false;

  int get hrs => _hrs;
  int get mins => _mins;
  int get secs => _secs;
  int get ms => _ms;
  bool get isRunning => _isRunning;
  bool get pauseTimer => _pauseTimer;
  bool get resumeTimer => _resumeTimer;
  bool get isNew => _isNew;

  void start() {
    if (_isNew) {
      _hrs = 0;
      _mins = 0;
      _secs = 0;
      _ms = 0;
      _isNew = false;
    }
    _isRunning = true;
    _pauseTimer = false;

    _timer = Timer.periodic(Duration(milliseconds: 10), (timer) {
      _ms += 10;
      if (_ms == 1000) {
        _secs++;
        _ms = 0;
      }
      if (_secs == 60) {
        _secs = 0;
        _mins++;
        if (_mins == 60) {
          _mins = 0;
          _hrs++;
        }
      }
      notifyListeners();
    });
  }

  void pause() {
    if (!_pauseTimer) {
      _pauseTimer = true;
      _isRunning = false;
      _timer.cancel();
    } else if (!_isRunning && _pauseTimer) {
      _pauseTimer = false;
      _isRunning = true;
      start();
    }
    notifyListeners();
  }

  void reset() {
    _timer.cancel();
    _hrs = 0;
    _mins = 0;
    _secs = 0;
    _ms = 0;
    _isRunning = false;
    notifyListeners();
  }
}
