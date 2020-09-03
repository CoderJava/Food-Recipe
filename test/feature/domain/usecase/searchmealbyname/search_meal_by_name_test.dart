import 'dart:convert';

import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:food_recipe/feature/data/model/searchmealbyname/search_meal_by_name_response.dart';
import 'package:food_recipe/feature/domain/repository/themealdb/themealdb_repository.dart';
import 'package:food_recipe/feature/domain/usecase/searchmealbyname/search_meal_by_name.dart';
import 'package:mockito/mockito.dart';

import '../../../../fixture/fixture_reader.dart';

class MockTheMealDbRepository extends Mock implements TheMealDbRepository {}

void main() {
  SearchMealByName searchMealByName;
  MockTheMealDbRepository mockTheMealDbRepository;

  setUp(() {
    mockTheMealDbRepository = MockTheMealDbRepository();
    searchMealByName = SearchMealByName(theMealDbRepository: mockTheMealDbRepository);
  });

  final tName = 'testName';
  final tParamsSearchMealByName = ParamsSearchMealByName(name: tName);

  test(
    'pastikan TheMealDbRepository berhasil menerima respon sukses dan gagal dari endpoint',
    () async {
      // arrange
      final searchMealByNameResponse = SearchMealByNameResponse.fromJson(
        json.decode(
          fixture('search_meal_by_name_response.json'),
        ),
      );
      when(mockTheMealDbRepository.searchMealByName(any)).thenAnswer((_) async => Right(searchMealByNameResponse));

      // act
      final result = await searchMealByName(tParamsSearchMealByName);

      // assert
      expect(result, Right(searchMealByNameResponse));
      verify(mockTheMealDbRepository.searchMealByName(tName));
      verifyNoMoreInteractions(mockTheMealDbRepository);
    },
  );

  test(
    'pastikan nilai props ParamsSearchMealByName adalah [name]',
    () async {
      // assert
      expect(tParamsSearchMealByName.props, [tParamsSearchMealByName.name]);
    },
  );

  test(
    'pastikan output dari fungsi toString adalah '
    'ParamsSearchMealByName{name: testName}',
    () async {
      // assert
      expect(
        tParamsSearchMealByName.toString(),
        'ParamsSearchMealByName{name: ${tParamsSearchMealByName.name}}',
      );
    },
  );
}
