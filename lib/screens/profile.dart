import 'package:flutter/material.dart';
import 'package:heroicons/heroicons.dart';
import 'package:kount/screens/partials/button.dart';
import 'package:kount/screens/partials/navbar.dart';
import 'package:kount/screens/partials/profile_field.dart';
import 'package:kount/screens/partials/top_navbar.dart';
import 'package:kount/screens/styles/constants.dart';

class Profile extends StatelessWidget {
  const Profile({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kBackgroundColor,
      appBar: TopNavBar(
        title: 'Profile',
        actions: [
          IconButton(
            onPressed: () {},
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
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Column(
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(100),
                          child: Image.network(
                            'https://images.unsplash.com/photo-1570295999919-56ceb5ecca61?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=1760&q=80',
                            width: 150,
                          ),
                        ),
                        SizedBox(
                          height: kDefaultSpacer,
                        ),
                        Text(
                          'Tom Jedusor',
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
                  value: 'tomvoldy@evilmail.com',
                ),
                SizedBox(
                  height: kDefaultSpacer * 2.5,
                ),
                ProfileField(
                  label: 'Password',
                  value: '•••••••••••••••',
                ),
                SizedBox(
                  height: kDefaultSpacer * 2.5,
                ),
                Button(
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
            ),
          ),
        ),
      ),
      bottomNavigationBar: BottomNavBar(),
    );
  }
}
