import 'package:flutter/material.dart';

// TODO: Denemelerin bittikten sonra hepsini static yap. setstate olunca değişmesi için static değil. en son halinde de neden statik olmalı öğren.
class AppColors {
  static bool isDark = true;

  static void updateTheme({
    required bool isDarkTheme,
  }) {
    isDark = isDarkTheme;
  }

  // Border Radius
  static const double borderRadius = 8;
  static BorderRadius borderRadiusAll = const BorderRadius.all(Radius.circular(borderRadius));
  static BorderRadius highBorderRadiusAll = const BorderRadius.all(Radius.circular(borderRadius * 3));
  static BorderRadius borderRadiusTop = const BorderRadius.vertical(
    top: Radius.circular(borderRadius),
  );
  static BorderRadius borderRadiusBottom = const BorderRadius.vertical(
    bottom: Radius.circular(borderRadius),
  );
  static BorderRadius borderRadiusCircular = const BorderRadius.all(
    Radius.circular(125),
  );

  // Padding
  static const EdgeInsets showcasePadding = EdgeInsets.all(3);

  // Main Colors
  static const Color transparent = Color.fromRGBO(0, 0, 0, 0);
  static const Color deepBlack = Color.fromRGBO(15, 15, 15, 1);
  static const Color deepWhite = Color.fromARGB(255, 255, 255, 255);
  static const Color black = Color.fromRGBO(16, 16, 16, 1);
  static const Color lightblack = Color.fromRGBO(32, 32, 32, 1);
  static const Color transparantBlack = Color.fromRGBO(16, 16, 16, 0.5);
  static const Color grey = Color.fromARGB(255, 99, 99, 99);
  static const Color dirtyWhite = Color.fromARGB(255, 168, 168, 168);
  static const Color white = Color.fromARGB(255, 250, 250, 250);
  static const Color red = Color.fromARGB(255, 218, 17, 17);
  static const Color dirtyRed = Color.fromARGB(255, 182, 28, 28);
  static const Color pink = Color.fromARGB(255, 224, 18, 163);
  static const Color blue = Color.fromARGB(255, 13, 121, 209);
  static const Color deepBlue = Color.fromARGB(255, 0, 83, 151);
  static const Color yellow = Color.fromARGB(255, 238, 196, 10);
  static const Color orange = Color.fromARGB(255, 238, 113, 10);
  static const Color orange2 = Color.fromARGB(255, 255, 152, 0);
  static const Color green = Color.fromARGB(255, 53, 226, 10);
  static const Color deepGreen = Color.fromARGB(255, 37, 184, 0);
  static const Color purple = Color.fromARGB(255, 145, 3, 211);
  static const Color deepPurple = Color.fromARGB(255, 96, 3, 158);
  static const Color lightGreen = Color.fromARGB(255, 137, 224, 140);

  // App Colors
  static Color get cursor {
    if (isDark) {
      return const Color.fromARGB(255, 204, 204, 204);
    } else {
      return const Color.fromARGB(255, 66, 66, 66);
    }
  }

  // Button Colors
  static Color hover = const Color.fromARGB(48, 73, 73, 73);

  // Theme Colors
  static Color main = const Color.fromARGB(255, 23, 115, 219);
  static Color lightMain = const Color.fromARGB(255, 70, 150, 241);
  static Color deepMain = const Color.fromARGB(255, 10, 64, 126);

  // TODO: boxShadows için de yap
  // Shadows
  static const List<Shadow> basicShadow = [
    Shadow(
      color: AppColors.transparantBlack,
      offset: Offset(1, 1),
      blurRadius: 2,
    ),
  ];
  static const List<BoxShadow> bottomShadow = [
    BoxShadow(
      spreadRadius: 0,
      blurRadius: 5,
      offset: Offset(0, 2),
    ),
  ];

  //////////////////////////////////////////////////////////////////////////
  static Color get background {
    if (isDark) {
      return const Color.fromARGB(255, 15, 15, 15);
    } else {
      return const Color.fromARGB(255, 226, 226, 226);
    }
  }

  static Color get onBackground {
    if (isDark) {
      return const Color.fromARGB(255, 247, 247, 247);
    } else {
      return const Color.fromARGB(255, 32, 32, 32);
    }
  }

  static Color get deepContrast {
    if (isDark) {
      return const Color.fromARGB(255, 0, 0, 0);
    } else {
      return const Color.fromARGB(255, 255, 255, 255);
    }
  }

