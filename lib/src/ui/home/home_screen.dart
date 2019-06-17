import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:food_recipe/src/blocs/home/home_bloc.dart';
import 'package:food_recipe/src/models/categories/categories.dart';
import 'package:food_recipe/src/models/latest/latest_meals.dart';
import 'package:food_recipe/src/ui/detailmeals/detail_meals_screen.dart';
import 'package:food_recipe/src/utils/utils.dart';
import 'package:food_recipe/values/color_assets.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void dispose() {
    homeBloc.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        _buildWidgetBackground(),
        SafeArea(
          child: ListView(
            children: <Widget>[
              Align(
                alignment: Alignment.topRight,
                child: GestureDetector(
                  onTap: () {
                    Navigator.pushNamed(context, navigatorInfoApp);
                  },
                  child: Padding(
                    padding: const EdgeInsets.only(top: 16.0, right: 16.0),
                    child: Icon(
                      Icons.info_outline,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
              _buildWidgetContent(),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildWidgetBackground() {
    return Column(
      children: <Widget>[
        Expanded(
          flex: 2,
          child: Container(
            color: ColorAssets.primarySwatchColor,
          ),
        ),
        Expanded(
          child: Container(
            color: Colors.white,
          ),
        )
      ],
    );
  }

  Widget _buildWidgetContent() {
    var mediaQuery = MediaQuery.of(context);
    return SafeArea(
      minimum: EdgeInsets.symmetric(horizontal: 16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Padding(padding: EdgeInsets.only(top: 16.0)),
          Text(
            "What are you\nCooking today ?",
            style: Theme.of(context).textTheme.display1.merge(
                  TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontFamily: "Roboto",
                  ),
                ),
          ),
          Padding(padding: EdgeInsets.only(top: 16.0)),
          _buildTextFieldSearchMeals(),
          Padding(padding: EdgeInsets.only(top: 24.0)),
          Text("Latest Recipe",
              style: Theme.of(context)
                  .textTheme
                  .title
                  .merge(TextStyle(color: Colors.white))),
          Padding(padding: EdgeInsets.only(top: 8.0)),
          _buildListViewLatestRecipe(mediaQuery),
          Padding(padding: EdgeInsets.only(top: 24.0)),
          Text("Category",
              style: Theme.of(context)
                  .textTheme
                  .title
                  .merge(TextStyle(color: ColorAssets.primaryTextColor))),
          Padding(padding: EdgeInsets.only(top: 8.0)),
          _buildListViewCategory(),
        ],
      ),
    );
  }

  Widget _buildListViewCategory() {
    return FutureBuilder(
      future: homeBloc.getCategories(),
      builder: (BuildContext context, AsyncSnapshot<Categories> snapshot) {
        if (snapshot.hasData) {
          int numberItem = 0;
          Categories categories = snapshot.data;
          return Container(
            height: 136.0,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: categories.categoryItems.length,
              itemBuilder: (context, index) {
                numberItem += 1;
                if (numberItem > 3) {
                  numberItem = 1;
                }
                var category = categories.categoryItems[index];
                return Container(
                  width: 136.0,
                  child: Padding(
                    padding: const EdgeInsets.only(right: 4.0),
                    child: GestureDetector(
                      onTap: () {
                        Navigator.pushNamed(context, navigatorListMeals,
                            arguments: category);
                      },
                      child: Card(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(16.0)),
                        color: _setColorItemCategory(numberItem),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 8.0, vertical: 12.0),
                          child: Column(
                            children: <Widget>[
                              Hero(
                                tag:
                                    "label_item_category_${category.idCategory}",
                                child: Text(
                                  category.strCategory,
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                              Padding(padding: const EdgeInsets.only(top: 8.0)),
                              Container(
                                width: 136.0,
                                height: 72.0,
                                child: FadeInImage(
                                  fit: BoxFit.cover,
                                  image: NetworkImage(
                                    category.strCategoryThumb,
                                  ),
                                  placeholder: AssetImage(
                                      "assets/images/img_placeholder.jpg"),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                );
              },
            ),
          );
        } else if (snapshot.hasError) {
          return Text(snapshot.error.toString());
        }
        return Center(child: buildCircularProgressIndicator());
      },
    );
  }

  Widget _buildListViewLatestRecipe(MediaQueryData mediaQuery) {
    return FutureBuilder(
      future: homeBloc.getLatestMeals(),
      builder: (BuildContext context, AsyncSnapshot<LatestMeals> snapshot) {
        if (snapshot.hasData) {
          var latestMeals = snapshot.data;
          return Container(
            height: mediaQuery.size.width / 2 + 64.0, // 256.0
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: latestMeals.latestMealsItems.length,
              itemBuilder: (context, index) {
                var latestMealsItem = latestMeals.latestMealsItems[index];
                return Padding(
                  padding: const EdgeInsets.only(right: 8.0),
                  child: GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) {
                            return DetailMealsScreen(
                              idMeal: latestMealsItem.idMeal,
                              strMeal: latestMealsItem.strMeal,
                              strMealThumb: latestMealsItem.strMealThumb,
                            );
                          },
                        ),
                      );
                    },
                    child: Card(
                      elevation: 4.0,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(16.0)),
                      child: ClipRRect(
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(16.0),
                          topRight: Radius.circular(16.0),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Container(
                              child: Hero(
                                tag:
                                    "image_detail_meals_${latestMealsItem.idMeal}",
                                child: FadeInImage(
                                  image: NetworkImage(
                                    latestMealsItem.strMealThumb,
                                  ),
                                  placeholder: AssetImage(
                                    "assets/images/img_placeholder.jpg",
                                  ),
                                  fit: BoxFit.cover,
                                ),
                              ),
                              width: mediaQuery.size.width - 96.0,
                              height: mediaQuery.size.width / 2, // 192.0
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(latestMealsItem.strMeal,
                                  maxLines: 2,
                                  style: Theme.of(context).textTheme.subhead),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                );
              },
            ),
          );
        } else if (snapshot.hasError) {
          return Text(snapshot.error.toString());
        }
        return Container(
          height: 128.0,
          child: Center(
            child: buildCircularProgressIndicator(),
          ),
        );
      },
    );
  }

  Widget _buildTextFieldSearchMeals() {
    return GestureDetector(
      onTap: () {
        Navigator.pushNamed(context, navigatorSearchMeals);
      },
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(36.0),
          color: Color(0x2FFFFFFF),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 12.0,
            vertical: 8.0,
          ),
          child: Row(
            children: <Widget>[
              Icon(
                Icons.search,
                color: Colors.white,
              ),
              Padding(padding: EdgeInsets.only(right: 8.0)),
              Expanded(
                child: TextField(
                  decoration: InputDecoration.collapsed(
                    hintText: "Search...",
                    hintStyle: TextStyle(
                      color: Colors.white70,
                    ),
                  ),
                  style: TextStyle(color: Colors.white),
                  maxLines: 1,
                  enabled: false,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Color _setColorItemCategory(int number) {
    if (number == 1) {
      return ColorAssets.accentColor;
    } else if (number == 2) {
      return ColorAssets.secondColorCategoryItem;
    } else {
      return ColorAssets.thirdColorCategoryItem;
    }
  }
}
