import 'package:flutter/material.dart';
import 'package:heroicons/heroicons.dart';
import 'package:kount/screens/partials/navbar.dart';

class Profile extends StatelessWidget {
  const Profile({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text(
          'Profile',
          style: TextStyle(fontSize: 18),
        ),
        centerTitle: true,
        backgroundColor: Colors.white,
        titleTextStyle: TextStyle(color: Colors.black),
        iconTheme: IconThemeData(color: Colors.black),
        leading: Padding(
          padding: EdgeInsets.only(left: 16),
          child: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: HeroIcon(
              HeroIcons.arrowLeft,
              size: 24,
            ),
          ),
        ),
        actions: [
          IconButton(
            onPressed: () {},
            icon: HeroIcon(
              HeroIcons.pencilSquare,
              size: 24,
            ),
          ),
        ],
        elevation: 0,
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
                          height: 16,
                        ),
                        Text(
                          'Tom Jedusor',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                SizedBox(
                  height: 40,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Email',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(
                      height: 16,
                    ),
                    Container(
                      width: MediaQuery.of(context).size.width,
                      decoration: BoxDecoration(
                        border: Border(
                            bottom: BorderSide(width: 1, color: Colors.grey)),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.only(bottom: 8),
                        child: Text(
                          'LordVoldy@darkmail.net',
                          style: TextStyle(
                            color: Colors.grey,
                          ),
                        ),
                      ),
                    )
                  ],
                ),
                SizedBox(
                  height: 40,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Password',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(
                      height: 16,
                    ),
                    Container(
                      width: MediaQuery.of(context).size.width,
                      decoration: BoxDecoration(
                        border: Border(
                            bottom: BorderSide(width: 1, color: Colors.grey)),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.only(bottom: 8),
                        child: Text(
                          '••••••••••••••••••••',
                          style: TextStyle(
                            color: Colors.grey,
                          ),
                        ),
                      ),
                    )
                  ],
                ),
                SizedBox(
                  height: 40,
                ),
                Container(
                  height: 48,
                  width: 200,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(7),
                    color: Colors.grey,
                  ),
                  alignment: Alignment.center,
                  child: Text(
                    'Log out',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                    ),
                  ),
                ),
                SizedBox(
                  height: 16,
                ),
                Container(
                  height: 48,
                  width: 200,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(7),
                    color: Colors.red,
                  ),
                  alignment: Alignment.center,
                  child: Text(
                    'Delete account',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                    ),
                  ),
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
