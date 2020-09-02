import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:meta/meta.dart';

part 'meal_category_response.g.dart';

@JsonSerializable()
class MealCategoryResponse extends Equatable {
  @JsonKey(name: 'categories')
  final List<ItemMealCategory> categories;

  MealCategoryResponse({@required this.categories});

  factory MealCategoryResponse.fromJson(Map<String, dynamic> json) => _$MealCategoryResponseFromJson(json);

  Map<String, dynamic> toJson() => _$MealCategoryResponseToJson(this);

  @override
  List<Object> get props => [categories];

  @override
  String toString() {
    return 'MealCategoryResponse{categories: $categories}';
  }
}

@JsonSerializable()
class ItemMealCategory extends Equatable {
  @JsonKey(name: 'idCategory')
  final String idCategory;
  @JsonKey(name: 'strCategory')
  final String strCategory;
  @JsonKey(name: 'strCategoryThumb')
  final String strCategoryThumb;

  ItemMealCategory({
    @required this.idCategory,
    @required this.strCategory,
    @required this.strCategoryThumb,
  });

  factory ItemMealCategory.fromJson(Map<String, dynamic> json) => _$ItemMealCategoryFromJson(json);

  Map<String, dynamic> toJson() => _$ItemMealCategoryToJson(this);

  @override
  List<Object> get props => [idCategory, strCategory, strCategoryThumb];

  @override
  String toString() {
    return 'ItemMealCategory{idCategory: $idCategory, strCategory: $strCategory, strCategoryThumb: $strCategoryThumb}';
  }
}
