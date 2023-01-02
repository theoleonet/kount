import 'package:flutter/material.dart';
import 'package:photo_manager/photo_manager.dart';

const double kSmallCardHeight = 168;
const BorderRadius kBaseBorderRadius = BorderRadius.all(Radius.circular(7));
const BorderRadius kTopBorderRadius = BorderRadius.only(
  topLeft: Radius.circular(14),
  topRight: Radius.circular(14),
);

const Color kOverlayColor = Color(0x4D000000);
const TextStyle kCardTitleStyle = TextStyle(
  color: Colors.white,
  fontSize: 18,
  fontWeight: FontWeight.bold,
);
const double kDefaultSpacer = 16;
const TextStyle kCardTimeStyle = TextStyle(
  color: Colors.white,
  fontSize: 24,
  fontWeight: FontWeight.bold,
);

const TextStyle kSingleCountdownTitleStyle = TextStyle(
  color: Colors.white,
  fontSize: 24,
  fontWeight: FontWeight.bold,
);
const TextStyle kSingleCountdownTimeStyle = TextStyle(
  color: Colors.white,
  fontSize: 32,
  fontWeight: FontWeight.bold,
);

const TextStyle kSingleCountdownDateStyle = TextStyle(
  color: Colors.white,
  fontSize: 18,
);

const TextStyle kCardDateStyle = TextStyle(
  color: Colors.white,
  fontSize: 14,
);

const Color kBackgroundColor = Color(0xFFFFFFFF);
const Color kSingleCountdownIconsColor = Color(0xFFFFFFFF);

const int kBaseColorPickerColor = 0xFFEEEEEE;
const int kBaseColorPickerRed = 0xFFFF0000;
const int kBaseColorPickerOrange = 0xFFFF6F00;
const int kBaseColorPickerYellow = 0xFFFDD835;
const int kBaseColorPickerGreen = 0xFFAEEA00;
const int kBaseColorPickerBlue = 0xFF26C6DA;
const int kBaseColorPickerPurple = 0xFF7B1FA2;
const int kShownInPicker = 20;
const ThumbnailSize kImageThumbnailSize = ThumbnailSize(750, 1334);

const double kImageThumbnailHeight = 150;
const double kImageThumbnailWidth = 85;

const TextStyle kCreationFieldLabel = TextStyle(
  fontSize: 18,
  fontWeight: FontWeight.bold,
);

const InputDecoration kInputDecoration = InputDecoration(
  border: OutlineInputBorder(),
);

const TextStyle kCreationFieldSubLabel = TextStyle(
  color: Colors.black54,
);

const TextStyle kCreationFieldSmallLabel = TextStyle(
  fontSize: 18,
);

const TextStyle kCreationFieldActionButton = TextStyle(
  decoration: TextDecoration.underline,
  color: Colors.grey,
);

const TextStyle kUnderlineText = TextStyle(
  decoration: TextDecoration.underline,
  fontSize: 18,
);

const TextStyle kSelectIndicator = TextStyle(
  fontSize: 32,
);

const Color kDefaultButtonColor = Color(0xFF9E9E9E);

const TextStyle kDefaultButtonTextStyle = TextStyle(
  color: Colors.white,
  fontSize: 18,
);

const double kDefaultButtonHeight = 48;

const kNavbarGradient = LinearGradient(
  begin: Alignment.topCenter,
  end: Alignment.bottomCenter,
  colors: [
    Color(0xFF000000),
    Color(0x00000000),
  ],
);

const double kNavbarGradientHeight = 300;

const double kBaseIconSize = 24;
const double kBigIconSize = 32;

const int kHeightFromBottomForText = 208;

const TextStyle kSettingsTitle = TextStyle(
  fontSize: 18,
);

const TextStyle kSettingsOption = TextStyle(
  fontSize: 18,
  color: Colors.grey,
);

const double kSettingOptionIconSize = 16;
const Color kSettingOptionIconColor = Color(0xFF9E9E9E);

const double kColorButtonRadius = 56;

const Color kColorButtonIconColor = Color(0xFF9E9E9E);

const double kBottomNavBarHeight = 96;

const TextStyle kTopNavBarTitleStyle = TextStyle(
  fontSize: 18,
  color: Colors.black,
);

const IconThemeData kTopNavBarIconsStyle = IconThemeData(color: Colors.black);

const Color kRadioButtonActiveColor = Color(0xFF000000);

const TextStyle kCreationFieldError = TextStyle(color: Colors.red);

const TextStyle kEditProfileTitleStyle = TextStyle(
  fontSize: 20,
  fontWeight: FontWeight.bold,
);

const TextStyle kSuccessText = TextStyle(
  fontSize: 18,
  color: Colors.green,
);
