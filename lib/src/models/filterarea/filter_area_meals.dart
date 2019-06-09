import 'package:json_annotation/json_annotation.dart';
part 'filter_area_meals.g.dart';

@JsonSerializable()
class FilterAreaMeals {
  @JsonKey(name: "meals")
  List<FilterAreaMealsItem> filterAreaMealsItems;

  FilterAreaMeals({this.filterAreaMealsItems});

  @override
  String toString() {
    return 'FilterAreaMeals{filterAreaMealsItems: $filterAreaMealsItems}';
  }

  factory FilterAreaMeals.fromJson(Map<String, dynamic> json) => _$FilterAreaMealsFromJson(json);

  Map<String, dynamic> toJson() => _$FilterAreaMealsToJson(this);

}

@JsonSerializable()
class FilterAreaMealsItem {
  String strMeal;
  String strMealThumb;
  String idMeal;

  FilterAreaMealsItem({this.strMeal, this.strMealThumb, this.idMeal});

  @override
  String toString() {
    return 'FilterAreaMealsItem{strMeal: $strMeal, strMealThumb: $strMealThumb, idMeal: $idMeal}';
  }

  factory FilterAreaMealsItem.fromJson(Map<String, dynamic> json) => _$FilterAreaMealsItemFromJson(json);

  Map<String, dynamic> toJson() => _$FilterAreaMealsItemToJson(this);


}