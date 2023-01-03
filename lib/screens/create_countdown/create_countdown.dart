import 'dart:convert';
import 'dart:io';
import 'dart:math';
import 'package:appwrite/appwrite.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:heroicons/heroicons.dart';
import 'package:image_picker/image_picker.dart';
import 'package:kount/screens/auth/auth_state.dart';
import 'package:kount/screens/partials/button.dart';
import 'package:kount/screens/partials/color_button.dart';
import 'package:intl/intl.dart';
import 'package:kount/screens/partials/custom_text_field.dart';
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
  String? title;
  dynamic background = kBaseColorPickerColor;

  List<Widget> _mediaFromLibraryList = [];
  List<Widget> _mediaFromUnsplashList = [];
  List<String> _libraryPicturesPath = [];
  List<String> _unsplashPicturesUrl = [];
  int currentPage = 0;
  int? lastPage;
  bool photoAdded = false;
  String backgroundType = 'color';

  int color = kBaseColorPickerColor;
  late List<int?> colors;

  void initState() {
    colors = [
      kBaseColorPickerColor,
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
        pickerColor: Color(color),
        onColorChanged: (color) => setState(() {
          this.color = color.value;
          background = color.value;
        }),
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
        // print(asset.file);
        var result = await asset.originFile.then((response) {
          _libraryPicturesPath.add(response!.path.toString());
        });

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
                // print(_libraryPicturesData);
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
        _libraryPicturesPath.insert(0, image.path);
        background = _libraryPicturesPath[0];
        backgroundType = 'galeryImage';

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
              _unsplashPicturesUrl.add(data['urls']['regular']);
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

  String getRandomString(int length) {
    const characters = 'AaBbCcDdEeFfGgHhIiJjKkLlMmNnOoPpQqRrSsTtUuVvWwXxYyZz';
    Random random = Random();
    return String.fromCharCodes(Iterable.generate(length,
        (_) => characters.codeUnitAt(random.nextInt(characters.length))));
  }

  Future createCountdown({String? galleryImageId}) async {
    AuthState state = AuthState();
    Databases databases = state.databases;
    Account account = state.account;

    Map<dynamic, dynamic> data;

    Future result = account.get();
    result.then((response) {
      var user_id = response.$id;
      data = {
        'title': title,
        'date': eventTime.toIso8601String(),
        'user_id': user_id,
        'unsplash_url': backgroundType == 'unsplashImage' ? background : null,
        'color': backgroundType == 'color' ? background : null,
        'galery_image_id':
            backgroundType == 'galeryImage' ? galleryImageId : null,
      };

      Future result = databases.createDocument(
        databaseId: '63af4631caad4e759e6e',
        collectionId: '63af48604cb294dfe0b2',
        documentId: ID.unique(),
        data: data,
      );

      result.then((response) {}).catchError((error) {
        print(error);
      }).catchError((error) {
        print(error);
      });
    });
  }

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
                CustomTextField(
                  onChanged: (value) {
                    title = value;
                  },
                  label: 'Title of the countdown',
                  help: 'Ex: Dinner at the chineese restaurant with family',
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
                                            print(index);
                                            selectedIndex = index;
                                            backgroundType = 'color';
                                            index == colors.length - 1
                                                ? background = color
                                                : background = colors[index]!;
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
                                            background =
                                                _libraryPicturesPath[index];
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
                                          background =
                                              _unsplashPicturesUrl[index];
                                          print(background);
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
                      Button(
                          onTap: () {
                            if (backgroundType == 'galeryImage') {
                              AuthState state = AuthState();
                              Storage storage = state.storage;

                              Future result = storage.createFile(
                                bucketId: '63b19dd7a3d52e427307',
                                fileId: ID.unique(),
                                file: InputFile(
                                    path: background,
                                    filename: getRandomString(56) + '.jpg'),
                              );

                              result.then((response) {
                                createCountdown(galleryImageId: response.$id);
                              });
                            } else {
                              createCountdown();
                            }
                          },
                          text: 'Create countdown'),
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
