import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../game/game_widget.dart';
import '../shader/shader_bg.dart';

class SpaceScreen extends StatelessWidget {
  const SpaceScreen({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: LayoutBuilder(
        builder: (context, constraints) => Stack(
          children: [
            SizedBox(
              width: constraints.maxWidth,
              height: constraints.maxHeight,
              child: ShaderBackground(constraints: constraints),
            ),
            Center(
              child: GravityGameWidget(constraints: constraints),
            ),
            const StarIconWidget()
          ],
        ),
      ),
    );
  }
}

class StarIconWidget extends StatelessWidget {
  const StarIconWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SvgPicture.asset(
        'assets/plus.svg',
        colorFilter: const ColorFilter.mode(Colors.black, BlendMode.srcIn),
        height: 50,
        width: 50,
      ),
    );
  }
}
