import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:food_recipe/feature/data/model/detailmeal/detail_meal_response.dart';
import 'package:food_recipe/feature/presentation/bloc/randommeal/random_meal_state.dart';

import '../../../fixture/fixture_reader.dart';

void main() {
  group('InitialRandomMealState', () {
    final tInitialRandomMealState = InitialRandomMealState();

    test(
      'pastikan nilai props adalah []',
      () async {
        // assert
        expect(tInitialRandomMealState.props, []);
      },
    );

    test(
      'pastikan output dari fungsi toString adalah InitialRandomMealState',
      () async {
        // assert
        expect(tInitialRandomMealState.toString(), 'InitialRandomMealState');
      },
    );
  });

  group('LoadingRandomMealState', () {
    final tLoadingRandomMealState = LoadingRandomMealState();

    test(
      'pastikan nilai props adalah []',
      () async {
        // assert
        expect(tLoadingRandomMealState.props, []);
      },
    );

    test(
      'pastikan output dari fungsi toString adalah LoadingRandomMealState',
      () async {
        // assert
        expect(tLoadingRandomMealState.toString(), 'LoadingRandomMealState');
      },
    );
  });

  group('FailureRandomMealState', () {
    final tFailureRandomMealState = FailureRandomMealState('testErrorMessage');

    test(
      'pastikan nilai props adalah [errorMessage]',
      () async {
        // assert
        expect(tFailureRandomMealState.props, [tFailureRandomMealState.errorMessage]);
      },
    );

    test(
      'pastikan output dari fungsi toString adalah FailureRandomMealState{errorMessage: testErrorMessage}',
      () async {
        // assert
        expect(
          tFailureRandomMealState.toString(),
          'FailureRandomMealState{errorMessage: ${tFailureRandomMealState.errorMessage}}',
        );
      },
    );
  });

  group('LoadedRandomMealState', () {
    final tDetailMealResponse = DetailMealResponse.fromJson(json.decode(fixture('detail_meal_response.json')));
    final tLoadedRandomMealState = LoadedRandomMealState(tDetailMealResponse);

    test(
      'pastikan nilai props adalah [detailMealResponse]',
      () async {
        // assert
        expect(tLoadedRandomMealState.props, [tLoadedRandomMealState.detailMealResponse]);
      },
    );

    test(
      'pastikan output dari fungsi toString adalah '
      'LoadedRandomMealState{detailMealResponse: testDetailMealResponse}',
      () async {
        // assert
        expect(
          tLoadedRandomMealState.toString(),
          'LoadedRandomMealState{detailMealResponse: ${tLoadedRandomMealState.detailMealResponse}}',
        );
      },
    );
  });
}
