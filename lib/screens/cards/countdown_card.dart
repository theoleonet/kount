import 'dart:async';

import 'package:appwrite/appwrite.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:kount/screens/auth/auth_state.dart';
import 'package:kount/screens/single_countdown.dart';
import 'package:kount/screens/styles/constants.dart';
import 'package:intl/intl.dart';

class CountdownCard extends StatefulWidget {
  const CountdownCard(
      {required this.title,
      required this.date,
      this.unsplash_url,
      this.galery_image_id,
      this.color,
      super.key});

  final String title;
  final String date;
  final String? unsplash_url;
  final String? galery_image_id;
  final int? color;

  @override
  State<CountdownCard> createState() => _CountdownCardState();
}

class _CountdownCardState extends State<CountdownCard> {
  Uint8List? thumbnail;
  DateTime? dateFormatted;
  late Timer _timer;

  @override
  void initState() {
    if (widget.galery_image_id != null) {
      getThumbnail(widget.galery_image_id!);
    }
    dateFormatted = DateTime.parse(widget.date).toLocal();
    print(DateTime.now().toLocal());
    _timer = Timer.periodic(const Duration(minutes: 1), (timer) => _update());
  }

  void _update() {
    setState(() {
      getSmartDate(dateFormatted!);
    });
  }

  Future getThumbnail(String fileId) async {
    AuthState state = AuthState();
    Storage storage = state.storage;

    final result = await storage.getFilePreview(
        bucketId: '63b19dd7a3d52e427307',
        fileId: fileId,
        width: 320,
        height: 150);

    thumbnail = result;
    setState(() {});
  }

  String getSmartDate(DateTime date) {
    String years = date.difference(DateTime.now().toLocal()).inDays / 365 < 1
        ? '0'
        : (date.difference(DateTime.now().toLocal()).inDays / 365)
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

    return years != '0'
        ? years != '1'
            ? 'in $years years'
            : 'in $years year'
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
                        : 'now';
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => SingleCountdown(
              title: widget.title,
              dateFormatted: dateFormatted!,
              color: widget.color,
              galery_image_id: widget.galery_image_id,
              unsplash_url: widget.unsplash_url,
            ),
          ),
        );
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
                      widget.galery_image_id != null
                          ? thumbnail != null
                              ? Ink.image(
                                  image: MemoryImage(thumbnail!),
                                  fit: BoxFit.cover,
                                )
                              : Container(color: Colors.grey)
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
                        padding: const EdgeInsets.all(20),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              widget.title,
                              style: kCardTitleStyle,
                            ),
                            SizedBox(
                              height: kDefaultSpacer,
                            ),
                            Text(
                              getSmartDate(dateFormatted!),
                              style: kCardTimeStyle,
                            ),
                            SizedBox(
                              height: kDefaultSpacer / 2,
                            ),
                            Text(
                              DateFormat('y MMMM d')
                                  .format(dateFormatted!)
                                  .toString(),
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
