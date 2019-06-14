import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:food_recipe/src/blocs/detailmeals/detail_meals_bloc.dart';
import 'package:food_recipe/src/database/entity/favorite_meal.dart';
import 'package:food_recipe/src/models/lookupmealsbyid/lookup_meals_by_id.dart';
import 'package:food_recipe/src/utils/utils.dart';
import 'package:url_launcher/url_launcher.dart';

class DetailMealsScreen extends StatefulWidget {
  final String idMeal;
  final String strMeal;
  final String strMealThumb;
  final FavoriteMeal favoriteMeal;

  DetailMealsScreen(
      {this.idMeal, this.strMeal, this.strMealThumb, this.favoriteMeal});

  @override
  _DetailMealsScreenState createState() => _DetailMealsScreenState();
}

class _DetailMealsScreenState extends State<DetailMealsScreen> {
  @override
  Widget build(BuildContext context) {
    var mediaQuery = MediaQuery.of(context);
    return Scaffold(
      body: Container(
        child: Stack(
          children: <Widget>[
            _buildWidgetImageHeader(mediaQuery),
            SafeArea(
              child: Padding(
                padding: const EdgeInsets.only(left: 16.0, top: 16.0),
                child: GestureDetector(
                  onTap: () {
                    Navigator.pop(context);
                  },
                  child: CircleAvatar(
                    child: Icon(Icons.arrow_back, color: Colors.black87),
                    backgroundColor: Colors.white,
                  ),
                ),
              ),
            ),
            _buildWidgetDetailMeal(mediaQuery, context),
          ],
        ),
      ),
    );
  }

