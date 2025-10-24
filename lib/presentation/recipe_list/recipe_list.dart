import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:sizer/sizer.dart';

import '../../core/app_export.dart';
import './widgets/recipe_card.dart';
import './widgets/recipe_category_chips.dart';
import './widgets/recipe_filter_modal.dart';
import './widgets/recipe_search_bar.dart';

class RecipeList extends StatefulWidget {
  const RecipeList({Key? key}) : super(key: key);

  @override
  State<RecipeList> createState() => _RecipeListState();
}

class _RecipeListState extends State<RecipeList> with TickerProviderStateMixin {
  late TabController _tabController;
  String _searchQuery = '';
  String _selectedCategory = 'Все';
  Map<String, dynamic> _activeFilters = {};
  bool _showFavoritesOnly = false;

  final List<String> _categories = [
    'Все',
    'Супы',
    'Мясо',
    'Овощи',
    'Десерты',
    'Напитки',
    'Закуски'
  ];

  // Mock recipe data
  final List<Map<String, dynamic>> _allRecipes = [
    {
      "id": 1,
      "name": "Борщ традиционный",
      "description":
          "Традиционный традиционный борщ с говядиной и свежей капустой. Идеально подходит для семейного обеда.",
      "image":
          "https://images.unsplash.com/photo-1606063948261-95e16cac679e",
      "semanticLabel":
          "Тарелка красного борща с говядиной, капустой и сметаной на деревянном столе",
      "cookingTime": 90,
      "difficulty": "Средне",
      "servings": 6,
      "category": "Супы",
      "appliances": ["Мультиварка", "Кухонный комбайн"],
      "isFavorite": true,
      "isDownloaded": false,
      "dietary": ["Безглютеновое"],
      "rating": 4.8
    },
    {
      "id": 2,
      "name": "Плов узбекский",
      "description":
          "Ароматный плов с бараниной, морковью и специями. Готовится в мультиварке для идеального результата.",
      "image":
          "https://images.unsplash.com/photo-1708269291204-70f0d4677244",
      "semanticLabel":
          "Тарелка узбекского плова с рисом, мясом и морковью, украшенная зеленью",
      "cookingTime": 120,
      "difficulty": "Сложно",
      "servings": 8,
      "category": "Мясо",
      "appliances": ["Мультиварка"],
      "isFavorite": false,
      "isDownloaded": true,
      "dietary": ["Безглютеновое"],
      "rating": 4.9
    },
    {
      "id": 3,
      "name": "Рататуй овощной",
      "description":
          "Французское овощное рагу с баклажанами, кабачками и томатами. Легкое и полезное блюдо.",
      "image":
          "https://images.unsplash.com/photo-1629536126224-7b88cb6cc823",
      "semanticLabel":
          "Красочное овощное рагу рататуй с нарезанными кружочками баклажанов, кабачков и помидоров",
      "cookingTime": 45,
      "difficulty": "Легко",
      "servings": 4,
      "category": "Овощи",
      "appliances": ["Мультиварка", "Пароварка"],
      "isFavorite": true,
      "isDownloaded": false,
      "dietary": ["Вегетарианское", "Веганское", "Низкокалорийное"],
      "rating": 4.6
    },
    {
      "id": 4,
      "name": "Тирамису классический",
      "description":
          "Итальянский десерт с маскарпоне, кофе и какао. Нежный и воздушный, тает во рту.",
      "image":
          "https://images.unsplash.com/photo-1594356224891-56876e5f9481",
      "semanticLabel":
          "Порция тирамису в стеклянной форме, посыпанная какао-порошком",
      "cookingTime": 30,
      "difficulty": "Средне",
      "servings": 6,
      "category": "Десерты",
      "appliances": ["Блендер"],
      "isFavorite": false,
      "isDownloaded": false,
      "dietary": ["Вегетарианское"],
      "rating": 4.7
    },
    {
      "id": 5,
      "name": "Смузи зеленый детокс",
      "description":
          "Полезный зеленый смузи со шпинатом, яблоком и имбирем. Заряд энергии на весь день.",
      "image":
          "https://images.unsplash.com/photo-1694944477918-a23f25d8dd78",
      "semanticLabel":
          "Стакан зеленого смузи с трубочкой, рядом лежат листья шпината и яблоко",
      "cookingTime": 10,
      "difficulty": "Легко",
      "servings": 2,
      "category": "Напитки",
      "appliances": ["Блендер"],
      "isFavorite": true,
      "isDownloaded": true,
      "dietary": ["Вегетарианское", "Веганское", "Низкокалорийное"],
      "rating": 4.5
    },
    {
      "id": 6,
      "name": "Брускетта с томатами",
      "description":
          "Итальянская закуска с хрустящим хлебом, свежими томатами и базиликом.",
      "image":
          "https://images.unsplash.com/photo-1625938395857-9cc28c63dbfd",
      "semanticLabel":
          "Несколько кусочков брускетты с нарезанными помидорами и зеленью на деревянной доске",
      "cookingTime": 15,
      "difficulty": "Легко",
      "servings": 4,
      "category": "Закуски",
      "appliances": ["Кухонный комбайн"],
      "isFavorite": false,
      "isDownloaded": false,
      "dietary": ["Вегетарианское"],
      "rating": 4.4
    }
  ];

