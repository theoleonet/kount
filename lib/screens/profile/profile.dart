import 'dart:math';
import 'package:appwrite/appwrite.dart';
import 'package:flutter/material.dart';
import 'package:heroicons/heroicons.dart';
import 'package:image_picker/image_picker.dart';
import 'package:kount/routes/routes.dart';
import 'package:kount/screens/auth/auth_state.dart';
import 'package:kount/screens/partials/button.dart';
import 'package:kount/screens/partials/navbar.dart';
import 'package:kount/screens/partials/profile_field.dart';
import 'package:kount/screens/partials/top_navbar.dart';
import 'package:kount/screens/styles/constants.dart';
import 'package:dio/dio.dart';

class Profile extends StatefulWidget {
  const Profile({super.key});

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  var user;
  var profilePic;
  var avatarFromLetters;

  @override
  void initState() {
    AuthState state = AuthState();
    Account account = state.account;

    getUser(account);
    getUserPreferences(account);
    getAvatarFromLetters();
  }

  String getRandomString(int length) {
    const characters = 'AaBbCcDdEeFfGgHhIiJjKkLlMmNnOoPpQqRrSsTtUuVvWwXxYyZz';
    Random random = Random();
    return String.fromCharCodes(Iterable.generate(length,
        (_) => characters.codeUnitAt(random.nextInt(characters.length))));
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

  void getUserPreferences(Account account) {
    Future result = account.getPrefs();

    result.then((response) {
      if (response.data['profile_pic'] != null &&
          response.data['profile_pic'] != '') {
        getProfilePic(response.data['profile_pic']);
      }
    }).catchError((error) {
      print(error);
    });
  }

  Future uploadProfilePic(Storage storage, Account account) async {
    final image = await ImagePicker().pickImage(source: ImageSource.gallery);

    if (image == null) return;
    final file = await MultipartFile.fromFile(image.path);

    Future result = storage.createFile(
      bucketId: '63aee16dee0424000ab2',
      fileId: ID.unique(),
      file: InputFile(path: image.path, filename: getRandomString(56) + '.jpg'),
    );

    result.then((response) {
      final id = response.$id;
      Future result = account.updatePrefs(prefs: {'profile_pic': id});
      result.then((response) {
        getUserPreferences(account);
      });
    }).catchError((error) {
      print(error.response);
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
      print(response);
      avatarFromLetters = response;
      setState(() {});
    }).catchError((error) {});
    setState(() {});
  }

  Future logOut(Account account) async {
    Future result = account.deleteSession(sessionId: 'current');
    result.then((response) {
      Navigator.pushNamed(context, kHomeRoute);
    }).catchError((error) {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kBackgroundColor,
      appBar: TopNavBar(
        title: 'Profile',
        actions: [
          IconButton(
            onPressed: () {
              Navigator.pushNamed(context, kProfileEditRoute);
            },
            icon: HeroIcon(
              HeroIcons.pencilSquare,
              size: 24,
            ),
          ),
        ],
      ),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: 16,
          ),
          child: SingleChildScrollView(
            child: user != null || avatarFromLetters != null
                ? Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Column(
                            children: [
                              GestureDetector(
                                onTap: () {
                                  AuthState state = AuthState();
                                  Account account = state.account;
                                  Storage storage = state.storage;
                                  uploadProfilePic(storage, account);
                                },
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(100),
                                  child: profilePic != null
                                      ? Image.memory(
                                          profilePic,
                                          width: 150,
                                        )
                                      : avatarFromLetters != null
                                          ? Image.memory(
                                              avatarFromLetters,
                                              width: 150,
                                              height: 150,
                                              fit: BoxFit.cover,
                                            )
                                          : Container(
                                              color: Colors.grey,
                                              height: 150,
                                              width: 150,
                                            ),
                                ),
                              ),
                              SizedBox(
                                height: kDefaultSpacer,
                              ),
                              Text(
                                user.name,
                                style: kCreationFieldLabel,
                              ),
                            ],
                          ),
                        ],
                      ),
                      SizedBox(
                        height: kDefaultSpacer * 2.5,
                      ),
                      ProfileField(
                        label: 'Email',
                        value: user.email,
                      ),
                      SizedBox(
                        height: kDefaultSpacer * 2.5,
                      ),
                      Button(
                        onTap: () {
                          AuthState state = AuthState();
                          Account account = state.account;
                          logOut(account);
                        },
                        text: 'Log out',
                        width: 200,
                      ),
                      SizedBox(
                        height: kDefaultSpacer,
                      ),
                      Button(
                        text: 'Delete account',
                        color: Color(0xFFF44336),
                        width: 200,
                      ),
                    ],
                  )
                : Container(),
          ),
        ),
      ),
      bottomNavigationBar: BottomNavBar(),
    );
  }
}
