import 'package:dartz/dartz.dart';
import 'package:food_recipe/core/error/failure.dart';
import 'package:food_recipe/feature/data/model/detailmeal/detail_meal_response.dart';

abstract class TheMealDbRepository {
  Future<Either<Failure, DetailMealResponse>> getRandomMeal();
}