// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'filter_categories.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

FilterCategories _$FilterCategoriesFromJson(Map<String, dynamic> json) {
  return FilterCategories(
      filterCategoryItems: (json['meals'] as List)
          ?.map((e) => e == null
              ? null
              : FilterCategoryItem.fromJson(e as Map<String, dynamic>))
          ?.toList());
}

Map<String, dynamic> _$FilterCategoriesToJson(FilterCategories instance) =>
    <String, dynamic>{'meals': instance.filterCategoryItems};

FilterCategoryItem _$FilterCategoryItemFromJson(Map<String, dynamic> json) {
  return FilterCategoryItem(
      strMeal: json['strMeal'] as String,
      strMealThumb: json['strMealThumb'] as String,
      idMeal: json['idMeal'] as String);
}

Map<String, dynamic> _$FilterCategoryItemToJson(FilterCategoryItem instance) =>
    <String, dynamic>{
      'strMeal': instance.strMeal,
      'strMealThumb': instance.strMealThumb,
      'idMeal': instance.idMeal
    };
