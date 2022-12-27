import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:heroicons/heroicons.dart';
import 'package:kount/routes/routes.dart';
import 'package:kount/screens/partials/navbar.dart';

class Settings extends StatelessWidget {
  const Settings({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text(
          'Settings',
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
        elevation: 0,
      ),
      body: SafeArea(
          child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Column(
          children: [
            SizedBox(
              height: 40,
            ),
            Row(
              children: [
                Text(
                  'Countdown format',
                  style: TextStyle(
                    fontSize: 18,
                  ),
                ),
                Spacer(),
                GestureDetector(
                  onTap: () =>
                      Navigator.pushNamed(context, kCountdownFormatRoute),
                  child: Row(
                    children: [
                      Text(
                        'Days',
                        style: TextStyle(
                          fontSize: 18,
                          color: Colors.grey,
                        ),
                      ),
                      SizedBox(
                        width: 16,
                      ),
                      HeroIcon(
                        HeroIcons.arrowRight,
                        size: 18,
                        color: Colors.grey,
                      ),
                    ],
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 40,
            ),
            Row(
              children: [
                Text(
                  'Countdown size',
                  style: TextStyle(
                    fontSize: 18,
                  ),
                ),
                Spacer(),
                GestureDetector(
                  onTap: () =>
                      Navigator.pushNamed(context, kCountdownSizeRoute),
                  child: Row(
                    children: [
                      Text(
                        'Small',
                        style: TextStyle(
                          fontSize: 18,
                          color: Colors.grey,
                        ),
                      ),
                      SizedBox(
                        width: 16,
                      ),
                      HeroIcon(
                        HeroIcons.arrowRight,
                        size: 18,
                        color: Colors.grey,
                      ),
                    ],
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 40,
            ),
            Row(
              children: [
                Text(
                  'Theme',
                  style: TextStyle(
                    fontSize: 18,
                  ),
                ),
                Spacer(),
                Text(
                  'Light',
                  style: TextStyle(
                    fontSize: 18,
                    color: Colors.grey,
                  ),
                ),
                SizedBox(
                  width: 16,
                ),
                HeroIcon(
                  HeroIcons.arrowRight,
                  size: 18,
                  color: Colors.grey,
                ),
              ],
            ),
            SizedBox(
              height: 40,
            ),
            Row(
              children: [
                Text(
                  'Reminders',
                  style: TextStyle(
                    fontSize: 18,
                  ),
                ),
                Spacer(),
                Text(
                  'Once',
                  style: TextStyle(
                    fontSize: 18,
                    color: Colors.grey,
                  ),
                ),
                SizedBox(
                  width: 16,
                ),
                HeroIcon(
                  HeroIcons.arrowRight,
                  size: 18,
                  color: Colors.grey,
                ),
              ],
            ),
            SizedBox(
              height: 40,
            ),
            Container(
              height: 48,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(7),
                color: Colors.grey,
              ),
              alignment: Alignment.center,
              child: Text(
                'Contact us',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                ),
              ),
            ),
          ],
        ),
      )),
      bottomNavigationBar: BottomNavBar(),
    );
  }
}
