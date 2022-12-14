import 'package:flutter/material.dart';
import 'package:kount/routes/routes.dart';
import 'package:kount/screens/auth/login.dart';
import 'package:kount/screens/auth/register.dart';
import 'package:kount/screens/create_countdown/create_countdown.dart';
import 'package:kount/screens/home/home.dart';
import 'package:kount/screens/layout.dart';
import 'package:kount/screens/profile/profile.dart';
import 'package:kount/screens/profile/profile_edit.dart';
import 'package:kount/screens/settings/countdown_format.dart';
import 'package:kount/screens/settings/countdown_size.dart';
import 'package:kount/screens/settings/custom_theme.dart';
import 'package:kount/screens/settings/settings.dart';

Map<String, WidgetBuilder> router = {
  kLayoutRoute: (context) => const Layout(),
  kHomeRoute: (context) => const Home(),
  kCreateCountdownRoute: (context) => const CreateCountdown(),
  kProfileRoute: (context) => const Profile(),
  kProfileEditRoute: (context) => const ProfileEdit(),
  kSettingsRoute: (context) => const Settings(),
  kCountdownFormatRoute: (context) => const CountdownFormat(),
  kCountdownSizeRoute: (context) => const CountdownSize(),
  kThemeRoute: (context) => const CustomTheme(),
  kRegisterRoute: (context) => const Register(),
  kLoginRoute: (context) => const Login(),
};
