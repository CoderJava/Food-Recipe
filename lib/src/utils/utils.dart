import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

const navigatorListMeals = "/list_meals";
const navigatorSearchMeals = "/search_meals";
const navigatorInfoApp = "/info_app";

Widget buildCircularProgressIndicator() {
  if (Platform.isIOS) {
    return CupertinoActivityIndicator();
  } else {
    return CircularProgressIndicator();
  }
}

Widget buildWidgetBackgroundCircle(MediaQueryData mediaQuery) {
  return Positioned(
    top: -100.0,
    left: -100.0,
    child: Container(
      width: mediaQuery.size.height / 2.2,
      height: mediaQuery.size.height / 2.2,
      decoration: BoxDecoration(
        color: Color(0x3FE8364B),
        shape: BoxShape.circle,
      ),
    ),
  );
}
