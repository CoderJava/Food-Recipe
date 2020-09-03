import 'dart:convert';

import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:food_recipe/feature/data/model/filterbycategory/filter_by_category_response.dart';
import 'package:food_recipe/feature/domain/repository/themealdb/themealdb_repository.dart';
import 'package:food_recipe/feature/domain/usecase/getfilterbycategory/get_filter_by_category.dart';
import 'package:mockito/mockito.dart';

import '../../../../fixture/fixture_reader.dart';

class MockTheMealDbRepository extends Mock implements TheMealDbRepository {}

void main() {
  GetFilterByCategory getFilterByCategory;
  MockTheMealDbRepository mockTheMealDbRepository;

  setUp(() {
    mockTheMealDbRepository = MockTheMealDbRepository();
    getFilterByCategory = GetFilterByCategory(theMealDbRepository: mockTheMealDbRepository);
  });

  final tCategory = 'testCategory';
  final tParamsGetFilterByCategory = ParamsGetFilterByCategory(category: tCategory);

  test(
    'pastikan TheMealDbRepository berhasil menerima respon sukses dan gagal dari endpoint getFilterByCategory',
    () async {
      // arrange
      final tFilterByCategoryResponse = FilterByCategoryResponse.fromJson(
        json.decode(
          fixture('filter_by_category_response.json'),
        ),
      );
      when(mockTheMealDbRepository.getFilterByCategory(any)).thenAnswer((_) async => Right(tFilterByCategoryResponse));

      // act
      final result = await getFilterByCategory(tParamsGetFilterByCategory);

      // assert
      expect(result, Right(tFilterByCategoryResponse));
      verify(mockTheMealDbRepository.getFilterByCategory(tCategory));
      verifyNoMoreInteractions(mockTheMealDbRepository);
    },
  );

  test(
    'pastikan nilai props ParamsGetFilterByCategory adalah [category]',
    () async {
      // assert
      expect(tParamsGetFilterByCategory.props, [tParamsGetFilterByCategory.category]);
    },
  );

  test(
    'pastikan output dari fungsi toString ParamsGetFilterByCategory adalah '
    'ParamsGetFilterByCategory{category: testCategory}',
    () async {
      // assert
      expect(
        tParamsGetFilterByCategory.toString(),
        'ParamsGetFilterByCategory{category: ${tParamsGetFilterByCategory.category}}',
      );
    },
  );
}
