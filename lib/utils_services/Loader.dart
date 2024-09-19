import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:sizer/sizer.dart';

import 'colors_util.dart';

Widget spinKitGlobal({double? size}) {
  return SpinKitPulse(
    color: blueGrey,
    size: size!,
  );
}

Widget screenLoader({Function()? onTap, bool? use_opacity = true}) {
  return InkWell(
    onTap: onTap,
    child: Container(
      height: 100.h,
      width: 100.w,
      child: Center(
        child: spinKitGlobal(
          size: 30.0,
        ),
      ),
      decoration: !use_opacity!
          ? BoxDecoration()
          : BoxDecoration(color: Colors.black.withOpacity(0.3)),
    ),
  );
}
