import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:food_recipe/core/error/failure.dart';
import 'package:food_recipe/core/network/network_info.dart';
import 'package:food_recipe/feature/data/datasource/themealdb/themealdb_remote_data_source.dart';
import 'package:food_recipe/feature/data/model/detailmeal/detail_meal_response.dart';
import 'package:food_recipe/feature/data/model/filterbycategory/filter_by_category_response.dart';
import 'package:food_recipe/feature/data/model/mealcategory/meal_category_response.dart';
import 'package:food_recipe/feature/data/model/searchmealbyname/search_meal_by_name_response.dart';
import 'package:food_recipe/feature/domain/repository/themealdb/themealdb_repository.dart';

class TheMealDbRepositoryImpl implements TheMealDbRepository {
  final TheMealDbRemoteDataSource theMealDbRemoteDataSource;
  final NetworkInfo networkInfo;

  TheMealDbRepositoryImpl({
    this.theMealDbRemoteDataSource,
    this.networkInfo,
  });

  @override
  Future<Either<Failure, DetailMealResponse>> getRandomMeal() async {
    var isConnected = await networkInfo.isConnected;
    if (isConnected) {
      try {
        var response = await theMealDbRemoteDataSource.getRandomMeal();
        return Right(response);
      } on DioError catch (error) {
        return Left(ServerFailure(error.message));
      }
    } else {
      return Left(ConnectionFailure());
   }
  }

  @override
  Future<Either<Failure, MealCategoryResponse>> getCategoryMeal() async {
    var isConnected = await networkInfo.isConnected;
    if (isConnected) {
      try {
        var response = await theMealDbRemoteDataSource.getCategoryMeal();
        return Right(response);
      } on DioError catch (error) {
        return Left(ServerFailure(error.message));
      }
    } else {
      return Left(ConnectionFailure());
    }
  }

  @override
  Future<Either<Failure, FilterByCategoryResponse>> getFilterByCategory(String category) async {
    var isConnected = await networkInfo.isConnected;
    if (isConnected) {
      try {
        var response = await theMealDbRemoteDataSource.getFilterByCategory(category);
        return Right(response);
      } on DioError catch (error) {
        return Left(ServerFailure(error.message));
      }
    } else {
      return Left(ConnectionFailure());
    }
  }

  @override
  Future<Either<Failure, SearchMealByNameResponse>> searchMealByName(String name) async {
    var isConnected = await networkInfo.isConnected;
    if (isConnected) {
      try {
        var response = await theMealDbRemoteDataSource.searchMealByName(name);
        return Right(response);
      } on DioError catch (error) {
        return Left(ServerFailure(error.message));
      }
    } else {
      return Left(ConnectionFailure());
    }
  }
}
