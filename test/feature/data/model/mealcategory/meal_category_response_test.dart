import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:food_recipe/feature/data/model/mealcategory/meal_category_response.dart';

import '../../../../fixture/fixture_reader.dart';

void main() {
  final tMealCategoryResponse = MealCategoryResponse.fromJson(
    json.decode(
      fixture('meal_category_response.json'),
    ),
  );

  test(
    'pastikan nilai props adalah '
    '[categories]',
    () async {
      // assert
      expect(tMealCategoryResponse.props, [tMealCategoryResponse.categories]);
    },
  );

  test(
    'pastikan output dari fungsi toString adalah '
    'MealCategoryResponse{categories: testCategories}',
    () async {
      // assert
      expect(
        tMealCategoryResponse.toString(),
        'MealCategoryResponse{categories: ${tMealCategoryResponse.categories}}',
      );
    },
  );

  test(
    'pastikan fungsi fromJson bisa mengembalikan objek class model MealCategoryResponse',
    () async {
      // arrange
      final jsonMap = json.decode(fixture('meal_category_response.json'));

      // act
      final actualModel = MealCategoryResponse.fromJson(jsonMap);

      // assert
      expect(actualModel, tMealCategoryResponse);
    },
  );

  test(
    'pastikan fungsi toJson bisa mengembalikan objek Map',
    () async {
      // arrange
      final model = MealCategoryResponse.fromJson(json.decode(fixture('meal_category_response.json')));

      // act
      final actualMap = json.encode(model.toJson());

      // assert
      expect(actualMap, json.encode(tMealCategoryResponse.toJson()));
    },
  );
}
