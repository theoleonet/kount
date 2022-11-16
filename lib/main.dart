import 'package:flutter/material.dart';
import 'package:kount/routes/router.dart';
import 'package:kount/routes/routes.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      initialRoute: kHomeRoute,
      routes: router,
      theme: ThemeData(),
    );
  }
}