  Widget _buildWidgetDetailMeal(
      MediaQueryData mediaQuery, BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: mediaQuery.size.height / 2.5),
      child: ClipRRect(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(28.0),
          topRight: Radius.circular(28.0),
        ),
        child: Container(
          width: double.infinity,
          color: Colors.white,
          child: SafeArea(
            left: false,
            top: false,
            right: false,
            child: ListView(
              padding: EdgeInsets.only(
                left: 16.0,
                top: 16.0,
                right: 16.0,
              ),
              children: <Widget>[
                _buildTitleMeal(context),
                _buildWidgetDataDetailMeal(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildWidgetDataDetailMeal() {
    if (widget.favoriteMeal == null) {
      return FutureBuilder(
        future: detailsMealsBloc.getDetailsMealsById(widget.idMeal),
        builder:
            (BuildContext context, AsyncSnapshot<LookupMealsById> snapshot) {
          if (snapshot.hasData) {
            LookupMealsById lookupMealsById = snapshot.data;
            var detailMeals = lookupMealsById.lookupMealsbyIdItems[0];
            return _buildWidgetBottomSheet(
                detailMeals: detailMeals, context: context);
          } else if (snapshot.hasError) {
            return Text(snapshot.error.toString());
          }
          return Padding(
            padding: const EdgeInsets.only(top: 16.0),
            child: Center(child: buildCircularProgressIndicator()),
          );
        },
      );
    } else {
      return _buildWidgetBottomSheet(context: context);
    }
  }

  Widget _buildWidgetBottomSheet(
      {LookupMealsByIdItem detailMeals, BuildContext context}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        _buildTagMeal(detailMeals?.strTags ?? widget.favoriteMeal?.strTags ?? null),
        Padding(padding: EdgeInsets.only(top: 24.0)),
        _buildWidgetPanelInfoGeneralMeal(detailMeals),
        Padding(padding: EdgeInsets.only(top: 24.0)),
        Text(
          "Ingredients",
          style: Theme.of(context).textTheme.title,
        ),
        _buildWidgetInfoIngredients(detailMeals),
        Padding(padding: EdgeInsets.only(top: 24.0)),
        Text(
          "Instructions",
          style: Theme.of(context).textTheme.title,
        ),
        _buildWidgetInfoInstructions(
          detailMeals?.strInstructions ?? widget.favoriteMeal?.strInstructions ?? "",
        ),
      ],
    );
  }

  Widget _buildWidgetInfoInstructions(String strInstructions) {
    return Padding(
      padding: EdgeInsets.only(left: 8.0, top: 8.0, right: 8.0, bottom: 16.0),
      child: Text(strInstructions.isEmpty ? "N/A" : strInstructions),
    );
  }

  Widget _buildWidgetInfoIngredients(LookupMealsByIdItem detailMeals) {
    List<String> ingredientsTemp = [];
    if (detailMeals == null) {
      ingredientsTemp
        ..add((widget.favoriteMeal.strMeasure1 ?? "") +
            " " +
            (widget.favoriteMeal.strIngredient1 ?? ""))
        ..add((widget.favoriteMeal.strMeasure2 ?? "") +
            " " +
            (widget.favoriteMeal.strIngredient2 ?? ""))
        ..add((widget.favoriteMeal.strMeasure3 ?? "") +
            " " +
            (widget.favoriteMeal.strIngredient3 ?? ""))
        ..add((widget.favoriteMeal.strMeasure4 ?? "") +
            " " +
            (widget.favoriteMeal.strIngredient4 ?? ""))
        ..add((widget.favoriteMeal.strMeasure5 ?? "") +
            " " +
            (widget.favoriteMeal.strIngredient5 ?? ""))
        ..add((widget.favoriteMeal.strMeasure6 ?? "") +
            " " +
            (widget.favoriteMeal.strIngredient6 ?? ""))
        ..add((widget.favoriteMeal.strMeasure7 ?? "") +
            " " +
            (widget.favoriteMeal.strIngredient7 ?? ""))
        ..add((widget.favoriteMeal.strMeasure8 ?? "") +
            " " +
            (widget.favoriteMeal.strIngredient8 ?? ""))
        ..add((widget.favoriteMeal.strMeasure9 ?? "") +
            " " +
            (widget.favoriteMeal.strIngredient9 ?? ""))
        ..add((widget.favoriteMeal.strMeasure10 ?? "") +
            " " +
            (widget.favoriteMeal.strIngredient10 ?? ""))
        ..add((widget.favoriteMeal.strMeasure11 ?? "") +
            " " +
            (widget.favoriteMeal.strIngredient11 ?? ""))
        ..add((widget.favoriteMeal.strMeasure12 ?? "") +
            " " +
            (widget.favoriteMeal.strIngredient12 ?? ""))
        ..add((widget.favoriteMeal.strMeasure13 ?? "") +
            " " +
            (widget.favoriteMeal.strIngredient13 ?? ""))
        ..add((widget.favoriteMeal.strMeasure14 ?? "") +
            " " +
            (widget.favoriteMeal.strIngredient14 ?? ""))
        ..add((widget.favoriteMeal.strMeasure15 ?? "") +
            " " +
            (widget.favoriteMeal.strIngredient15 ?? ""))
        ..add((widget.favoriteMeal.strMeasure16 ?? "") +
            " " +
            (widget.favoriteMeal.strIngredient16 ?? ""))
        ..add((widget.favoriteMeal.strMeasure17 ?? "") +
            " " +
            (widget.favoriteMeal.strIngredient17 ?? ""))
        ..add((widget.favoriteMeal.strMeasure18 ?? "") +
            " " +
            (widget.favoriteMeal.strIngredient18 ?? ""))
        ..add((widget.favoriteMeal.strMeasure19 ?? "") +
            " " +
            (widget.favoriteMeal.strIngredient19 ?? ""))
        ..add((widget.favoriteMeal.strMeasure20 ?? "") +
            " " +
            (widget.favoriteMeal.strIngredient20 ?? ""));
    } else {
      ingredientsTemp
        ..add((detailMeals.strMeasure1 ?? "") +
            " " +
            (detailMeals.strIngredient1 ?? ""))
        ..add((detailMeals.strMeasure2 ?? "") +
            " " +
            (detailMeals.strIngredient2 ?? ""))
        ..add((detailMeals.strMeasure3 ?? "") +
            " " +
            (detailMeals.strIngredient3 ?? ""))
        ..add((detailMeals.strMeasure4 ?? "") +
            " " +
            (detailMeals.strIngredient4 ?? ""))
        ..add((detailMeals.strMeasure5 ?? "") +
            " " +
            (detailMeals.strIngredient5 ?? ""))
        ..add((detailMeals.strMeasure6 ?? "") +
            " " +
            (detailMeals.strIngredient6 ?? ""))
        ..add((detailMeals.strMeasure7 ?? "") +
            " " +
            (detailMeals.strIngredient7 ?? ""))
        ..add((detailMeals.strMeasure8 ?? "") +
            " " +
            (detailMeals.strIngredient8 ?? ""))
        ..add((detailMeals.strMeasure9 ?? "") +
            " " +
            (detailMeals.strIngredient9 ?? ""))
        ..add((detailMeals.strMeasure10 ?? "") +
            " " +
            (detailMeals.strIngredient10 ?? ""))
        ..add((detailMeals.strMeasure11 ?? "") +
            " " +
            (detailMeals.strIngredient11 ?? ""))
        ..add((detailMeals.strMeasure12 ?? "") +
            " " +
            (detailMeals.strIngredient12 ?? ""))
        ..add((detailMeals.strMeasure13 ?? "") +
            " " +
            (detailMeals.strIngredient13 ?? ""))
        ..add((detailMeals.strMeasure14 ?? "") +
            " " +
            (detailMeals.strIngredient14 ?? ""))
        ..add((detailMeals.strMeasure15 ?? "") +
            " " +
            (detailMeals.strIngredient15 ?? ""))
        ..add((detailMeals.strMeasure16 ?? "") +
            " " +
            (detailMeals.strIngredient16 ?? ""))
        ..add((detailMeals.strMeasure17 ?? "") +
            " " +
            (detailMeals.strIngredient17 ?? ""))
        ..add((detailMeals.strMeasure18 ?? "") +
            " " +
            (detailMeals.strIngredient18 ?? ""))
        ..add((detailMeals.strMeasure19 ?? "") +
            " " +
            (detailMeals.strIngredient19 ?? ""))
        ..add((detailMeals.strMeasure20 ?? "") +
            " " +
            (detailMeals.strIngredient20 ?? ""));
    }
    List<String> ingredients = [];
    for (String ingredientItem in ingredientsTemp) {
      if (ingredientItem.trim().isEmpty) {
        break;
      }
      ingredients.add(ingredientItem);
    }
    return Padding(
      padding: EdgeInsets.only(left: 8.0, top: 8.0, right: 8.0),
      child: ListView.builder(
        padding: EdgeInsets.all(0.0),
        shrinkWrap: true,
        physics: NeverScrollableScrollPhysics(),
        itemCount: ingredients.length,
        itemBuilder: (context, index) {
          return Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.only(top: 5.0),
                child: Container(
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.black54,
                  ),
                  width: 6.0,
                  height: 6.0,
                ),
              ),
              Padding(padding: EdgeInsets.only(right: 16.0)),
              Expanded(
                child: Text(ingredients[index]),
              ),
            ],
          );
        },
      ),
    );
  }

  Widget _buildWidgetPanelInfoGeneralMeal(LookupMealsByIdItem detailMeals) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: <Widget>[
        _buildWidgetInfoPlayVideo(
            detailMeals?.strYoutube ?? widget.favoriteMeal?.strYoutube ?? ""),
        Padding(padding: EdgeInsets.only(left: 8.0)),
        _buildVerticalDivider(),
        Padding(padding: EdgeInsets.only(left: 8.0)),
        _buildWidgetInfoCategoryMeal(
            detailMeals?.strCategory ?? widget.favoriteMeal?.strCategory ?? ""),
        Padding(padding: EdgeInsets.only(left: 8.0)),
        _buildVerticalDivider(),
        Padding(padding: EdgeInsets.only(left: 8.0)),
        _buildWidgetInfoCountryMeal(
            detailMeals?.strArea ?? widget.favoriteMeal?.strArea ?? ""),
        Padding(padding: EdgeInsets.only(left: 8.0)),
      ],
    );
  }

  Widget _buildWidgetInfoCountryMeal(String strArea) {
    return Column(
      children: <Widget>[
        Text("Country"),
        Text(strArea.isEmpty ? "N/A" : strArea, style: TextStyle(fontWeight: FontWeight.bold)),
      ],
    );
  }

  Widget _buildWidgetInfoCategoryMeal(String strCategory) {
    return Column(
      children: <Widget>[
        Text("Category"),
        Text(strCategory.isEmpty ? "N/A" : strCategory, style: TextStyle(fontWeight: FontWeight.bold)),
      ],
    );
  }

  Widget _buildVerticalDivider() {
    return Container(
      color: Colors.grey,
      width: 1.0,
      height: 42.0,
    );
  }

  Widget _buildWidgetInfoPlayVideo(String strYoutube) {
    return GestureDetector(
      onTap: () async {
        if (strYoutube.isNotEmpty) {
          if (Platform.isIOS) {
            if (await canLaunch(strYoutube)) {
              await launch(strYoutube, forceSafariVC: false);
            } else {
              if (await canLaunch(strYoutube)) {
                await launch(strYoutube);
              } else {
                Scaffold.of(context).showSnackBar(
                    SnackBar(content: Text("Could not play video")));
                throw "Could not play video";
              }
            }
          } else {
            if (await canLaunch(strYoutube)) {
              await launch(strYoutube);
            } else {
              Scaffold.of(context).showSnackBar(
                  SnackBar(content: Text("Could not play video")));
              throw "Could not play video";
            }
          }
        }
      },
      child: Row(
        children: <Widget>[
          Icon(
            Icons.ondemand_video,
            size: 28.0,
          ),
          Padding(padding: EdgeInsets.only(left: 8.0)),
          Column(
            children: <Widget>[
              Text(strYoutube.isEmpty ? "Video" : "Play"),
              Text(
                strYoutube.isEmpty ? "N/A" : "Video",
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildTagMeal(String strTags) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Icon(
          Icons.label,
          color: Colors.black26,
          size: 24.0,
        ),
        Padding(padding: EdgeInsets.only(left: 4.0)),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.only(top: 3.5),
            child: Text(
              strTags != null
                  ? strTags.substring(0, strTags.length - 1)
                  : "N/A",
              style: TextStyle(color: Colors.grey),
              maxLines: 2,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildTitleMeal(BuildContext context) {
    return Text(
      widget.strMeal ?? widget.favoriteMeal.strMeal,
      style: Theme.of(context)
          .textTheme
          .title
          .merge(TextStyle(fontWeight: FontWeight.bold)),
      maxLines: 2,
    );
  }

  Widget _buildWidgetImageHeader(MediaQueryData mediaQuery) {
    return Hero(
      tag: "image_detail_meals_${widget.idMeal ?? widget.favoriteMeal.idMeal}",
      child: FadeInImage(
        image: NetworkImage(
            widget.strMealThumb ?? widget.favoriteMeal.strMealThumb),
        placeholder: AssetImage("assets/images/img_placeholder.jpg"),
        fit: BoxFit.cover,
        width: double.infinity,
        height: mediaQuery.size.height / 2.2,
      ),
    );
  }
}
