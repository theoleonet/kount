import 'package:appwrite/appwrite.dart';
import 'package:flutter/material.dart';
import 'package:kount/routes/routes.dart';
import 'package:kount/screens/auth/auth_state.dart';
import 'package:kount/screens/partials/button.dart';
import 'package:kount/screens/partials/custom_text_field.dart';
import 'package:kount/screens/partials/navbar.dart';
import 'package:kount/screens/partials/top_navbar.dart';
import 'package:kount/screens/styles/constants.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  String password = '';
  String email = '';
  bool submitted = false;

// create a TextEditingController
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  String? appwriteError = null;

  // dispose it when the widget is unmounted
  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  void loginAccount(String email, String password) async {
    AuthState state = AuthState();
    Account account = state.account;

    Future result = account.createEmailSession(
      email: email,
      password: password,
    );

    appwriteError = null;

    result.then((response) {
      Navigator.pushNamed(context, kProfileRoute);
    }).catchError((error) {
      appwriteError = error.message;
      setState(() {});
    });
  }

  String? get _emailErrorText {
    final text = _emailController.value.text;
    if (text.isEmpty) {
      return 'Can\'t be empty';
    }
    if (appwriteError != null) {
      return appwriteError;
    }
    // return null if the text is valid
    return null;
  }

  String? get _passwordErrorText {
    final text = _passwordController.value.text;
    if (text.isEmpty) {
      return 'Can\'t be empty';
    }
    // return null if the text is valid
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kBackgroundColor,
      appBar: TopNavBar(
        title: 'Register',
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 24,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            ValueListenableBuilder(
                valueListenable: _emailController,
                builder: (context, TextEditingValue value, __) {
                  return CustomTextField(
                    controller: _emailController,
                    errorText: submitted ? _emailErrorText : null,
                    onChanged: (value) {
                      email = value;
                    },
                    label: 'Email',
                    help: 'Ex: SuperUser@mail.com',
                  );
                }),
            SizedBox(
              height: kDefaultSpacer * 2.5,
            ),
            ValueListenableBuilder(
              valueListenable: _passwordController,
              builder: (context, TextEditingValue value, __) {
                return CustomTextField(
                  controller: _passwordController,
                  errorText: submitted ? _passwordErrorText : null,
                  onChanged: (value) {
                    password = value;
                  },
                  label: 'Password',
                  help: 'Ex: bananaremoteleafsupernova',
                );
              },
            ),
            SizedBox(
              height: kDefaultSpacer * 2.5,
            ),
            Button(
              onTap: () {
                submitted = true;
                if (_passwordErrorText != null || _emailErrorText != null) {
                  setState(() {});
                  return;
                }
                loginAccount(email, password);
              },
              text: 'Login',
            ),
            SizedBox(
              height: kDefaultSpacer,
            ),
            Row(children: [
              Spacer(),
              GestureDetector(
                onTap: () {
                  Navigator.pushNamed(
                    context,
                    kRegisterRoute,
                  );
                },
                child: Text(
                  'Don\'t have an account yet?',
                  style: kUnderlineText,
                ),
              ),
            ])
          ],
        ),
      ),
      bottomNavigationBar: BottomNavBar(),
    );
  }
}
