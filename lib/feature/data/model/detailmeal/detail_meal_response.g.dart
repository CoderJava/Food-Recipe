// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'detail_meal_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

DetailMealResponse _$DetailMealResponseFromJson(Map<String, dynamic> json) {
  return DetailMealResponse(
    meals: (json['meals'] as List)
        ?.map((e) => e == null
            ? null
            : ItemDetailMeal.fromJson(e as Map<String, dynamic>))
        ?.toList(),
  );
}

Map<String, dynamic> _$DetailMealResponseToJson(DetailMealResponse instance) =>
    <String, dynamic>{
      'meals': instance.meals,
    };

ItemDetailMeal _$ItemDetailMealFromJson(Map<String, dynamic> json) {
  return ItemDetailMeal(
    idMeal: json['idMeal'] as String,
    strMeal: json['strMeal'] as String,
    strCategory: json['strCategory'] as String,
    strArea: json['strArea'] as String,
    strInstructions: json['strInstructions'] as String,
    strMealThumb: json['strMealThumb'] as String,
    strTags: json['strTags'] as String,
    strYoutube: json['strYoutube'] as String,
    listIngredients:
        (json['listIngredients'] as List)?.map((e) => e as String)?.toList(),
    strSource: json['strSource'] as String,
  );
}

Map<String, dynamic> _$ItemDetailMealToJson(ItemDetailMeal instance) =>
    <String, dynamic>{
      'idMeal': instance.idMeal,
      'strMeal': instance.strMeal,
      'strCategory': instance.strCategory,
      'strArea': instance.strArea,
      'strInstructions': instance.strInstructions,
      'strMealThumb': instance.strMealThumb,
      'strTags': instance.strTags,
      'strYoutube': instance.strYoutube,
      'listIngredients': instance.listIngredients,
      'strSource': instance.strSource,
    };
