import 'package:flutter/material.dart';
import 'package:kount/routes/routes.dart';
import 'package:kount/screens/create_countdown.dart';
import 'package:kount/screens/home.dart';
import 'package:kount/screens/profile.dart';

Map<String, WidgetBuilder> router = {
  kHomeRoute: (context) => const Home(),
  kCreateCountdownRoute: (context) => const CreateCountdown(),
  kProfileRoute: (context) => const Profile(),
};
