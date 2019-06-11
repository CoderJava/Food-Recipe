import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ListMeals extends StatefulWidget {
  @override
  _ListMealsState createState() => _ListMealsState();
}

class _ListMealsState extends State<ListMeals> {
  @override
  Widget build(BuildContext context) {
    var mediaQuery = MediaQuery.of(context);
    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        child: Stack(
          children: <Widget>[
            _buildWidgetBackgroundCircle(mediaQuery),
            _buildWidgetArrowBackMenu(),
          ],
        ),
      ),
    );
  }

  Widget _buildWidgetArrowBackMenu() {
    return SafeArea(
            minimum: EdgeInsets.symmetric(horizontal: 16.0),
            child: CircleAvatar(
              child: Platform.isIOS
                  ? Icon(Icons.arrow_back_ios, color: Colors.black)
                  : Icon(Icons.arrow_back, color: Colors.black),
              maxRadius: 24.0,
              backgroundColor: Colors.white,
            ),
          );
  }

  Widget _buildWidgetBackgroundCircle(MediaQueryData mediaQuery) {
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
}
