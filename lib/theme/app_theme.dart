import 'package:flutter/material.dart';

/// Thèmes clair et sombre de l'application.
///
/// L'ambiance visee est "salle de cinema" : des surfaces profondes en mode
/// sombre, un violet electrique comme couleur principale et un ambre chaud
/// reserve aux notes et aux etoiles.
class AppTheme {
  AppTheme._();

  /// Couleur des etoiles et des notes, identique dans les deux themes.
  static const Color star = Color(0xFFFFC24B);

  static const Color _violet = Color(0xFF6C5CE7);
  static const Color _violetClair = Color(0xFF9B8CFF);

  static ThemeData get light => _build(Brightness.light);
  static ThemeData get dark => _build(Brightness.dark);

  static ThemeData _build(Brightness brightness) {
    final bool sombre = brightness == Brightness.dark;
    final ColorScheme colors = sombre ? _darkScheme : _lightScheme;

    return ThemeData(
      useMaterial3: true,
      brightness: brightness,
      colorScheme: colors,
      scaffoldBackgroundColor: colors.surface,
      splashFactory: InkSparkle.splashFactory,

      appBarTheme: AppBarTheme(
        backgroundColor: colors.surface,
        foregroundColor: colors.onSurface,
        surfaceTintColor: Colors.transparent,
        elevation: 0,
        scrolledUnderElevation: 0,
        centerTitle: false,
        titleTextStyle: TextStyle(
          fontSize: 21,
          fontWeight: FontWeight.w800,
          letterSpacing: -0.6,
          color: colors.onSurface,
        ),
      ),

      textTheme: _textTheme(colors),

      cardTheme: CardThemeData(
        color: colors.surfaceContainer,
        elevation: sombre ? 0 : 6,
        shadowColor: sombre ? Colors.transparent : const Color(0x14000000),
        surfaceTintColor: Colors.transparent,
        margin: EdgeInsets.zero,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(22),
          side: sombre
              ? BorderSide(color: colors.outlineVariant)
              : BorderSide.none,
        ),
      ),

      chipTheme: ChipThemeData(
        backgroundColor: colors.surfaceContainerHigh,
        selectedColor: colors.primary,
        labelStyle: TextStyle(
          color: colors.onSurfaceVariant,
          fontWeight: FontWeight.w600,
          fontSize: 13,
        ),
        side: BorderSide.none,
        shape: const StadiumBorder(),
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
      ),

      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: colors.surfaceContainerHigh,
        hintStyle: TextStyle(color: colors.onSurfaceVariant, fontSize: 15),
        labelStyle: TextStyle(color: colors.onSurfaceVariant),
        prefixIconColor: colors.onSurfaceVariant,
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 18,
          vertical: 17,
        ),
        border: _bordure(colors.outlineVariant, 0),
        enabledBorder: _bordure(colors.outlineVariant, 0),
        focusedBorder: _bordure(colors.primary, 1.6),
        errorBorder: _bordure(colors.error, 1.2),
        focusedErrorBorder: _bordure(colors.error, 1.6),
      ),

      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: colors.primary,
          foregroundColor: colors.onPrimary,
          disabledBackgroundColor: colors.surfaceContainerHighest,
          elevation: 0,
          padding: const EdgeInsets.symmetric(vertical: 18),
          textStyle: const TextStyle(
            fontWeight: FontWeight.w700,
            fontSize: 15.5,
            letterSpacing: 0.2,
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
        ),
      ),

      iconButtonTheme: IconButtonThemeData(
        style: IconButton.styleFrom(foregroundColor: colors.onSurfaceVariant),
      ),

      dividerTheme: DividerThemeData(
        color: colors.outlineVariant,
        thickness: 1,
        space: 1,
      ),

      snackBarTheme: SnackBarThemeData(
        backgroundColor: colors.inverseSurface,
        contentTextStyle: TextStyle(color: colors.onInverseSurface),
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(14),
        ),
      ),
    );
  }

  static OutlineInputBorder _bordure(Color couleur, double epaisseur) {
    return OutlineInputBorder(
      borderRadius: BorderRadius.circular(16),
      borderSide: epaisseur == 0
          ? BorderSide.none
          : BorderSide(color: couleur, width: epaisseur),
    );
  }

  static TextTheme _textTheme(ColorScheme colors) {
    return TextTheme(
      displaySmall: TextStyle(
        fontSize: 30,
        fontWeight: FontWeight.w800,
        letterSpacing: -1,
        height: 1.15,
        color: colors.onSurface,
      ),
      headlineSmall: TextStyle(
        fontSize: 23,
        fontWeight: FontWeight.w800,
        letterSpacing: -0.6,
        height: 1.2,
        color: colors.onSurface,
      ),
      titleLarge: TextStyle(
        fontSize: 18,
        fontWeight: FontWeight.w700,
        letterSpacing: -0.3,
        color: colors.onSurface,
      ),
      titleMedium: TextStyle(
        fontSize: 15.5,
        fontWeight: FontWeight.w700,
        letterSpacing: -0.2,
        color: colors.onSurface,
      ),
      bodyMedium: TextStyle(
        fontSize: 14.5,
        height: 1.55,
        color: colors.onSurfaceVariant,
      ),
      bodySmall: TextStyle(
        fontSize: 12.5,
        height: 1.4,
        letterSpacing: 0.1,
        color: colors.onSurfaceVariant,
      ),
      labelLarge: TextStyle(
        fontSize: 13,
        fontWeight: FontWeight.w700,
        letterSpacing: 0.3,
        color: colors.onSurface,
      ),
    );
  }

  static final ColorScheme _darkScheme =
      ColorScheme.fromSeed(
        seedColor: _violet,
        brightness: Brightness.dark,
      ).copyWith(
        primary: _violetClair,
        onPrimary: const Color(0xFF17132B),
        secondary: star,
        onSecondary: const Color(0xFF241A00),
        surface: const Color(0xFF0B0E14),
        onSurface: const Color(0xFFE9EBF2),
        surfaceContainer: const Color(0xFF141922),
        surfaceContainerHigh: const Color(0xFF1B212C),
        surfaceContainerHighest: const Color(0xFF232A37),
        onSurfaceVariant: const Color(0xFF98A2B3),
        outlineVariant: const Color(0xFF262E3B),
        inverseSurface: const Color(0xFFE9EBF2),
        onInverseSurface: const Color(0xFF14161C),
      );

  static final ColorScheme _lightScheme =
      ColorScheme.fromSeed(
        seedColor: _violet,
        brightness: Brightness.light,
      ).copyWith(
        primary: const Color(0xFF5B4BE8),
        onPrimary: Colors.white,
        secondary: const Color(0xFFB57C00),
        onSecondary: Colors.white,
        surface: const Color(0xFFF5F6FB),
        onSurface: const Color(0xFF13161D),
        surfaceContainer: Colors.white,
        surfaceContainerHigh: Colors.white,
        surfaceContainerHighest: const Color(0xFFECEEF6),
        onSurfaceVariant: const Color(0xFF5B6474),
        outlineVariant: const Color(0xFFE2E6F0),
        inverseSurface: const Color(0xFF13161D),
        onInverseSurface: Colors.white,
      );
}
