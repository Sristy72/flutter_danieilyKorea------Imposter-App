import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../common/constants/app_colors.dart';
import 'app_colors.dart';

class AppTheme {
  static ThemeData get light => ThemeData(
    scaffoldBackgroundColor: AppColors.primaryBackground,
    primaryColor: AppColors.primaryBackground,
    colorScheme: ColorScheme.light(primary: AppColors.primaryBackground),

    textTheme: GoogleFonts.poppinsTextTheme(),
    appBarTheme: AppBarTheme(
      iconTheme: IconThemeData(color: Colors.white),
      backgroundColor: AppColors.primaryBackground,
      titleTextStyle: TextStyle(
        fontSize: 24,
        color: Colors.black,
        fontWeight: FontWeight.w600,
      ),
    ),
  );
}
