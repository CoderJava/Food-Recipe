import 'dart:convert';

import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:food_recipe/core/error/failure.dart';
import 'package:food_recipe/core/util/constant_error_message.dart';
import 'package:food_recipe/feature/data/model/searchmealbyname/search_meal_by_name_response.dart';
import 'package:food_recipe/feature/domain/usecase/searchmealbyname/search_meal_by_name.dart';
import 'package:food_recipe/feature/presentation/bloc/searchmeal/bloc.dart';
import 'package:mockito/mockito.dart';

import '../../../fixture/fixture_reader.dart';

class MockSearchMealByName extends Mock implements SearchMealByName {}

void main() {
  SearchMealBloc searchMealBloc;
  MockSearchMealByName mockSearchMealByName;

  setUp(() {
    mockSearchMealByName = MockSearchMealByName();
    searchMealBloc = SearchMealBloc(searchMealByName: mockSearchMealByName);
  });

  tearDown(() {
    searchMealBloc?.close();
  });

  test(
    'pastikan AssertionError akan terpanggil ketika menerima argumen null',
    () async {
      // assert
      expect(() => SearchMealBloc(searchMealByName: null), throwsAssertionError);
    },
  );

  test(
    'pastikan initialState adalah InitialSearchMealState',
    () async {
      // assert
      expect(searchMealBloc.initialState, InitialSearchMealState());
    },
  );

  test(
    'pastikan tidak ada state yang ter-emit ketika bloc sudah ter-close',
    () async {
      // act
      await searchMealBloc.close();

      // assert
      await expectLater(searchMealBloc, emitsInOrder([InitialSearchMealState(), emitsDone]));
    },
  );

  group('load search meal', () {
    final tSearchMealByNameResponse = SearchMealByNameResponse.fromJson(
      json.decode(
        fixture('search_meal_by_name_response.json'),
      ),
    );
    final tName = 'testName';
    final tParamsSearchMealByName = ParamsSearchMealByName(name: tName);

    blocTest(
      'pastikan emit [LoadingSearchMealState, LoadedSearchMealState] ketika terima event '
      'LoadSearchMealEvent dengan proses berhasil',
      build: () async {
        when(mockSearchMealByName(any)).thenAnswer((_) async => Right(tSearchMealByNameResponse));
        return searchMealBloc;
      },
      act: (bloc) {
        return bloc.add(LoadSearchMealEvent(tName));
      },
      expect: [
        LoadingSearchMealState(),
        LoadedSearchMealState(tSearchMealByNameResponse),
      ],
      verify: (_) async {
        verify(mockSearchMealByName(tParamsSearchMealByName));
      },
    );

    blocTest(
      'pastikan emit [LoadingSearchMealState, FailureSearchMealState] ketika terima event '
      'LoadSearchMealEvent dengan proses gagal dari API',
      build: () async {
        when(mockSearchMealByName(any)).thenAnswer((_) async => Left(ServerFailure('testErrorMessage')));
        return searchMealBloc;
      },
      act: (bloc) {
        return bloc.add(LoadSearchMealEvent(tName));
      },
      expect: [
        LoadingSearchMealState(),
        FailureSearchMealState('testErrorMessage'),
      ],
      verify: (_) async {
        verify(mockSearchMealByName(tParamsSearchMealByName));
      },
    );

    blocTest(
      'pastikan emit [LoadingSearchMealState, FailureSearchMealState] ketika terima event '
      'LoadSearchMealEvent dengan kondisi internet tidak terhubung',
      build: () async {
        when(mockSearchMealByName(any)).thenAnswer((_) async => Left(ConnectionFailure()));
        return searchMealBloc;
      },
      act: (bloc) {
        return bloc.add(LoadSearchMealEvent(tName));
      },
      expect: [
        LoadingSearchMealState(),
        FailureSearchMealState(ConstantErrorMessage().connectionError),
      ],
      verify: (_) async {
        verify(mockSearchMealByName(tParamsSearchMealByName));
      },
    );
  });
}
