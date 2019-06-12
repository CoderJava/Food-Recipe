import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:food_recipe/src/blocs/detailmeals/detail_meals_bloc.dart';
import 'package:food_recipe/src/models/lookupmealsbyid/lookup_meals_by_id.dart';
import 'package:food_recipe/src/utils/utils.dart';
import 'package:url_launcher/url_launcher.dart';

class DetailMealsScreen extends StatefulWidget {
  final String idMeal;
  final String strMeal;
  final String strMealThumb;

  DetailMealsScreen(this.idMeal, this.strMeal, this.strMealThumb);

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
    return FutureBuilder(
      future: detailsMealsBloc.getDetailsMealsById(widget.idMeal),
      builder: (BuildContext context, AsyncSnapshot<LookupMealsById> snapshot) {
        if (snapshot.hasData) {
          LookupMealsById lookupMealsById = snapshot.data;
          var detailMeals = lookupMealsById.lookupMealsbyIdItems[0];
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              _buildTagMeal(detailMeals.strTags),
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
              _buildWidgetInfoInstructions(detailMeals.strInstructions),
            ],
          );
        } else if (snapshot.hasError) {
          return Text(snapshot.error.toString());
        }
        return Padding(
          padding: const EdgeInsets.only(top: 16.0),
          child: Center(child: buildCircularProgressIndicator()),
        );
      },
    );
  }

  Widget _buildWidgetInfoInstructions(String strInstructions) {
    return Padding(
      padding: EdgeInsets.only(left: 8.0, top: 8.0, right: 8.0),
      child: Text(strInstructions),
    );
  }

  Widget _buildWidgetInfoIngredients(LookupMealsByIdItem detailMeals) {
    List<String> ingredientsTemp = [];
    ingredientsTemp
      ..add(detailMeals.strMeasure1 + " " + detailMeals.strIngredient1)
      ..add(detailMeals.strMeasure2 + " " + detailMeals.strIngredient2)
      ..add(detailMeals.strMeasure3 + " " + detailMeals.strIngredient3)
      ..add(detailMeals.strMeasure4 + " " + detailMeals.strIngredient4)
      ..add(detailMeals.strMeasure5 + " " + detailMeals.strIngredient5)
      ..add(detailMeals.strMeasure6 + " " + detailMeals.strIngredient6)
      ..add(detailMeals.strMeasure7 + " " + detailMeals.strIngredient7)
      ..add(detailMeals.strMeasure8 + " " + detailMeals.strIngredient8)
      ..add(detailMeals.strMeasure9 + " " + detailMeals.strIngredient9)
      ..add(detailMeals.strMeasure10 + " " + detailMeals.strIngredient10)
      ..add(detailMeals.strMeasure11 + " " + detailMeals.strIngredient11)
      ..add(detailMeals.strMeasure12 + " " + detailMeals.strIngredient12)
      ..add(detailMeals.strMeasure13 + " " + detailMeals.strIngredient13)
      ..add(detailMeals.strMeasure14 + " " + detailMeals.strIngredient14)
      ..add(detailMeals.strMeasure15 + " " + detailMeals.strIngredient15)
      ..add(detailMeals.strMeasure16 + " " + detailMeals.strIngredient16)
      ..add(detailMeals.strMeasure17 + " " + detailMeals.strIngredient17)
      ..add(detailMeals.strMeasure18 + " " + detailMeals.strIngredient18)
      ..add(detailMeals.strMeasure19 + " " + detailMeals.strIngredient19)
      ..add(detailMeals.strMeasure20 + " " + detailMeals.strIngredient20);
    List<String> ingredients = [];
    for (String ingredientItem in ingredientsTemp) {
      if (ingredientItem.trim().isEmpty) {
        break;
      }
      ingredients.add(ingredientItem);
    }
    return Padding(
      padding: EdgeInsets.only(left: 8.0, top: 8.0),
      child: ListView.builder(
        padding: EdgeInsets.all(0.0),
        shrinkWrap: true,
        physics: NeverScrollableScrollPhysics(),
        itemCount: ingredients.length,
        itemBuilder: (context, index) {
          return Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Container(
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.black54,
                ),
                width: 6.0,
                height: 6.0,
              ),
              Padding(padding: EdgeInsets.only(right: 16.0)),
              Text(ingredients[index]),
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
        _buildWidgetInfoPlayVideo(detailMeals.strYoutube),
        Padding(padding: EdgeInsets.only(left: 8.0)),
        _buildVerticalDivider(),
        Padding(padding: EdgeInsets.only(left: 8.0)),
        _buildWidgetInfoCategoryMeal(detailMeals.strCategory),
        Padding(padding: EdgeInsets.only(left: 8.0)),
        _buildVerticalDivider(),
        Padding(padding: EdgeInsets.only(left: 8.0)),
        _buildWidgetInfoCountryMeal(detailMeals),
        Padding(padding: EdgeInsets.only(left: 8.0)),
      ],
    );
  }

  Widget _buildWidgetInfoCountryMeal(LookupMealsByIdItem detailMeals) {
    return Column(
      children: <Widget>[
        Text("Country"),
        Text(detailMeals.strArea,
            style: TextStyle(fontWeight: FontWeight.bold)),
      ],
    );
  }

  Widget _buildWidgetInfoCategoryMeal(String strCategory) {
    return Column(
      children: <Widget>[
        Text("Category"),
        Text(strCategory, style: TextStyle(fontWeight: FontWeight.bold)),
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
      children: <Widget>[
        Icon(
          Icons.label,
          color: Colors.black26,
          size: 24.0,
        ),
        Padding(padding: EdgeInsets.only(left: 4.0)),
        Text(
          strTags.substring(0, strTags.length - 1),
          style: TextStyle(color: Colors.grey),
          maxLines: 1,
        ),
      ],
    );
  }

  Widget _buildTitleMeal(BuildContext context) {
    return Text(
      widget.strMeal,
      style: Theme.of(context)
          .textTheme
          .title
          .merge(TextStyle(fontWeight: FontWeight.bold)),
      maxLines: 2,
    );
  }

  Widget _buildWidgetImageHeader(MediaQueryData mediaQuery) {
    return Hero(
      tag: "image_detail_meals_${widget.idMeal}",
      child: FadeInImage(
        image: NetworkImage(widget.strMealThumb),
        placeholder: AssetImage("assets/images/img_placeholder.jpg"),
        fit: BoxFit.cover,
        width: double.infinity,
        height: mediaQuery.size.height / 2.2,
      ),
    );
  }
}
