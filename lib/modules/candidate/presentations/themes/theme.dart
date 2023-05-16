import 'package:app/configs/font_style_text.dart';
import 'package:app/modules/candidate/presentations/themes/color.dart';
import 'package:flutter/material.dart';

final ThemeData themeData = ThemeData(
    useMaterial3: true,
    appBarTheme: const AppBarTheme(
        color: colorBackgroundAppBar,
        titleTextStyle: textStyleTitleAppBar,
        centerTitle: true));
