import 'package:flutter/material.dart';

import 'colors.dart';

class AppTheme {
  static String truenoFont = "Trueno";
  static String actionSansFont = "ActionSans";
  static ThemeData theme(BuildContext context) => ThemeData(
      useMaterial3: true,
      splashColor: AppColors.primarySwatch[50],
      disabledColor: AppColors.neutralSwatch[100],
      textButtonTheme: TextButtonThemeData(
          style: TextButton.styleFrom(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(5)))),
      appBarTheme: AppBarTheme(
        backgroundColor: AppColors.colorWhite,
        foregroundColor: AppColors.colorWhite,
        surfaceTintColor: AppColors.colorWhite,
        iconTheme: IconThemeData(
          color: AppColors.primarySwatch[700],
        ),
        elevation: 0,
      ),
      fontFamily: actionSansFont,
      dividerTheme: DividerThemeData(
          color: AppColors.neutralSwatch[100], thickness: 1, space: 0),
      scaffoldBackgroundColor: AppColors.colorWhite,
      bottomSheetTheme: BottomSheetThemeData(
          backgroundColor: AppColors.colorWhite,
          elevation: 0,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(20))),
      primaryColor: AppColors.primarySwatch[700],
      colorScheme: ColorScheme.fromSwatch(
        primarySwatch: MaterialColor(
          AppColors.primarySwatch[700]!.value,
          AppColors.primarySwatch,
        ),
        errorColor: AppColors.accentRed[900],
      ).copyWith(
          secondary: MaterialColor(
        AppColors.secondarySwatch[700]!.value,
        AppColors.secondarySwatch,
      )));
}
