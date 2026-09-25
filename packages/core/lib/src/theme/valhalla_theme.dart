import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../models/enums.dart';

/// "Hearth & Iron" palette. Single dark theme in v1.
///
/// Gold is the action colour and the colour of coins; Frost is reserved for
/// XP and progress. The two never swap roles.
class VColors {
  VColors._();
  static const bg = Color(0xFF0E0B09);
  static const surface = Color(0xFF1A1411);
  static const surface2 = Color(0xFF241C17);
  static const surface3 = Color(0xFF2F2520);
  static const border = Color(0xFF3A302A);
  static const line = border;
  static const sheet = Color(0xFF1E1712);
  static const field = Color(0xFF140F0C);

  static const bone = Color(0xFFEDE3D0);
  static const ash = Color(0xFFA39684);
  static const ash2 = Color(0xFF7E7366);
  static const parchment = Color(0xFFCDBB98);

  static const gold = Color(0xFFE3A645);
  static const goldBright = Color(0xFFF5C66B);
  static const goldDim = Color(0xFF8A6428);
  static const ornament = Color(0xFFB98A3E);
  static const onGold = Color(0xFF241607);

  static const frost = Color(0xFF6FB3C8);
  static const frostBright = Color(0xFFA6DCEB);
  static const moss = Color(0xFF86B368);
  static const amber = Color(0xFFE89A4A);
  static const blood = Color(0xFFA8322A);
  static const bloodText = Color(0xFFE26A5C);
  static const rune = Color(0xFF5FA8DA);

  static const rarityCommon = Color(0xFF9A958D);
  static const rarityRare = rune;
  static const rarityLegendary = Color(0xFFE8AE48);

  static Color rarity(ItemRarity r) => switch (r) {
        ItemRarity.common => rarityCommon,
        ItemRarity.rare => rarityRare,
        ItemRarity.legendary => rarityLegendary,
      };

  /// Per-level accent for badges, rings and stage tints.
  static const levelColors = <int, Color>{
    1: Color(0xFF8C857B),
    2: Color(0xFFA8774D),
    3: Color(0xFF72A05A),
    4: Color(0xFF6FA0C6),
    5: Color(0xFFCF5A45),
    6: Color(0xFFA27CCF),
    7: Color(0xFFE2B24F),
    8: Color(0xFFF4E6BD),
  };

  static Color level(int l) => levelColors[l] ?? ash;

  static const goldGradient = LinearGradient(
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
    colors: [Color(0xFFF8D183), Color(0xFFE7AB4C), Color(0xFFC98B30)],
    stops: [0, .5, 1],
  );
  static const cardGradient = LinearGradient(
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
    colors: [Color(0xFF211913), Color(0xFF171210)],
  );
}

/// Type helpers. Cinzel for names, titles and big numbers; Manrope for
/// everything that is read; Noto Sans Runic only as decoration.
class VType {
  VType._();

  static TextStyle cinzel({double size = 20, FontWeight weight = FontWeight.w700, Color color = VColors.bone, double? spacing, double? height}) =>
      GoogleFonts.cinzel(fontSize: size, fontWeight: weight, color: color, letterSpacing: spacing, height: height);

  static TextStyle body({double size = 15, FontWeight weight = FontWeight.w500, Color color = VColors.bone, double? height, double? spacing, bool tabular = false}) =>
      GoogleFonts.manrope(
        fontSize: size,
        fontWeight: weight,
        color: color,
        height: height,
        letterSpacing: spacing,
        fontFeatures: tabular ? const [FontFeature.tabularFigures()] : null,
      );

  static TextStyle runes({double size = 15, Color color = VColors.goldDim, double spacing = 6}) =>
      GoogleFonts.notoSansRunic(fontSize: size, color: color, letterSpacing: spacing);

  /// Small caps section label ("DEMNÄCHST IN DER HALLE").
  static TextStyle eyebrow({double size = 12, Color color = const Color(0xFFC9B89A)}) =>
      cinzel(size: size, weight: FontWeight.w700, color: color, spacing: size * .16);

  static TextStyle title({double size = 22}) => cinzel(size: size, weight: FontWeight.w700, spacing: .6);
}

/// Decorative runes only; far-right associated signs (Othala, Sowilo, Algiz,
/// Hagalaz, Tiwaz, Eihwaz) are deliberately excluded.
const safeRunes = 'ᚠ ᚢ ᚦ ᚨ ᚱ ᚲ ᚷ ᚹ ᚾ ᛁ ᛃ ᛈ ᛒ ᛖ ᛗ ᛚ ᛞ';

