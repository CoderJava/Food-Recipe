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
      body: Stack(
        children: <Widget>[
          _buildWidgetBackgroundCircle(mediaQuery),
        ],
      ),
    );
  }

  Positioned _buildWidgetBackgroundCircle(MediaQueryData mediaQuery) {
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
