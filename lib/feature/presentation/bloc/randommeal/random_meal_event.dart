import 'package:equatable/equatable.dart';

abstract class RandomMealEvent extends Equatable {
  const RandomMealEvent();
}

class LoadRandomMealEvent extends RandomMealEvent {
  @override
  List<Object> get props => [];
}