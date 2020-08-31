import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:food_recipe/core/error/failure.dart';
import 'package:food_recipe/core/network/network_info.dart';
import 'package:food_recipe/feature/data/datasource/themealdb/themealdb_remote_data_source.dart';
import 'package:food_recipe/feature/data/model/detailmeal/detail_meal_response.dart';
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
}
