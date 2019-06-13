import 'dart:async';

import 'package:food_recipe/src/models/area/area_meals.dart';
import 'package:food_recipe/src/models/categories/categories.dart';
import 'package:food_recipe/src/models/filterarea/filter_area_meals.dart';
import 'package:food_recipe/src/models/filtercategories/filter_categories.dart';
import 'package:food_recipe/src/models/latest/latest_meals.dart';
import 'package:food_recipe/src/models/lookupmealsbyid/lookup_meals_by_id.dart';
import 'package:food_recipe/src/models/randommeals/random_meals.dart';
import 'package:food_recipe/src/models/searchmeals/search_meals.dart';

import 'food_api_provider.dart';

class FoodApiRepository {
  final foodApiProvider = FoodApiProvider();

  Future<RandomMeals> getRandomMeals() => foodApiProvider.getRandomMeals();

  Future<Categories> getCategories() => foodApiProvider.getCategories();

  Future<LatestMeals> getLatestMeals() => foodApiProvider.getLatestMeals();

  Future<AreaMeals> getAreaMeals() => foodApiProvider.getAreaMeals();

  Future<FilterCategories> getFilterByCategories(String category) =>
      foodApiProvider.getFilterByCategories(category);

  Future<FilterAreaMeals> getFilterByArea(String area) =>
      foodApiProvider.getFilterByArea(area);

  Future<LookupMealsById> getLookupMealsById(String id) =>
      foodApiProvider.getLookupMealsById(id);

  Future<SearchMeals> getSearchMealsByKeyword(String keyword) =>
      foodApiProvider.getSearchMealsByKeyword(keyword);
}
