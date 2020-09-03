import 'package:equatable/equatable.dart';
import 'package:food_recipe/feature/data/model/detailmeal/detail_meal_response.dart';

abstract class RandomMealState extends Equatable {
  const RandomMealState();

  @override
  List<Object> get props => [];
}

class InitialRandomMealState extends RandomMealState {}

class LoadingRandomMealState extends RandomMealState {}

class FailureRandomMealState extends RandomMealState {
  final String errorMessage;

  FailureRandomMealState(this.errorMessage);

  @override
  List<Object> get props => [errorMessage];

  @override
  String toString() {
    return 'FailureRandomMealState{errorMessage: $errorMessage}';
  }
}

class LoadedRandomMealState extends RandomMealState {
  final DetailMealResponse detailMealResponse;

  LoadedRandomMealState(this.detailMealResponse);

  @override
  List<Object> get props => [detailMealResponse];

  @override
  String toString() {
    return 'LoadedRandomMealState{detailMealResponse: $detailMealResponse}';
  }
}