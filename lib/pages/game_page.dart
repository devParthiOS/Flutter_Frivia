import 'package:flutter/material.dart';
import 'package:trivia/providers/game_page_provider.dart';
import 'package:provider/provider.dart';

class GamePage extends StatelessWidget {
  late String difficulty;
  double? _deviceWidth, _deviceHight;
  GamePageProvider? _pageProvider;
  GamePage({required this.difficulty});

  @override
  Widget build(BuildContext context) {
    _deviceHight = MediaQuery.of(context).size.height;
    _deviceWidth = MediaQuery.of(context).size.width;

    return ChangeNotifierProvider(
      create: (context) => GamePageProvider(
        context: context,
        level: difficulty,
      ),
      child: _buidUI(),
    );
  }

  Widget _buidUI() {
    return Builder(builder: (context) {
      _pageProvider = context.watch<GamePageProvider>();
      if (_pageProvider!.questions != null) {
        return Scaffold(
          appBar: AppBar(
            backgroundColor: Color.fromARGB(217, 255, 255, 255),
            title: Text(
              difficulty,
              style: const TextStyle(color: Colors.black),
            ),
          ),
          body: SafeArea(
              child: Container(
            padding: EdgeInsets.symmetric(horizontal: _deviceHight! * 0.05),
            child: _gameUI(),
          )),
        );
      } else {
        return const Center(
          child: CircularProgressIndicator(),
        );
      }
    });
  }

  Widget _gameUI() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      mainAxisSize: MainAxisSize.max,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        _questionText(),
        Column(
          children: [
            _trueButton(),
            SizedBox(
              height: _deviceHight! * 0.01,
            ),
            _falseButton()
          ],
        )
      ],
    );
  }

  Widget _questionText() {
    return Text(
      _pageProvider!.getCurrentQustionText(),
      style: const TextStyle(
        color: Colors.white,
        fontWeight: FontWeight.w400,
        fontSize: 25,
      ),
    );
  }

  Widget _trueButton() {
    return MaterialButton(
        onPressed: () {
          _pageProvider!.questionAnswer("True");
        },
        minWidth: _deviceWidth! * 0.80,
        height: _deviceHight! * 0.10,
        color: Colors.green,
        child: const Text(
          "True",
          style: TextStyle(color: Colors.white, fontSize: 25),
        ));
  }

  Widget _falseButton() {
    return MaterialButton(
        onPressed: () {
          _pageProvider!.questionAnswer("False");
        },
        minWidth: _deviceWidth! * 0.80,
        height: _deviceHight! * 0.10,
        color: Colors.red,
        child: const Text(
          "False",
          style: TextStyle(color: Colors.white, fontSize: 25),
        ));
  }
}
