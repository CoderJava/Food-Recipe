import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:meta/meta.dart';

part 'detail_meal_response.g.dart';

@JsonSerializable()
class DetailMealResponse extends Equatable {
  @JsonKey(name: 'idMeal')
  final String idMeal;
  @JsonKey(name: 'strMeal')
  final String strMeal;
  @JsonKey(name: 'strCategory')
  final String strCategory;
  @JsonKey(name: 'strArea')
  final String strArea;
  @JsonKey(name: 'strInstructions')
  final String strInstructions;
  @JsonKey(name: 'strMealThumb')
  final String strMealThumb;
  @JsonKey(name: 'strTags')
  final String strTags;
  @JsonKey(name: 'strYoutube')
  final String strYoutube;
  final List<String> listIngredients;
  @JsonKey(name: 'strSource')
  final String strSource;

  DetailMealResponse({
    @required this.idMeal,
    @required this.strMeal,
    @required this.strCategory,
    @required this.strArea,
    @required this.strInstructions,
    @required this.strMealThumb,
    @required this.strTags,
    @required this.strYoutube,
    @required this.listIngredients,
    @required this.strSource,
  });

  factory DetailMealResponse.fromJson(Map<String, dynamic> json) => _$DetailMealResponseFromJson(json);

  Map<String, dynamic> toJson() => _$DetailMealResponseToJson(this);

  @override
  List<Object> get props => [
        idMeal,
        strMeal,
        strCategory,
        strArea,
        strInstructions,
        strMealThumb,
        strTags,
        strYoutube,
        listIngredients,
        strSource,
      ];

  @override
  String toString() {
    return 'DetailMealResponse{idMeal: $idMeal, strMeal: $strMeal, strCategory: $strCategory, strArea: $strArea, '
        'strInstructions: $strInstructions, strMealThumb: $strMealThumb, strTags: $strTags, strYoutube: $strYoutube, '
        'listIngredients: $listIngredients, strSource: $strSource}';
  }
}
