import 'package:json_annotation/json_annotation.dart';
part 'filter_categories.g.dart';

@JsonSerializable()
class FilterCategories {
  @JsonKey(name: "meals")
  List<FilterCategoryItem> filterCategoryItems;

  FilterCategories({this.filterCategoryItems});

  @override
  String toString() {
    return 'FilterCategories{filterCategoryItems: $filterCategoryItems}';
  }

  factory FilterCategories.fromJson(Map<String, dynamic> json) => _$FilterCategoriesFromJson(json);

  Map<String, dynamic> toJson() => _$FilterCategoriesToJson(this);

}

@JsonSerializable()
class FilterCategoryItem {
  String strMeal;
  String strMealThumb;
  String idMeal;

  FilterCategoryItem({this.strMeal, this.strMealThumb, this.idMeal});

  @override
  String toString() {
    return 'FilterCategoryItem{strMeal: $strMeal, strMealThumb: $strMealThumb, idMeal: $idMeal}';
  }

  factory FilterCategoryItem.fromJson(Map<String, dynamic> json) => _$FilterCategoryItemFromJson(json);

  Map<String, dynamic> toJson() => _$FilterCategoryItemToJson(this);

}