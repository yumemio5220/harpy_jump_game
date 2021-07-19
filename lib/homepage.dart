import 'dart:async';

import 'package:flutter/material.dart';
import 'package:harpy_jump_game/bird.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  static double birdYaxis = 0;
  double time = 0;
  double height = 0;
  double initialHeight = birdYaxis;
  bool gameHasStated = false;

  void jump() {
    setState(() {
      time = 0;
      initialHeight = birdYaxis;
    });
  }

  void startGame() {
    gameHasStated = true;
    Timer.periodic(Duration(milliseconds: 60), (timer) {
      time += 0.05;
      height = -4.9 * time * time + 2.8 * time;
      setState(() {
        birdYaxis = initialHeight - height;
      });
      if (birdYaxis > 1) {
        timer.cancel();
        gameHasStated = false;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Expanded(
            flex: 2,
            child: GestureDetector(
              onTap: () {
                if (gameHasStated) {
                  jump();
                } else {
                  startGame();
                }
              },
              child: AnimatedContainer(
                alignment: Alignment(0,birdYaxis),
                duration: Duration(milliseconds: 0),
                color: Colors.blue,
                child: MyBird(),
              ),
            ),
          ),
          Expanded(
            child: Container(
              color: Colors.green,
            ),
          ),
        ],
      ),
    );
  }
}
