// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'budget_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Budget _$BudgetFromJson(Map<String, dynamic> json) => Budget(
  total: (json['total'] as num).toInt(),
  spent: (json['spent'] as num).toInt(),
  categories: (json['categories'] as List<dynamic>)
      .map((e) => Category.fromJson(e as Map<String, dynamic>))
      .toList(),
);

Map<String, dynamic> _$BudgetToJson(Budget instance) => <String, dynamic>{
  'total': instance.total,
  'spent': instance.spent,
  'categories': instance.categories.map((e) => e.toJson()).toList(),
};

Category _$CategoryFromJson(Map<String, dynamic> json) => Category(
  name: json['name'] as String,
  allocated: (json['allocated'] as num).toInt(),
  spent: (json['spent'] as num).toInt(),
  subCategories: (json['subCategories'] as List<dynamic>?)
      ?.map((e) => SubCategory.fromJson(e as Map<String, dynamic>))
      .toList(),
);

Map<String, dynamic> _$CategoryToJson(Category instance) => <String, dynamic>{
  'name': instance.name,
  'allocated': instance.allocated,
  'spent': instance.spent,
  'subCategories': instance.subCategories?.map((e) => e.toJson()).toList(),
};

SubCategory _$SubCategoryFromJson(Map<String, dynamic> json) => SubCategory(
  name: json['name'] as String,
  allocated: (json['allocated'] as num).toInt(),
  spent: (json['spent'] as num).toInt(),
);

Map<String, dynamic> _$SubCategoryToJson(SubCategory instance) =>
    <String, dynamic>{
      'name': instance.name,
      'allocated': instance.allocated,
      'spent': instance.spent,
    };
