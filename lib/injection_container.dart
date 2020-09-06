import 'package:data_connection_checker/data_connection_checker.dart';
import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';

import 'config/base_url_config.dart';
import 'core/network/network_info.dart';
import 'feature/data/datasource/themealdb/themealdb_remote_data_source.dart';
import 'feature/data/repository/themealdb/themealdb_repository_impl.dart';
import 'feature/domain/repository/themealdb/themealdb_repository.dart';
import 'feature/domain/usecase/getcategorymeal/get_category_meal.dart';
import 'feature/domain/usecase/getdetailmealbyid/get_detail_meal_by_id.dart';
import 'feature/domain/usecase/getfilterbycategory/get_filter_by_category.dart';
import 'feature/domain/usecase/getrandommeal/get_random_meal.dart';
import 'feature/domain/usecase/searchmealbyname/search_meal_by_name.dart';
import 'feature/presentation/bloc/categorymeal/bloc.dart';
import 'feature/presentation/bloc/detailmeal/bloc.dart';
import 'feature/presentation/bloc/randommeal/bloc.dart';
import 'feature/presentation/bloc/searchmeal/bloc.dart';

final sl = GetIt.instance;

Future<void> init() async {
  /**
   * ! Feature
   */
  // Bloc
  sl.registerFactory(() => CategoryMealBloc(getCategoryMeal: sl(), getFilterByCategory: sl()));
  sl.registerFactory(() => RandomMealBloc(getRandomMeal: sl()));
  sl.registerFactory(() => SearchMealBloc(searchMealByName: sl()));
  sl.registerFactory(() => DetailMealBloc(getDetailMealById: sl()));

  // Use case
  sl.registerLazySingleton(() => GetCategoryMeal(theMealDbRepository: sl()));
  sl.registerLazySingleton(() => GetFilterByCategory(theMealDbRepository: sl()));
  sl.registerLazySingleton(() => GetRandomMeal(theMealDbRepository: sl()));
  sl.registerLazySingleton(() => SearchMealByName(theMealDbRepository: sl()));
  sl.registerLazySingleton(() => GetDetailMealById(theMealDbRepository: sl()));

  // Repository
  sl.registerLazySingleton<TheMealDbRepository>(
    () => TheMealDbRepositoryImpl(
      theMealDbRemoteDataSource: sl(),
      networkInfo: sl(),
    ),
  );

  // Data source
  sl.registerLazySingleton<TheMealDbRemoteDataSource>(() => TheMealDbRemoteDataSourceImpl(dio: sl()));

  /**
   * ! Core
   */
  sl.registerLazySingleton<NetworkInfo>(() => NetworkInfoImpl(sl()));

  /**
   * ! External
   */
  sl.registerLazySingleton(() {
    final dio = Dio();
    dio.options.baseUrl = BaseUrlConfig().baseUrlMealDb;
    return dio;
  });
  sl.registerLazySingleton(() => DataConnectionChecker());
}
