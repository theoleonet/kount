import 'dart:async';

import 'package:appwrite/appwrite.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:heroicons/heroicons.dart';
import 'package:kount/screens/auth/auth_state.dart';
import 'package:kount/screens/partials/navbar.dart';
import 'package:kount/screens/partials/text_editor.dart';
import 'package:kount/screens/styles/constants.dart';
import 'package:intl/intl.dart';

class SingleCountdown extends StatefulWidget {
  const SingleCountdown({
    required this.title,
    required this.dateFormatted,
    required this.id,
    this.unsplash_url,
    this.galery_image_id,
    this.color,
    this.content,
    super.key,
  });

  final String title;
  final DateTime dateFormatted;
  final String? unsplash_url;
  final String? galery_image_id;
  final int? color;
  final String id;
  final String? content;
  @override
  State<SingleCountdown> createState() => _SingleCountdownState();
}

class _SingleCountdownState extends State<SingleCountdown> {
  var thumbnail;
  DateTime? dateFormatted;
  late Timer _timer;
  String? format;

  void initState() {
    if (widget.galery_image_id != null) {
      getThumbnail(widget.galery_image_id!);
    }
    _timer =
        Timer.periodic(const Duration(milliseconds: 500), (timer) => _update());
    getUserPrefs();
  }

  void _update() {
    setState(() {
      getDate(date: dateFormatted!, format: format);
    });
  }

  String getDate({required DateTime date, required String? format}) {
    String years = date.difference(DateTime.now().toLocal()).inDays / 365 < 1
        ? '0'
        : (date.difference(DateTime.now().toLocal()).inDays / 365)
            .round()
            .toString();

    String months = date.difference(DateTime.now().toLocal()).inDays / 12 < 1
        ? '0'
        : (date.difference(DateTime.now().toLocal()).inDays / 12)
            .round()
            .toString();

    String weeks = date.difference(DateTime.now().toLocal()).inDays / 7 < 1
        ? '0'
        : (date.difference(DateTime.now().toLocal()).inDays / 7)
            .round()
            .toString();

    String days = (date.difference(DateTime.now().toLocal()).inDays).toString();

    String hours =
        (date.difference(DateTime.now().toLocal()).inHours).toString();

    String minutes =
        (date.difference(DateTime.now().toLocal()).inMinutes).toString();

    String seconds =
        (date.difference(DateTime.now().toLocal()).inSeconds).toString();

    print(format);

    if (format == 'year') {
      return years != '1' ? 'in $years years' : 'in $years year';
    }

    if (format == 'month') {
      return months != '1' ? 'in $months months' : 'in $months month';
    }

    if (format == 'week') {
      return weeks != '1' ? 'in $weeks weeks' : 'in $weeks week';
    }

    if (format == 'day') {
      return days != '1' ? 'in $days days' : 'in $days day';
    }

    if (format == 'hour') {
      return hours != '1' ? 'in $hours hours' : 'in $hours hour';
    }

    if (format == 'minute') {
      return minutes != '1' ? 'in $minutes minutes' : 'in $minutes minute';
    }

    if (format == 'second') {
      return seconds != '1' ? 'in $seconds seconds' : 'in $seconds second';
    }

    return years != '0'
        ? years != '1'
            ? 'in $years years'
            : 'in $years year'
        : months != '0'
            ? months != '1'
                ? 'in $months months'
                : 'in $months month'
            : weeks != '0'
                ? weeks != '1'
                    ? 'in $weeks weeks'
                    : 'in $weeks week'
                : days != '0'
                    ? days != '1'
                        ? 'in $days days'
                        : 'in $days day'
                    : hours != '0'
                        ? hours != '1'
                            ? 'in $hours hours'
                            : 'in $hours hour'
                        : minutes != '0'
                            ? minutes != '1'
                                ? 'in $minutes minutes'
                                : 'in $minutes minute'
                            : seconds != '0'
                                ? seconds != '1'
                                    ? 'in $seconds seconds'
                                    : 'in $seconds second'
                                : 'now';
  }

  void getUserPrefs() {
    AuthState state = AuthState();
    Account account = state.account;

    Future response = account.getPrefs();
    response.then((result) {
      format = result.data['countdown_format'];
      setState(() {});
    }).catchError((error) {});
  }

  Future getThumbnail(String fileId) async {
    AuthState state = AuthState();
    Storage storage = state.storage;

    final result = await storage.getFilePreview(
        bucketId: '63b19dd7a3d52e427307',
        fileId: fileId,
        width: 560,
        height: 940);

    thumbnail = result;
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Stack(
        children: [
          widget.galery_image_id != null
              ? thumbnail != null
                  ? Ink.image(
                      image: MemoryImage(thumbnail!),
                      fit: BoxFit.cover,
                    )
                  : Container(
                      color: Colors.grey,
                    )
              : widget.unsplash_url != null
                  ? Ink.image(
                      image: NetworkImage(widget.unsplash_url!),
                      fit: BoxFit.cover)
                  : widget.color != null
                      ? Container(
                          color: Color(widget.color!),
                        )
                      : Container(color: Colors.grey),
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
              children: [
                Text(
                  widget.title,
                  style: kSingleCountdownTitleStyle,
                ),
                SizedBox(
                  height: kDefaultSpacer,
                ),
                Text(
                  getDate(date: widget.dateFormatted, format: format),
                  style: kSingleCountdownTimeStyle,
                ),
                SizedBox(
                  height: kDefaultSpacer / 2,
                ),
                Text(
                  DateFormat('y MMMM d')
                      .format(widget.dateFormatted)
                      .toString(),
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
                        children: [
                          HeroIcon(
                            HeroIcons.chevronUp,
                            color: Colors.black,
                            size: kBigIconSize,
                          ),
                          SizedBox(
                            height: kDefaultSpacer * 2.5,
                          ),
                          TextEditor(
                            countdown_id: widget.id,
                            contentFromDB: widget.content,
                          ),
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
