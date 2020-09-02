// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'meal_category_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MealCategoryResponse _$MealCategoryResponseFromJson(Map<String, dynamic> json) {
  return MealCategoryResponse(
    categories: (json['categories'] as List)
        ?.map((e) => e == null
            ? null
            : ItemMealCategory.fromJson(e as Map<String, dynamic>))
        ?.toList(),
  );
}

Map<String, dynamic> _$MealCategoryResponseToJson(
        MealCategoryResponse instance) =>
    <String, dynamic>{
      'categories': instance.categories,
    };

ItemMealCategory _$ItemMealCategoryFromJson(Map<String, dynamic> json) {
  return ItemMealCategory(
    idCategory: json['idCategory'] as String,
    strCategory: json['strCategory'] as String,
    strCategoryThumb: json['strCategoryThumb'] as String,
  );
}

Map<String, dynamic> _$ItemMealCategoryToJson(ItemMealCategory instance) =>
    <String, dynamic>{
      'idCategory': instance.idCategory,
      'strCategory': instance.strCategory,
      'strCategoryThumb': instance.strCategoryThumb,
    };
