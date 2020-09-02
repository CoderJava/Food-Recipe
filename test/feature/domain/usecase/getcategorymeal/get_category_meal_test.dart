import 'dart:convert';

import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:food_recipe/core/usecase/usecase.dart';
import 'package:food_recipe/feature/data/model/mealcategory/meal_category_response.dart';
import 'package:food_recipe/feature/domain/repository/themealdb/themealdb_repository.dart';
import 'package:food_recipe/feature/domain/usecase/getcategorymeal/get_category_meal.dart';
import 'package:mockito/mockito.dart';

import '../../../../fixture/fixture_reader.dart';

class MockTheMealDbRepository extends Mock implements TheMealDbRepository {}

void main() {
  GetCategoryMeal getCategoryMeal;
  MockTheMealDbRepository mockTheMealDbRepository;

  setUp(() {
    mockTheMealDbRepository = MockTheMealDbRepository();
    getCategoryMeal = GetCategoryMeal(theMealDbRepository: mockTheMealDbRepository);
  });

  test(
    'pastikan TheMealDbRepository berhasil menerima respon sukses dan gagal dari endpoint',
    () async {
      // arrange
      final mealCategoryResponse = MealCategoryResponse.fromJson(
        json.decode(
          fixture('meal_category_response.json'),
        ),
      );
      when(mockTheMealDbRepository.getCategoryMeal()).thenAnswer((_) async => Right(mealCategoryResponse));

      // act
      final result = await getCategoryMeal(NoParams());

      // assert
      expect(result, Right(mealCategoryResponse));
      verify(mockTheMealDbRepository.getCategoryMeal());
      verifyNoMoreInteractions(mockTheMealDbRepository);
    },
  );
}