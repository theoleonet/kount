import 'package:flutter/material.dart';
import 'package:heroicons/heroicons.dart';
import 'package:kount/screens/cards/countdown_card.dart';
import 'package:kount/screens/partials/navbar.dart';

class CountdownSize extends StatefulWidget {
  const CountdownSize({super.key});

  @override
  State<CountdownSize> createState() => _CountdownSizeState();
}

enum Sizes { small, medium, big }

class _CountdownSizeState extends State<CountdownSize> {
  Sizes? _size = Sizes.small;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text(
          'Countdown Size',
          style: TextStyle(fontSize: 18),
        ),
        centerTitle: true,
        backgroundColor: Colors.white,
        titleTextStyle: TextStyle(color: Colors.black),
        iconTheme: IconThemeData(color: Colors.black),
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: HeroIcon(
            HeroIcons.arrowLeft,
            size: 24,
          ),
        ),
        elevation: 0,
      ),
      body: Column(
        children: [
          CountdownCard(),
          Flexible(
            child: Column(
              children: [
                RadioListTile<Sizes>(
                  activeColor: Colors.black,
                  title: const Text('Small'),
                  value: Sizes.small,
                  groupValue: _size,
                  onChanged: (Sizes? value) {
                    setState(() {
                      _size = value;
                    });
                  },
                ),
                RadioListTile<Sizes>(
                  activeColor: Colors.black,
                  title: const Text('Medium'),
                  value: Sizes.medium,
                  groupValue: _size,
                  onChanged: (Sizes? value) {
                    setState(() {
                      _size = value;
                    });
                  },
                ),
              ],
            ),
          ),
        ],
      ),
      bottomNavigationBar: BottomNavBar(),
    );
  }
}
