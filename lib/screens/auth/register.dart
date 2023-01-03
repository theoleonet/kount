import 'package:appwrite/appwrite.dart';
import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:kount/routes/routes.dart';
import 'package:kount/screens/auth/auth_state.dart';
import 'package:kount/screens/partials/button.dart';
import 'package:kount/screens/partials/custom_text_field.dart';
import 'package:kount/screens/partials/navbar.dart';
import 'package:kount/screens/partials/top_navbar.dart';
import 'package:kount/screens/styles/constants.dart';
import 'package:provider/provider.dart';

class Register extends StatefulWidget {
  const Register({super.key});

  @override
  State<Register> createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  String password = '';
  String email = '';
  String name = '';
  bool submitted = false;

// create a TextEditingController
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _nameController = TextEditingController();

  // dispose it when the widget is unmounted
  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    _nameController.dispose();
    super.dispose();
  }

  void createAccount(String name, String email, String password) async {
    AuthState state = AuthState();
    Account account = state.account;

    Future result = account.create(
      userId: ID.unique(),
      email: email,
      password: password,
      name: name,
    );

    result.then((response) {
      Future result =
          account.createEmailSession(email: email, password: password);
      result.then((response) {
        Future result = account.getPrefs();

        result.then((response) {
          var userPrefs = response.data;

          Future result = account.updatePrefs(prefs: {
            'profile_pic': userPrefs['profile_pic'] != null
                ? userPrefs['profile_pic']
                : null,
            'countdown_format': 'smart',
          });

          result.then((response) {
            Navigator.pushNamed(context, kProfileRoute);
          }).catchError((error) {
            print(error);
          });
        }).catchError((error) {});
      }).catchError((error) {
        print(error.message);
      });
    });
  }

  String? get _emailErrorText {
    // at any time, we can get the text from _controller.value.text
    final text = _emailController.value.text;
    // Note: you can do your own custom validation here
    // Move this logic this outside the widget for more testable code
    if (text.isEmpty) {
      return 'Can\'t be empty';
    }
    if (!EmailValidator.validate(text)) {
      return 'Invalid email adress';
    }
    // return null if the text is valid
    return null;
  }

  String? get _nameErrorText {
    // at any time, we can get the text from _controller.value.text
    final text = _nameController.value.text;
    // Note: you can do your own custom validation here
    // Move this logic this outside the widget for more testable code
    if (text.isEmpty) {
      return 'Can\'t be empty';
    }
    if (text.length < 2) {
      return 'Name must be at least 2 characters';
    }
    // return null if the text is valid
    return null;
  }

  String? get _passwordErrorText {
    // at any time, we can get the text from _controller.value.text
    final text = _passwordController.value.text;
    // Note: you can do your own custom validation here
    // Move this logic this outside the widget for more testable code
    if (text.isEmpty) {
      return 'Can\'t be empty';
    }
    if (text.length < 8) {
      return 'Password should be at least 8 character';
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
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 24,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              ValueListenableBuilder(
                  valueListenable: _nameController,
                  builder: (context, TextEditingValue value, __) {
                    return CustomTextField(
                      controller: _nameController,
                      errorText: submitted ? _nameErrorText : null,
                      onChanged: (value) {
                        name = value;
                      },
                      label: 'Name',
                      help: 'Tom Malvolo Riddle',
                    );
                  }),
              SizedBox(
                height: kDefaultSpacer * 2.5,
              ),
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
                    obscureText: true,
                  );
                },
              ),
              SizedBox(
                height: kDefaultSpacer * 2.5,
              ),
              Button(
                onTap: () {
                  submitted = true;
                  if (_passwordErrorText != null && _emailErrorText != null) {
                    setState(() {});
                    return;
                  }
                  createAccount(name, email, password);
                },
                text: 'Register',
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
                      kLoginRoute,
                    );
                  },
                  child: Text(
                    'Already have an account?',
                    style: kUnderlineText,
                  ),
                ),
              ])
            ],
          ),
        ),
      ),
    );
  }
}