  static Color get panelBackground {
    if (isDark) {
      return const Color.fromARGB(255, 34, 34, 34);
    } else {
      return const Color.fromARGB(255, 247, 247, 247);
    }
  }

  static Color get panelBackground2 {
    if (isDark) {
      return const Color.fromARGB(255, 54, 54, 54);
    } else {
      return const Color.fromARGB(255, 231, 231, 231);
    }
  }

  static Color get panelBackground3 {
    if (isDark) {
      return const Color.fromARGB(255, 70, 70, 70);
    } else {
      return const Color.fromARGB(255, 214, 214, 214);
    }
  }

  static Color get text {
    if (isDark) {
      return const Color.fromARGB(255, 245, 245, 245);
    } else {
      return const Color.fromARGB(255, 19, 19, 19);
    }
  }

  static Color get appbar {
    if (isDark) {
      return const Color.fromARGB(255, 32, 32, 32);
    } else {
      return const Color.fromARGB(255, 218, 218, 218);
    }
  }

  // skillColors
  static List<Color> skillColors = [
    const Color.fromARGB(255, 255, 105, 0),
    const Color.fromARGB(255, 107, 65, 18),
    const Color.fromARGB(255, 110, 194, 0),
    const Color.fromARGB(255, 0, 195, 255),
    const Color.fromARGB(255, 255, 0, 221),
    const Color.fromARGB(255, 0, 3, 204),
    const Color.fromARGB(255, 228, 194, 0),
    const Color.fromARGB(255, 221, 7, 0),
    const Color.fromARGB(255, 89, 0, 255),
    const Color.fromARGB(255, 0, 88, 27),
    const Color.fromARGB(255, 129, 49, 29),
    const Color.fromARGB(255, 67, 0, 155),
  ];

  // ---------------------------------------------------------------------------------------------------------------

  // Dark Theme
  ThemeData appTheme = ThemeData(
    // Scaffold Background Color
    scaffoldBackgroundColor: background,

    // Bottom Navigation Bar
    bottomNavigationBarTheme: BottomNavigationBarThemeData(
      type: BottomNavigationBarType.fixed,
      backgroundColor: panelBackground,
      elevation: 0,
      unselectedIconTheme: IconThemeData(
        color: white.withValues(alpha: 0.7),
        size: 27,
      ),
      unselectedLabelStyle: const TextStyle(
        fontSize: 12,
      ),
      selectedItemColor: white,
      selectedIconTheme: const IconThemeData(
        color: white,
        size: 30,
      ),
      selectedLabelStyle: const TextStyle(
        fontSize: 12,
      ),
      showSelectedLabels: false,
      showUnselectedLabels: false,
    ),
    // AppBar
    appBarTheme: AppBarTheme(
      toolbarHeight: 40,
      backgroundColor: appbar,
      surfaceTintColor: appbar,
      iconTheme: IconThemeData(
        color: text,
      ),
      titleTextStyle: TextStyle(
        color: text,
        fontSize: 22,
        fontWeight: FontWeight.bold,
      ),
      actionsIconTheme: IconThemeData(
        color: text,
      ),
      toolbarTextStyle: TextStyle(
        color: text,
        fontSize: 14,
        fontWeight: FontWeight.bold,
      ),
      foregroundColor: red,
      centerTitle: true,
    ),
    // List Tile
    listTileTheme: ListTileThemeData(
      tileColor: background,
      selectedTileColor: background,
      iconColor: text,
      textColor: text,
    ),
    // Divider
    dividerTheme: DividerThemeData(
      color: onBackground,
      thickness: 1,
    ),
    radioTheme: RadioThemeData(
      fillColor: WidgetStateProperty.all<Color>(main),
    ),
    // Icon
    iconTheme: IconThemeData(
      color: text,
    ),
    // Dialog
    dialogTheme: DialogTheme(
      backgroundColor: background,
      surfaceTintColor: background,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
        side: const BorderSide(
          color: AppColors.grey,
          width: 1,
        ),
      ),
    ),
    // IconButton
    iconButtonTheme: IconButtonThemeData(
      style: ButtonStyle(
        overlayColor: WidgetStatePropertyAll<Color>(hover),
      ),
    ),
    // Time Picker
    timePickerTheme: TimePickerThemeData(
      backgroundColor: background,
      hourMinuteColor: panelBackground,
      dialBackgroundColor: panelBackground,
      dialTextColor: text,
      entryModeIconColor: text,
      confirmButtonStyle: ElevatedButton.styleFrom(
        backgroundColor: main,
        shape: RoundedRectangleBorder(
          borderRadius: borderRadiusAll,
        ),
      ),
      hourMinuteTextColor: text,
      dayPeriodColor: main,
      dayPeriodBorderSide: BorderSide(
        color: main,
        width: 2,
      ),
      dayPeriodShape: RoundedRectangleBorder(
        borderRadius: borderRadiusAll,
      ),
      dayPeriodTextColor: text,
    ),
    // Textfield
    inputDecorationTheme: InputDecorationTheme(
      filled: false,
      border: OutlineInputBorder(
        borderRadius: borderRadiusAll,
        borderSide: BorderSide(
          color: onBackground,
          width: 1,
        ),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: borderRadiusAll * 1.5,
        borderSide: BorderSide(
          color: onBackground,
          width: 2,
        ),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: borderRadiusAll,
        borderSide: BorderSide(
          color: onBackground,
          width: 1,
        ),
      ),
      errorBorder: OutlineInputBorder(
        borderRadius: borderRadiusAll,
        borderSide: const BorderSide(
          color: red,
          width: 2,
        ),
      ),
      focusedErrorBorder: OutlineInputBorder(
        borderRadius: borderRadiusAll,
        borderSide: const BorderSide(
          color: red,
          width: 3,
        ),
      ),
      disabledBorder: OutlineInputBorder(
        borderRadius: borderRadiusAll,
        borderSide: BorderSide(
          color: onBackground,
          width: 1,
        ),
      ),
      labelStyle: TextStyle(
        color: text,
      ),
      hintStyle: const TextStyle(
        color: dirtyWhite,
      ),
    ),

