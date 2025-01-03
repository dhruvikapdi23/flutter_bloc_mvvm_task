
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'app_colors.dart';
import 'app_dimen.dart';


class AppTheme {
  static final light = ThemeData(
      primaryColor: AppColors.primaryColor,
      scaffoldBackgroundColor: AppColors.whiteColor,
      iconTheme: const IconThemeData(color: AppColors.textColor),
      cardColor: AppColors.cardColor,
      hintColor: AppColors.whiteColor,
      dividerColor: AppColors.blackColor,
      textTheme: TextTheme(
        //use
        displayLarge: getTextStyle(AppColors.textColor, FontDimen.dimen20,
            fontWeight: FontWeight.bold),
        //use
        displayMedium: getTextStyle(AppColors.textColor, FontDimen.dimen18,
            fontWeight: FontWeight.w600),
        //use
        displaySmall: getTextStyle(AppColors.textColor, FontDimen.dimen14,
            fontWeight: FontWeight.w600),
        headlineLarge: getTextStyle(
          AppColors.textColor,
          fontWeight: FontWeight.w500,
          FontDimen.dimen18,
        ),
        headlineMedium: getTextStyle(
          AppColors.textColor,
          fontWeight: FontWeight.w500,
          FontDimen.dimen18,
        ),
        //use
        headlineSmall: getTextStyle(
          AppColors.textColor,
          fontWeight: FontWeight.w500,
          FontDimen.dimen16,
        ),
        titleLarge: getTextStyle(
          AppColors.textColor,
          fontWeight: FontWeight.w400,
          FontDimen.dimen16,
        ),
        titleMedium: getTextStyle(
          AppColors.textColor,
          fontWeight: FontWeight.w400,
          FontDimen.dimen16,
        ),
        //use
        titleSmall: getTextStyle(
            AppColors.textColor,
            fontWeight: FontWeight.w300,
            FontDimen.dimen15),
        labelLarge: getTextStyle(
          AppColors.textColor,
          fontWeight: FontWeight.w400,
          FontDimen.dimen16,
        ),
        labelMedium: getTextStyle(
          AppColors.textColor,
          fontWeight: FontWeight.w400,
          FontDimen.dimen14,
        ),
        labelSmall: getTextStyle(AppColors.textColor, FontDimen.dimen16,
            fontWeight: FontWeight.w700),
        bodyLarge: getTextStyle(
          AppColors.textColor,
          fontWeight: FontWeight.w400,
          FontDimen.dimen12,
        ),
        bodyMedium: getTextStyle(
          AppColors.textColor,
          fontWeight: FontWeight.w400,
          FontDimen.dimen10,
        ),
        bodySmall: getTextStyle(
          AppColors.textColor,
          fontWeight: FontWeight.w400,
          FontDimen.dimen12,
        ),
      ));
}

TextStyle getTextStyle(Color color, double size,
        {FontWeight? fontWeight, String? fontFamily}) =>
    GoogleFonts.urbanist(
      color: color,
      fontSize: size,
      fontWeight: fontWeight ?? FontWeight.w400,
      textStyle: TextStyle(
        color: color,
        fontSize: size,
        fontWeight: fontWeight ?? FontWeight.w400,
      ),
    );
