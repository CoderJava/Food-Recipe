// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'search_meal_by_name_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SearchMealByNameResponse _$SearchMealByNameResponseFromJson(
    Map<String, dynamic> json) {
  return SearchMealByNameResponse(
    meals: (json['meals'] as List)
        ?.map((e) => e == null
            ? null
            : ItemSearchMeal.fromJson(e as Map<String, dynamic>))
        ?.toList(),
  );
}

Map<String, dynamic> _$SearchMealByNameResponseToJson(
        SearchMealByNameResponse instance) =>
    <String, dynamic>{
      'meals': instance.meals,
    };

ItemSearchMeal _$ItemSearchMealFromJson(Map<String, dynamic> json) {
  return ItemSearchMeal(
    idMeal: json['idMeal'] as String,
    strMeal: json['strMeal'] as String,
    strMealThumb: json['strMealThumb'] as String,
  );
}

Map<String, dynamic> _$ItemSearchMealToJson(ItemSearchMeal instance) =>
    <String, dynamic>{
      'idMeal': instance.idMeal,
      'strMeal': instance.strMeal,
      'strMealThumb': instance.strMealThumb,
    };
