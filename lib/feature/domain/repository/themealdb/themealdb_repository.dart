import 'package:dartz/dartz.dart';
import 'package:food_recipe/core/error/failure.dart';
import 'package:food_recipe/feature/data/model/detailmeal/detail_meal_response.dart';
import 'package:food_recipe/feature/data/model/filterbycategory/filter_by_category_response.dart';
import 'package:food_recipe/feature/data/model/mealcategory/meal_category_response.dart';
import 'package:food_recipe/feature/data/model/searchmealbyname/search_meal_by_name_response.dart';

abstract class TheMealDbRepository {
  Future<Either<Failure, DetailMealResponse>> getRandomMeal();

  Future<Either<Failure, MealCategoryResponse>> getCategoryMeal();

  Future<Either<Failure, FilterByCategoryResponse>> getFilterByCategory(String category);

  Future<Either<Failure, SearchMealByNameResponse>> searchMealByName(String name);
}