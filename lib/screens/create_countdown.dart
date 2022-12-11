import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:heroicons/heroicons.dart';
import 'package:image_picker/image_picker.dart';
import 'package:kount/screens/partials/color_button.dart';
import 'package:kount/screens/partials/navbar.dart';
import 'package:intl/intl.dart';
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

  Color color = Color(0xFFEEEEEE);
  late List<Color?> colors;

  void initState() {
    colors = [
      null,
      Color(0xFFFF0000),
      Color(0xFFFF6F00),
      Color(0xFFFDD835),
      Color(0xFFAEEA00),
      Color(0xFF26C6DA),
      Color(0xFF7B1FA2),
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
    final PermissionState _ps = await PhotoManager.requestPermissionExtend();
    if (_ps.isAuth) {
      List<AssetPathEntity> albums =
          await PhotoManager.getAssetPathList(onlyAll: true);
      print(albums);
      List<AssetEntity> media =
          await albums[0].getAssetListPaged(page: currentPage, size: 20);
      print(media);
      List<Widget> temp = [];
      for (var asset in media) {
        temp.add(
          FutureBuilder(
            future: asset.thumbnailDataWithSize(
              ThumbnailSize(750, 1334),
            ),
            builder:
                (BuildContext context, AsyncSnapshot<Uint8List?> snapshot) {
              if (asset.type == AssetType.video) {
                return Container();
              }
              if (snapshot.connectionState == ConnectionState.done)
                return Stack(
                  children: <Widget>[
                    Positioned.fill(
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(7),
                        child: Image.memory(
                          snapshot.data!,
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                  ],
                );
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
        if (!photoAdded)
          _mediaFromLibraryList.insert(1, _mediaFromLibraryList[0]);
        photoAdded = true;
        _mediaFromLibraryList[0] = Container(
          height: 150,
          width: 85,
          child: Stack(
            children: <Widget>[
              Positioned.fill(
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(7),
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
                      borderRadius: BorderRadius.circular(7),
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
      appBar: AppBar(
        title: Text(
          'Create countdown',
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
      backgroundColor: Colors.white,
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
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(
                      height: 8,
                    ),
                    TextField(
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 64,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Date of the event',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(
                      height: 8,
                    ),
                    Text(
                      DateFormat('y MMMM d').format(eventTime).toString(),
                      style: TextStyle(
                        color: Colors.black54,
                      ),
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
                  height: 64,
                ),
                Container(
                  width: MediaQuery.of(context).size.width,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        'Choose a background',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(
                        height: 24,
                      ),
                      SizedBox(
                        height: 56,
                        child: ListView.builder(
                            physics: ClampingScrollPhysics(),
                            shrinkWrap: true,
                            scrollDirection: Axis.horizontal,
                            itemCount: colors.length,
                            itemBuilder: (BuildContext context, int index) {
                              return Row(
                                children: [
                                  GestureDetector(
                                    onTap: () {
                                      setState(() {
                                        selectedIndex = index;
                                        backgroundType = 'color';
                                      });
                                      if (selectedIndex == colors.length - 1 &&
                                          backgroundType == 'color') {
                                        pickColor(context);
                                      }
                                    },
                                    child: ColorButton(
                                      color: index == 7 ? color : colors[index],
                                      icon: icons[index],
                                      border: index == selectedIndex &&
                                              backgroundType == 'color'
                                          ? true
                                          : false,
                                    ),
                                  ),
                                  SizedBox(
                                    width: 24,
                                  ),
                                ],
                              );
                            }),
                      ),
                      SizedBox(
                        height: 64,
                      ),
                      Row(children: [
                        Text(
                          'Photo library',
                          style: TextStyle(
                            fontSize: 18,
                          ),
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
                            style: TextStyle(
                                decoration: TextDecoration.underline,
                                color: Colors.grey),
                          ),
                        )
                      ]),
                      SizedBox(
                        height: 16,
                      ),
                      Container(
                        height: 150,
                        child: ListView.builder(
                            shrinkWrap: true,
                            scrollDirection: Axis.horizontal,
                            itemCount: _mediaFromLibraryList.length,
                            itemBuilder: (BuildContext context, int index) {
                              return Row(
                                children: [
                                  GestureDetector(
                                    onTap: () {
                                      setState(() {
                                        selectedIndex = index;
                                        backgroundType = 'galeryImage';
                                      });
                                    },
                                    child: Container(
                                      height: 150,
                                      width: 85,
                                      decoration: BoxDecoration(
                                          border: selectedIndex == index &&
                                                  backgroundType ==
                                                      'galeryImage'
                                              ? Border.all(color: Colors.black)
                                              : null,
                                          borderRadius:
                                              BorderRadius.circular(7)),
                                      child: _mediaFromLibraryList[index],
                                    ),
                                  ),
                                  SizedBox(
                                    width: 16,
                                  ),
                                ],
                              );
                            }),
                      ),
                      SizedBox(
                        height: 64,
                      ),
                      Row(children: [
                        Text(
                          'Unsplash',
                          style: TextStyle(
                            fontSize: 18,
                          ),
                        ),
                        Spacer(),
                        GestureDetector(
                          onTap: () => searchImage(),
                          child: Text(
                            'Search',
                            style: TextStyle(
                                decoration: TextDecoration.underline,
                                color: Colors.grey),
                          ),
                        )
                      ]),
                      SizedBox(
                        height: 16,
                      ),
                      Container(
                        height: 150,
                        child: ListView.builder(
                          shrinkWrap: true,
                          scrollDirection: Axis.horizontal,
                          itemCount: _mediaFromLibraryList.length,
                          itemBuilder: (BuildContext context, int index) {
                            return Row(
                              children: [
                                GestureDetector(
                                  onTap: () {
                                    setState(() {
                                      selectedIndex = index;
                                      backgroundType = 'unsplashImage';
                                    });
                                  },
                                  child: Container(
                                    height: 150,
                                    width: 85,
                                    decoration: BoxDecoration(
                                      border: selectedIndex == index &&
                                              backgroundType == 'unsplashImage'
                                          ? Border.all(color: Colors.black)
                                          : null,
                                      borderRadius: BorderRadius.circular(7),
                                    ),
                                    child: _mediaFromUnsplashList[index],
                                  ),
                                ),
                                SizedBox(
                                  width: 16,
                                ),
                              ],
                            );
                          },
                        ),
                      ),
                      SizedBox(
                        height: 64,
                      ),
                      Container(
                        height: 48,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(7),
                          color: Colors.grey,
                        ),
                        alignment: Alignment.center,
                        child: Text(
                          'Create Countdown',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 18,
                          ),
                        ),
                      ),
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
