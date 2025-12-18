// --------------
// Budget entity
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

// --------------
// Spending Categories entity
// --------------

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


// --------------
// Spending Sub-Categories entity
// --------------
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