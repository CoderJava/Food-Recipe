import 'package:flutter/material.dart';
import 'package:food_recipe/src/ui/listmeals/list_meals_screen.dart';
import 'package:food_recipe/values/color_assets.dart';

import 'ui/favorite/favorite_screen.dart';
import 'ui/home/home_screen.dart';
import 'utils/utils.dart';

class App extends StatefulWidget {
  @override
  _AppState createState() => _AppState();
}

class _AppState extends State<App> {
  int _indexTabSelected = 0;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      routes: {
        navigatorListMeals: (context) {
          return ListMealsScreen();
        },
      },
      theme: ThemeData(
        primaryColor: ColorAssets.primarySwatchColor,
        accentColor: ColorAssets.accentColor,
      ),
      home: Scaffold(
        body: _buildBodyWidget(),
        bottomNavigationBar: BottomNavigationBar(
          currentIndex: _indexTabSelected,
          items: [
            BottomNavigationBarItem(
              title: Text("Home"),
              icon: Icon(Icons.home),
            ),
            BottomNavigationBarItem(
              title: Text("Favorite"),
              icon: Icon(Icons.star),
            ),
          ],
          onTap: (indexTab) {
            setState(() => _indexTabSelected = indexTab);
          },
        ),
      ),
    );
  }

  Widget _buildBodyWidget() {
    if (_indexTabSelected == 0) {
      return HomeScreen();
    } else {
      return FavoriteScreen();
    }
  }
}
