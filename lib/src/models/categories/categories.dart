import 'package:json_annotation/json_annotation.dart';
part 'categories.g.dart';

@JsonSerializable()
class Categories {
  @JsonKey(name: "categories")
  List<CategoryItem> categoryItems;

  Categories({this.categoryItems});

  @override
  String toString() {
    return 'Categories{categoryItems: $categoryItems}';
  }

  factory Categories.fromJson(Map<String, dynamic> json) => _$CategoriesFromJson(json);

  Map<String, dynamic> toJson() => _$CategoriesToJson(this);

}

@JsonSerializable()
class CategoryItem {
  String idCategory;
  String strCategory;
  String strCategoryThumb;
  String strCategoryDescription;

  CategoryItem({this.idCategory, this.strCategory, this.strCategoryThumb, this.strCategoryDescription});

  @override
  String toString() {
    return 'CategoryItem{idCategory: $idCategory, strCategory: $strCategory, strCategoryThumb: $strCategoryThumb, strCategoryDescription: $strCategoryDescription}';
  }

  factory CategoryItem.fromJson(Map<String, dynamic> json) => _$CategoryItemFromJson(json);

  Map<String, dynamic> toJson() => _$CategoryItemToJson(this);
}