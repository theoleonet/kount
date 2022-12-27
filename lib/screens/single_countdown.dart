import 'package:flutter/material.dart';
import 'package:heroicons/heroicons.dart';
import 'package:kount/screens/partials/navbar.dart';
import 'package:kount/screens/partials/text_editor.dart';
import 'package:kount/screens/styles/constants.dart';

class SingleCountdown extends StatefulWidget {
  const SingleCountdown({super.key});
  @override
  State<SingleCountdown> createState() => _SingleCountdownState();
}

class _SingleCountdownState extends State<SingleCountdown> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Stack(
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
            decoration: const BoxDecoration(
              gradient: kNavbarGradient,
            ),
            height: kNavbarGradientHeight,
          ),
          SafeArea(
            child: Container(
              padding: const EdgeInsets.all(24),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  GestureDetector(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: const HeroIcon(
                      HeroIcons.arrowLeft,
                      color: Colors.white,
                      size: kBaseIconSize,
                    ),
                  ),
                  const Spacer(),
                  Row(
                    children: const [
                      HeroIcon(
                        HeroIcons.userPlus,
                        color: kSingleCountdownIconsColor,
                        size: kBaseIconSize,
                      ),
                      SizedBox(width: kDefaultSpacer * 2),
                      HeroIcon(
                        HeroIcons.arrowUpOnSquare,
                        color: kSingleCountdownIconsColor,
                        size: kBaseIconSize,
                      ),
                      SizedBox(width: kDefaultSpacer * 2),
                      HeroIcon(
                        HeroIcons.pencilSquare,
                        color: kSingleCountdownIconsColor,
                        size: kBaseIconSize,
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
          Container(
            height:
                MediaQuery.of(context).size.height - kHeightFromBottomForText,
            padding: const EdgeInsets.only(left: 24, right: 24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.end,
              children: const [
                Text(
                  'Dinner at the chineese restaurant with family and also with our friends, it will be super duper cool!! you\'ll see',
                  style: kSingleCountdownTitleStyle,
                ),
                SizedBox(
                  height: kDefaultSpacer,
                ),
                Text(
                  'In 12 days',
                  style: kSingleCountdownTimeStyle,
                ),
                SizedBox(
                  height: kDefaultSpacer / 2,
                ),
                Text(
                  '14 november 2022',
                  style: kSingleCountdownDateStyle,
                ),
              ],
            ),
          ),
          SafeArea(
            child: DraggableScrollableSheet(
              initialChildSize: 0.1,
              minChildSize: 0.1,
              maxChildSize: 1,
              builder:
                  (BuildContext context, ScrollController scrollController) {
                return Container(
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius: kTopBorderRadius,
                  ),
                  child: ListView.builder(
                    padding: const EdgeInsets.only(top: 24),
                    itemCount: 1,
                    controller: scrollController,
                    itemBuilder: (BuildContext context, int index) {
                      return Column(
                        children: const [
                          HeroIcon(
                            HeroIcons.chevronUp,
                            color: Colors.black,
                            size: kBigIconSize,
                          ),
                          SizedBox(
                            height: kDefaultSpacer * 2.5,
                          ),
                          TextEditor(),
                        ],
                      );
                    },
                  ),
                );
              },
            ),
          ),
        ],
      ),
      bottomNavigationBar: const BottomNavBar(),
    );
  }
}
