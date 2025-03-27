import 'dart:async';
import 'dart:math';

class GameLogic {
  // Private constructor to prevent instantiation
  GameLogic._();

  static String formatTime(int seconds) {
    int minutes = seconds ~/ 60;
    int remainingSeconds = seconds % 60;
    return '$minutes:${remainingSeconds.toString().padLeft(2, '0')}'; // ✅ Format as mm:ss
  }
}
