import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

/// A class that contains all theme configurations redesigned in Apple Home app style.
class AppTheme {
  AppTheme._();

  // Apple Home app inspired color palette
  static const Color primaryLight =
      Color(0xFF007AFF); // Apple system blue for primary elements
  static const Color primaryDark =
      Color(0xFF0A84FF); // Darker blue for dark mode
  static const Color secondaryLight =
      Color(0xFFFF9500); // Apple system orange for accent elements
  static const Color secondaryDark =
      Color(0xFFFF9F0A); // Darker orange for dark mode

  // Clean background system matching Apple Home
  static const Color backgroundLight =
      Color(0xFFFAFAFA); // Very light gray background
  static const Color backgroundDark =
      Color(0xFF000000); // Pure black for dark mode
  static const Color surfaceLight = Color(0xFFFFFFFF); // Pure white surfaces
  static const Color surfaceDark = Color(0xFF1C1C1E); // Apple dark surface

  // Text colors following Apple system guidelines
  static const Color textPrimary = Color(0xFF000000); // Pure black text
  static const Color textSecondary =
      Color(0xFF8E8E93); // Apple secondary text gray
  static const Color textPrimaryDark =
      Color(0xFFFFFFFF); // White text for dark mode
  static const Color textSecondaryDark =
      Color(0xFF8E8E93); // Consistent secondary gray

  // Card and surface colors with Apple Home styling
  static const Color cardLight = Color(0xFFFFFFFF); // Pure white cards
  static const Color cardDark = Color(0xFF2C2C2E); // Apple card dark
  static const Color dialogLight = Color(0xFFFFFFFF); // White dialogs
  static const Color dialogDark = Color(0xFF2C2C2E); // Dark dialogs

  // Apple-style subtle shadows and borders
  static const Color shadowLight =
      Color(0x08000000); // Very subtle shadow (3% opacity)
  static const Color shadowDark =
      Color(0x40000000); // Slightly more visible in dark
  static const Color borderLight = Color(0xFFE5E5EA); // Apple separator color
  static const Color borderDark = Color(0xFF38383A); // Dark mode separator

  // Semantic colors matching Apple system colors
  static const Color successColor = Color(0xFF34C759); // Apple system green
  static const Color warningColor = Color(0xFFFF9500); // Apple system orange
  static const Color errorColor = Color(0xFFFF3B30); // Apple system red

  /// Light theme optimized for Apple Home app style
  static ThemeData lightTheme = ThemeData(
    brightness: Brightness.light,
    colorScheme: ColorScheme(
      brightness: Brightness.light,
      primary: primaryLight,
      onPrimary: Colors.white,
      primaryContainer: primaryLight.withValues(alpha: 0.1),
      onPrimaryContainer: primaryLight,
      secondary: secondaryLight,
      onSecondary: Colors.white,
      secondaryContainer: secondaryLight.withValues(alpha: 0.1),
      onSecondaryContainer: secondaryLight,
      tertiary: warningColor,
      onTertiary: Colors.white,
      tertiaryContainer: warningColor.withValues(alpha: 0.1),
      onTertiaryContainer: warningColor,
      error: errorColor,
      onError: Colors.white,
      surface: surfaceLight,
      onSurface: textPrimary,
      onSurfaceVariant: textSecondary,
      outline: borderLight,
      outlineVariant: borderLight.withValues(alpha: 0.5),
      shadow: shadowLight,
      scrim: Colors.black26,
      inverseSurface: surfaceDark,
      onInverseSurface: textPrimaryDark,
      inversePrimary: primaryDark,
    ),
    scaffoldBackgroundColor: backgroundLight,
    cardColor: cardLight,
    dividerColor: borderLight,

    // Apple-style app bar with clean design
    appBarTheme: AppBarTheme(
      backgroundColor: surfaceLight,
      foregroundColor: textPrimary,
      elevation: 0,
      scrolledUnderElevation: 0,
      shadowColor: Colors.transparent,
      surfaceTintColor: Colors.transparent,
      titleTextStyle: GoogleFonts.inter(
        fontSize: 17,
        fontWeight: FontWeight.w600,
        color: textPrimary,
        letterSpacing: -0.41,
      ),
      toolbarTextStyle: GoogleFonts.inter(
        fontSize: 17,
        fontWeight: FontWeight.w400,
        color: textPrimary,
      ),
    ),

    // Apple Home style cards with subtle elevation
    cardTheme: CardThemeData(
      color: cardLight,
      elevation: 0,
      shadowColor: shadowLight,
      surfaceTintColor: Colors.transparent,
      shape: RoundedRectangleBorder(
        borderRadius:
            BorderRadius.circular(12.0), // Apple's standard corner radius
        side: BorderSide(color: borderLight, width: 0.5),
      ),
      margin: const EdgeInsets.all(4.0),
    ),

    // Bottom navigation with Apple styling
    bottomNavigationBarTheme: BottomNavigationBarThemeData(
      backgroundColor: surfaceLight.withValues(alpha: 0.95),
      selectedItemColor: primaryLight,
      unselectedItemColor: textSecondary,
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
    floatingActionButtonTheme: FloatingActionButtonThemeData(
      backgroundColor: primaryLight,
      foregroundColor: Colors.white,
      elevation: 6,
      focusElevation: 8,
      hoverElevation: 8,
      highlightElevation: 10,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16.0),
      ),
    ),

