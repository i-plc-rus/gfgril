import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

/// A class that contains all theme configurations redesigned in Apple Home app style.
class AppTheme {
  AppTheme._();

  // Apple Home app inspired color palette
  static const Color primaryLight = Color(0xFF007AFF); // Apple system blue
  static const Color primaryDark = Color(0xFF0A84FF); // Apple dark mode blue
  
  // Убираем зеленые акцентные цвета, используем только синий как в Apple Home
  static const Color secondaryLight = Color(0xFF8E8E93); // Neutral gray for secondary elements
  static const Color secondaryDark = Color(0xFF98989D); // Neutral gray for dark mode

  // Clean background system matching Apple Home
  static const Color backgroundLight = Color(0xFFF2F2F7); // Apple system gray 6
  static const Color backgroundDark = Color(0xFF000000); // Pure black
  static const Color surfaceLight = Color(0xFFFFFFFF); // Pure white
  static const Color surfaceDark = Color(0xFF1C1C1E); // Apple system gray 6 dark

  // Text colors following Apple system guidelines
  static const Color textPrimary = Color(0xFF000000);
  static const Color textPrimaryLight = Color(0xFF000000);

  static const Color textSecondary = Color(0xFF8E8E93);
  static const Color textSecondaryLight = Color(0xFF8E8E93);
  static const Color textPrimaryDark = Color(0xFFFFFFFF);
  static const Color textSecondaryDark = Color(0xFF98989D);

  // Card and surface colors with Apple Home styling
  static const Color cardLight = Color(0xFFFFFFFF);
  static const Color cardDark = Color(0xFF2C2C2E);
  static const Color dialogLight = Color(0xFFFFFFFF);
  static const Color dialogDark = Color(0xFF2C2C2E);

  // Apple-style subtle shadows and borders
  static const Color shadowLight = Color(0x14000000);
  static const Color shadowDark = Color(0x28000000);
  static const Color borderLight = Color(0xFFC6C6C8);
  static const Color borderDark = Color(0xFF38383A);

  // Semantic colors - используем только для статусов, не для кнопок
  static const Color successColor = Color(0xFF34C759);
  //static const Color warningColor = Color(0xFFFF9500);
  static const Color warningColor = Color(0xFFC6C6C8);
  static const Color errorColor = Color(0xFFFF3B30);

