import 'dart:convert';

import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:food_recipe/core/error/failure.dart';
import 'package:food_recipe/core/usecase/usecase.dart';
import 'package:food_recipe/core/util/constant_error_message.dart';
import 'package:food_recipe/feature/data/model/filterbycategory/filter_by_category_response.dart';
import 'package:food_recipe/feature/data/model/mealcategory/meal_category_response.dart';
import 'package:food_recipe/feature/domain/usecase/getcategorymeal/get_category_meal.dart';
import 'package:food_recipe/feature/domain/usecase/getfilterbycategory/get_filter_by_category.dart';
import 'package:food_recipe/feature/presentation/bloc/categorymeal/bloc.dart';
import 'package:mockito/mockito.dart';

import '../../../fixture/fixture_reader.dart';

class MockGetCategoryMeal extends Mock implements GetCategoryMeal {}

class MockGetFilterByCategory extends Mock implements GetFilterByCategory {}

void main() {
  CategoryMealBloc categoryMealBloc;
  MockGetCategoryMeal mockGetCategoryMeal;
  MockGetFilterByCategory mockGetFilterByCategory;

  setUp(() {
    mockGetCategoryMeal = MockGetCategoryMeal();
    mockGetFilterByCategory = MockGetFilterByCategory();
    categoryMealBloc = CategoryMealBloc(
      getCategoryMeal: mockGetCategoryMeal,
      getFilterByCategory: mockGetFilterByCategory,
    );
  });

  tearDown(() {
    categoryMealBloc?.close();
  });

  test(
    'pastikan initialState adalah InitialCategoryMealState',
    () async {
      // assert
      expect(categoryMealBloc.initialState, InitialCategoryMealState());
    },
  );

  test(
    'pastikan AssertionError akan terpanggil ketika menerima argumen null',
    () async {
      // assert
      expect(
        () => CategoryMealBloc(
          getCategoryMeal: null,
          getFilterByCategory: mockGetFilterByCategory,
        ),
        throwsAssertionError,
      );
      expect(
        () => CategoryMealBloc(
          getCategoryMeal: mockGetCategoryMeal,
          getFilterByCategory: null,
        ),
        throwsAssertionError,
      );
    },
  );

  test(
    'pastikan tidak ada state yang ter-emit ketika bloc sudah ter-close',
    () async {
      // act
      await categoryMealBloc.close();

      // assert
      await expectLater(categoryMealBloc, emitsInOrder([InitialCategoryMealState(), emitsDone]));
    },
  );

  group('load category meal', () {
    final tMealCategoryResponse = MealCategoryResponse.fromJson(json.decode(fixture('meal_category_response.json')));
    final tFilterByCategoryResponse = FilterByCategoryResponse.fromJson(
      json.decode(
        fixture('filter_by_category_response.json'),
      ),
    );
    final tNoParams = NoParams();
    final tParamsGetFilterByCategory = ParamsGetFilterByCategory(category: 'testStrCategory');

    blocTest(
      'pastikan emit [LoadingCategoryMealState, LoadedDetailCategoryMealState] ketika terima event '
      'LoadCategoryMealEvent dengan proses berhasil',
      build: () async {
        when(mockGetCategoryMeal(any)).thenAnswer((_) async => Right(tMealCategoryResponse));
        when(mockGetFilterByCategory(any)).thenAnswer((_) async => Right(tFilterByCategoryResponse));
        return categoryMealBloc;
      },
      act: (bloc) {
        return bloc.add(LoadCategoryMealEvent());
      },
      expect: [
        LoadingCategoryMealState(),
        LoadedCategoryMealState(tMealCategoryResponse, tFilterByCategoryResponse),
      ],
      verify: (_) async {
        verify(mockGetCategoryMeal(tNoParams));
        verify(mockGetFilterByCategory(tParamsGetFilterByCategory));
      },
    );

    blocTest(
      'pastikan emit [LoadingCategoryMealState, FailureCategoryMealState] ketika terima event '
      'LoadCategoryMealEvent dengan proses gagal dari endpoint getCategoryMeal',
      build: () async {
        when(mockGetCategoryMeal(any)).thenAnswer((_) async => Left(ServerFailure('testErrorMessage')));
        return categoryMealBloc;
      },
      act: (bloc) {
        return bloc.add(LoadCategoryMealEvent());
      },
      expect: [
        LoadingCategoryMealState(),
        FailureCategoryMealState('testErrorMessage'),
      ],
      verify: (_) async {
        verify(mockGetCategoryMeal(tNoParams));
      },
    );

    blocTest(
      'pastikan emit [LoadingCategoryMealState, FailureCategoryMealState] ketika terima event '
      'LoadCategoryMealEvent dengan kondisi internet tidak terhubung dari endpoint getCategoryMeal',
      build: () async {
        when(mockGetCategoryMeal(any)).thenAnswer((_) async => Left(ConnectionFailure()));
        return categoryMealBloc;
      },
      act: (bloc) {
        return bloc.add(LoadCategoryMealEvent());
      },
      expect: [
        LoadingCategoryMealState(),
        FailureCategoryMealState(ConstantErrorMessage().connectionError),
      ],
      verify: (_) async {
        verify(mockGetCategoryMeal(tNoParams));
      },
    );

    blocTest(
      'pastikan emit [LoadingCategoryMealState, FailureCategoryMealState] ketika terima event '
      'LoadCategoryMealEvent dengan proses gagal dari endpoint getFilterByCategory',
      build: () async {
        when(mockGetCategoryMeal(any)).thenAnswer((_) async => Right(tMealCategoryResponse));
        when(mockGetFilterByCategory(any)).thenAnswer((_) async => Left(ServerFailure('testErrorMessage')));
        return categoryMealBloc;
      },
      act: (bloc) {
        return bloc.add(LoadCategoryMealEvent());
      },
      expect: [
        LoadingCategoryMealState(),
        FailureCategoryMealState('testErrorMessage'),
      ],
      verify: (_) async {
        verify(mockGetCategoryMeal(tNoParams));
        verify(mockGetFilterByCategory(tParamsGetFilterByCategory));
      },
    );

    blocTest(
      'pastikan emit [LoadingCategoryMealState, FailureCategoryMealState] ketika terima event '
      'LoadCategoryMealEvent dengan kondisi internet tidak terhubung dari endpoint getFilterByCategory',
      build: () async {
        when(mockGetCategoryMeal(any)).thenAnswer((_) async => Right(tMealCategoryResponse));
        when(mockGetFilterByCategory(any)).thenAnswer((_) async => Left(ConnectionFailure()));
        return categoryMealBloc;
      },
      act: (bloc) {
        return bloc.add(LoadCategoryMealEvent());
      },
      expect: [
        LoadingCategoryMealState(),
        FailureCategoryMealState(ConstantErrorMessage().connectionError),
      ],
      verify: (_) async {
        verify(mockGetCategoryMeal(tNoParams));
        verify(mockGetFilterByCategory(tParamsGetFilterByCategory));
      },
    );
  });

  group('load detail category meal', () {
    final tFilterByCategoryResponse = FilterByCategoryResponse.fromJson(
      json.decode(
        fixture('filter_by_category_response.json'),
      ),
    );
    final tCategory = 'testStrCategory';
    final tParamsGetFilterByCategory = ParamsGetFilterByCategory(category: tCategory);

    blocTest(
      'pastikan emit [LoadingDetailCategoryMealState, LoadedDetailCategoryMealState] ketika terima event '
      'LoadDetailCategoryMealEvent dengan proses berhasil',
      build: () async {
        when(mockGetFilterByCategory(any)).thenAnswer((_) async => Right(tFilterByCategoryResponse));
        return categoryMealBloc;
      },
      act: (bloc) {
        return bloc.add(LoadDetailCategoryMealEvent(tCategory));
      },
      expect: [
        LoadingDetailCategoryMealState(),
        LoadedDetailCategoryMealState(tFilterByCategoryResponse),
      ],
      verify: (_) async {
        verify(mockGetFilterByCategory(tParamsGetFilterByCategory));
      },
    );

    blocTest(
      'pastikan emit [LoadingDetailCategoryMealState, FailureDetailCategoryMealState] ketika terima event '
      'LoadDetailCategoryMealEvent dengan proses gagal dari API',
      build: () async {
        when(mockGetFilterByCategory(any)).thenAnswer((_) async => Left(ServerFailure('testErrorMessage')));
        return categoryMealBloc;
      },
      act: (bloc) {
        return bloc.add(LoadDetailCategoryMealEvent(tCategory));
      },
      expect: [
        LoadingDetailCategoryMealState(),
        FailureDetailCategoryMealState('testErrorMessage'),
      ],
      verify: (_) async {
        verify(mockGetFilterByCategory(tParamsGetFilterByCategory));
      },
    );

    blocTest(
      'pastikan emit [LoadingDetailCategoryMealState, FailureDetailCategoryMealState] ketika terima event '
      'LoadDetailCategoryMealEvent dengan kondisi internet tidak terhubung',
      build: () async {
        when(mockGetFilterByCategory(any)).thenAnswer((_) async => Left(ConnectionFailure()));
        return categoryMealBloc;
      },
      act: (bloc) {
        return bloc.add(LoadDetailCategoryMealEvent(tCategory));
      },
      expect: [
        LoadingDetailCategoryMealState(),
        FailureDetailCategoryMealState(ConstantErrorMessage().connectionError),
      ],
      verify: (_) async {
        verify(mockGetFilterByCategory(tParamsGetFilterByCategory));
      },
    );
  });
}
