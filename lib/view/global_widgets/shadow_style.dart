import 'package:flutter/material.dart';

import '../../extentions/app_colors.dart';
import 'AppColors.dart';

BoxDecoration getdecoration(
    {double? borderRadius = 20, BuildContext? context}) {
  return BoxDecoration(
      color: AppColors.theme_color,
      borderRadius: BorderRadius.circular(borderRadius!));
}
