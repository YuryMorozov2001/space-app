import 'package:flame/game.dart';
import 'package:flutter/material.dart';

import 'game.dart';

class GravityGameWidget extends StatefulWidget {
  const GravityGameWidget({super.key, required this.constraints});
  final BoxConstraints constraints;
  @override
  State<GravityGameWidget> createState() => _GravityGameWidgetState();
}

class _GravityGameWidgetState extends State<GravityGameWidget> {
  late AccelerometerGravityGame game;
  @override
  void initState() {
    super.initState();
    game = AccelerometerGravityGame();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(2.0),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(22),
        child: Container(
          height: widget.constraints.maxHeight * 0.5,
          color: Colors.white,
          child: Padding(
            padding: const EdgeInsets.all(2.0),
            child: GameWidget(
              game: AccelerometerGravityGame(),
            ),
          ),
        ),
      ),
    );
  }
}
