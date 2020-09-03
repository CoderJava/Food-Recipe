import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:food_recipe/feature/data/model/searchmealbyname/search_meal_by_name_response.dart';

import '../../../../fixture/fixture_reader.dart';

void main() {
  final tSearchMealByNameResponse = SearchMealByNameResponse.fromJson(
    json.decode(
      fixture('search_meal_by_name_response.json'),
    ),
  );

  test(
    'pastikan nilai props adalah [meals]',
    () async {
      // assert
      expect(tSearchMealByNameResponse.props, [tSearchMealByNameResponse.meals]);
    },
  );

  test(
    'pastikan output dari fungsi toString adalah '
    'SearchMealByNameResponse{meals: testMeals}',
    () async {
      // assert
      expect(
        tSearchMealByNameResponse.toString(),
        'SearchMealByNameResponse{meals: ${tSearchMealByNameResponse.meals}}',
      );
    },
  );

  test(
    'pastikan fungsi fromJson bisa mengembalikan objek class model SearchMealByNameResponse',
    () async {
      // arrange
      final jsonMap = json.decode(fixture('search_meal_by_name_response.json'));

      // act
      final actualModel = SearchMealByNameResponse.fromJson(jsonMap);

      // assert
      expect(actualModel, tSearchMealByNameResponse);
    },
  );

  test(
    'pastikan fungsi toJson bisa mengembalikan objek Map',
    () async {
      // arrange
      final model = SearchMealByNameResponse.fromJson(json.decode(fixture('search_meal_by_name_response.json')));

      // act
      final actualMap = json.encode(model.toJson());

      // assert
      expect(actualMap, json.encode(tSearchMealByNameResponse.toJson()));
    },
  );
}
