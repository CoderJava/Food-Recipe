import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:food_recipe/feature/data/model/detailmeal/detail_meal_response.dart';

import '../../../../fixture/fixture_reader.dart';

void main() {
  final tDetailMealResponse = DetailMealResponse.fromJson(
    json.decode(
      fixture('detail_meal_response.json'),
    ),
  );

  test(
    'pastikan nilai props adalah [meals]',
    () async {
      // assert
      expect(tDetailMealResponse.props, [tDetailMealResponse.meals]);
    },
  );

  test(
    'pastikan output dari fungsi toString adalah '
    'DetailMealResponse{meals: testMeals}',
    () async {
      // assert
      expect(
        tDetailMealResponse.toString(),
        'DetailMealResponse{meals: ${tDetailMealResponse.meals}}',
      );
    },
  );

  test(
    'pastikan fungsi fromJson bisa mengembalikan objek class model DetailMealResponse',
    () async {
      // arrange
      final jsonMap = json.decode(fixture('detail_meal_response.json'));

      // act
      final actualModel = DetailMealResponse.fromJson(jsonMap);

      // assert
      expect(actualModel, tDetailMealResponse);
    },
  );

  test(
    'pastikan fungsi toJson bisa mengembalikan objek Map',
    () async {
      // arrange
      final model = DetailMealResponse.fromJson(json.decode(fixture('detail_meal_response.json')));

      // act
      final actualMap = json.encode(model.toJson());

      // assert
      expect(actualMap, json.encode(tDetailMealResponse.toJson()));
    },
  );
}