  List<Map<String, dynamic>> _filteredRecipes = [];

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this, initialIndex: 1);
    _filteredRecipes = List.from(_allRecipes);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  void _filterRecipes() {
    setState(() {
      _filteredRecipes = _allRecipes.where((recipe) {
        // Search query filter
        if (_searchQuery.isNotEmpty) {
          final searchLower = _searchQuery.toLowerCase();
          if (!recipe['name'].toString().toLowerCase().contains(searchLower) &&
              !recipe['description']
                  .toString()
                  .toLowerCase()
                  .contains(searchLower)) {
            return false;
          }
        }

        // Category filter
        if (_selectedCategory != 'Все' &&
            recipe['category'] != _selectedCategory) {
          return false;
        }

        // Favorites filter
        if (_showFavoritesOnly && !(recipe['isFavorite'] as bool)) {
          return false;
        }

        // Active filters
        if (_activeFilters.isNotEmpty) {
          // Cooking time filter
          if (_activeFilters['cookingTime'] != null) {
            final cookingTime = recipe['cookingTime'] as int;
            final timeFilter = _activeFilters['cookingTime'] as String;

            switch (timeFilter) {
              case 'До 15 мин':
                if (cookingTime > 15) return false;
                break;
              case '15-30 мин':
                if (cookingTime < 15 || cookingTime > 30) return false;
                break;
              case '30-60 мин':
                if (cookingTime < 30 || cookingTime > 60) return false;
                break;
              case 'Более 60 мин':
                if (cookingTime <= 60) return false;
                break;
            }
          }

          // Difficulty filter
          if (_activeFilters['difficulty'] != null) {
            if (recipe['difficulty'] != _activeFilters['difficulty'])
              return false;
          }

          // Appliances filter
          if (_activeFilters['appliances'] != null) {
            final selectedAppliances =
                _activeFilters['appliances'] as List<String>;
            final recipeAppliances = recipe['appliances'] as List<String>;
            if (!selectedAppliances
                .any((appliance) => recipeAppliances.contains(appliance))) {
              return false;
            }
          }

          // Dietary filter
          if (_activeFilters['dietary'] != null) {
            final selectedDietary = _activeFilters['dietary'] as List<String>;
            final recipeDietary = recipe['dietary'] as List<String>? ?? [];
            if (!selectedDietary.any((diet) => recipeDietary.contains(diet))) {
              return false;
            }
          }
        }

        return true;
      }).toList();
    });
  }

  void _toggleFavorite(int recipeId) {
    setState(() {
      final recipeIndex =
          _allRecipes.indexWhere((recipe) => recipe['id'] == recipeId);
      if (recipeIndex != -1) {
        _allRecipes[recipeIndex]['isFavorite'] =
            !(_allRecipes[recipeIndex]['isFavorite'] as bool);
        _filterRecipes();

        final isFavorite = _allRecipes[recipeIndex]['isFavorite'] as bool;
        Fluttertoast.showToast(
          msg: isFavorite ? 'Добавлено в избранное' : 'Удалено из избранного',
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
        );
      }
    });
  }

  void _shareRecipe(Map<String, dynamic> recipe) {
    Fluttertoast.showToast(
      msg: 'Рецепт "${recipe['name']}" поделен',
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.BOTTOM,
    );
  }

  void _downloadRecipe(int recipeId) {
    setState(() {
      final recipeIndex =
          _allRecipes.indexWhere((recipe) => recipe['id'] == recipeId);
      if (recipeIndex != -1) {
        _allRecipes[recipeIndex]['isDownloaded'] = true;
        _filterRecipes();

        Fluttertoast.showToast(
          msg: 'Рецепт скачан для офлайн использования',
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
        );
      }
    });
  }

  void _showFilterModal() {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      isScrollControlled: true,
      builder: (context) => SizedBox(
        height: 80.h,
        child: RecipeFilterModal(
          currentFilters: _activeFilters,
          onFiltersChanged: (filters) {
            setState(() {
              _activeFilters = filters;
              _filterRecipes();
            });
          },
        ),
      ),
    );
  }

  Future<void> _refreshRecipes() async {
    // Simulate network refresh
    await Future.delayed(const Duration(seconds: 1));
    setState(() {
      _filterRecipes();
    });

    Fluttertoast.showToast(
      msg: 'Рецепты обновлены',
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.BOTTOM,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.lightTheme.scaffoldBackgroundColor,
      body: SafeArea(
        child: Column(
          children: [
            // App Bar with Tab Bar
            Container(
              decoration: BoxDecoration(
                color: AppTheme.surfaceLight.withValues(alpha: 0.95),
                border: Border(
                  bottom: BorderSide(
                    color: AppTheme.lightTheme.colorScheme.outline
                        .withValues(alpha: 0.1),
                  ),
                ),
              ),
              child: Column(
                children: [
                  // Header with title and favorites toggle
                  Padding(
                    padding:
                        EdgeInsets.symmetric(horizontal: 4.w, vertical: 2.h),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'GFGRIL Рецепты',
                          style: AppTheme.lightTheme.textTheme.headlineSmall
                              ?.copyWith(
                            fontWeight: FontWeight.w700,
                            color: AppTheme.primaryLight,
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            setState(() {
                              _showFavoritesOnly = !_showFavoritesOnly;
                              _filterRecipes();
                            });
                          },
                          child: Container(
                            padding: EdgeInsets.all(2.w),
                            decoration: BoxDecoration(
                              color: _showFavoritesOnly
                                  ? AppTheme.secondaryLight
                                      .withValues(alpha: 0.1)
                                  : Colors.transparent,
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: CustomIconWidget(
                              iconName: _showFavoritesOnly
                                  ? 'favorite'
                                  : 'favorite_border',
                              color: _showFavoritesOnly
                                  ? AppTheme.secondaryLight
                                  : AppTheme.textSecondary,
                              size: 6.w,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  // Tab Bar
                  TabBar(
                    controller: _tabController,
                    tabs: const [
                      Tab(text: 'Главная'),
                      Tab(text: 'Рецепты'),
                      Tab(text: 'Поддержка'),
                    ],
                    onTap: (index) {
                      if (index != 1) {
                        // Navigate to other screens
                        switch (index) {
                          case 0:
                            Navigator.pushNamed(context, '/home-dashboard');
                            break;
                          case 2:
                            Navigator.pushNamed(context, '/settings');
                            break;
                        }
                      }
                    },
                  ),
                ],
              ),
            ),
            // Search Bar
            RecipeSearchBar(
              onSearchChanged: (query) {
                setState(() {
                  _searchQuery = query;
                  _filterRecipes();
                });
              },
              onFilterTap: _showFilterModal,
            ),
            // Category Chips
            RecipeCategoryChips(
              categories: _categories,
              selectedCategory: _selectedCategory,
              onCategorySelected: (category) {
                setState(() {
                  _selectedCategory = category;
                  _filterRecipes();
                });
              },
            ),
            // Recipe List
            Expanded(
              child: RefreshIndicator(
                onRefresh: _refreshRecipes,
                color: AppTheme.secondaryLight,
                child: _filteredRecipes.isEmpty
                    ? _buildEmptyState()
                    : ListView.builder(
                        padding: EdgeInsets.only(bottom: 2.h),
                        itemCount: _filteredRecipes.length,
                        itemBuilder: (context, index) {
                          final recipe = _filteredRecipes[index];
                          return RecipeCard(
                            recipe: recipe,
                            onTap: () {
                              // Navigate to recipe detail
                              Fluttertoast.showToast(
                                msg: 'Открытие рецепта "${recipe['name']}"',
                                toastLength: Toast.LENGTH_SHORT,
                                gravity: ToastGravity.BOTTOM,
                              );
                            },
                            onFavoriteToggle: () =>
                                _toggleFavorite(recipe['id'] as int),
                            onShare: () => _shareRecipe(recipe),
                            onDownload: () =>
                                _downloadRecipe(recipe['id'] as int),
                          );
                        },
                      ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildEmptyState() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          CustomIconWidget(
            iconName: 'restaurant_menu',
            color: AppTheme.textSecondary.withValues(alpha: 0.5),
            size: 15.w,
          ),
          SizedBox(height: 2.h),
          Text(
            _showFavoritesOnly
                ? 'Нет избранных рецептов'
                : 'Рецепты не найдены',
            style: AppTheme.lightTheme.textTheme.titleMedium?.copyWith(
              color: AppTheme.textSecondary,
            ),
          ),
          SizedBox(height: 1.h),
          Text(
            _showFavoritesOnly
                ? 'Добавьте рецепты в избранное для быстрого доступа'
                : 'Попробуйте изменить параметры поиска или фильтры',
            style: AppTheme.lightTheme.textTheme.bodyMedium?.copyWith(
              color: AppTheme.textSecondary.withValues(alpha: 0.7),
            ),
            textAlign: TextAlign.center,
          ),
          if (!_showFavoritesOnly) ...[
            SizedBox(height: 3.h),
            ElevatedButton(
              onPressed: () {
                setState(() {
                  _searchQuery = '';
                  _selectedCategory = 'Все';
                  _activeFilters.clear();
                  _filterRecipes();
                });
              },
              child: const Text('Сбросить фильтры'),
            ),
          ],
        ],
      ),
    );
  }
}