ThemeData valhallaTheme() {
  const scheme = ColorScheme.dark(
    primary: VColors.gold,
    onPrimary: VColors.onGold,
    secondary: VColors.frost,
    onSecondary: VColors.bg,
    surface: VColors.surface,
    onSurface: VColors.bone,
    error: VColors.bloodText,
    onError: VColors.bg,
    outline: VColors.border,
    surfaceContainerHighest: VColors.surface2,
  );
  final base = ThemeData(useMaterial3: true, colorScheme: scheme, brightness: Brightness.dark);
  final text = GoogleFonts.manropeTextTheme(base.textTheme).apply(bodyColor: VColors.bone, displayColor: VColors.bone);
  final radius12 = BorderRadius.circular(14);
  return base.copyWith(
    scaffoldBackgroundColor: VColors.bg,
    canvasColor: VColors.bg,
    splashFactory: InkSparkle.splashFactory,
    textTheme: text.copyWith(
      headlineMedium: VType.cinzel(size: 26),
      headlineSmall: VType.cinzel(size: 22),
      titleLarge: VType.cinzel(size: 20),
      titleMedium: text.titleMedium?.copyWith(fontWeight: FontWeight.w700),
      labelSmall: text.labelSmall?.copyWith(color: VColors.ash, letterSpacing: 1.2),
    ),
    appBarTheme: AppBarTheme(
      backgroundColor: VColors.bg,
      foregroundColor: VColors.bone,
      elevation: 0,
      scrolledUnderElevation: 0,
      centerTitle: false,
      titleTextStyle: VType.cinzel(size: 20, spacing: .6),
    ),
    cardTheme: CardThemeData(
      color: VColors.surface,
      elevation: 0,
      margin: EdgeInsets.zero,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(18), side: const BorderSide(color: VColors.border)),
    ),
    navigationBarTheme: NavigationBarThemeData(
      backgroundColor: VColors.surface,
      indicatorColor: VColors.gold.withValues(alpha: 0.18),
      iconTheme: WidgetStateProperty.resolveWith((s) => IconThemeData(color: s.contains(WidgetState.selected) ? VColors.gold : VColors.ash)),
      labelTextStyle: WidgetStateProperty.resolveWith(
          (s) => TextStyle(fontSize: 11, fontWeight: FontWeight.w600, color: s.contains(WidgetState.selected) ? VColors.gold : VColors.ash)),
    ),
    navigationRailTheme: const NavigationRailThemeData(
      backgroundColor: VColors.surface,
      selectedIconTheme: IconThemeData(color: VColors.gold),
      unselectedIconTheme: IconThemeData(color: VColors.ash),
      selectedLabelTextStyle: TextStyle(color: VColors.gold, fontWeight: FontWeight.w600),
      unselectedLabelTextStyle: TextStyle(color: VColors.ash),
    ),
    inputDecorationTheme: InputDecorationTheme(
      filled: true,
      fillColor: VColors.field,
      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
      hintStyle: VType.body(color: VColors.ash2),
      labelStyle: VType.body(color: VColors.ash, size: 14),
      border: OutlineInputBorder(borderRadius: radius12, borderSide: const BorderSide(color: VColors.border)),
      enabledBorder: OutlineInputBorder(borderRadius: radius12, borderSide: const BorderSide(color: VColors.border)),
      focusedBorder: OutlineInputBorder(borderRadius: radius12, borderSide: BorderSide(color: VColors.gold.withValues(alpha: .8), width: 1.5)),
      errorBorder: OutlineInputBorder(borderRadius: radius12, borderSide: const BorderSide(color: VColors.bloodText)),
    ),
    filledButtonTheme: FilledButtonThemeData(
      style: FilledButton.styleFrom(
        backgroundColor: VColors.gold,
        foregroundColor: VColors.onGold,
        minimumSize: const Size(64, 50),
        shape: RoundedRectangleBorder(borderRadius: radius12),
        textStyle: VType.body(weight: FontWeight.w800, size: 15),
      ),
    ),
    outlinedButtonTheme: OutlinedButtonThemeData(
      style: OutlinedButton.styleFrom(
        foregroundColor: VColors.bone,
        side: const BorderSide(color: VColors.border),
        minimumSize: const Size(64, 48),
        shape: RoundedRectangleBorder(borderRadius: radius12),
      ),
    ),
    textButtonTheme: TextButtonThemeData(style: TextButton.styleFrom(foregroundColor: VColors.gold, textStyle: VType.body(weight: FontWeight.w800, size: 14))),
    chipTheme: ChipThemeData(
      backgroundColor: VColors.surface2,
      side: const BorderSide(color: VColors.border),
      labelStyle: const TextStyle(color: VColors.bone, fontSize: 12),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(999)),
    ),
    dividerTheme: const DividerThemeData(color: VColors.border, thickness: 1, space: 1),
    snackBarTheme: SnackBarThemeData(
      backgroundColor: VColors.surface3,
      contentTextStyle: VType.body(size: 14, weight: FontWeight.w600),
      behavior: SnackBarBehavior.floating,
      shape: RoundedRectangleBorder(borderRadius: radius12),
    ),
    dialogTheme: DialogThemeData(
      backgroundColor: VColors.sheet,
      titleTextStyle: VType.cinzel(size: 20),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(22), side: const BorderSide(color: VColors.border)),
    ),
    bottomSheetTheme: const BottomSheetThemeData(
      backgroundColor: VColors.sheet,
      modalBackgroundColor: VColors.sheet,
      showDragHandle: false,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.vertical(top: Radius.circular(28))),
    ),
    listTileTheme: const ListTileThemeData(iconColor: VColors.ash),
    switchTheme: SwitchThemeData(
      thumbColor: WidgetStateProperty.resolveWith((s) => s.contains(WidgetState.selected) ? const Color(0xFFFFF4DC) : const Color(0xFF8C8173)),
      trackColor: WidgetStateProperty.resolveWith((s) => s.contains(WidgetState.selected) ? VColors.gold : const Color(0xFF2A221C)),
      trackOutlineColor: WidgetStateProperty.resolveWith((s) => s.contains(WidgetState.selected) ? VColors.goldBright.withValues(alpha: .7) : VColors.border),
    ),
    checkboxTheme: CheckboxThemeData(
      fillColor: WidgetStateProperty.resolveWith((s) => s.contains(WidgetState.selected) ? VColors.gold : Colors.transparent),
      checkColor: const WidgetStatePropertyAll(VColors.onGold),
      side: const BorderSide(color: Color(0xFF5A4C40), width: 1.5),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(6)),
    ),
    progressIndicatorTheme: const ProgressIndicatorThemeData(color: VColors.gold),
    dataTableTheme: const DataTableThemeData(headingTextStyle: TextStyle(color: VColors.ash, fontWeight: FontWeight.w600)),
  );
}
