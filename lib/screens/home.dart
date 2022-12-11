import 'package:flutter/material.dart';
import 'package:heroicons/heroicons.dart';
import 'package:kount/screens/cards/countdown_card.dart';
import 'package:kount/screens/partials/navbar.dart';

class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
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
