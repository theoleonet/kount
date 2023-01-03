import 'dart:async';
import 'dart:math';

import 'package:appwrite/appwrite.dart';
import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:image_picker/image_picker.dart';
import 'package:kount/screens/auth/auth_state.dart';
import 'package:kount/screens/partials/button.dart';
import 'package:kount/screens/partials/custom_text_field.dart';
import 'package:kount/screens/partials/navbar.dart';
import 'package:kount/screens/partials/top_navbar.dart';
import 'package:kount/screens/styles/constants.dart';

class ProfileEdit extends StatefulWidget {
  const ProfileEdit({super.key});

  @override
  State<ProfileEdit> createState() => _ProfileEditState();
}

class _ProfileEditState extends State<ProfileEdit> {
  var user;
  var profilePic;
  var avatarFromLetters;
  late Timer _timer;
  late Map<dynamic, dynamic> userPrefs;

  String password = '';
  String newPassword = '';
  String oldPassword = '';
  String email = '';
  String name = '';

  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _newPasswordController = TextEditingController();
  final _oldPasswordController = TextEditingController();
  final _nameController = TextEditingController();

  bool nameSubmitted = false;
  bool emailSubmitted = false;
  bool passwordSubmitted = false;

  bool nameSuccess = false;
  bool emailSuccess = false;
  bool passwordSuccess = false;

  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    _newPasswordController.dispose();
    _oldPasswordController.dispose();
    _nameController.dispose();
    super.dispose();
  }

  void reset() {
    _nameController.clear();
    _emailController.clear();
    _passwordController.clear();
    _newPasswordController.clear();
    _oldPasswordController.clear();
    passwordSubmitted = false;
    emailSubmitted = false;
    nameSubmitted = false;
  }

  void initState() {
    AuthState state = AuthState();
    Account account = state.account;

    getUser(account);
    getUserPreferences(account);
    getAvatarFromLetters();
  }

  void getUser(Account account) {
    AuthState state = AuthState();
    Account account = state.account;

    Future result = account.get();
    result.then((response) {
      user = response;
      setState(() {});
    }).catchError((error) {
      print(error.response);
    });
  }

  String getRandomString(int length) {
    const characters = 'AaBbCcDdEeFfGgHhIiJjKkLlMmNnOoPpQqRrSsTtUuVvWwXxYyZz';
    Random random = Random();
    return String.fromCharCodes(Iterable.generate(length,
        (_) => characters.codeUnitAt(random.nextInt(characters.length))));
  }

  Future uploadProfilePic(Storage storage, Account account) async {
    final image = await ImagePicker().pickImage(source: ImageSource.gallery);

    if (image == null) return;

    Future result = storage.createFile(
      bucketId: '63aee16dee0424000ab2',
      fileId: ID.unique(),
      file: InputFile(path: image.path, filename: getRandomString(56) + '.jpg'),
    );

    result.then((response) {
      final id = response.$id;
      Future result = account.updatePrefs(prefs: {
        'profile_pic': id,
        'countdown_format': userPrefs['countdown_format'] != null &&
                userPrefs['countdown_format'] != ''
            ? userPrefs['countdown_format']
            : 'smart'
      });
      result.then((response) {
        getUserPreferences(account);
      });
    }).catchError((error) {
      print(error.response);
    });
  }

  void getUserPreferences(Account account) {
    Future result = account.getPrefs();

    result.then((response) {
      if (response.data['profile_pic'] != null &&
          response.data['profile_pic'] != '') {
        getProfilePic(response.data['profile_pic']);
      }
      userPrefs = response.data;
    }).catchError((error) {
      print(error);
    });
  }

  Future getProfilePic(String fileId) async {
    if (fileId != null && fileId != '') {
      AuthState state = AuthState();
      Storage storage = state.storage;

      final result = await storage.getFilePreview(
          bucketId: '63aee16dee0424000ab2',
          fileId: fileId,
          width: 150,
          height: 150);

      profilePic = result;
      setState(() {});
      return;
    }
    profilePic = null;
    setState(() {});
  }

  Future getAvatarFromLetters() async {
    AuthState state = AuthState();
    Avatars avatars = state.avatars;

    Future result = avatars.getInitials(width: 150);
    result.then((response) {
      avatarFromLetters = response;
      setState(() {});
    }).catchError((error) {});
    setState(() {});
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
    // return null if the text is valid
    return null;
  }

  String? get _newPasswordErrorText {
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

  String? get _oldPasswordErrorText {
    // at any time, we can get the text from _controller.value.text
    final text = _oldPasswordController.value.text;
    // Note: you can do your own custom validation here
    // Move this logic this outside the widget for more testable code
    if (text.isEmpty) {
      return 'Can\'t be empty';
    }
    // return null if the text is valid
    return null;
  }

  void updateName({required String name}) {
    AuthState state = AuthState();
    Account account = state.account;

    Future result = account.updateName(name: name);

    result.then((response) {
      setState(() {
        nameSuccess = true;
        getUser(account);
        reset();
      });
      _timer = Timer(Duration(seconds: 3), () {
        setState(() {
          nameSuccess = false;
        });
      });
    }).catchError((error) {
      print(error);
    });
  }

  void updateEmail({required String email, required String password}) {
    AuthState state = AuthState();
    Account account = state.account;

    Future result = account.updateEmail(email: email, password: password);

    result.then((response) {
      setState(() {
        emailSuccess = true;
        getUser(account);
        reset();
      });
      _timer = Timer(Duration(seconds: 3), () {
        setState(() {
          emailSuccess = false;
        });
      });
    }).catchError((error) {
      print(error);
    });
  }

  void updatePassword(
      {required String newPassword, required String oldPassword}) {
    AuthState state = AuthState();
    Account account = state.account;

    print(password);
    print(oldPassword);

    Future result =
        account.updatePassword(password: newPassword, oldPassword: oldPassword);

    result.then((response) {
      setState(() {
        passwordSuccess = true;
        getUser(account);
        reset();
      });
      _timer = Timer(Duration(seconds: 3), () {
        setState(() {
          passwordSuccess = false;
        });
      });
    }).catchError((error) {
      print(error);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kBackgroundColor,
      appBar: TopNavBar(title: 'Edit profile'),
      body: user != null
          ? SafeArea(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Change profile picture',
                          style: kEditProfileTitleStyle),
                      SizedBox(
                        height: kDefaultSpacer,
                      ),
                      GestureDetector(
                        onTap: () {
                          AuthState state = AuthState();
                          Account account = state.account;
                          Storage storage = state.storage;
                          uploadProfilePic(storage, account);
                        },
                        child: Row(
                          children: [
                            ClipRRect(
                              borderRadius: BorderRadius.circular(100),
                              child: profilePic != null
                                  ? Image.memory(
                                      profilePic,
                                      width: 100,
                                    )
                                  : avatarFromLetters != null
                                      ? Image.memory(
                                          avatarFromLetters,
                                          width: 100,
                                          height: 100,
                                          fit: BoxFit.cover,
                                        )
                                      : Container(),
                            ),
                            SizedBox(
                              width: kDefaultSpacer * 1.5,
                            ),
                            Flexible(
                              child: Button(
                                text: 'Change profile picture',
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: kDefaultSpacer * 4,
                      ),
                      Text('Change name', style: kEditProfileTitleStyle),
                      SizedBox(
                        height: kDefaultSpacer,
                      ),
                      Column(
                        children: [
                          nameSuccess
                              ? Column(children: [
                                  Text('Succesfully changed the name',
                                      style: kSuccessText),
                                  SizedBox(height: kDefaultSpacer),
                                ])
                              : Container(),
                          ValueListenableBuilder(
                            valueListenable: _nameController,
                            builder: (context, TextEditingValue value, __) {
                              return Column(children: [
                                CustomTextField(
                                  controller: _nameController,
                                  label: 'New name',
                                  help: 'Current name: ' + user.name,
                                  errorText:
                                      nameSubmitted ? _nameErrorText : null,
                                  onChanged: (value) {
                                    name = value;
                                  },
                                ),
                                SizedBox(
                                  height: kDefaultSpacer,
                                ),
                                Button(
                                  text: 'Change name',
                                  onTap: () {
                                    nameSubmitted = true;
                                    if (_nameErrorText != null) {
                                      setState(() {});
                                      return;
                                    }
                                    updateName(name: name);
                                  },
                                )
                              ]);
                            },
                          ),
                        ],
                      ),
                      SizedBox(
                        height: kDefaultSpacer * 4,
                      ),
                      Text('Change email', style: kEditProfileTitleStyle),
                      SizedBox(
                        height: kDefaultSpacer,
                      ),
                      emailSuccess
                          ? Column(children: [
                              Text('Succesfully changed the email',
                                  style: kSuccessText),
                              SizedBox(height: kDefaultSpacer),
                            ])
                          : Container(),
                      ValueListenableBuilder(
                        valueListenable: _passwordController,
                        builder: (context, TextEditingValue value, __) {
                          return Column(children: [
                            CustomTextField(
                              controller: _passwordController,
                              label: 'Password',
                              errorText:
                                  passwordSubmitted ? _passwordErrorText : null,
                              onChanged: (value) {
                                password = value;
                              },
                            ),
                          ]);
                        },
                      ),
                      SizedBox(
                        height: kDefaultSpacer,
                      ),
                      ValueListenableBuilder(
                        valueListenable: _emailController,
                        builder: (context, TextEditingValue value, __) {
                          return Column(children: [
                            CustomTextField(
                              controller: _emailController,
                              label: 'New email',
                              help: 'Current email: ' + user.email,
                              errorText:
                                  emailSubmitted ? _emailErrorText : null,
                              onChanged: (value) {
                                email = value;
                              },
                            ),
                            SizedBox(
                              height: kDefaultSpacer,
                            ),
                            Button(
                              text: 'Change email',
                              onTap: () {
                                emailSubmitted = true;
                                if (_emailErrorText != null ||
                                    _passwordErrorText != null) {
                                  setState(() {});
                                  return;
                                }
                                updateEmail(email: email, password: password);
                              },
                            )
                          ]);
                        },
                      ),
                      SizedBox(
                        height: kDefaultSpacer * 4,
                      ),
                      Text('Change password', style: kEditProfileTitleStyle),
                      SizedBox(
                        height: kDefaultSpacer,
                      ),
                      passwordSuccess
                          ? Column(children: [
                              Text('Succesfully changed the password',
                                  style: kSuccessText),
                              SizedBox(height: kDefaultSpacer),
                            ])
                          : Container(),
                      ValueListenableBuilder(
                        valueListenable: _oldPasswordController,
                        builder: (context, TextEditingValue value, __) {
                          return Column(children: [
                            CustomTextField(
                              controller: _oldPasswordController,
                              label: 'Current password',
                              errorText: passwordSubmitted
                                  ? _oldPasswordErrorText
                                  : null,
                              onChanged: (value) {
                                oldPassword = value;
                              },
                            ),
                          ]);
                        },
                      ),
                      SizedBox(
                        height: kDefaultSpacer * 1.5,
                      ),
                      ValueListenableBuilder(
                        valueListenable: _newPasswordController,
                        builder: (context, TextEditingValue value, __) {
                          return Column(children: [
                            CustomTextField(
                              controller: _newPasswordController,
                              label: 'New password',
                              errorText:
                                  passwordSubmitted ? _passwordErrorText : null,
                              onChanged: (value) {
                                newPassword = value;
                              },
                            ),
                          ]);
                        },
                      ),
                      SizedBox(
                        height: kDefaultSpacer,
                      ),
                      Button(
                        text: 'Change password',
                        onTap: () {
                          passwordSubmitted = true;
                          if (_newPasswordErrorText != null ||
                              _oldPasswordErrorText != null) {
                            setState(() {});
                            return;
                          }
                          updatePassword(
                              newPassword: newPassword,
                              oldPassword: oldPassword);
                        },
                      ),
                      SizedBox(
                        height: kDefaultSpacer * 4,
                      )
                    ],
                  ),
                ),
              ),
            )
          : Container(),
    );
  }
}
