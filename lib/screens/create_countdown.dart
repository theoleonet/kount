import 'dart:convert';
import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:heroicons/heroicons.dart';
import 'package:image_picker/image_picker.dart';
import 'package:kount/screens/partials/button.dart';
import 'package:kount/screens/partials/color_button.dart';
import 'package:intl/intl.dart';
import 'package:kount/screens/partials/top_navbar.dart';
import 'package:kount/screens/styles/constants.dart';
import 'package:photo_manager/photo_manager.dart';
import 'package:http/http.dart' as http;

class CreateCountdown extends StatefulWidget {
  const CreateCountdown({super.key});

  @override
  State<CreateCountdown> createState() => _CreateCountdownState();
}

class _CreateCountdownState extends State<CreateCountdown> {
  File? image;
  DateTime eventTime = DateTime.now();

  List<Widget> _mediaFromLibraryList = [];
  List<Widget> _mediaFromUnsplashList = [];
  int currentPage = 0;
  int? lastPage;
  bool photoAdded = false;
  String backgroundType = 'color';

  Color color = kBaseColorPickerColor;
  late List<Color?> colors;

  void initState() {
    colors = [
      null,
      kBaseColorPickerRed,
      kBaseColorPickerOrange,
      kBaseColorPickerYellow,
      kBaseColorPickerGreen,
      kBaseColorPickerBlue,
      kBaseColorPickerPurple,
      color,
    ];

    getImages();
    getMediasFromUnsplash();
  }

  List<HeroIcons?> icons = [
    HeroIcons.noSymbol,
    null,
    null,
    null,
    null,
    null,
    null,
    HeroIcons.swatch,
  ];

  int selectedIndex = 0;

  void pickColor(BuildContext context) => showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: Text('Pick your color'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              buildColorPicker(),
              TextButton(
                child: Text(
                  'Select',
                ),
                onPressed: () => Navigator.of(context).pop(),
              ),
            ],
          ),
        ),
      );

  Widget buildColorPicker() => ColorPicker(
        pickerColor: color,
        onColorChanged: (color) => setState(() => this.color = color),
      );

