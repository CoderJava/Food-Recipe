import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:food_recipe/feature/data/model/filterbycategory/filter_by_category_response.dart';

import '../../../../fixture/fixture_reader.dart';

void main() {
  final tFilterByCategoryResponse = FilterByCategoryResponse.fromJson(
    json.decode(
      fixture('filter_by_category_response.json'),
    ),
  );

  test(
    'pastikan nilai props adalah [meals]',
    () async {
      // assert
      expect(tFilterByCategoryResponse.props, [tFilterByCategoryResponse.meals]);
    },
  );

  test(
    'pastikan output dari fungsi toString adalah '
    'FilterByCategoryResponse{meals: testMeals}',
    () async {
      // assert
      expect(
        tFilterByCategoryResponse.toString(),
        'FilterByCategoryResponse{meals: ${tFilterByCategoryResponse.meals}}',
      );
    },
  );

  test(
    'pastikan fungsi fromJson bisa mengembalikan objek class model FilterByCategoryResponse',
    () async {
      // arrange
      final jsonMap = json.decode(fixture('filter_by_category_response.json'));

      // act
      final actualModel = FilterByCategoryResponse.fromJson(jsonMap);

      // assert
      expect(actualModel, tFilterByCategoryResponse);
    },
  );

  test(
    'pastikan fungsi toJson bisa mengembalikan objek Map',
    () async {
      // arrange
      final model = FilterByCategoryResponse.fromJson(
        json.decode(
          fixture('filter_by_category_response.json'),
        ),
      );

      // act
      final map = json.encode(model.toJson());

      // assert
      expect(map, json.encode(tFilterByCategoryResponse.toJson()));
    },
  );
}
