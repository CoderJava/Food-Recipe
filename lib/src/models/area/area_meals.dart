import 'package:json_annotation/json_annotation.dart';
part 'area_meals.g.dart';

@JsonSerializable()
class AreaMeals {
  @JsonKey(name: "meals")
  List<AreaMealsItem> areaMealsItems;

  AreaMeals({this.areaMealsItems});

  @override
  String toString() {
    return 'AreaMeals{areaMealsItems: $areaMealsItems}';
  }

  factory AreaMeals.fromJson(Map<String, dynamic> json) => _$AreaMealsFromJson(json);

  Map<String, dynamic> toJson() => _$AreaMealsToJson(this);

}

@JsonSerializable()
class AreaMealsItem {
  String strArea;

  AreaMealsItem({this.strArea});

  @override
  String toString() {
    return 'AreaMealsItem{strArea: $strArea}';
  }

  factory AreaMealsItem.fromJson(Map<String, dynamic> json) => _$AreaMealsItemFromJson(json);

  Map<String, dynamic> toJson() => _$AreaMealsItemToJson(this);

}