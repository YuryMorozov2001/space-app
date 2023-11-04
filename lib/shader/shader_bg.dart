import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';

class ShaderBackground extends StatefulWidget {
  const ShaderBackground({super.key, required this.constraints});
  final BoxConstraints constraints;
  @override
  State<ShaderBackground> createState() => _ShaderBackgroundState();
}

class _ShaderBackgroundState extends State<ShaderBackground>
    with TickerProviderStateMixin {
  late Ticker _ticker;
  late Future<FragmentShader> _shaderFuture;

  final ValueNotifier<double> _timeNotifier = ValueNotifier(0);

  @override
  void initState() {
    super.initState();
    _shaderFuture = _load();

    _ticker = createTicker((Duration elapsed) {
      _timeNotifier.value = elapsed.inMilliseconds.toDouble() * 0.0008;
    });
    _ticker.start();
  }

  @override
  void dispose() {
    _ticker.dispose();
    _timeNotifier.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<FragmentShader>(
      future: _shaderFuture,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const CircularProgressIndicator();
        }
        if (snapshot.hasData) {
          final shader = snapshot.data!;
          return ValueListenableBuilder<double>(
            valueListenable: _timeNotifier,
            builder: (_, time, __) {
              shader.setFloat(0, widget.constraints.maxWidth);
              shader.setFloat(1, widget.constraints.maxHeight);
              shader.setFloat(2, time);
              return CustomPaint(
                painter: ShaderPainter(shader),
              );
            },
          );
        } else {
          return Text('Error loading shader: ${snapshot.error}');
        }
      },
    );
  }
}

class ShaderPainter extends CustomPainter {
  final FragmentShader shader;

  ShaderPainter(this.shader);

  @override
  void paint(Canvas canvas, Size size) {
    canvas.drawRect(
      Rect.fromLTWH(0, 0, size.width, size.height),
      Paint()..shader = shader,
    );
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return oldDelegate != this;
  }
}

Future<FragmentShader> _load() async {
  FragmentProgram program =
      await FragmentProgram.fromAsset('shaders/stars.frag');
  final shader = program.fragmentShader();

  return shader;
}
