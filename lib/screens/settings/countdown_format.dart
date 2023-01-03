import 'package:appwrite/appwrite.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:heroicons/heroicons.dart';
import 'package:kount/screens/auth/auth_state.dart';
import 'package:kount/screens/cards/countdown_card.dart';
import 'package:kount/screens/partials/navbar.dart';
import 'package:kount/screens/partials/top_navbar.dart';
import 'package:kount/screens/styles/constants.dart';

class CountdownFormat extends StatefulWidget {
  const CountdownFormat({super.key});

  @override
  State<CountdownFormat> createState() => _CountdownFormatState();
}

enum Formats { smart, years, weeks, months, days, hours, minutes, seconds }

class _CountdownFormatState extends State<CountdownFormat> {
  String selected = "";
  String? format;

  @override
  void initState() {
    getUserPrefs();
  }

  void getUserPrefs() {
    AuthState state = AuthState();
    Account account = state.account;

    Future response = account.getPrefs();
    response.then((result) {
      format = result.data['countdown_format'];
      getFormat(format: format);
      setState(() {});
    }).catchError((error) {});
  }

  Formats? _format = Formats.smart;
  Formats getFormat({required String? format}) {
    if (format == 'year') {
      return _format = Formats.years;
    }

    if (format == 'month') {
      return _format = Formats.months;
    }

    if (format == 'week') {
      return _format = Formats.weeks;
    }

    if (format == 'day') {
      return _format = Formats.days;
    }

    if (format == 'hour') {
      return _format = Formats.hours;
    }

    if (format == 'minute') {
      return _format = Formats.minutes;
    }

    if (format == 'second') {
      return _format = Formats.seconds;
    }
    return _format = Formats.smart;
  }

  void setPrefence(String format) {
    AuthState state = AuthState();
    Account account = state.account;

    Future result = account.getPrefs();

    result.then((response) {
      var userPrefs = response.data;

      Future result = account.updatePrefs(prefs: {
        'profile_pic':
            userPrefs['profile_pic'] != null ? userPrefs['profile_pic'] : null,
        'countdown_format': format,
      });

      result.then((response) {}).catchError((error) {
        print(error);
      });
    }).catchError(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kBackgroundColor,
      appBar: TopNavBar(title: 'Countdown format'),
      body: Column(
        children: [
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
                          setPrefence('smart');
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
                          setPrefence('year');
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
                          setPrefence('month');
                        });
                      },
                    ),
                    RadioListTile<Formats>(
                      activeColor: kRadioButtonActiveColor,
                      title: const Text('Weeks'),
                      value: Formats.weeks,
                      groupValue: _format,
                      onChanged: (Formats? value) {
                        setState(() {
                          _format = value;
                          setPrefence('week');
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
                          setPrefence('day');
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
                          setPrefence('hour');
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
                          setPrefence('minute');
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
                          setPrefence('second');
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