  /// Light theme optimized for Apple Home app style
  static ThemeData lightTheme = ThemeData(
    brightness: Brightness.light,
    colorScheme: const ColorScheme.light(
      primary: primaryLight,
      onPrimary: Colors.white,
      secondary: secondaryLight,
      onSecondary: Colors.white,
      error: errorColor,
      onError: Colors.white,
      background: backgroundLight,
      onBackground: textPrimaryLight,
      surface: surfaceLight,
      onSurface: textPrimaryLight,
      surfaceVariant: cardLight,
      onSurfaceVariant: textSecondaryLight,
      outline: borderLight,
    ),
    scaffoldBackgroundColor: backgroundLight,
    cardColor: cardLight,
    dividerColor: borderLight,

    // Apple-style app bar with clean design
    appBarTheme: AppBarTheme(
      backgroundColor: surfaceLight,
      foregroundColor: textPrimaryLight,
      elevation: 0,
      scrolledUnderElevation: 0,
      shadowColor: Colors.transparent,
      surfaceTintColor: Colors.transparent,
      titleTextStyle: GoogleFonts.inter(
        fontSize: 17,
        fontWeight: FontWeight.w600,
        color: textPrimaryLight,
        letterSpacing: -0.41,
      ),
    ),

    // Apple Home style cards with subtle elevation
    cardTheme: const CardThemeData(
      color: cardLight,
      elevation: 0,
      shadowColor: shadowLight,
      surfaceTintColor: Colors.transparent,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(12.0)),
        side: BorderSide(color: borderLight, width: 0.5),
      ),
      margin: EdgeInsets.all(4.0),
    ),

    // Bottom navigation with Apple styling
    bottomNavigationBarTheme: BottomNavigationBarThemeData(
      backgroundColor: surfaceLight.withOpacity(0.95),
      selectedItemColor: primaryLight,
      unselectedItemColor: textSecondaryLight,
      selectedLabelStyle: GoogleFonts.inter(
        fontSize: 10,
        fontWeight: FontWeight.w500,
        letterSpacing: 0.12,
      ),
      unselectedLabelStyle: GoogleFonts.inter(
        fontSize: 10,
        fontWeight: FontWeight.w400,
        letterSpacing: 0.12,
      ),
      type: BottomNavigationBarType.fixed,
      elevation: 0,
    ),

    // Apple-style floating action button
    floatingActionButtonTheme: const FloatingActionButtonThemeData(
      backgroundColor: primaryLight,
      foregroundColor: Colors.white,
      elevation: 6,
      focusElevation: 8,
      hoverElevation: 8,
      highlightElevation: 10,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(16.0)),
      ),
    ),

    // Apple system button styles - УБИРАЕМ ЗЕЛЕНЫЕ КНОПКИ
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        foregroundColor: Colors.white,
        backgroundColor: primaryLight, // Только синий цвет
        disabledForegroundColor: textSecondaryLight.withOpacity(0.3),
        disabledBackgroundColor: borderLight,
        elevation: 0,
        shadowColor: Colors.transparent,
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
        minimumSize: const Size(88, 44),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8.0),
        ),
        textStyle: GoogleFonts.inter(
          fontSize: 17,
          fontWeight: FontWeight.w600,
          letterSpacing: -0.41,
        ),
      ),
    ),

    outlinedButtonTheme: OutlinedButtonThemeData(
      style: OutlinedButton.styleFrom(
        foregroundColor: primaryLight, // Только синий цвет
        disabledForegroundColor: textSecondaryLight.withOpacity(0.3),
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
        minimumSize: const Size(88, 44),
        side: const BorderSide(color: borderLight, width: 1.0), // Серая граница вместо цветной
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8.0),
        ),
        textStyle: GoogleFonts.inter(
          fontSize: 17,
          fontWeight: FontWeight.w400,
          letterSpacing: -0.41,
        ),
      ),
    ),

    textButtonTheme: TextButtonThemeData(
      style: TextButton.styleFrom(
        foregroundColor: primaryLight, // Только синий цвет
        disabledForegroundColor: textSecondaryLight.withOpacity(0.3),
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        minimumSize: const Size(44, 44),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8.0),
        ),
        textStyle: GoogleFonts.inter(
          fontSize: 17,
          fontWeight: FontWeight.w400,
          letterSpacing: -0.41,
        ),
      ),
    ),

    // Apple system text theme
    textTheme: _buildTextTheme(isLight: true),

    // Apple-style input fields
    inputDecorationTheme: InputDecorationTheme(
      fillColor: surfaceLight,
      filled: true,
      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10.0),
        borderSide: const BorderSide(color: borderLight, width: 1.0),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10.0),
        borderSide: const BorderSide(color: borderLight, width: 1.0),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10.0),
        borderSide: const BorderSide(color: primaryLight, width: 2.0),
      ),
      errorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10.0),
        borderSide: const BorderSide(color: errorColor, width: 1.0),
      ),
      focusedErrorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10.0),
        borderSide: const BorderSide(color: errorColor, width: 2.0),
      ),
      labelStyle: GoogleFonts.inter(
        color: textSecondaryLight,
        fontSize: 17,
        fontWeight: FontWeight.w400,
      ),
      hintStyle: GoogleFonts.inter(
        color: textSecondaryLight.withOpacity(0.6),
        fontSize: 17,
        fontWeight: FontWeight.w400,
      ),
      errorStyle: GoogleFonts.inter(
        color: errorColor,
        fontSize: 13,
        fontWeight: FontWeight.w400,
      ),
    ),

    // Добавляем стиль для серых кнопок как в Apple Home
    filledButtonTheme: FilledButtonThemeData(
      style: FilledButton.styleFrom(
        foregroundColor: textPrimaryLight,
        backgroundColor: Color(0xFFE5E5EA), // Светло-серый как в Apple Home
        disabledForegroundColor: textSecondaryLight.withOpacity(0.3),
        disabledBackgroundColor: borderLight,
        elevation: 0,
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
        minimumSize: const Size(88, 44),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8.0),
        ),
        textStyle: GoogleFonts.inter(
          fontSize: 17,
          fontWeight: FontWeight.w400,
          letterSpacing: -0.41,
        ),
      ),
    ),

    // Остальные настройки остаются без изменений...
  );

  /// Dark theme optimized for Apple Home app dark mode
  static ThemeData darkTheme = ThemeData(
    brightness: Brightness.dark,
    colorScheme: const ColorScheme.dark(
      primary: primaryDark,
      onPrimary: Colors.white,
      secondary: secondaryDark,
      onSecondary: Colors.white,
      error: errorColor,
      onError: Colors.white,
      background: backgroundDark,
      onBackground: textPrimaryDark,
      surface: surfaceDark,
      onSurface: textPrimaryDark,
      surfaceVariant: cardDark,
      onSurfaceVariant: textSecondaryDark,
      outline: borderDark,
    ),
    scaffoldBackgroundColor: backgroundDark,
    cardColor: cardDark,
    dividerColor: borderDark,

    // Dark mode app bar
    appBarTheme: AppBarTheme(
      backgroundColor: surfaceDark,
      foregroundColor: textPrimaryDark,
      elevation: 0,
      scrolledUnderElevation: 0,
      shadowColor: Colors.transparent,
      surfaceTintColor: Colors.transparent,
      titleTextStyle: GoogleFonts.inter(
        fontSize: 17,
        fontWeight: FontWeight.w600,
        color: textPrimaryDark,
        letterSpacing: -0.41,
      ),
    ),

    // Dark mode cards
    cardTheme: const CardThemeData(
      color: cardDark,
      elevation: 0,
      shadowColor: shadowDark,
      surfaceTintColor: Colors.transparent,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(12.0)),
        side: BorderSide(color: borderDark, width: 0.5),
      ),
      margin: EdgeInsets.all(4.0),
    ),

    // Кнопки для темной темы - тоже убираем зеленый
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        foregroundColor: Colors.white,
        backgroundColor: primaryDark,
        disabledForegroundColor: textSecondaryDark.withOpacity(0.3),
        disabledBackgroundColor: borderDark,
        elevation: 0,
        shadowColor: Colors.transparent,
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
        minimumSize: const Size(88, 44),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8.0),
        ),
        textStyle: GoogleFonts.inter(
          fontSize: 17,
          fontWeight: FontWeight.w600,
          letterSpacing: -0.41,
        ),
      ),
    ),

    outlinedButtonTheme: OutlinedButtonThemeData(
      style: OutlinedButton.styleFrom(
        foregroundColor: primaryDark,
        disabledForegroundColor: textSecondaryDark.withOpacity(0.3),
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
        minimumSize: const Size(88, 44),
        side: const BorderSide(color: borderDark, width: 1.0),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8.0),
        ),
        textStyle: GoogleFonts.inter(
          fontSize: 17,
          fontWeight: FontWeight.w400,
          letterSpacing: -0.41,
        ),
      ),
    ),

    textButtonTheme: TextButtonThemeData(
      style: TextButton.styleFrom(
        foregroundColor: primaryDark,
        disabledForegroundColor: textSecondaryDark.withOpacity(0.3),
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        minimumSize: const Size(44, 44),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8.0),
        ),
        textStyle: GoogleFonts.inter(
          fontSize: 17,
          fontWeight: FontWeight.w400,
          letterSpacing: -0.41,
        ),
      ),
    ),

    // Серые кнопки для темной темы
    filledButtonTheme: FilledButtonThemeData(
      style: FilledButton.styleFrom(
        foregroundColor: textPrimaryDark,
        backgroundColor: Color(0xFF38383A), // Темно-серый для dark mode
        disabledForegroundColor: textSecondaryDark.withOpacity(0.3),
        disabledBackgroundColor: borderDark,
        elevation: 0,
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
        minimumSize: const Size(88, 44),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8.0),
        ),
        textStyle: GoogleFonts.inter(
          fontSize: 17,
          fontWeight: FontWeight.w400,
          letterSpacing: -0.41,
        ),
      ),
    ),

    // Остальные настройки dark theme...
  );

  /// Helper method to build Apple-inspired text theme using Inter font family
  static TextTheme _buildTextTheme({required bool isLight}) {
    final Color textHighEmphasis = isLight ? textPrimaryLight : textPrimaryDark;
    final Color textMediumEmphasis = isLight ? textSecondaryLight : textSecondaryDark;

    return TextTheme(
      displayLarge: GoogleFonts.inter(
        fontSize: 34,
        fontWeight: FontWeight.w700,
        color: textHighEmphasis,
        letterSpacing: 0.37,
        height: 1.12,
      ),
      displayMedium: GoogleFonts.inter(
        fontSize: 28,
        fontWeight: FontWeight.w700,
        color: textHighEmphasis,
        letterSpacing: 0.36,
        height: 1.16,
      ),
      displaySmall: GoogleFonts.inter(
        fontSize: 22,
        fontWeight: FontWeight.w700,
        color: textHighEmphasis,
        letterSpacing: 0.35,
        height: 1.22,
      ),
      headlineLarge: GoogleFonts.inter(
        fontSize: 20,
        fontWeight: FontWeight.w600,
        color: textHighEmphasis,
        letterSpacing: 0.38,
        height: 1.25,
      ),
      headlineMedium: GoogleFonts.inter(
        fontSize: 17,
        fontWeight: FontWeight.w600,
        color: textHighEmphasis,
        letterSpacing: -0.41,
        height: 1.29,
      ),
      headlineSmall: GoogleFonts.inter(
        fontSize: 16,
        fontWeight: FontWeight.w600,
        color: textHighEmphasis,
        letterSpacing: -0.32,
        height: 1.33,
      ),
      titleLarge: GoogleFonts.inter(
        fontSize: 17,
        fontWeight: FontWeight.w600,
        color: textHighEmphasis,
        letterSpacing: -0.41,
        height: 1.27,
      ),
      titleMedium: GoogleFonts.inter(
        fontSize: 16,
        fontWeight: FontWeight.w600,
        color: textHighEmphasis,
        letterSpacing: -0.32,
        height: 1.50,
      ),
      titleSmall: GoogleFonts.inter(
        fontSize: 15,
        fontWeight: FontWeight.w600,
        color: textHighEmphasis,
        letterSpacing: -0.24,
        height: 1.43,
      ),
      bodyLarge: GoogleFonts.inter(
        fontSize: 17,
        fontWeight: FontWeight.w400,
        color: textHighEmphasis,
        letterSpacing: -0.41,
        height: 1.50,
      ),
      bodyMedium: GoogleFonts.inter(
        fontSize: 15,
        fontWeight: FontWeight.w400,
        color: textHighEmphasis,
        letterSpacing: -0.24,
        height: 1.43,
      ),
      bodySmall: GoogleFonts.inter(
        fontSize: 13,
        fontWeight: FontWeight.w400,
        color: textMediumEmphasis,
        letterSpacing: -0.08,
        height: 1.33,
      ),
      labelLarge: GoogleFonts.inter(
        fontSize: 15,
        fontWeight: FontWeight.w500,
        color: textHighEmphasis,
        letterSpacing: -0.24,
        height: 1.43,
      ),
      labelMedium: GoogleFonts.inter(
        fontSize: 13,
        fontWeight: FontWeight.w500,
        color: textMediumEmphasis,
        letterSpacing: -0.08,
        height: 1.33,
      ),
      labelSmall: GoogleFonts.inter(
        fontSize: 11,
        fontWeight: FontWeight.w500,
        color: textMediumEmphasis,
        letterSpacing: 0.07,
        height: 1.45,
      ),
    );
  }

  /// Специальные стили кнопок для интерфейса в стиле Apple Home
  static ButtonStyle getAppleHomeButtonStyle({
    required bool isLight,
    bool isPrimary = false,
    bool isDestructive = false,
  }) {
    if (isDestructive) {
      return FilledButton.styleFrom(
        foregroundColor: errorColor,
        backgroundColor: isLight ? Color(0xFFFFF5F5) : Color(0xFF2C1C1C),
        textStyle: GoogleFonts.inter(
          fontSize: 17,
          fontWeight: FontWeight.w400,
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8.0),
        ),
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      );
    }

    if (isPrimary) {
      return ElevatedButton.styleFrom(
        foregroundColor: Colors.white,
        backgroundColor: isLight ? primaryLight : primaryDark,
        textStyle: GoogleFonts.inter(
          fontSize: 17,
          fontWeight: FontWeight.w600,
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8.0),
        ),
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      );
    }

    // Стандартная серая кнопка как в Apple Home
    return FilledButton.styleFrom(
      foregroundColor: isLight ? textPrimaryLight : textPrimaryDark,
      backgroundColor: isLight ? Color(0xFFE5E5EA) : Color(0xFF38383A),
      textStyle: GoogleFonts.inter(
        fontSize: 17,
        fontWeight: FontWeight.w400,
      ),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8.0),
      ),
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
    );
  }
  

  static TextStyle getAppleMonospaceStyle({
    required bool isLight,
    double fontSize = 17,
    FontWeight fontWeight = FontWeight.w400,
    Color? color,
  }) {
    final Color textColor = color ?? (isLight ? textPrimary : textPrimaryDark);

    return GoogleFonts.inter(
      fontSize: fontSize,
      fontWeight: fontWeight,
      color: textColor,
      letterSpacing: -0.41,
    );
  }

   static TextStyle getMonospaceStyle({
    required bool isLight,
    double fontSize = 14,
    FontWeight fontWeight = FontWeight.w400,
    Color? color,
  }) {
    return getAppleMonospaceStyle(
      isLight: isLight,
      fontSize: fontSize,
      fontWeight: fontWeight,
      color: color,
    );
  }

  static BoxDecoration getAppleCardDecoration({
    required bool isLight,
    double borderRadius = 12.0,
    bool hasBorder = true,
  }) {
    return BoxDecoration(
      color: isLight ? cardLight : cardDark,
      borderRadius: BorderRadius.circular(borderRadius),
      border: hasBorder
          ? Border.all(
              color: isLight ? borderLight : borderDark,
              width: 0.5,
            )
          : null,
      boxShadow: [
        BoxShadow(
          color: isLight ? shadowLight : shadowDark,
          blurRadius: 10,
          offset: const Offset(0, 1),
        ),
      ],
    );
  }

  static BoxDecoration getGlassMorphismDecoration({
    required bool isLight,
    double borderRadius = 12.0,
    double opacity = 1.0,
  }) {
    return getAppleCardDecoration(
      isLight: isLight,
      borderRadius: borderRadius,
    );
  }


  /// Стиль для кнопок действий устройств (как в Apple Home)
  static ButtonStyle getDeviceActionButtonStyle({
    required bool isLight,
    bool isActive = false,
  }) {
    return OutlinedButton.styleFrom(
      foregroundColor: isActive ? 
        (isLight ? primaryLight : primaryDark) : 
        (isLight ? textSecondaryLight : textSecondaryDark),
      backgroundColor: Colors.transparent,
      side: BorderSide(
        color: isActive ? 
          (isLight ? primaryLight : primaryDark) : 
          (isLight ? borderLight : borderDark),
        width: 1.0,
      ),
      textStyle: GoogleFonts.inter(
        fontSize: 15,
        fontWeight: isActive ? FontWeight.w600 : FontWeight.w400,
      ),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8.0),
      ),
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
    );
  }
}

