// ignore_for_file: use_build_context_synchronously

import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:dio/dio.dart';

class GamePageProvider extends ChangeNotifier {
  final Dio _dio = Dio();
  final int _maxQuestion = 10;
  late final String? level;
  List? questions;
  int _currentQuestionCount = 0;
  int score = 0;

  BuildContext context;
  GamePageProvider({required this.context, required this.level}) {
    _dio.options.baseUrl = 'https://opentdb.com/api.php';
    _getQuestionFromAip();
  }
  Future<void> _getQuestionFromAip() async {
    var response = await _dio.get(
      '',
      queryParameters: {
        'amount': _maxQuestion,
        'type': 'boolean',
        'difficulty': '',
      },
    );
    var data = jsonDecode(response.toString());
    questions = data["results"];
    notifyListeners();
  }

  String getCurrentQustionText() {
    return questions![_currentQuestionCount]['question'];
  }

  void questionAnswer(String answer) async {
    bool isCorrect =
        questions![_currentQuestionCount]["correct_answer"] == answer;
    if (isCorrect) {
      score++;
    }
    _currentQuestionCount++;
    showDialog(
        barrierDismissible: false,
        context: context,
        builder: (builderContex) {
          return AlertDialog(
            backgroundColor: isCorrect ? Colors.green : Colors.red,
            title: Icon(
              isCorrect ? Icons.check_circle : Icons.cancel_sharp,
              color: Colors.white,
            ),
          );
        });
    await Future.delayed(
      const Duration(seconds: 1),
    );
    Navigator.pop(context);
    if (_currentQuestionCount == _maxQuestion) {
      _endGame();
    } else {
      notifyListeners();
    }
  }

  Future<void> _endGame() async {
    showDialog(
        barrierDismissible: false,
        context: context,
        builder: (builder) {
          return AlertDialog(
            backgroundColor: Colors.blue,
            title: const Text(
              "End Game!",
              style: TextStyle(
                fontSize: 25,
                color: Colors.white,
              ),
            ),
            content: Text("Score; $score/$_maxQuestion"),
          );
        });
    await Future.delayed(const Duration(seconds: 3));
    Navigator.pop(context);
    Navigator.pop(context);
  }
}
