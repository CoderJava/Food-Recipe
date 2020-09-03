import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:meta/meta.dart';

part 'search_meal_by_name_response.g.dart';

@JsonSerializable()
class SearchMealByNameResponse extends Equatable {
  @JsonKey(name: 'meals')
  final List<ItemSearchMeal> meals;

  SearchMealByNameResponse({@required this.meals});

  factory SearchMealByNameResponse.fromJson(Map<String, dynamic> json) => _$SearchMealByNameResponseFromJson(json);

  Map<String, dynamic> toJson() => _$SearchMealByNameResponseToJson(this);

  @override
  List<Object> get props => [meals];

  @override
  String toString() {
    return 'SearchMealByNameResponse{meals: $meals}';
  }
}

@JsonSerializable()
class ItemSearchMeal extends Equatable {
  @JsonKey(name: 'idMeal')
  final String idMeal;
  @JsonKey(name: 'strMeal')
  final String strMeal;
  @JsonKey(name: 'strMealThumb')
  final String strMealThumb;

  ItemSearchMeal({
    @required this.idMeal,
    @required this.strMeal,
    @required this.strMealThumb,
  });

  factory ItemSearchMeal.fromJson(Map<String, dynamic> json) => _$ItemSearchMealFromJson(json);

  Map<String, dynamic> toJson() => _$ItemSearchMealToJson(this);

  @override
  List<Object> get props => [idMeal, strMeal, strMealThumb];

  @override
  String toString() {
    return 'ItemSearchMeal{idMeal: $idMeal, strMeal: $strMeal, strMealThumb: $strMealThumb}';
  }
}
