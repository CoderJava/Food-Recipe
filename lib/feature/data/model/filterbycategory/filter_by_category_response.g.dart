// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'filter_by_category_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

FilterByCategoryResponse _$FilterByCategoryResponseFromJson(
    Map<String, dynamic> json) {
  return FilterByCategoryResponse(
    meals: (json['meals'] as List)
        ?.map((e) => e == null
            ? null
            : ItemFilterByCategory.fromJson(e as Map<String, dynamic>))
        ?.toList(),
  );
}

Map<String, dynamic> _$FilterByCategoryResponseToJson(
        FilterByCategoryResponse instance) =>
    <String, dynamic>{
      'meals': instance.meals,
    };

ItemFilterByCategory _$ItemFilterByCategoryFromJson(Map<String, dynamic> json) {
  return ItemFilterByCategory(
    strMeal: json['strMeal'] as String,
    strMealThumb: json['strMealThumb'] as String,
    idMeal: json['idMeal'] as String,
  );
}

Map<String, dynamic> _$ItemFilterByCategoryToJson(
        ItemFilterByCategory instance) =>
    <String, dynamic>{
      'strMeal': instance.strMeal,
      'strMealThumb': instance.strMealThumb,
      'idMeal': instance.idMeal,
    };
