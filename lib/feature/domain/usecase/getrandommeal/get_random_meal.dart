import 'package:dartz/dartz.dart';
import 'package:food_recipe/core/error/failure.dart';
import 'package:food_recipe/core/usecase/usecase.dart';
import 'package:food_recipe/feature/data/model/detailmeal/detail_meal_response.dart';
import 'package:food_recipe/feature/domain/repository/themealdb/themealdb_repository.dart';

class GetRandomMeal implements UseCase<DetailMealResponse, NoParams> {
  final TheMealDbRepository theMealDbRepository;

  GetRandomMeal({this.theMealDbRepository});

  @override
  Future<Either<Failure, DetailMealResponse>> call(NoParams params) async {
    return await theMealDbRepository.getRandomMeal();
  }
}