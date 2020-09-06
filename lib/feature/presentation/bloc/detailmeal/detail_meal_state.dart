import 'package:equatable/equatable.dart';
import 'package:food_recipe/feature/data/model/detailmeal/detail_meal_response.dart';

abstract class DetailMealState extends Equatable {
  const DetailMealState();

  @override
  List<Object> get props => [];
}

class InitialDetailMealState extends DetailMealState {}

class LoadingDetailMealState extends DetailMealState {}

class FailureDetailMealState extends DetailMealState {}

class LoadedDetailMealState extends DetailMealState {
  final DetailMealResponse detailMealResponse;

  LoadedDetailMealState(this.detailMealResponse);

  @override
  List<Object> get props => [detailMealResponse];

  @override
  String toString() {
    return 'LoadedDetailMealState{detailMealResponse: $detailMealResponse}';
  }
}