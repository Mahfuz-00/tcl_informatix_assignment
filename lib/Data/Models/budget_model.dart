// --------------
// Budget, Spending Categories, Spending Sub-Categories model
// --------------
import 'package:json_annotation/json_annotation.dart';

part 'budget_model.g.dart';

@JsonSerializable(explicitToJson: true)
class Budget {
  final int total;
  final int spent;
  final List<Category> categories;

  Budget({
    required this.total,
    required this.spent,
    required this.categories,
  });

  factory Budget.fromJson(Map<String, dynamic> json) => _$BudgetFromJson(json);
  Map<String, dynamic> toJson() => _$BudgetToJson(this);
}

@JsonSerializable(explicitToJson: true)
class Category {
  final String name;
  final int allocated;
  final int spent;
  final List<SubCategory>? subCategories;

  Category({
    required this.name,
    required this.allocated,
    required this.spent,
    this.subCategories,
  });

  factory Category.fromJson(Map<String, dynamic> json) => _$CategoryFromJson(json);
  Map<String, dynamic> toJson() => _$CategoryToJson(this);
}

@JsonSerializable()
class SubCategory {
  final String name;
  final int allocated;
  final int spent;

  SubCategory({
    required this.name,
    required this.allocated,
    required this.spent,
  });

  factory SubCategory.fromJson(Map<String, dynamic> json) => _$SubCategoryFromJson(json);
  Map<String, dynamic> toJson() => _$SubCategoryToJson(this);
}