import 'package:dartz/dartz.dart';
import 'package:meta/meta.dart';
import 'package:food_recipe/core/error/failure.dart';
import 'package:food_recipe/core/usecase/usecase.dart';
import 'package:food_recipe/feature/data/model/mealcategory/meal_category_response.dart';
import 'package:food_recipe/feature/domain/repository/themealdb/themealdb_repository.dart';

class GetCategoryMeal implements UseCase<MealCategoryResponse, NoParams> {
  final TheMealDbRepository theMealDbRepository;

  GetCategoryMeal({@required this.theMealDbRepository});

  @override
  Future<Either<Failure, MealCategoryResponse>> call(NoParams params) async {
    return await theMealDbRepository.getCategoryMeal();
  }
}
