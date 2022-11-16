import 'package:flutter/material.dart';
import 'package:kount/routes/routes.dart';
import 'package:kount/screens/home.dart';

Map<String, WidgetBuilder> router = {
  kHomeRoute: (context) => const Home(),
};
