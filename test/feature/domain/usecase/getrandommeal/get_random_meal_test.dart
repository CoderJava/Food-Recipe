import 'dart:convert';

import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:food_recipe/core/usecase/usecase.dart';
import 'package:food_recipe/feature/data/model/detailmeal/detail_meal_response.dart';
import 'package:food_recipe/feature/domain/repository/themealdb/themealdb_repository.dart';
import 'package:food_recipe/feature/domain/usecase/getrandommeal/get_random_meal.dart';
import 'package:mockito/mockito.dart';

import '../../../../fixture/fixture_reader.dart';

class MockTheMealDbRepository extends Mock implements TheMealDbRepository {}

void main() {
  GetRandomMeal getRandomMeal;
  MockTheMealDbRepository mockTheMealDbRepository;

  setUp(() {
    mockTheMealDbRepository = MockTheMealDbRepository();
    getRandomMeal = GetRandomMeal(theMealDbRepository: mockTheMealDbRepository);
  });

  test(
    'pastikan TheMealDbRepository berhasil menerima respon sukses dan gagal dari endpoint getRandomMeal',
    () async {
      // arrange
      final tDetailMealResponse = DetailMealResponse.fromJson(json.decode(fixture('detail_meal_response.json')));
      when(mockTheMealDbRepository.getRandomMeal()).thenAnswer((_) async => Right(tDetailMealResponse));

      // act
      final result = await getRandomMeal(NoParams());

      // assert
      expect(result, Right(tDetailMealResponse));
      verify(mockTheMealDbRepository.getRandomMeal());
      verifyNoMoreInteractions(mockTheMealDbRepository);
    },
  );
}