    // Apple system button styles
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        foregroundColor: Colors.white,
        backgroundColor: primaryLight,
        disabledForegroundColor: textSecondary,
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
        foregroundColor: primaryLight,
        disabledForegroundColor: textSecondary,
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
        minimumSize: const Size(88, 44),
        side: BorderSide(color: primaryLight, width: 1.0),
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
        foregroundColor: primaryLight,
        disabledForegroundColor: textSecondary,
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
        borderSide: BorderSide(color: borderLight, width: 1.0),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10.0),
        borderSide: BorderSide(color: borderLight, width: 1.0),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10.0),
        borderSide: BorderSide(color: primaryLight, width: 2.0),
      ),
      errorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10.0),
        borderSide: BorderSide(color: errorColor, width: 1.0),
      ),
      focusedErrorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10.0),
        borderSide: BorderSide(color: errorColor, width: 2.0),
      ),
      labelStyle: GoogleFonts.inter(
        color: textSecondary,
        fontSize: 17,
        fontWeight: FontWeight.w400,
      ),
      hintStyle: GoogleFonts.inter(
        color: textSecondary.withValues(alpha: 0.6),
        fontSize: 17,
        fontWeight: FontWeight.w400,
      ),
      errorStyle: GoogleFonts.inter(
        color: errorColor,
        fontSize: 13,
        fontWeight: FontWeight.w400,
      ),
    ),

    // Apple system switches
    switchTheme: SwitchThemeData(
      thumbColor: WidgetStateProperty.resolveWith((states) {
        if (states.contains(WidgetState.selected)) {
          return Colors.white;
        }
        return Colors.white;
      }),
      trackColor: WidgetStateProperty.resolveWith((states) {
        if (states.contains(WidgetState.selected)) {
          return successColor;
        }
        return borderLight;
      }),
      overlayColor: WidgetStateProperty.resolveWith((states) {
        if (states.contains(WidgetState.pressed)) {
          return primaryLight.withValues(alpha: 0.12);
        }
        return null;
      }),
    ),

    // Apple checkboxes
    checkboxTheme: CheckboxThemeData(
      fillColor: WidgetStateProperty.resolveWith((states) {
        if (states.contains(WidgetState.selected)) {
          return primaryLight;
        }
        return Colors.transparent;
      }),
      checkColor: WidgetStateProperty.all(Colors.white),
      overlayColor: WidgetStateProperty.resolveWith((states) {
        if (states.contains(WidgetState.pressed)) {
          return primaryLight.withValues(alpha: 0.12);
        }
        return null;
      }),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(3.0),
      ),
    ),

    // Apple radio buttons
    radioTheme: RadioThemeData(
      fillColor: WidgetStateProperty.resolveWith((states) {
        if (states.contains(WidgetState.selected)) {
          return primaryLight;
        }
        return textSecondary;
      }),
      overlayColor: WidgetStateProperty.resolveWith((states) {
        if (states.contains(WidgetState.pressed)) {
          return primaryLight.withValues(alpha: 0.12);
        }
        return null;
      }),
    ),

    // Progress indicators in Apple blue
    progressIndicatorTheme: ProgressIndicatorThemeData(
      color: primaryLight,
      linearTrackColor: borderLight,
      circularTrackColor: borderLight,
    ),

    // Apple-style sliders
    sliderTheme: SliderThemeData(
      activeTrackColor: primaryLight,
      thumbColor: Colors.white,
      overlayColor: primaryLight.withValues(alpha: 0.12),
      inactiveTrackColor: borderLight,
      valueIndicatorColor: primaryLight,
      valueIndicatorTextStyle: GoogleFonts.inter(
        color: Colors.white,
        fontSize: 14,
        fontWeight: FontWeight.w600,
      ),
    ),

    // Apple tab bar styling
    tabBarTheme: TabBarThemeData(
      labelColor: primaryLight,
      unselectedLabelColor: textSecondary,
      indicatorColor: primaryLight,
      indicatorSize: TabBarIndicatorSize.tab,
      labelStyle: GoogleFonts.inter(
        fontSize: 13,
        fontWeight: FontWeight.w600,
        letterSpacing: -0.08,
      ),
      unselectedLabelStyle: GoogleFonts.inter(
        fontSize: 13,
        fontWeight: FontWeight.w400,
        letterSpacing: -0.08,
      ),
    ),

    // Apple tooltips
    tooltipTheme: TooltipThemeData(
      decoration: BoxDecoration(
        color: textPrimary.withValues(alpha: 0.9),
        borderRadius: BorderRadius.circular(8),
      ),
      textStyle: GoogleFonts.inter(
        color: Colors.white,
        fontSize: 13,
        fontWeight: FontWeight.w400,
      ),
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
    ),

    // Apple-style snackbars
    snackBarTheme: SnackBarThemeData(
      backgroundColor: textPrimary,
      contentTextStyle: GoogleFonts.inter(
        color: Colors.white,
        fontSize: 17,
        fontWeight: FontWeight.w400,
      ),
      actionTextColor: primaryLight,
      behavior: SnackBarBehavior.floating,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
      ),
      elevation: 6,
    ),

    // Apple bottom sheets
    bottomSheetTheme: const BottomSheetThemeData(
      backgroundColor: Colors.transparent,
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(16.0)),
      ),
    ),

    dialogTheme: DialogThemeData(backgroundColor: dialogLight),
  );

  /// Dark theme optimized for Apple Home app dark mode
  static ThemeData darkTheme = ThemeData(
    brightness: Brightness.dark,
    colorScheme: ColorScheme(
      brightness: Brightness.dark,
      primary: primaryDark,
      onPrimary: Colors.white,
      primaryContainer: primaryDark.withValues(alpha: 0.2),
      onPrimaryContainer: primaryDark,
      secondary: secondaryDark,
      onSecondary: Colors.white,
      secondaryContainer: secondaryDark.withValues(alpha: 0.2),
      onSecondaryContainer: secondaryDark,
      tertiary: warningColor,
      onTertiary: Colors.white,
      tertiaryContainer: warningColor.withValues(alpha: 0.2),
      onTertiaryContainer: warningColor,
      error: errorColor,
      onError: Colors.white,
      surface: surfaceDark,
      onSurface: textPrimaryDark,
      onSurfaceVariant: textSecondaryDark,
      outline: borderDark,
      outlineVariant: borderDark.withValues(alpha: 0.5),
      shadow: shadowDark,
      scrim: Colors.black54,
      inverseSurface: surfaceLight,
      onInverseSurface: textPrimary,
      inversePrimary: primaryLight,
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
      toolbarTextStyle: GoogleFonts.inter(
        fontSize: 17,
        fontWeight: FontWeight.w400,
        color: textPrimaryDark,
      ),
    ),

    // Dark mode cards
    cardTheme: CardThemeData(
      color: cardDark,
      elevation: 0,
      shadowColor: shadowDark,
      surfaceTintColor: Colors.transparent,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12.0),
        side: BorderSide(color: borderDark, width: 0.5),
      ),
      margin: const EdgeInsets.all(4.0),
    ),

    // Dark mode bottom navigation
    bottomNavigationBarTheme: BottomNavigationBarThemeData(
      backgroundColor: surfaceDark.withValues(alpha: 0.95),
      selectedItemColor: primaryDark,
      unselectedItemColor: textSecondaryDark,
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

    // Dark mode floating action button
    floatingActionButtonTheme: FloatingActionButtonThemeData(
      backgroundColor: primaryDark,
      foregroundColor: Colors.white,
      elevation: 6,
      focusElevation: 8,
      hoverElevation: 8,
      highlightElevation: 10,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16.0),
      ),
    ),

    // Dark mode buttons
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        foregroundColor: Colors.white,
        backgroundColor: primaryDark,
        disabledForegroundColor: textSecondaryDark,
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
        disabledForegroundColor: textSecondaryDark,
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
        minimumSize: const Size(88, 44),
        side: BorderSide(color: primaryDark, width: 1.0),
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
        disabledForegroundColor: textSecondaryDark,
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

    // Dark mode text theme
    textTheme: _buildTextTheme(isLight: false),

    // Dark mode input fields
    inputDecorationTheme: InputDecorationTheme(
      fillColor: surfaceDark,
      filled: true,
      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10.0),
        borderSide: BorderSide(color: borderDark, width: 1.0),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10.0),
        borderSide: BorderSide(color: borderDark, width: 1.0),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10.0),
        borderSide: BorderSide(color: primaryDark, width: 2.0),
      ),
      errorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10.0),
        borderSide: BorderSide(color: errorColor, width: 1.0),
      ),
      focusedErrorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10.0),
        borderSide: BorderSide(color: errorColor, width: 2.0),
      ),
      labelStyle: GoogleFonts.inter(
        color: textSecondaryDark,
        fontSize: 17,
        fontWeight: FontWeight.w400,
      ),
      hintStyle: GoogleFonts.inter(
        color: textSecondaryDark.withValues(alpha: 0.6),
        fontSize: 17,
        fontWeight: FontWeight.w400,
      ),
      errorStyle: GoogleFonts.inter(
        color: errorColor,
        fontSize: 13,
        fontWeight: FontWeight.w400,
      ),
    ),

    // Dark mode switches
    switchTheme: SwitchThemeData(
      thumbColor: WidgetStateProperty.resolveWith((states) {
        if (states.contains(WidgetState.selected)) {
          return Colors.white;
        }
        return Colors.white;
      }),
      trackColor: WidgetStateProperty.resolveWith((states) {
        if (states.contains(WidgetState.selected)) {
          return successColor;
        }
        return borderDark;
      }),
      overlayColor: WidgetStateProperty.resolveWith((states) {
        if (states.contains(WidgetState.pressed)) {
          return primaryDark.withValues(alpha: 0.12);
        }
        return null;
      }),
    ),

    // Dark mode checkboxes
    checkboxTheme: CheckboxThemeData(
      fillColor: WidgetStateProperty.resolveWith((states) {
        if (states.contains(WidgetState.selected)) {
          return primaryDark;
        }
        return Colors.transparent;
      }),
      checkColor: WidgetStateProperty.all(Colors.white),
      overlayColor: WidgetStateProperty.resolveWith((states) {
        if (states.contains(WidgetState.pressed)) {
          return primaryDark.withValues(alpha: 0.12);
        }
        return null;
      }),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(3.0),
      ),
    ),

    // Dark mode radio buttons
    radioTheme: RadioThemeData(
      fillColor: WidgetStateProperty.resolveWith((states) {
        if (states.contains(WidgetState.selected)) {
          return primaryDark;
        }
        return textSecondaryDark;
      }),
      overlayColor: WidgetStateProperty.resolveWith((states) {
        if (states.contains(WidgetState.pressed)) {
          return primaryDark.withValues(alpha: 0.12);
        }
        return null;
      }),
    ),

    // Dark mode progress indicators
    progressIndicatorTheme: ProgressIndicatorThemeData(
      color: primaryDark,
      linearTrackColor: borderDark,
      circularTrackColor: borderDark,
    ),

    // Dark mode sliders
    sliderTheme: SliderThemeData(
      activeTrackColor: primaryDark,
      thumbColor: Colors.white,
      overlayColor: primaryDark.withValues(alpha: 0.12),
      inactiveTrackColor: borderDark,
      valueIndicatorColor: primaryDark,
      valueIndicatorTextStyle: GoogleFonts.inter(
        color: Colors.white,
        fontSize: 14,
        fontWeight: FontWeight.w600,
      ),
    ),

    // Dark mode tab bar
    tabBarTheme: TabBarThemeData(
      labelColor: primaryDark,
      unselectedLabelColor: textSecondaryDark,
      indicatorColor: primaryDark,
      indicatorSize: TabBarIndicatorSize.tab,
      labelStyle: GoogleFonts.inter(
        fontSize: 13,
        fontWeight: FontWeight.w600,
        letterSpacing: -0.08,
      ),
      unselectedLabelStyle: GoogleFonts.inter(
        fontSize: 13,
        fontWeight: FontWeight.w400,
        letterSpacing: -0.08,
      ),
    ),

    // Dark mode tooltips
    tooltipTheme: TooltipThemeData(
      decoration: BoxDecoration(
        color: textPrimaryDark.withValues(alpha: 0.9),
        borderRadius: BorderRadius.circular(8),
      ),
      textStyle: GoogleFonts.inter(
        color: Colors.black,
        fontSize: 13,
        fontWeight: FontWeight.w400,
      ),
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
    ),

    // Dark mode snackbars
    snackBarTheme: SnackBarThemeData(
      backgroundColor: surfaceDark,
      contentTextStyle: GoogleFonts.inter(
        color: textPrimaryDark,
        fontSize: 17,
        fontWeight: FontWeight.w400,
      ),
      actionTextColor: primaryDark,
      behavior: SnackBarBehavior.floating,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
      ),
      elevation: 6,
    ),

    // Dark mode bottom sheets
    bottomSheetTheme: const BottomSheetThemeData(
      backgroundColor: Colors.transparent,
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(16.0)),
      ),
    ),

    dialogTheme: DialogThemeData(backgroundColor: dialogDark),
  );

  /// Helper method to build Apple-inspired text theme using Inter font family
  static TextTheme _buildTextTheme({required bool isLight}) {
    final Color textHighEmphasis = isLight ? textPrimary : textPrimaryDark;
    final Color textMediumEmphasis =
        isLight ? textSecondary : textSecondaryDark;
    final Color textDisabled = isLight
        ? textSecondary.withValues(alpha: 0.6)
        : textSecondaryDark.withValues(alpha: 0.6);

    return TextTheme(
      // Large display text - Apple style
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

      // Headlines - Apple system font sizing
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

      // Titles - matching Apple Home app
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

      // Body text - Apple system body sizes
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

      // Labels - Apple style
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
        color: textDisabled,
        letterSpacing: 0.07,
        height: 1.45,
      ),
    );
  }

  /// Helper method to get Apple system monospace style for data display
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

  /// Helper method to create Apple Home app style card decoration
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

  /// Helper method to get Apple system colors
  static Color getAppleSystemColor(String type) {
    switch (type.toLowerCase()) {
      case 'blue':
      case 'primary':
        return primaryLight;
      case 'orange':
      case 'secondary':
        return secondaryLight;
      case 'green':
      case 'success':
        return successColor;
      case 'red':
      case 'error':
        return errorColor;
      case 'gray':
      case 'secondary_text':
        return textSecondary;
      default:
        return primaryLight;
    }
  }

  // Keep existing methods for backward compatibility
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

  static Color getSemanticColor(String type) {
    return getAppleSystemColor(type);
  }
}
