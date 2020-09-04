import 'package:equatable/equatable.dart';

abstract class SearchMealEvent extends Equatable {
  const SearchMealEvent();
}

class LoadSearchMealEvent extends SearchMealEvent {
  final String name;

  LoadSearchMealEvent(this.name);

  @override
  List<Object> get props => [name];

  @override
  String toString() {
    return 'LoadSearchMealEvent{name: $name}';
  }
}