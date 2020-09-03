import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:food_recipe/core/error/failure.dart';
import 'package:meta/meta.dart';
import 'package:food_recipe/core/usecase/usecase.dart';
import 'package:food_recipe/feature/data/model/searchmealbyname/search_meal_by_name_response.dart';
import 'package:food_recipe/feature/domain/repository/themealdb/themealdb_repository.dart';

class SearchMealByName implements UseCase<SearchMealByNameResponse, ParamsSearchMealByName> {
  final TheMealDbRepository theMealDbRepository;

  SearchMealByName({@required this.theMealDbRepository});

  @override
  Future<Either<Failure, SearchMealByNameResponse>> call(ParamsSearchMealByName params) async {
    return await theMealDbRepository.searchMealByName(params.name);
  }
}

class ParamsSearchMealByName extends Equatable {
  final String name;

  ParamsSearchMealByName({@required this.name});

  @override
  List<Object> get props => [name];

  @override
  String toString() {
    return 'ParamsSearchMealByName{name: $name}';
  }
}
