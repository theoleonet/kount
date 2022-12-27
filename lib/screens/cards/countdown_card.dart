import 'package:flutter/material.dart';
import 'package:kount/screens/single_countdown.dart';
import 'package:kount/screens/styles/constants.dart';

class CountdownCard extends StatelessWidget {
  const CountdownCard({super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(context,
            MaterialPageRoute(builder: (context) => const SingleCountdown()));
      },
      child: Center(
        child: Column(
          children: [
            SizedBox(
              height: kSmallCardHeight,
              child: FractionallySizedBox(
                widthFactor: .9,
                child: Card(
                  clipBehavior: Clip.antiAlias,
                  shape: RoundedRectangleBorder(
                    borderRadius: kBaseBorderRadius,
                  ),
                  child: Stack(
                    children: [
                      Ink.image(
                        image: const NetworkImage(
                            'https://images.pexels.com/photos/262978/pexels-photo-262978.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=2'),
                        fit: BoxFit.cover,
                      ),
                      Container(
                        color: kOverlayColor,
                      ),
                      Container(
                        padding: const EdgeInsets.all(20),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: const [
                            Text(
                              'Dinner at the chineese restaurant with family',
                              style: kCardTitleStyle,
                            ),
                            SizedBox(
                              height: kDefaultSpacer,
                            ),
                            Text(
                              'In 12 days',
                              style: kCardTimeStyle,
                            ),
                            SizedBox(
                              height: kDefaultSpacer / 2,
                            ),
                            Text(
                              '14 november 2022',
                              style: kCardDateStyle,
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ),
            const SizedBox(
              height: kDefaultSpacer * 1.5,
            )
          ],
        ),
      ),
    );
  }
}
