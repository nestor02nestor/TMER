import 'dart:async';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class ClockProvider with ChangeNotifier {
  bool is24HourFormat = true;
  DateTime currentTime = DateTime.now();
  Timer? timer;
  bool isCountdownActive = false;
  int countdownSeconds = 0;
  Timer? countdownTimer;

  ClockProvider() {
    _initTimer();
  }

  void _initTimer() {
    timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      currentTime = DateTime.now();
      notifyListeners();
    });
  }

  String get formattedTime {
    return is24HourFormat
        ? DateFormat('HH:mm:ss').format(currentTime)
        : DateFormat('hh:mm:ss a').format(currentTime);
  }

  String get formattedDate {
    return DateFormat('yyyy-MM-dd').format(currentTime);
  }

  void toggleTimeFormat() {
    is24HourFormat = !is24HourFormat;
    notifyListeners();
  }

  void startCountdown(int seconds) {
    countdownSeconds = seconds;
    isCountdownActive = true;
    countdownTimer?.cancel();
    countdownTimer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (countdownSeconds > 0) {
        countdownSeconds--;
        notifyListeners();
      } else {
        stopCountdown();
      }
    });
  }

  void stopCountdown() {
    isCountdownActive = false;
    countdownTimer?.cancel();
    countdownTimer = null;
    notifyListeners();
  }

  String get countdownDisplay {
    int hours = countdownSeconds ~/ 3600;
    int minutes = (countdownSeconds % 3600) ~/ 60;
    int seconds = countdownSeconds % 60;
    return '${hours.toString().padLeft(2, '0')}:${minutes.toString().padLeft(2, '0')}:${seconds.toString().padLeft(2, '0')}';
  }

  @override
  void dispose() {
    timer?.cancel();
    countdownTimer?.cancel();
    super.dispose();
  }
}
