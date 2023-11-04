import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'screen/space_screen.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations(
    [
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ],
  );

  runApp(const SpaceApp());
}

class SpaceApp extends StatelessWidget {
  const SpaceApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'space',
      home: SpaceScreen(),
    );
  }
}
