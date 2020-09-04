import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:food_recipe/feature/data/model/searchmealbyname/search_meal_by_name_response.dart';
import 'package:food_recipe/feature/presentation/bloc/searchmeal/bloc.dart';

import '../../../fixture/fixture_reader.dart';

void main() {
  group('InitialSearchMealState', () {
    final tInitialSearchMealState = InitialSearchMealState();

    test(
      'pastikan nilai props adalah []',
      () async {
        // assert
        expect(tInitialSearchMealState.props, []);
      },
    );

    test(
      'pastikan output dari fungsi toString adalah InitialSearchMealState',
      () async {
        // assert
        expect(tInitialSearchMealState.toString(), 'InitialSearchMealState');
      },
    );
  });

  group('LoadingSearchMealState', () {
    final tLoadingSearchMealState = LoadingSearchMealState();

    test(
      'pastikan nilai props adalah []',
      () async {
        // assert
        expect(tLoadingSearchMealState.props, []);
      },
    );

    test(
      'pastikan output dari fungsi toString adalah LoadingSearchMealState',
      () async {
        // assert
        expect(tLoadingSearchMealState.toString(), 'LoadingSearchMealState');
      },
    );
  });

  group('FailureSearchMealState', () {
    final tFailureSearchMealState = FailureSearchMealState('testErrorMessage');

    test(
      'pastikan nilai props adalah [errorMessage]',
      () async {
        // assert
        expect(tFailureSearchMealState.props, [tFailureSearchMealState.errorMessage]);
      },
    );

    test(
      'pastikan output dari fungsi toString adalah '
      'FailureSearchMealState{errorMessage: testErrorMessage}',
      () async {
        // assert
        expect(
          tFailureSearchMealState.toString(),
          'FailureSearchMealState{errorMessage: ${tFailureSearchMealState.errorMessage}}',
        );
      },
    );
  });

  group('LoadedSearchMealState', () {
    final tSearchMealByNameResponse = SearchMealByNameResponse.fromJson(
      json.decode(
        fixture('search_meal_by_name_response.json'),
      ),
    );
    final tLoadedSearchMealState = LoadedSearchMealState(tSearchMealByNameResponse);

    test(
      'pastikan nilai props adalah [searchMealByNameResponse]',
      () async {
        // assert
        expect(tLoadedSearchMealState.props, [tLoadedSearchMealState.searchMealByNameResponse]);
      },
    );

    test(
      'pastikan output dari fungsi toString adalah '
      'LoadedSearchMealState{searchMealByNameResponse: ${tLoadedSearchMealState.searchMealByNameResponse}}',
      () async {
        // assert
        expect(
          tLoadedSearchMealState.toString(),
          'LoadedSearchMealState{searchMealByNameResponse: ${tLoadedSearchMealState.searchMealByNameResponse}}',
        );
      },
    );
  });
}