    // PopMenu
    popupMenuTheme: PopupMenuThemeData(
      color: background,
      shape: RoundedRectangleBorder(
        borderRadius: borderRadiusAll,
      ),
      textStyle: TextStyle(
        color: text,
      ),
      labelTextStyle: WidgetStateProperty.all<TextStyle>(
        TextStyle(
          color: text,
        ),
      ),
    ),

    // Date Picker
    datePickerTheme: DatePickerThemeData(
      confirmButtonStyle: ButtonStyle(
        backgroundColor: WidgetStateProperty.all<Color>(main),
        shape: WidgetStateProperty.all<RoundedRectangleBorder>(
          RoundedRectangleBorder(
            borderRadius: borderRadiusAll,
          ),
        ),
        foregroundColor: WidgetStateProperty.all<Color>(deepWhite),
      ),
      cancelButtonStyle: ButtonStyle(
        overlayColor: WidgetStateProperty.all<Color>(hover),
        foregroundColor: WidgetStateProperty.all<Color>(text),
      ),
    ),

    // Slider
    sliderTheme: SliderThemeData(
      trackHeight: 4,
      thumbShape: const RoundSliderThumbShape(
        enabledThumbRadius: 8.0,
      ),
      overlayShape: const RoundSliderOverlayShape(
        overlayRadius: 8.0,
      ),
      thumbColor: onBackground,
      activeTrackColor: main,
      inactiveTrackColor: grey,
    ),
    // BottomSheet
    bottomSheetTheme: BottomSheetThemeData(
      backgroundColor: background,
      surfaceTintColor: background,
      shape: RoundedRectangleBorder(
        borderRadius: borderRadiusTop,
      ),
    ),
    // Progress Indicator
    progressIndicatorTheme: ProgressIndicatorThemeData(
      color: main,
    ),
    // Text
    textTheme: TextTheme(
      bodyLarge: TextStyle(color: text, decorationColor: text),
      bodyMedium: TextStyle(color: text, decorationColor: text),
      bodySmall: TextStyle(color: text, decorationColor: text),
      displayLarge: TextStyle(color: text, decorationColor: text),
      displayMedium: TextStyle(color: text, decorationColor: text),
      displaySmall: TextStyle(color: text, decorationColor: text),
      labelLarge: TextStyle(color: text, decorationColor: text),
      labelMedium: TextStyle(color: text, decorationColor: text),
      labelSmall: TextStyle(color: text, decorationColor: text),
      titleLarge: TextStyle(color: text, decorationColor: text, fontWeight: FontWeight.bold),
      titleMedium: TextStyle(color: text, decorationColor: text, fontWeight: FontWeight.bold),
      titleSmall: TextStyle(color: text, decorationColor: text, fontWeight: FontWeight.bold),
      headlineLarge: TextStyle(color: text, decorationColor: text, fontWeight: FontWeight.bold),
      headlineMedium: TextStyle(color: text, decorationColor: text, fontWeight: FontWeight.bold),
      headlineSmall: TextStyle(color: text, decorationColor: text, fontWeight: FontWeight.bold),
    ),
    // Text Button
    textButtonTheme: TextButtonThemeData(
      style: ButtonStyle(
        foregroundColor: WidgetStateProperty.all<Color>(text),
        overlayColor: WidgetStateProperty.all<Color>(text.withValues(alpha: 0.1)),
        shape: WidgetStateProperty.all<RoundedRectangleBorder>(
          RoundedRectangleBorder(
            borderRadius: borderRadiusAll,
          ),
        ),
      ),
    ),

