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
    'pastikan nilai props adalah [idMeal, strMeal, strCategory, strArea, strInstructions, strMealThumb, strTags, '
    'strYoutube, listIngredients, strSource]',
    () async {
      // assert
      expect(
        tDetailMealResponse.props,
        [
          tDetailMealResponse.idMeal,
          tDetailMealResponse.strMeal,
          tDetailMealResponse.strCategory,
          tDetailMealResponse.strArea,
          tDetailMealResponse.strInstructions,
          tDetailMealResponse.strMealThumb,
          tDetailMealResponse.strTags,
          tDetailMealResponse.strYoutube,
          tDetailMealResponse.listIngredients,
          tDetailMealResponse.strSource,
        ],
      );
    },
  );

  test(
    'pastikan output dari fungsi toString adalah '
    'DetailMealResponse{idMeal: testIdMeal, strMeal: testStrMeal, strCategory: testStrCategory, strArea: testStrArea, '
    'strInstructions: testStrInstructions, strMealThumb: testStrMealThumb, strTags: testStrTags, '
    'strYoutube: testStrYoutube, listIngredients: testListIngredients, strSource: testStrSource}',
    () async {
      // assert
      expect(
        tDetailMealResponse.toString(),
        'DetailMealResponse{idMeal: ${tDetailMealResponse.idMeal}, strMeal: ${tDetailMealResponse.strMeal}, '
        'strCategory: ${tDetailMealResponse.strCategory}, strArea: ${tDetailMealResponse.strArea}, '
        'strInstructions: ${tDetailMealResponse.strInstructions}, strMealThumb: ${tDetailMealResponse.strMealThumb}, '
        'strTags: ${tDetailMealResponse.strTags}, strYoutube: ${tDetailMealResponse.strYoutube}, '
        'listIngredients: ${tDetailMealResponse.listIngredients}, strSource: ${tDetailMealResponse.strSource}}',
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
