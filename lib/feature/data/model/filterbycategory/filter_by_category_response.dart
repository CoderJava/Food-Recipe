import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:meta/meta.dart';

part 'filter_by_category_response.g.dart';

@JsonSerializable()
class FilterByCategoryResponse extends Equatable {
  @JsonKey(name: 'meals')
  final List<ItemFilterByCategory> meals;

  FilterByCategoryResponse({@required this.meals});

  factory FilterByCategoryResponse.fromJson(Map<String, dynamic> json) => _$FilterByCategoryResponseFromJson(json);

  Map<String, dynamic> toJson() => _$FilterByCategoryResponseToJson(this);

  @override
  List<Object> get props => [meals];

  @override
  String toString() {
    return 'FilterByCategoryResponse{meals: $meals}';
  }
}

@JsonSerializable()
class ItemFilterByCategory extends Equatable {
  @JsonKey(name: 'strMeal')
  final String strMeal;
  @JsonKey(name: 'strMealThumb')
  final String strMealThumb;
  @JsonKey(name: 'idMeal')
  final String idMeal;

  ItemFilterByCategory({
    @required this.strMeal,
    @required this.strMealThumb,
    @required this.idMeal,
  });

  factory ItemFilterByCategory.fromJson(Map<String, dynamic> json) => _$ItemFilterByCategoryFromJson(json);

  Map<String, dynamic> toJson() => _$ItemFilterByCategoryToJson(this);

  @override
  List<Object> get props => [strMeal, strMealThumb, idMeal];

  @override
  String toString() {
    return 'ItemFilterByCategory{strMeal: $strMeal, strMealThumb: $strMealThumb, idMeal: $idMeal}';
  }
}
