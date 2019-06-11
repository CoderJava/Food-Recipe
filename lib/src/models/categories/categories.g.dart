// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'categories.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Categories _$CategoriesFromJson(Map<String, dynamic> json) {
  return Categories(
      categoryItems: (json['categories'] as List)
          ?.map((e) => e == null
              ? null
              : CategoryItem.fromJson(e as Map<String, dynamic>))
          ?.toList());
}

Map<String, dynamic> _$CategoriesToJson(Categories instance) =>
    <String, dynamic>{'categories': instance.categoryItems};

CategoryItem _$CategoryItemFromJson(Map<String, dynamic> json) {
  return CategoryItem(
      idCategory: json['idCategory'] as String,
      strCategory: json['strCategory'] as String,
      strCategoryThumb: json['strCategoryThumb'] as String,
      strCategoryDescription: json['strCategoryDescription'] as String);
}

Map<String, dynamic> _$CategoryItemToJson(CategoryItem instance) =>
    <String, dynamic>{
      'idCategory': instance.idCategory,
      'strCategory': instance.strCategory,
      'strCategoryThumb': instance.strCategoryThumb,
      'strCategoryDescription': instance.strCategoryDescription
    };
