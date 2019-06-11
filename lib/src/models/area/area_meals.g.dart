// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'area_meals.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AreaMeals _$AreaMealsFromJson(Map<String, dynamic> json) {
  return AreaMeals(
      areaMealsItems: (json['meals'] as List)
          ?.map((e) => e == null
              ? null
              : AreaMealsItem.fromJson(e as Map<String, dynamic>))
          ?.toList());
}

Map<String, dynamic> _$AreaMealsToJson(AreaMeals instance) =>
    <String, dynamic>{'meals': instance.areaMealsItems};

AreaMealsItem _$AreaMealsItemFromJson(Map<String, dynamic> json) {
  return AreaMealsItem(strArea: json['strArea'] as String);
}

Map<String, dynamic> _$AreaMealsItemToJson(AreaMealsItem instance) =>
    <String, dynamic>{'strArea': instance.strArea};
