import 'dart:convert';

import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:food_recipe/core/error/failure.dart';
import 'package:food_recipe/core/usecase/usecase.dart';
import 'package:food_recipe/core/util/constant_error_message.dart';
import 'package:food_recipe/feature/data/model/detailmeal/detail_meal_response.dart';
import 'package:food_recipe/feature/domain/usecase/getrandommeal/get_random_meal.dart';
import 'package:food_recipe/feature/presentation/bloc/randommeal/random_meal_bloc.dart';
import 'package:food_recipe/feature/presentation/bloc/randommeal/random_meal_event.dart';
import 'package:food_recipe/feature/presentation/bloc/randommeal/random_meal_state.dart';
import 'package:mockito/mockito.dart';

import '../../../fixture/fixture_reader.dart';

class MockGetRandomMeal extends Mock implements GetRandomMeal {}

void main() {
  RandomMealBloc randomMealBloc;
  MockGetRandomMeal mockGetRandomMeal;

  setUp(() {
    mockGetRandomMeal = MockGetRandomMeal();
    randomMealBloc = RandomMealBloc(getRandomMeal: mockGetRandomMeal);
  });

  tearDown(() {
    randomMealBloc?.close();
  });

  test(
    'pastikan AssertionError akan terpanggil ketika menerima argumen null',
    () async {
      // assert
      expect(() => RandomMealBloc(getRandomMeal: null), throwsAssertionError);
    },
  );

  test(
    'pastikan initialState adalah InitialRandomMealState',
    () async {
      // assert
      expect(randomMealBloc.initialState, InitialRandomMealState());
    },
  );

  test(
    'pastikan tidak ada state yang ter-emit ketika bloc sudah ter-close',
    () async {
      // act
      await randomMealBloc.close();

      // assert
      await expectLater(randomMealBloc, emitsInOrder([InitialRandomMealState(), emitsDone]));
    },
  );

  group('load random meal', () {
    final tDetailMealResponse = DetailMealResponse.fromJson(
      json.decode(
        fixture('detail_meal_response.json'),
      ),
    );
    final tNoParams = NoParams();

    blocTest(
      'pastikan emit [LoadingRandomMealState, LoadedRandomMealState] ketika terima event '
      'LoadRandomMealEvent dengan proses berhasil',
      build: () async {
        when(mockGetRandomMeal(any)).thenAnswer((_) async => Right(tDetailMealResponse));
        return randomMealBloc;
      },
      act: (bloc) {
        return bloc.add(LoadRandomMealEvent());
      },
      expect: [
        LoadingRandomMealState(),
        LoadedRandomMealState(tDetailMealResponse),
      ],
      verify: (_) async {
        verify(mockGetRandomMeal(tNoParams));
      },
    );

    blocTest(
      'pastikan emit [LoadingRandomMealState, FailureRandomMealState] ketika terima event '
      'LoadRandomMealEvent dengan proses gagal dari API',
      build: () async {
        when(mockGetRandomMeal(any)).thenAnswer((_) async => Left(ServerFailure('testErrorMessage')));
        return randomMealBloc;
      },
      act: (bloc) {
        return bloc.add(LoadRandomMealEvent());
      },
      expect: [
        LoadingRandomMealState(),
        FailureRandomMealState('testErrorMessage'),
      ],
      verify: (_) async {
        verify(mockGetRandomMeal(tNoParams));
      },
    );

    blocTest(
      'pastikan emit [LoadingRandomMealState, FailureRandomMealState] ketika terima event '
      'LoadRandomMealEvent dengan kondisi internet tidak terhubung',
      build: () async {
        when(mockGetRandomMeal(any)).thenAnswer((_) async => Left(ConnectionFailure()));
        return randomMealBloc;
      },
      act: (bloc) {
        return bloc.add(LoadRandomMealEvent());
      },
      expect: [
        LoadingRandomMealState(),
        FailureRandomMealState(ConstantErrorMessage().connectionError),
      ],
      verify: (_) async {
        verify(mockGetRandomMeal(tNoParams));
      },
    );
  });
}
