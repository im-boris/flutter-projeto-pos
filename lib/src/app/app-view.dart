
import 'package:flutter/material.dart';
import 'package:quiz_v1/src/app/app-widgets.dart';


class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Quiz idade dos famosos',
      debugShowCheckedModeBanner: false,
      theme: criaTemaApp(),
      home: new TelaInicial()
    );
  }
}