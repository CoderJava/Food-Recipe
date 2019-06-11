// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'filter_area_meals.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

FilterAreaMeals _$FilterAreaMealsFromJson(Map<String, dynamic> json) {
  return FilterAreaMeals(
      filterAreaMealsItems: (json['meals'] as List)
          ?.map((e) => e == null
              ? null
              : FilterAreaMealsItem.fromJson(e as Map<String, dynamic>))
          ?.toList());
}

Map<String, dynamic> _$FilterAreaMealsToJson(FilterAreaMeals instance) =>
    <String, dynamic>{'meals': instance.filterAreaMealsItems};

FilterAreaMealsItem _$FilterAreaMealsItemFromJson(Map<String, dynamic> json) {
  return FilterAreaMealsItem(
      strMeal: json['strMeal'] as String,
      strMealThumb: json['strMealThumb'] as String,
      idMeal: json['idMeal'] as String);
}

Map<String, dynamic> _$FilterAreaMealsItemToJson(
        FilterAreaMealsItem instance) =>
    <String, dynamic>{
      'strMeal': instance.strMeal,
      'strMealThumb': instance.strMealThumb,
      'idMeal': instance.idMeal
    };
