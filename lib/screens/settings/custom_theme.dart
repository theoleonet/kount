import 'package:flutter/material.dart';
import 'package:heroicons/heroicons.dart';
import 'package:kount/screens/partials/navbar.dart';

class CustomTheme extends StatefulWidget {
  const CustomTheme({super.key});

  @override
  State<CustomTheme> createState() => _CustomThemeState();
}

enum Themes { light, dark }

class _CustomThemeState extends State<CustomTheme> {
  String selected = "";

  Themes? _theme = Themes.light;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text(
          'Theme',
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
          Flexible(
            child: ListView.builder(
                itemCount: 1,
                itemBuilder: ((context, index) {
                  return Column(children: [
                    RadioListTile<Themes>(
                      activeColor: Colors.black,
                      title: const Text('Light'),
                      value: Themes.light,
                      groupValue: _theme,
                      onChanged: (Themes? value) {
                        setState(() {
                          _theme = value;
                        });
                      },
                    ),
                    RadioListTile<Themes>(
                      activeColor: Colors.black,
                      title: const Text('Dark'),
                      value: Themes.dark,
                      groupValue: _theme,
                      onChanged: (Themes? value) {
                        setState(() {
                          _theme = value;
                        });
                      },
                    ),
                  ]);
                })),
          ),
        ],
      ),
      bottomNavigationBar: BottomNavBar(),
    );
  }
}
