import 'dart:io';
import 'dart:math';

import 'package:flame_forge2d/flame_forge2d.dart';
import 'package:flutter/material.dart';
import 'package:sensors_plus/sensors_plus.dart';
import 'package:space/game/game_world.dart';

import 'components/ball.dart';

class AccelerometerGravityGame extends Forge2DGame {
  AccelerometerGravityGame()
      : super(gravity: Vector2(0, 10.0), world: AccelerometerGravityWorld());

  @override
  Color backgroundColor() {
    return Colors.white;
  }

  List<Ball> balls = [];

  void createBalls() {
    balls = List.generate(
      20,
      (index) => Ball(Vector2.all(Random().nextDouble() * 10)),
    );
  }

  @override
  Future<void> onLoad() async {
    await super.onLoad();
    createBalls();
    world.addAll(balls);
    final double platformMultiplier = Platform.isIOS ? 1.0 : 3.0;
    accelerometerEvents.listen((AccelerometerEvent event) {
      final gravityVector = Vector2(
        -event.x * 50 * platformMultiplier,
        event.y * 80 * platformMultiplier,
      );
      WidgetsBinding.instance.addPostFrameCallback((_) {
        updateObjectGravity(gravityVector);
      });
    });
  }

  void updateObjectGravity(Vector2 gravityVector) {
    for (final ball in balls) {
      final gravityForce = gravityVector;
      ball.body.applyForce(gravityForce);
    }
  }
}
