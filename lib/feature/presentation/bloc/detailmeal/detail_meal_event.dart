import 'package:equatable/equatable.dart';

abstract class DetailMealEvent extends Equatable {
  const DetailMealEvent();
}

class LoadDetailMealEvent extends DetailMealEvent {
  final String idMeal;

  LoadDetailMealEvent(this.idMeal);

  @override
  List<Object> get props => [idMeal];

  @override
  String toString() {
    return 'LoadDetailMealEvent{idMeal: $idMeal}';
  }
}