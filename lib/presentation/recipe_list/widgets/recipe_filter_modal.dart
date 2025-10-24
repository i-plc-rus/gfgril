import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../../../core/app_export.dart';
import '../../../theme/app_theme.dart';

class RecipeFilterModal extends StatefulWidget {
  final Map<String, dynamic> currentFilters;
  final Function(Map<String, dynamic>) onFiltersChanged;

  const RecipeFilterModal({
    Key? key,
    required this.currentFilters,
    required this.onFiltersChanged,
  }) : super(key: key);

  @override
  State<RecipeFilterModal> createState() => _RecipeFilterModalState();
}

class _RecipeFilterModalState extends State<RecipeFilterModal> {
  late Map<String, dynamic> _filters;

  final List<String> _cookingTimes = [
    'До 15 мин',
    '15-30 мин',
    '30-60 мин',
    'Более 60 мин'
  ];
  final List<String> _difficulties = ['Легко', 'Средне', 'Сложно'];
  final List<String> _appliances = [
    'Аэрогриль',
    'Кухонный робот',
    'Блендер',
    'Пароварка'
  ];
  final List<String> _dietaryPreferences = [
    'Вегетарианское',
    'Веганское',
    'Безглютеновое',
    'Низкокалорийное'
  ];

  @override
  void initState() {
    super.initState();
    _filters = Map<String, dynamic>.from(widget.currentFilters);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppTheme.lightTheme.colorScheme.surface,
        borderRadius: const BorderRadius.vertical(top: Radius.circular(24)),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // Handle bar
          Container(
            margin: EdgeInsets.symmetric(vertical: 2.h),
            width: 12.w,
            height: 0.5.h,
            decoration: BoxDecoration(
              color: AppTheme.textSecondary.withValues(alpha: 0.3),
              borderRadius: BorderRadius.circular(2),
            ),
          ),
          // Header
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 4.w),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Фильтры',
                  style: AppTheme.lightTheme.textTheme.titleLarge?.copyWith(
                    fontWeight: FontWeight.w600,
                  ),
                ),
                TextButton(
                  onPressed: _clearAllFilters,
                  child: Text(
                    'Очистить все',
                    style: AppTheme.lightTheme.textTheme.labelLarge?.copyWith(
                      color: AppTheme.secondaryLight,
                    ),
                  ),
                ),
              ],
            ),
          ),
          // Filter content
          Expanded(
            child: SingleChildScrollView(
              padding: EdgeInsets.symmetric(horizontal: 4.w),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildFilterSection(
                    'Время приготовления',
                    _cookingTimes,
                    'cookingTime',
                    false,
                  ),
                  _buildFilterSection(
                    'Сложность',
                    _difficulties,
                    'difficulty',
                    false,
                  ),
                  _buildFilterSection(
                    'Тип устройства',
                    _appliances,
                    'appliances',
                    true,
                  ),
                  _buildFilterSection(
                    'Диетические предпочтения',
                    _dietaryPreferences,
                    'dietary',
                    true,
                  ),
                  SizedBox(height: 2.h),
                ],
              ),
            ),
          ),
          // Apply button
          Container(
            padding: EdgeInsets.all(4.w),
            child: SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  widget.onFiltersChanged(_filters);
                  Navigator.pop(context);
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppTheme.secondaryLight,
                  padding: EdgeInsets.symmetric(vertical: 2.h),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                child: Text(
                  'Применить фильтры',
                  style: AppTheme.lightTheme.textTheme.labelLarge?.copyWith(
                    color: Colors.white,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFilterSection(
    String title,
    List<String> options,
    String filterKey,
    bool isMultiSelect,
  ) {
    return ExpansionTile(
      title: Text(
        title,
        style: AppTheme.lightTheme.textTheme.titleSmall?.copyWith(
          fontWeight: FontWeight.w600,
        ),
      ),
      initiallyExpanded: true,
      children: options.map((option) {
        final isSelected = isMultiSelect
            ? (_filters[filterKey] as List<String>? ?? []).contains(option)
            : _filters[filterKey] == option;

        return CheckboxListTile(
          title: Text(
            option,
            style: AppTheme.lightTheme.textTheme.bodyMedium,
          ),
          value: isSelected,
          onChanged: (value) {
            setState(() {
              if (isMultiSelect) {
                final currentList =
                    (_filters[filterKey] as List<String>? ?? []);
                if (value == true) {
                  if (!currentList.contains(option)) {
                    _filters[filterKey] = [...currentList, option];
                  }
                } else {
                  _filters[filterKey] =
                      currentList.where((item) => item != option).toList();
                }
              } else {
                _filters[filterKey] = value == true ? option : null;
              }
            });
          },
          activeColor: AppTheme.secondaryLight,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
        );
      }).toList(),
    );
  }

  void _clearAllFilters() {
    setState(() {
      _filters.clear();
    });
  }
}
