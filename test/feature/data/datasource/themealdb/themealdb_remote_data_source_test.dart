import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:food_recipe/feature/data/model/mealcategory/meal_category_response.dart';
import 'package:matcher/matcher.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:food_recipe/config/base_url_config.dart';
import 'package:food_recipe/feature/data/datasource/themealdb/themealdb_remote_data_source.dart';
import 'package:food_recipe/feature/data/model/detailmeal/detail_meal_response.dart';
import 'package:mockito/mockito.dart';

import '../../../../fixture/fixture_reader.dart';

class MockDioAdapter extends Mock implements HttpClientAdapter {}

class MockDio extends Mock implements Dio {}

void main() {
  TheMealDbRemoteDataSource theMealDbRemoteDataSource;
  MockDio mockDio;
  MockDioAdapter mockDioAdapter;

  setUp(() {
    mockDio = MockDio();
    mockDioAdapter = MockDioAdapter();
    mockDio.httpClientAdapter = mockDioAdapter;
    mockDio.options = BaseOptions(baseUrl: BaseUrlConfig().baseUrlMealDb);
    theMealDbRemoteDataSource = TheMealDbRemoteDataSourceImpl(dio: mockDio);
  });

  group('getRandomMeal', () {
    final tDetailMealResponse = DetailMealResponse.fromJson(
      json.decode(
        fixture('detail_meal_response.json'),
      ),
    );

    void setUpMockDioSuccess() {
      final responsePayload = json.decode(fixture('api_detail_meal_response.json'));
      final response = Response(
        data: responsePayload,
        statusCode: 200,
        headers: Headers.fromMap({
          Headers.contentTypeHeader: [Headers.jsonContentType],
        }),
      );
      when(mockDio.get(any)).thenAnswer((_) async => response);
    }

    test(
      'pastikan endpoint getRandomMeal benar-benar terpanggil dengan method GET',
      () async {
        // arrange
        setUpMockDioSuccess();

        // act
        await theMealDbRemoteDataSource.getRandomMeal();

        // assert
        verify(mockDio.get('/random.php'));
      },
    );

    test(
      'pastikan mengembalikan objek model DetailMealResponse ketika menerima respon sukses (200) '
      'dari endpoint',
      () async {
        // arrange
        setUpMockDioSuccess();

        // act
        final result = await theMealDbRemoteDataSource.getRandomMeal();

        // assert
        expect(result, tDetailMealResponse);
      },
    );

    test(
      'pastikan akan menerima exception DioError ketika menerima respon kegagalan dari endpoint',
      () async {
        // arrange
        final response = Response(
          data: 'Bad Request',
          statusCode: 400,
        );
        when(mockDio.get(any)).thenAnswer((_) async => response);

        // act
        final call = theMealDbRemoteDataSource.getRandomMeal();

        // assert
        expect(() => call, throwsA(TypeMatcher<DioError>()));
      },
    );
  });

  group('getCategoryMeal', () {
    final tMealCategoryResponse = MealCategoryResponse.fromJson(
      json.decode(
        fixture('meal_category_response.json'),
      ),
    );

    void setUpMockDioSuccess() {
      final responsePayload = json.decode(fixture('meal_category_response.json'));
      final response = Response(
        data: responsePayload,
        statusCode: 200,
        headers: Headers.fromMap({
          Headers.contentTypeHeader: [Headers.jsonContentType],
        }),
      );
      when(mockDio.get(any)).thenAnswer((_) async => response);
    }

    test(
      'pastikan endpoint getCategoryMeal benar-benar terpanggil dengan method GET',
      () async {
        // arrange
        setUpMockDioSuccess();

        // act
        await theMealDbRemoteDataSource.getCategoryMeal();

        // assert
        verify(mockDio.get('/categories.php'));
      },
    );

    test(
      'pastikan mengembalikan objek model MealCategoryResponse ketika menerima respon sukses (200) '
      'dari endpoint',
      () async {
        // arrange
        setUpMockDioSuccess();

        // act
        final result = await theMealDbRemoteDataSource.getCategoryMeal();

        // assert
        expect(result, tMealCategoryResponse);
      },
    );

    test(
      'pastikan akan menerima exception DioError ketika menerima respon kegagalan dari endpoint',
      () async {
        // arrange
        final response = Response(
          data: 'Bad Request',
          statusCode: 400,
        );
        when(mockDio.get(any)).thenAnswer((_) async => response);

        // act
        final call = theMealDbRemoteDataSource.getCategoryMeal();

        // assert
        expect(() => call, throwsA(TypeMatcher<DioError>()));
      },
    );
  });
}
