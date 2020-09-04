import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:food_recipe/feature/data/model/filterbycategory/filter_by_category_response.dart';
import 'package:food_recipe/feature/data/model/mealcategory/meal_category_response.dart';
import 'package:food_recipe/feature/presentation/bloc/categorymeal/bloc.dart';

import '../../../fixture/fixture_reader.dart';

void main() {
  group('InitialCategoryMealState', () {
    final tInitialCategoryMealState = InitialCategoryMealState();

    test(
      'pastikan nilai props adalah []',
      () async {
        // assert
        expect(tInitialCategoryMealState.props, []);
      },
    );

    test(
      'pastikan output dari fungsi toString adalah InitialCategoryMealState',
      () async {
        // assert
        expect(tInitialCategoryMealState.toString(), 'InitialCategoryMealState');
      },
    );
  });

  group('LoadingCategoryMealState', () {
    final tLoadingCategoryMealState = LoadingCategoryMealState();

    test(
      'pastikan nilai props adalah []',
      () async {
        // assert
        expect(tLoadingCategoryMealState.props, []);
      },
    );

    test(
      'pastikan output dari fungsi toString adalah LoadingCategoryMealState',
      () async {
        // assert
        expect(tLoadingCategoryMealState.toString(), 'LoadingCategoryMealState');
      },
    );
  });

  group('LoadingDetailCategoryMealState', () {
    final tLoadingDetailCategoryMealState = LoadingDetailCategoryMealState();

    test(
      'pastikan nilai props adalah []',
      () async {
        // assert
        expect(tLoadingDetailCategoryMealState.props, []);
      },
    );

    test(
      'pastikan output dari fungsi toString adalah LoadingDetailCategoryMealState',
      () async {
        // assert
        expect(tLoadingDetailCategoryMealState.toString(), 'LoadingDetailCategoryMealState');
      },
    );
  });

  group('FailureCategoryMealState', () {
    final tFailureCategoryMealState = FailureCategoryMealState('testErrorMessage');

    test(
      'pastikan nilai props adalah [errorMessage]',
      () async {
        // assert
        expect(tFailureCategoryMealState.props, [tFailureCategoryMealState.errorMessage]);
      },
    );

    test(
      'pastikan output dari fungsi toString adalah '
      'FailureCategoryMealState{errorMessage: testErrorMessage]',
      () async {
        // assert
        expect(
          tFailureCategoryMealState.toString(),
          'FailureCategoryMealState{errorMessage: ${tFailureCategoryMealState.errorMessage}}',
        );
      },
    );
  });

  group('FailureDetailCategoryMealState', () {
    final tFailureDetailCategoryMealState = FailureDetailCategoryMealState('testErrorMessage');

    test(
      'pastikan nilai props adalah [errorMessage]',
      () async {
        // assert
        expect(tFailureDetailCategoryMealState.props, [tFailureDetailCategoryMealState.errorMessage]);
      },
    );

    test(
      'pastikan output dari fungsi toString adalah '
      'FailureDetailCategoryMealState{errorMessage: ${tFailureDetailCategoryMealState.errorMessage}}',
      () async {
        // assert
        expect(
          tFailureDetailCategoryMealState.toString(),
          'FailureDetailCategoryMealState{errorMessage: ${tFailureDetailCategoryMealState.errorMessage}}',
        );
      },
    );
  });

  group('LoadedCategoryMealState', () {
    final tMealCategoryResponse = MealCategoryResponse.fromJson(json.decode(fixture('meal_category_response.json')));
    final tFilterByCategoryResponse = FilterByCategoryResponse.fromJson(
      json.decode(
        fixture('filter_by_category_response.json'),
      ),
    );
    final tLoadedCategoryMealState = LoadedCategoryMealState(
      tMealCategoryResponse,
      tFilterByCategoryResponse,
    );

    test(
      'pastikan nilai props adalah [mealCategoryResponse, filterByCategoryResponse]',
      () async {
        // assert
        expect(
          tLoadedCategoryMealState.props,
          [tLoadedCategoryMealState.mealCategoryResponse, tLoadedCategoryMealState.filterByCategoryResponse],
        );
      },
    );

    test(
      'pastikan output dari fungsi toString adalah '
      'LoadedCategoryMealState{mealCategoryResponse: testMealCategoryResponse, filterByCategoryResponse: testFilterByCategoryResponse}',
      () async {
        // assert
        expect(
          tLoadedCategoryMealState.toString(),
          'LoadedCategoryMealState{mealCategoryResponse: ${tLoadedCategoryMealState.mealCategoryResponse}, '
          'filterByCategoryResponse: ${tLoadedCategoryMealState.filterByCategoryResponse}}',
        );
      },
    );
  });

  group('LoadedDetailCategoryMealState', () {
    final tFilterByCategoryResponse = FilterByCategoryResponse.fromJson(
      json.decode(
        fixture('filter_by_category_response.json'),
      ),
    );
    final tLoadedDetailCategoryMealState = LoadedDetailCategoryMealState(tFilterByCategoryResponse);

    test(
      'pastikan nilai props adalah [filterByCategoryResponse]',
      () async {
        // assert
        expect(tLoadedDetailCategoryMealState.props, [tLoadedDetailCategoryMealState.filterByCategoryResponse]);
      },
    );

    test(
      'pastikan output dari fungsi toString adalah '
      'LoadedDetailCategoryMealState{filterByCategoryResponse: testFilterByCategoryResponse}',
      () async {
        // assert
        expect(
          tLoadedDetailCategoryMealState.toString(),
          'LoadedDetailCategoryMealState{filterByCategoryResponse: ${tLoadedDetailCategoryMealState.filterByCategoryResponse}}',
        );
      },
    );
  });
}
