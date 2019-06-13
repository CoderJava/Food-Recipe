import 'package:food_recipe/src/database/entity/favorite_meal.dart';

class FavoriteMealsBlocModel {
  List<FavoriteMeal> listFavoriteMeals;
  bool isLoading;

  FavoriteMealsBlocModel({this.listFavoriteMeals, this.isLoading = false,});

  @override
  String toString() {
    return 'FavoriteMealsBlocModel{listFavoriteMeals: $listFavoriteMeals, isLoading: $isLoading}';
  }

}