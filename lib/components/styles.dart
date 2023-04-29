// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:sessions/constants.dart';

const TextStyle titleTextStyle = TextStyle(
  fontSize: 20,
  fontWeight: FontWeight.bold,
);

TextStyle titleBlueFontStyle() {
  return TextStyle(
    fontSize: 20,
    fontWeight: FontWeight.bold,
    color: kPrimaryDarkColor,
  );
}

const TextStyle sideMenuTileStyle = TextStyle(
  fontWeight: FontWeight.bold,
  color: Colors.white,
);

const TextStyle blogTitleStyle = TextStyle(
  fontWeight: FontWeight.bold,
  fontSize: 18,
  color: Colors.black,
);

const TextStyle blogSubtitleStyle = TextStyle(
  fontWeight: FontWeight.w200,
  fontSize: 13,
  color: Colors.black,
);

TextStyle popUpMenuItemStyle() {
  return TextStyle(
    color: kPrimaryColor,
    fontWeight: FontWeight.bold,
  );
}
