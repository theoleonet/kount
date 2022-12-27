import 'package:flutter/material.dart';
import 'package:kount/screens/cards/countdown_card.dart';
import 'package:kount/screens/partials/navbar.dart';
import 'package:kount/screens/partials/top_navbar.dart';
import 'package:kount/screens/styles/constants.dart';

class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kBackgroundColor,
      appBar: TopNavBar(
        title: 'Home',
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              CountdownCard(),
              CountdownCard(),
              CountdownCard(),
              CountdownCard(),
              CountdownCard(),
              CountdownCard(),
              CountdownCard(),
              CountdownCard(),
              CountdownCard(),
            ],
          ),
        ),
      ),
      bottomNavigationBar: BottomNavBar(),
    );
  }
}
