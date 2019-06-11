import 'dart:io' show Platform;

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

const navigatorListMeals = "/list_meals";

Widget buildCircularProgressIndicator() {
  if (Platform.isIOS) {
    return CupertinoActivityIndicator();
  } else {
    return CircularProgressIndicator();
  }
}
