import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:food_recipe/core/error/failure.dart';
import 'package:meta/meta.dart';
import 'package:food_recipe/core/usecase/usecase.dart';
import 'package:food_recipe/feature/data/model/filterbycategory/filter_by_category_response.dart';
import 'package:food_recipe/feature/domain/repository/themealdb/themealdb_repository.dart';

class GetFilterByCategory implements UseCase<FilterByCategoryResponse, ParamsGetFilterByCategory> {
  final TheMealDbRepository theMealDbRepository;

  GetFilterByCategory({@required this.theMealDbRepository});

  @override
  Future<Either<Failure, FilterByCategoryResponse>> call(ParamsGetFilterByCategory params) async {
    return await theMealDbRepository.getFilterByCategory(params.category);
  }
}

class ParamsGetFilterByCategory extends Equatable {
  final String category;

  ParamsGetFilterByCategory({@required this.category});

  @override
  List<Object> get props => [category];

  @override
  String toString() {
    return 'ParamsGetFilterByCategory{category: $category}';
  }
}