    // Elevated Button
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ButtonStyle(
        backgroundColor: WidgetStateProperty.all<Color>(main),
        foregroundColor: WidgetStateProperty.all<Color>(text),
        surfaceTintColor: WidgetStateProperty.all<Color>(background),
        shape: WidgetStateProperty.all<RoundedRectangleBorder>(
          RoundedRectangleBorder(
            borderRadius: borderRadiusAll,
          ),
        ),
        padding: WidgetStateProperty.all<EdgeInsetsGeometry>(
          const EdgeInsets.symmetric(
            horizontal: 15,
            vertical: 10,
          ),
        ),
      ),
    ),
    // Checkbox
    checkboxTheme: CheckboxThemeData(
      checkColor: WidgetStateProperty.all<Color>(background),
      overlayColor: WidgetStateProperty.all<Color>(hover),
      side: BorderSide(
        color: main,
        width: 2,
      ),
    ),
    // Floating Action Button
    floatingActionButtonTheme: FloatingActionButtonThemeData(
      backgroundColor: deepWhite,
      foregroundColor: black,
      splashColor: hover,
      elevation: 3,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(50)),
      ),
    ),
    // Switch
    switchTheme: SwitchThemeData(
      thumbColor: WidgetStateProperty.all<Color>(lightMain),
      trackOutlineColor: WidgetStateProperty.all<Color>(transparent),
    ),
    hintColor: dirtyWhite,
    textSelectionTheme: TextSelectionThemeData(cursorColor: cursor),
    // SnackBar
    snackBarTheme: SnackBarThemeData(
      backgroundColor: appbar,
      contentTextStyle: TextStyle(
        color: text,
        fontSize: 16,
        overflow: TextOverflow.ellipsis,
      ),
    ),
    // card
    cardTheme: CardTheme(
      color: background,
      shadowColor: black,
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: borderRadiusAll,
      ),
    ),
    // TODO:default container radius

    // ---------------------

    // Color Scheme
    colorScheme: ColorScheme(
      brightness: Brightness.dark,
      // primary: main,
      // onPrimary: lightMain,
      // secondary: const Color.fromARGB(255, 0, 255, 213),
      // onSecondary: const Color.fromARGB(255, 0, 255, 0),
      // error: Colors.red,
      // onError: const Color.fromARGB(255, 255, 0, 13),
      // surface: onBackground,
      // onSurface: background,

      primary: main,
      onPrimary: background,
      secondary: lightMain,
      onSecondary: const Color.fromARGB(157, 0, 241, 0),
      error: Colors.red,
      onError: const Color.fromARGB(255, 255, 0, 13),
      surface: panelBackground2,
      onSurface: text,

      // TODO: düzenlenecek. gerekli değilse kaldır
      // errorContainer: const Color(0xFF93000A),
      // onErrorContainer: const Color(0xFFFFDAD6),
      // primaryContainer: main,
      // onPrimaryContainer: const Color(0xFFDCE1FF),
      // secondaryContainer: const Color(0xFF424659),
      // onSben önceliklecondaryContainer: const Color(0xFFDEE1F9),
      // tertiary: const Color(0xFFE3BADA),
      // onTertiary: const Color(0xFF43273F),
      // tertiaryContainer: const Color(0xFF5B3D57),
      // onTertiaryContainer: const Color(0xFFFFD7F5),
      // surfaceVariant: const Color(0xFF45464F),
      // onSurfaceVariant: const Color(0xFFC6C5D0),
      // outline: const Color(0xFF90909A),
      // onInverseSurface: const Color(0xFF1B1B1F),
      // inverseSurface: const Color(0xFFE4E1E6),
      // inversePrimary: lightMain,
      // shadow: const Color(0xFF000000),
      // surfaceTint: const Color(0xFFB7C4FF),
      // outlineVariant: const Color(0xFF45464F),
      // scrim: const Color(0xFF000000),
    ),
  );

// TODO: dark a göre düzenle
  // Light Theme
}
