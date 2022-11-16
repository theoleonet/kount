import 'package:flutter/material.dart';
import 'package:kount/screens/cards/countdown_card.dart';

class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            CountdownCard(),
          ],
        ),
      ),
    );
  }
}
