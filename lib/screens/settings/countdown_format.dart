import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:heroicons/heroicons.dart';
import 'package:kount/screens/cards/countdown_card.dart';
import 'package:kount/screens/partials/navbar.dart';

class CountdownFormat extends StatefulWidget {
  const CountdownFormat({super.key});

  @override
  State<CountdownFormat> createState() => _CountdownFormatState();
}

enum Formats { smart, years, months, days, hours, minutes, seconds }

class _CountdownFormatState extends State<CountdownFormat> {
  String selected = "";

  Formats? _format = Formats.smart;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text(
          'Countdown Format',
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
            child: ListView.builder(
                itemCount: 1,
                itemBuilder: ((context, index) {
                  return Column(children: [
                    RadioListTile<Formats>(
                      activeColor: Colors.black,
                      title: const Text('Smart'),
                      value: Formats.smart,
                      groupValue: _format,
                      onChanged: (Formats? value) {
                        setState(() {
                          _format = value;
                        });
                      },
                    ),
                    RadioListTile<Formats>(
                      activeColor: Colors.black,
                      title: const Text('Years'),
                      value: Formats.years,
                      groupValue: _format,
                      onChanged: (Formats? value) {
                        setState(() {
                          _format = value;
                        });
                      },
                    ),
                    RadioListTile<Formats>(
                      activeColor: Colors.black,
                      title: const Text('Months'),
                      value: Formats.months,
                      groupValue: _format,
                      onChanged: (Formats? value) {
                        setState(() {
                          _format = value;
                        });
                      },
                    ),
                    RadioListTile<Formats>(
                      activeColor: Colors.black,
                      title: const Text('Days'),
                      value: Formats.days,
                      groupValue: _format,
                      onChanged: (Formats? value) {
                        setState(() {
                          _format = value;
                        });
                      },
                    ),
                    RadioListTile<Formats>(
                      activeColor: Colors.black,
                      title: const Text('Hours'),
                      value: Formats.hours,
                      groupValue: _format,
                      onChanged: (Formats? value) {
                        setState(() {
                          _format = value;
                        });
                      },
                    ),
                    RadioListTile<Formats>(
                      activeColor: Colors.black,
                      title: const Text('Minutes'),
                      value: Formats.minutes,
                      groupValue: _format,
                      onChanged: (Formats? value) {
                        setState(() {
                          _format = value;
                        });
                      },
                    ),
                    RadioListTile<Formats>(
                      activeColor: Colors.black,
                      title: const Text('Seconds'),
                      value: Formats.seconds,
                      groupValue: _format,
                      onChanged: (Formats? value) {
                        setState(() {
                          _format = value;
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
