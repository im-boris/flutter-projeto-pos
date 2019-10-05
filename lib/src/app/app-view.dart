
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:quiz_v1/src/app/app-widgets.dart';
import 'package:quiz_v1/src/login/login-view.dart';
import 'package:quiz_v1/src/quiz/quiz-view.dart';


class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
     SystemChrome.setPreferredOrientations([
        DeviceOrientation.portraitUp,
        DeviceOrientation.portraitDown,
    ]);
    return MaterialApp(
      title: 'Quiz idade dos famosos',
      debugShowCheckedModeBanner: false,
      theme: criaTemaApp(),
      home: TelaInicial()
    ); 
  }
}