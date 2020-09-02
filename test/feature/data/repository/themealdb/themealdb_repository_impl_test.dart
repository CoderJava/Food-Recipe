import 'dart:convert';

import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:food_recipe/core/error/failure.dart';
import 'package:food_recipe/core/network/network_info.dart';
import 'package:food_recipe/feature/data/datasource/themealdb/themealdb_remote_data_source.dart';
import 'package:food_recipe/feature/data/model/detailmeal/detail_meal_response.dart';
import 'package:food_recipe/feature/data/model/mealcategory/meal_category_response.dart';
import 'package:food_recipe/feature/data/repository/themealdb/themealdb_repository_impl.dart';
import 'package:mockito/mockito.dart';

import '../../../../fixture/fixture_reader.dart';

class MockTheMealDbRemoteDataSource extends Mock implements TheMealDbRemoteDataSource {}

class MockNetworkInfo extends Mock implements NetworkInfo {}

void main() {
  TheMealDbRepositoryImpl theMealDbRepositoryImpl;
  MockTheMealDbRemoteDataSource mockTheMealDbRemoteDataSource;
  MockNetworkInfo mockNetworkInfo;

  setUp(() {
    mockTheMealDbRemoteDataSource = MockTheMealDbRemoteDataSource();
    mockNetworkInfo = MockNetworkInfo();
    theMealDbRepositoryImpl = TheMealDbRepositoryImpl(
      theMealDbRemoteDataSource: mockTheMealDbRemoteDataSource,
      networkInfo: mockNetworkInfo,
    );
  });

  void setUpMockNetworkConnected() {
    when(mockNetworkInfo.isConnected).thenAnswer((_) async => true);
  }

  void setUpMockNetworkDisconnected() {
    when(mockNetworkInfo.isConnected).thenAnswer((_) async => false);
  }

  void testConnected(Function action) {
    test(
      'pastikan device terhubung ke itnernet ketika memanggil endpoint',
      () async {
        // arrange
        setUpMockNetworkConnected();

        // act
        await action.call();

        // assert
        verify(mockNetworkInfo.isConnected);
      },
    );
  }

  void testDisconnected(Function action) {
    test(
      'pastikan mengembalikan objek ConnectionFailure ketika device tidak terhubung ke internet',
      () async {
        // arrange
        setUpMockNetworkDisconnected();

        // act
        final result = await action.call();

        // assert
        verify(mockNetworkInfo.isConnected);
        expect(result, Left(ConnectionFailure()));
      },
    );
  }

  group('getRandomMeal', () {
    final tDetailMealResponse = DetailMealResponse.fromJson(
      json.decode(
        fixture('detail_meal_response.json'),
      ),
    );

    testConnected(() => theMealDbRepositoryImpl.getRandomMeal());

    test(
      'pastikan mengembalikan objek model DetailMealResponse ketika TheMealDbRemoteDataSource berhasil menerima '
      'respon sukses dari endpoint',
      () async {
        // arrange
        setUpMockNetworkConnected();
        when(mockTheMealDbRemoteDataSource.getRandomMeal()).thenAnswer((_) async => tDetailMealResponse);

        // act
        final result = await theMealDbRepositoryImpl.getRandomMeal();

        // assert
        verify(mockTheMealDbRemoteDataSource.getRandomMeal());
        expect(result, Right(tDetailMealResponse));
      },
    );

    test(
      'pastikan mengembalikan objek ServerFailure ketika TheMealDbRemoteDataSource menerima respon kegagalan dari '
      'endpoint',
      () async {
        // arrange
        setUpMockNetworkConnected();
        when(mockTheMealDbRemoteDataSource.getRandomMeal()).thenThrow(DioError(error: 'testError'));

        // act
        final result = await theMealDbRepositoryImpl.getRandomMeal();

        // assert
        verify(mockTheMealDbRemoteDataSource.getRandomMeal());
        expect(result, Left(ServerFailure('testError')));
      },
    );

    testDisconnected(() => theMealDbRepositoryImpl.getRandomMeal());
  });

  group('getCategoryMeal', () {
    final tMealCategoryResponse = MealCategoryResponse.fromJson(
      json.decode(
        fixture('meal_category_response.json'),
      ),
    );

    testConnected(() => theMealDbRepositoryImpl.getCategoryMeal());

    test(
      'pastikan mengembalikan objek model MealCategoryResponse ketika TheMealDbRemoteDataSource berhasil menerima '
      'respon sukses dari endpoint',
      () async {
        // arrange
        setUpMockNetworkConnected();
        when(mockTheMealDbRemoteDataSource.getCategoryMeal()).thenAnswer((_) async => tMealCategoryResponse);

        // act
        final result = await theMealDbRepositoryImpl.getCategoryMeal();

        // assert
        verify(mockTheMealDbRemoteDataSource.getCategoryMeal());
        expect(result, Right(tMealCategoryResponse));
      },
    );

    test(
      'pastikan mengembalikan objek ServerFailure ketika TheMealDbRemoteDataSource menerima respon kegagalan dari '
      'endpoint',
      () async {
        // arrange
        setUpMockNetworkConnected();
        when(mockTheMealDbRemoteDataSource.getCategoryMeal()).thenThrow(DioError(error: 'testError'));

        // act
        final result = await theMealDbRepositoryImpl.getCategoryMeal();

        // assert
        verify(mockTheMealDbRemoteDataSource.getCategoryMeal());
        expect(result, Left(ServerFailure('testError')));
      },
    );

    testDisconnected(() => theMealDbRepositoryImpl.getCategoryMeal());
  });
}
