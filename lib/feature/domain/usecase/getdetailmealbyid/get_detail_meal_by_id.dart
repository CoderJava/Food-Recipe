import 'package:dartz/dartz.dart';
import 'package:meta/meta.dart';
import 'package:equatable/equatable.dart';
import 'package:food_recipe/core/error/failure.dart';
import 'package:food_recipe/core/usecase/usecase.dart';
import 'package:food_recipe/feature/data/model/detailmeal/detail_meal_response.dart';
import 'package:food_recipe/feature/domain/repository/themealdb/themealdb_repository.dart';

class GetDetailMealById implements UseCase<DetailMealResponse, ParamsGetDetailMealById> {
  final TheMealDbRepository theMealDbRepository;

  GetDetailMealById({@required this.theMealDbRepository});

  @override
  Future<Either<Failure, DetailMealResponse>> call(params) async {
    return await theMealDbRepository.getDetailMealById(params.id);
  }
}

class ParamsGetDetailMealById extends Equatable {
  final String id;

  ParamsGetDetailMealById(this.id);

  @override
  List<Object> get props => [id];

  @override
  String toString() {
    return 'ParamsGetDetailMealById{id: $id}';
  }
}