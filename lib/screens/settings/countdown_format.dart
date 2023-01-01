import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:heroicons/heroicons.dart';
import 'package:kount/screens/cards/countdown_card.dart';
import 'package:kount/screens/partials/navbar.dart';
import 'package:kount/screens/partials/top_navbar.dart';
import 'package:kount/screens/styles/constants.dart';

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
      backgroundColor: kBackgroundColor,
      appBar: TopNavBar(title: 'Countdown format'),
      body: Column(
        children: [
          // CountdownCard(),
          Flexible(
            child: ListView.builder(
                itemCount: 1,
                itemBuilder: ((context, index) {
                  return Column(children: [
                    RadioListTile<Formats>(
                      activeColor: kRadioButtonActiveColor,
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
                      activeColor: kRadioButtonActiveColor,
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
                      activeColor: kRadioButtonActiveColor,
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
                      activeColor: kRadioButtonActiveColor,
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
                      activeColor: kRadioButtonActiveColor,
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
                      activeColor: kRadioButtonActiveColor,
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
                      activeColor: kRadioButtonActiveColor,
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