//Get images from the gallery
  getImages() async {
    lastPage = currentPage;
    final PermissionState ps = await PhotoManager.requestPermissionExtend();
    if (ps.isAuth) {
      List<AssetPathEntity> albums =
          await PhotoManager.getAssetPathList(onlyAll: true);
      List<AssetEntity> media = await albums[0]
          .getAssetListPaged(page: currentPage, size: kShownInPicker);
      List<Widget> temp = [];
      for (var asset in media) {
        temp.add(
          FutureBuilder(
            future: asset.thumbnailDataWithSize(
              kImageThumbnailSize,
            ),
            builder:
                (BuildContext context, AsyncSnapshot<Uint8List?> snapshot) {
              if (asset.type == AssetType.video) {
                return Container();
              }
              if (snapshot.connectionState == ConnectionState.done) {
                return Stack(
                  children: <Widget>[
                    Positioned.fill(
                      child: ClipRRect(
                        borderRadius: kBaseBorderRadius,
                        child: Image.memory(
                          snapshot.data!,
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                  ],
                );
              }
              return Container();
            },
          ),
        );
      }
      setState(
        () {
          _mediaFromLibraryList.addAll(temp);
          currentPage++;
        },
      );
    } else {
      // Limited(iOS) or Rejected, use `==` for more precise judgements.
      // You can call `PhotoManager.openSetting()` to open settings for further steps.
      PhotoManager.openSetting();
    }
  }

  Future pickImage() async {
    try {
      final image = await ImagePicker().pickImage(source: ImageSource.gallery);

      if (image == null) return;

      final imageTemp = File(image.path);
      setState(() {
        this.image = imageTemp;
        if (!photoAdded) {
          _mediaFromLibraryList.insert(1, _mediaFromLibraryList[0]);
        }
        photoAdded = true;
        _mediaFromLibraryList[0] = Container(
          height: kImageThumbnailHeight,
          width: kImageThumbnailWidth,
          child: Stack(
            children: <Widget>[
              Positioned.fill(
                child: ClipRRect(
                  borderRadius: kBaseBorderRadius,
                  child: Image.file(
                    this.image!,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ],
          ),
        );
      });
    } on PlatformException catch (e) {
      print('Failed to pick image: $e');
    }
  }

  void getMediasFromUnsplash() {
    http
        .get(Uri.parse(
            'https://api.unsplash.com/photos?page=1&client_id=qntmzZFZTf3Fra9t1_lRknHgWfwQB7GYi7doy7xhqVo'))
        .then((response) {
      if (response.statusCode == 200) {
        dynamic datas = jsonDecode(response.body);
        for (dynamic data in datas) {
          try {
            setState(() {
              Stack media = Stack(
                children: <Widget>[
                  Positioned.fill(
                    child: ClipRRect(
                      borderRadius: kBaseBorderRadius,
                      child: Image.network(
                        data['urls']['regular'],
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                ],
              );

              _mediaFromUnsplashList.add(media);
            });
          } catch (error) {
            print(error.toString());
          }
        }
      } else {
        debugPrint('Oups... mauvaise réponse');
      }
    }).onError((error, stackTrace) {
      debugPrintStack(stackTrace: stackTrace);
    });
  }

  Future searchImage() async {}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: TopNavBar(
        title: 'Create a new countdown',
      ),
      backgroundColor: kBackgroundColor,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(24),
            child: Column(
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Title of the countdown',
                      style: kCreationFieldLabel,
                    ),
                    SizedBox(
                      height: kDefaultSpacer / 2,
                    ),
                    Text(
                      'Ex: Dinner at the chineese restautant with family',
                      style: kCreationFieldSubLabel,
                    ),
                    SizedBox(
                      height: kDefaultSpacer,
                    ),
                    TextField(
                      decoration: kInputDecoration,
                    ),
                  ],
                ),
                SizedBox(
                  height: kDefaultSpacer * 4,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Date of the event',
                      style: kCreationFieldLabel,
                    ),
                    SizedBox(
                      height: kDefaultSpacer / 2,
                    ),
                    Text(
                      DateFormat('y MMMM d').format(eventTime).toString(),
                      style: kCreationFieldSubLabel,
                    ),
                    SizedBox(
                      height: 24,
                    ),
                    Container(
                      height: 125,
                      child: CupertinoDatePicker(
                        initialDateTime: DateTime.now(),
                        mode: CupertinoDatePickerMode.date,
                        onDateTimeChanged: (DateTime newdate) {
                          setState(() {
                            eventTime = newdate;
                          });
                        },
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: kDefaultSpacer * 4,
                ),
                Container(
                  width: MediaQuery.of(context).size.width,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        'Choose a background',
                        style: kCreationFieldLabel,
                      ),
                      SizedBox(
                        height: kDefaultSpacer * 1.5,
                      ),
                      SizedBox(
                        height: kDefaultSpacer * 6,
                        child: ListView.builder(
                            physics: ClampingScrollPhysics(),
                            shrinkWrap: true,
                            scrollDirection: Axis.horizontal,
                            itemCount: colors.length,
                            itemBuilder: (BuildContext context, int index) {
                              return Row(
                                children: [
                                  Column(
                                    children: [
                                      GestureDetector(
                                        onTap: () {
                                          setState(() {
                                            selectedIndex = index;
                                            backgroundType = 'color';
                                          });
                                          if (selectedIndex ==
                                                  colors.length - 1 &&
                                              backgroundType == 'color') {
                                            pickColor(context);
                                          }
                                        },
                                        child: ColorButton(
                                          color: index == colors.length - 1
                                              ? color
                                              : colors[index],
                                          icon: icons[index],
                                        ),
                                      ),
                                      Text(
                                        selectedIndex == index &&
                                                backgroundType == 'color'
                                            ? '•'
                                            : '',
                                        style: kSelectIndicator,
                                      ),
                                    ],
                                  ),
                                  SizedBox(
                                    width: kDefaultSpacer * 1.5,
                                  ),
                                ],
                              );
                            }),
                      ),
                      SizedBox(
                        height: kDefaultSpacer * 3,
                      ),
                      Row(
                        children: [
                          Text(
                            'Photo library',
                            style: kCreationFieldSmallLabel,
                          ),
                          Spacer(),
                          GestureDetector(
                            onTap: () {
                              pickImage();
                              selectedIndex = 0;
                              backgroundType = 'galeryImage';
                            },
                            child: Text(
                              'View all',
                              style: kCreationFieldActionButton,
                            ),
                          )
                        ],
                      ),
                      SizedBox(
                        height: kDefaultSpacer,
                      ),
                      Container(
                        height: kImageThumbnailHeight * 1.3,
                        child: ListView.builder(
                            shrinkWrap: true,
                            scrollDirection: Axis.horizontal,
                            itemCount: _mediaFromLibraryList.length,
                            itemBuilder: (BuildContext context, int index) {
                              return Row(
                                children: [
                                  Column(
                                    children: [
                                      GestureDetector(
                                        onTap: () {
                                          setState(() {
                                            selectedIndex = index;
                                            backgroundType = 'galeryImage';
                                          });
                                        },
                                        child: Container(
                                          height: kImageThumbnailHeight,
                                          width: kImageThumbnailWidth,
                                          decoration: BoxDecoration(
                                              borderRadius:
                                                  kBaseBorderRadius * 1.3),
                                          child: _mediaFromLibraryList[index],
                                        ),
                                      ),
                                      Text(
                                        selectedIndex == index &&
                                                backgroundType == 'galeryImage'
                                            ? '•'
                                            : '',
                                        style: kSelectIndicator,
                                      ),
                                    ],
                                  ),
                                  SizedBox(
                                    width: kDefaultSpacer,
                                  ),
                                ],
                              );
                            }),
                      ),
                      SizedBox(
                        height: kDefaultSpacer * 3,
                      ),
                      Row(children: [
                        Text(
                          'Unsplash',
                          style: kCreationFieldSmallLabel,
                        ),
                        Spacer(),
                        GestureDetector(
                          onTap: () => searchImage(),
                          child: Text(
                            'Search',
                            style: kCreationFieldActionButton,
                          ),
                        )
                      ]),
                      SizedBox(
                        height: kDefaultSpacer,
                      ),
                      Container(
                        height: kImageThumbnailHeight * 1.3,
                        child: ListView.builder(
                          shrinkWrap: true,
                          scrollDirection: Axis.horizontal,
                          itemCount: _mediaFromLibraryList.length,
                          itemBuilder: (BuildContext context, int index) {
                            return Row(
                              children: [
                                Column(
                                  children: [
                                    GestureDetector(
                                      onTap: () {
                                        setState(() {
                                          selectedIndex = index;
                                          backgroundType = 'unsplashImage';
                                        });
                                      },
                                      child: Container(
                                        height: kImageThumbnailHeight,
                                        width: kImageThumbnailWidth,
                                        decoration: BoxDecoration(
                                          borderRadius: kBaseBorderRadius,
                                        ),
                                        child: _mediaFromUnsplashList[index],
                                      ),
                                    ),
                                    Text(
                                      selectedIndex == index &&
                                              backgroundType == 'unsplashImage'
                                          ? '•'
                                          : '',
                                      style: kSelectIndicator,
                                    ),
                                  ],
                                ),
                                SizedBox(
                                  width: kDefaultSpacer,
                                ),
                              ],
                            );
                          },
                        ),
                      ),
                      SizedBox(
                        height: kDefaultSpacer * 2,
                      ),
                      Button(text: 'Create countdown'),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
