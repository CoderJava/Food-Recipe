import 'package:equatable/equatable.dart';

abstract class CategoryMealEvent extends Equatable {
  const CategoryMealEvent();
}

class LoadCategoryMealEvent extends CategoryMealEvent {
  @override
  List<Object> get props => [];
}

class LoadDetailCategoryMealEvent extends CategoryMealEvent {
  final String category;

  LoadDetailCategoryMealEvent(this.category);

  @override
  List<Object> get props => [category];

  @override
  String toString() {
    return 'LoadDetailCategoryMealEvent{category: $category}';
  }
}