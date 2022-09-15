import 'package:flutter/cupertino.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'colors.dart';

class AppTextStyle {
  static TextStyle get title {
    return TextStyle(
      fontSize: 18.sp,
      color: AppColors.titleTextColor,
    );
  }

  static TextStyle get bodyL {
    return TextStyle(
      fontSize: 16.sp,
      color: AppColors.bodyTextColor,
    );
  }

  static TextStyle get bodyM {
    return TextStyle(
      fontSize: 14.sp,
      color: AppColors.bodyTextColor,
    );
  }

  static TextStyle get bodyS {
    return TextStyle(
      fontSize: 12.sp,
      color: AppColors.bodyTextColor,
    );
  }

  static TextStyle get price {
    return TextStyle(
      fontSize: 15.sp,
      color: AppColors.primary,
    );
  }

  static TextStyle get subTitle16 {
    return TextStyle(
      fontSize: 16.sp,
      color: AppColors.titleTextColor,
    );
  }

  static TextStyle get subTitle14 {
    return TextStyle(
      fontSize: 14.sp,
      color: AppColors.titleTextColor,
    );
  }
}
