// --------------
// Budget entity with categories and sub.
// --------------
class BudgetEntity {
  final int total;
  final int spent;
  final List<CategoryEntity> categories;

  BudgetEntity({
    required this.total,
    required this.spent,
    required this.categories,
  });
}

class CategoryEntity {
  final String name;
  final int allocated;
  final int spent;
  final List<SubCategoryEntity>? subCategories;

  CategoryEntity({
    required this.name,
    required this.allocated,
    required this.spent,
    this.subCategories,
  });
}

class SubCategoryEntity {
  final String name;
  final int allocated;
  final int spent;

  SubCategoryEntity({
    required this.name,
    required this.allocated,
    required this.spent,
  });
}