import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:food_recipe/src/blocs/listmeals/list_meals_bloc.dart';
import 'package:food_recipe/src/database/entity/favorite_meal.dart';
import 'package:food_recipe/src/models/categories/categories.dart';
import 'package:food_recipe/src/models/filtercategories/filter_categories.dart';
import 'package:food_recipe/src/models/lookupmealsbyid/lookup_meals_by_id.dart';
import 'package:food_recipe/src/ui/detailmeals/detail_meals_screen.dart';
import 'package:food_recipe/src/utils/utils.dart';

class ListMealsScreen extends StatefulWidget {
  @override
  _ListMealsScreenState createState() => _ListMealsScreenState();
}

class _ListMealsScreenState extends State<ListMealsScreen> {
  CategoryItem categoryItem;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var mediaQuery = MediaQuery.of(context);
    categoryItem = ModalRoute.of(context).settings.arguments;

    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        child: Stack(
          children: <Widget>[
            buildWidgetBackgroundCircle(mediaQuery),
            _buildWidgetContent(mediaQuery),
          ],
        ),
      ),
    );
  }

  Widget _buildWidgetContent(MediaQueryData mediaQuery) {
    return SafeArea(
      minimum: EdgeInsets.symmetric(horizontal: 16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Padding(padding: EdgeInsets.only(top: 16.0)),
          Hero(
            tag: "label_item_category_${categoryItem.idCategory}",
            child: Text(
              categoryItem.strCategory,
              style: Theme.of(context)
                  .textTheme
                  .display2
                  .merge(TextStyle(fontWeight: FontWeight.bold)),
              maxLines: 1,
            ),
          ),
          Padding(padding: EdgeInsets.only(top: 16.0)),
          Expanded(
            child: FutureBuilder(
              future:
                  listMealsBloc.getFilterCategories(categoryItem.strCategory),
              builder: (BuildContext context,
                  AsyncSnapshot<FilterCategories> snapshot) {
                if (snapshot.hasData) {
                  FilterCategories filterCategories = snapshot.data;
                  return ListView.builder(
                    shrinkWrap: true,
                    itemCount: filterCategories.filterCategoryItems.length,
                    itemBuilder: (context, index) {
                      FilterCategoryItem filterCategoryItem =
                          filterCategories.filterCategoryItems[index];
                      return CardMeal(filterCategoryItem);
                    },
                  );
                } else if (snapshot.hasError) {
                  return Text(snapshot.error.toString());
                }
                return Center(child: buildCircularProgressIndicator());
              },
            ),
          ),
        ],
      ),
    );
  }
}

class CardMeal extends StatefulWidget {
  final FilterCategoryItem filterCategoryItem;

  CardMeal(this.filterCategoryItem);

  @override
  _CardMealState createState() => _CardMealState();
}

class _CardMealState extends State<CardMeal> {
  @override
  Widget build(BuildContext context) {
    var mediaQuery = MediaQuery.of(context);
    return Padding(
      padding: const EdgeInsets.only(bottom: 16.0),
      child: GestureDetector(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) {
              return DetailMealsScreen(
                idMeal: widget.filterCategoryItem.idMeal,
                strMeal: widget.filterCategoryItem.strMeal,
                strMealThumb: widget.filterCategoryItem.strMealThumb,
              );
            }),
          );
        },
        child: Card(
          elevation: 8.0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16.0),
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(16.0),
            child: Stack(
              children: <Widget>[
                Hero(
                  tag: "image_detail_meals_${widget.filterCategoryItem.idMeal}",
                  child: FadeInImage(
                    image: NetworkImage(widget.filterCategoryItem.strMealThumb),
                    placeholder:
                        AssetImage("assets/images/img_placeholder.jpg"),
                    fit: BoxFit.cover,
                    width: double.infinity,
                    height: mediaQuery.size.width / 1.5,
                  ),
                ),
                Container(
                  width: double.infinity,
                  height: mediaQuery.size.width / 1.5,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      stops: [0.1, 0.9],
                      colors: [
                        Color(0xFFFFFFFF),
                        Color(0x00FFFFFF),
                      ],
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Expanded(
                        child: Text(
                          widget.filterCategoryItem.strMeal,
                          style: Theme.of(context).textTheme.title,
                          maxLines: 2,
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          var isFavorite = widget.filterCategoryItem.isFavorite;
                          if (isFavorite) {
                            listMealsBloc
                                .deleteFavoriteMealById(
                                    widget.filterCategoryItem.idMeal)
                                .then((status) {
                              setState(() {
                                widget.filterCategoryItem.isFavorite =
                                    !isFavorite;
                              });
                            });
                          } else {
                            Future<LookupMealsById> lookupMealsById =
                                listMealsBloc.getDetailMealById(
                                    widget.filterCategoryItem.idMeal);
                            lookupMealsById.then((value) {
                              if (value != null) {
                                var item = value.lookupMealsbyIdItems[0];
                                FavoriteMeal favoriteMeal =
                                    FavoriteMeal.fromJson(item.toJson());
                                listMealsBloc
                                    .addFavoriteMeal(favoriteMeal)
                                    .then((status) {
                                  setState(() {
                                    widget.filterCategoryItem.isFavorite =
                                        !isFavorite;
                                  });
                                });
                              } else {
                                Scaffold.of(context).showSnackBar(SnackBar(
                                    content:
                                        Text("Failed added to favorite meal")));
                              }
                            });
                          }
                        },
                        child: CircleAvatar(
                          backgroundColor: Color(0xAFE8364B),
                          child: Icon(
                            widget.filterCategoryItem.isFavorite
                                ? Icons.favorite
                                : Icons.favorite_border,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
