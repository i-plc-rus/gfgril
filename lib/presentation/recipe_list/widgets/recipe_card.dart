import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../../../core/app_export.dart';

class RecipeCard extends StatelessWidget {
  final Map<String, dynamic> recipe;
  final VoidCallback onTap;
  final VoidCallback onFavoriteToggle;
  final VoidCallback onShare;
  final VoidCallback onDownload;

  const RecipeCard({
    Key? key,
    required this.recipe,
    required this.onTap,
    required this.onFavoriteToggle,
    required this.onShare,
    required this.onDownload,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final isFavorite = recipe['isFavorite'] as bool? ?? false;
    final isDownloaded = recipe['isDownloaded'] as bool? ?? false;

    return GestureDetector(
      onTap: onTap,
      onLongPress: () => _showQuickActions(context),
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 4.w, vertical: 1.h),
        decoration: BoxDecoration(
          color: AppTheme.lightTheme.colorScheme.surface,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
            color:
                AppTheme.lightTheme.colorScheme.outline.withValues(alpha: 0.1),
          ),
          boxShadow: [
            BoxShadow(
              color: AppTheme.shadowLight,
              blurRadius: 8,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Recipe Image
            Stack(
              children: [
                ClipRRect(
                  borderRadius:
                      const BorderRadius.vertical(top: Radius.circular(16)),
                  child: CustomImageWidget(
                    imageUrl: recipe['image'] as String,
                    width: double.infinity,
                    height: 25.h,
                    fit: BoxFit.cover,
                    semanticLabel: recipe['semanticLabel'] as String,
                  ),
                ),
                // Favorite and Download indicators
                Positioned(
                  top: 2.h,
                  right: 3.w,
                  child: Row(
                    children: [
                      if (isDownloaded)
                        Container(
                          padding: EdgeInsets.all(2.w),
                          decoration: BoxDecoration(
                            color: AppTheme.successColor.withValues(alpha: 0.9),
                            shape: BoxShape.circle,
                          ),
                          child: CustomIconWidget(
                            iconName: 'download_done',
                            color: Colors.white,
                            size: 4.w,
                          ),
                        ),
                      SizedBox(width: 2.w),
                      GestureDetector(
                        onTap: onFavoriteToggle,
                        child: Container(
                          padding: EdgeInsets.all(2.w),
                          decoration: BoxDecoration(
                            color: Colors.black.withValues(alpha: 0.5),
                            shape: BoxShape.circle,
                          ),
                          child: CustomIconWidget(
                            iconName:
                                isFavorite ? 'favorite' : 'favorite_border',
                            color:
                                isFavorite ? AppTheme.errorColor : Colors.white,
                            size: 4.w,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                // Difficulty badge
                Positioned(
                  top: 2.h,
                  left: 3.w,
                  child: Container(
                    padding:
                        EdgeInsets.symmetric(horizontal: 3.w, vertical: 1.h),
                    decoration: BoxDecoration(
                      color:
                          _getDifficultyColor(recipe['difficulty'] as String),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Text(
                      recipe['difficulty'] as String,
                      style: AppTheme.lightTheme.textTheme.labelSmall?.copyWith(
                        color: Colors.white,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ),
              ],
            ),
            // Recipe Details
            Padding(
              padding: EdgeInsets.all(4.w),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    recipe['name'] as String,
                    style: AppTheme.lightTheme.textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.w600,
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  SizedBox(height: 1.h),
                  Row(
                    children: [
                      CustomIconWidget(
                        iconName: 'access_time',
                        color: AppTheme.textSecondary,
                        size: 4.w,
                      ),
                      SizedBox(width: 1.w),
                      Text(
                        '${recipe['cookingTime']} мин',
                        style:
                            AppTheme.lightTheme.textTheme.bodySmall?.copyWith(
                          color: AppTheme.textSecondary,
                        ),
                      ),
                      SizedBox(width: 4.w),
                      CustomIconWidget(
                        iconName: 'people',
                        color: AppTheme.textSecondary,
                        size: 4.w,
                      ),
                      SizedBox(width: 1.w),
                      Text(
                        '${recipe['servings']} порций',
                        style:
                            AppTheme.lightTheme.textTheme.bodySmall?.copyWith(
                          color: AppTheme.textSecondary,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 1.h),
                  // Appliance compatibility
                  Row(
                    children: [
                      Text(
                        'Совместимо: ',
                        style:
                            AppTheme.lightTheme.textTheme.bodySmall?.copyWith(
                          color: AppTheme.textSecondary,
                        ),
                      ),
                      Expanded(
                        child: Wrap(
                          spacing: 2.w,
                          children: (recipe['appliances'] as List<String>)
                              .map((appliance) {
                            return Container(
                              padding: EdgeInsets.symmetric(
                                  horizontal: 2.w, vertical: 0.5.h),
                              decoration: BoxDecoration(
                                color: AppTheme.secondaryLight
                                    .withValues(alpha: 0.1),
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: Text(
                                appliance,
                                style: AppTheme.lightTheme.textTheme.labelSmall
                                    ?.copyWith(
                                  color: AppTheme.secondaryLight,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            );
                          }).toList(),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Color _getDifficultyColor(String difficulty) {
    switch (difficulty.toLowerCase()) {
      case 'легко':
        return AppTheme.successColor;
      case 'средне':
        return AppTheme.warningColor;
      case 'сложно':
        return AppTheme.errorColor;
      default:
        return AppTheme.textSecondary;
    }
  }

  void _showQuickActions(BuildContext context) {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      builder: (context) => Container(
        decoration: BoxDecoration(
          color: AppTheme.lightTheme.colorScheme.surface,
          borderRadius: const BorderRadius.vertical(top: Radius.circular(24)),
        ),
        padding: EdgeInsets.all(4.w),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 12.w,
              height: 0.5.h,
              decoration: BoxDecoration(
                color: AppTheme.textSecondary.withValues(alpha: 0.3),
                borderRadius: BorderRadius.circular(2),
              ),
            ),
            SizedBox(height: 3.h),
            Text(
              'Быстрые действия',
              style: AppTheme.lightTheme.textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.w600,
              ),
            ),
            SizedBox(height: 2.h),
            _buildQuickActionTile(
              context,
              'Добавить в избранное',
              'favorite',
              onFavoriteToggle,
            ),
            _buildQuickActionTile(
              context,
              'Поделиться',
              'share',
              onShare,
            ),
            _buildQuickActionTile(
              context,
              'Скачать для офлайн',
              'download',
              onDownload,
            ),
            SizedBox(height: 2.h),
          ],
        ),
      ),
    );
  }

  Widget _buildQuickActionTile(
    BuildContext context,
    String title,
    String iconName,
    VoidCallback onTap,
  ) {
    return ListTile(
      leading: CustomIconWidget(
        iconName: iconName,
        color: AppTheme.textPrimary,
        size: 5.w,
      ),
      title: Text(
        title,
        style: AppTheme.lightTheme.textTheme.bodyMedium,
      ),
      onTap: () {
        Navigator.pop(context);
        onTap();
      },
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
    );
  }
}
