import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:manga_app/common/constants/size_constants.dart';
import 'package:manga_app/common/extensions/size_extension.dart';
import 'package:manga_app/views/themes/app_color.dart';

class AppText {
  const AppText._();

  static TextTheme get _ibmPlexSansTextTheme =>
      GoogleFonts.ibmPlexSansTextTheme();

  static TextStyle get _whiteHeadline6 =>
      _ibmPlexSansTextTheme.headline6.copyWith(
        fontSize: Sizes.dimen_20.sp,
        color: Colors.black,
      );

  static TextStyle get _whiteHeadline5 =>
      _ibmPlexSansTextTheme.headline5.copyWith(
        fontSize: Sizes.dimen_24.sp,
        color: Colors.black,
      );

  static TextStyle get _whiteSubTitle1 =>
      _ibmPlexSansTextTheme.subtitle1.copyWith(
        fontSize: Sizes.dimen_16.sp,
        color: Colors.black,
      );

  static TextStyle get _whiteTextButton =>
      _ibmPlexSansTextTheme.button.copyWith(
        fontSize: Sizes.dimen_16.sp,
        color: Colors.black,
      );

  static TextStyle get _whiteBodyText2 =>
      _ibmPlexSansTextTheme.bodyText2.copyWith(
          fontSize: Sizes.dimen_14.sp,
          color: Colors.black,
          wordSpacing: 0.25,
          letterSpacing: 0.25);

  static getTextTheme() => TextTheme(
      headline5: _whiteHeadline5,
      headline6: _whiteHeadline6,
      subtitle1: _whiteSubTitle1,
      bodyText2: _whiteBodyText2,
      button: _whiteTextButton);
}

extension ThemeTextExtension on TextTheme {
  TextStyle get primarySubTitle1 =>
      subtitle1.copyWith(color: AppColors.primary, fontWeight: FontWeight.w600);

  TextStyle get greySubtitle1 => subtitle1.copyWith(
        color: Colors.grey,
      );

  TextStyle get secondaryHeadline6 => headline6.copyWith(
        color: AppColors.secondary,
      );
}
