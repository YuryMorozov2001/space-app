import 'package:flame/palette.dart';
import 'package:flame_forge2d/flame_forge2d.dart';
import 'package:flutter/material.dart';

class Ball extends BodyComponent with ContactCallbacks {
  late Paint originalPaint;
  bool giveNudge = false;
  final double radius;
  final BodyType bodyType;
  final Vector2 _position;

  final Paint _blue = BasicPalette.blue.paint();

  Ball(
    this._position, {
    this.radius = 2,
    this.bodyType = BodyType.dynamic,
    Color? color,
  }) {
    paint = Paint()..color = Colors.black;
  }

  @override
  Body createBody() {
    final shape = CircleShape();
    shape.radius = radius;

    final fixtureDef = FixtureDef(
      shape,
      restitution: 0.0,
      density: 1,
      friction: 10,
    );

    final bodyDef = BodyDef(
      userData: this,
      angularDamping: 1,
      position: _position,
      type: bodyType,
    );

    return world.createBody(bodyDef)..createFixture(fixtureDef);
  }

  @override
  void renderCircle(Canvas canvas, Offset center, double radius) {
    super.renderCircle(canvas, center, radius);
    canvas.drawLine(center, center, _blue);
  }
}
