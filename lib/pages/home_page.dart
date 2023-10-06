import 'package:flutter/material.dart';
import 'package:trivia/pages/game_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  double? _devicewidth;
  double? _deviceHeight;
  double sliderLevel = 0;
  String level = "Easy";
  @override
  Widget build(BuildContext context) {
    _deviceHeight = MediaQuery.of(context).size.height;
    _devicewidth = MediaQuery.of(context).size.width;

    return _buildUI();
  }

  Widget _buildUI() {
    return Scaffold(
      body: SizedBox(
        width: _devicewidth,
        height: _deviceHeight,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          mainAxisSize: MainAxisSize.max,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [_titleWithLevel(), _levelSlider(), _startButton()],
        ),
      ),
    );
  }

  Widget _titleWithLevel() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        const Text(
          "Frivia",
          style: TextStyle(
              fontSize: 40, fontWeight: FontWeight.w900, color: Colors.white),
        ),
        Text(
          level,
          style: const TextStyle(
              color: Colors.white, fontSize: 20, fontWeight: FontWeight.w500),
        )
      ],
    );
  }

  Widget _levelSlider() {
    return Slider(
        min: 0,
        max: 2,
        label: "Difficulty",
        inactiveColor: const Color.fromARGB(53, 3, 168, 244),
        activeColor: Colors.lightBlue,
        divisions: 2,
        value: sliderLevel,
        onChanged: (onChanged) {
          sliderLevel = onChanged;
          setLevel(onChanged);
          setState(() {});
        });
  }

  void setLevel(double) {
    switch (double) {
      case 0:
        level = "Easy";
        break;
      case 1:
        level = "Medium";
        break;
      case 2:
        level = "Hard";
        break;
      default:
    }
  }

  Widget _startButton() {
    return MaterialButton(
      color: Colors.lightBlue,
      minWidth: _devicewidth! * 0.6,
      child: const Text(
        "Start",
        style: TextStyle(fontSize: 50, color: Colors.white),
      ),
      onPressed: () {
        Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => GamePage(
                    difficulty: level,
                  )),
        );
      },
    );
  }
}
