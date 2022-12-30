import 'package:flutter/material.dart';
import 'package:kount/routes/router.dart';
import 'package:kount/routes/routes.dart';
import 'package:appwrite/appwrite.dart';

void main() {
  runApp(const MyApp());
  Client client = Client();
  client
      .setEndpoint(
        'http://localhost:90/v1',
      )
      .setProject(
        '63ac90ca35e31ed84b02',
      )
      .setSelfSigned(
        status: true,
      ); // For self signed certificates, only use for development
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
      child: MaterialApp(
        initialRoute: kHomeRoute,
        routes: router,
        theme: ThemeData(),
      ),
    );
  }
}
