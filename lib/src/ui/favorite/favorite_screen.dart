import 'package:flutter/material.dart';
import 'package:food_recipe/src/blocs/favorite/favorite_bloc.dart';
import 'package:food_recipe/src/blocs/favorite/favorite_meals_bloc_model.dart';
import 'package:food_recipe/src/database/entity/favorite_meal.dart';
import 'package:food_recipe/src/ui/detailmeals/detail_meals_screen.dart';
import 'package:food_recipe/src/utils/utils.dart';

class FavoriteScreen extends StatefulWidget {
  @override
  _FavoriteScreenState createState() => _FavoriteScreenState();
}

class _FavoriteScreenState extends State<FavoriteScreen> {
  FavoriteBloc _favoriteBloc;

  @override
  void initState() {
    _favoriteBloc = FavoriteBloc();
    _favoriteBloc.getAllFavoriteMeals();
    super.initState();
  }

  @override
  void dispose() {
    _favoriteBloc.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var mediaQuery = MediaQuery.of(context);
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
          Text(
            "Favorite\nRecipe",
            style: Theme.of(context)
                .textTheme
                .display2
                .merge(TextStyle(fontWeight: FontWeight.bold)),
          ),
          Padding(padding: EdgeInsets.only(top: 16)),
          Expanded(
            child: StreamBuilder(
              stream: _favoriteBloc.listFavoriteMeal,
              builder: (BuildContext context,
                  AsyncSnapshot<FavoriteMealsBlocModel> snapshot) {
                if (snapshot.hasData) {
                  FavoriteMealsBlocModel favoriteMealsBlocModel = snapshot.data;
                  if (favoriteMealsBlocModel.isLoading) {
                    return Center(child: buildCircularProgressIndicator());
                  } else {
                    List<FavoriteMeal> listFavoriteMeals =
                        favoriteMealsBlocModel.listFavoriteMeals;
                    return ListView.builder(
                      shrinkWrap: true,
                      itemCount: listFavoriteMeals.length,
                      itemBuilder: (context, index) {
                        FavoriteMeal favoriteMeal = listFavoriteMeals[index];
                        return Padding(
                          padding: const EdgeInsets.only(bottom: 16.0),
                          child: GestureDetector(
                            onTap: () {
                              Navigator.push(context, MaterialPageRoute(
                                builder: (context) {
                                  return DetailMealsScreen(
                                    favoriteMeal: favoriteMeal,
                                  );
                                },
                              ));
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
                                      tag:
                                          "image_detail_meals_${favoriteMeal.idMeal}",
                                      child: FadeInImage(
                                        image: NetworkImage(
                                            favoriteMeal.strMealThumb),
                                        placeholder: AssetImage(
                                            "assets/images/img_placeholder.jpg"),
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
                                            Color(0x00FFFFFF)
                                          ],
                                        ),
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.all(16.0),
                                      child: Row(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: <Widget>[
                                          Expanded(
                                            child: Text(
                                              favoriteMeal.strMeal,
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .title,
                                              maxLines: 2,
                                            ),
                                          ),
                                          GestureDetector(
                                            onTap: () {
                                              _favoriteBloc
                                                  .removeFavoriteMealById(
                                                      favoriteMeal.idMeal);
                                            },
                                            child: CircleAvatar(
                                              backgroundColor:
                                                  Color(0xAFE8364B),
                                              child: Icon(
                                                Icons.favorite,
                                                color: Colors.white,
                                              ),
                                            ),
                                          )
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        );
                      },
                    );
                  }
                } else if (snapshot.hasError) {
                  return Text(snapshot.error.toString());
                }
                return Container();
              },
            ),
          ),
        ],
      ),
    );
  }
}
