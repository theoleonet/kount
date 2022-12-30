import 'package:flutter/material.dart';
import 'package:kount/routes/routes.dart';
import 'package:kount/screens/auth/login.dart';
import 'package:kount/screens/auth/register.dart';
import 'package:kount/screens/create_countdown.dart';
import 'package:kount/screens/home.dart';
import 'package:kount/screens/profile.dart';
import 'package:kount/screens/settings/countdown_format.dart';
import 'package:kount/screens/settings/countdown_size.dart';
import 'package:kount/screens/settings/custom_theme.dart';
import 'package:kount/screens/settings/settings.dart';

Map<String, WidgetBuilder> router = {
  kHomeRoute: (context) => const Home(),
  kCreateCountdownRoute: (context) => const CreateCountdown(),
  kProfileRoute: (context) => const Profile(),
  kSettingsRoute: (context) => const Settings(),
  kCountdownFormatRoute: (context) => const CountdownFormat(),
  kCountdownSizeRoute: (context) => const CountdownSize(),
  kThemeRoute: (context) => const CustomTheme(),
  kRegisterRoute: (context) => const Register(),
  kLoginRoute: (context) => const Login(),
};
