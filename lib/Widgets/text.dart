import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';


Widget text(
  
    {required String text,
    Color? color,
    int ?maxLines,
    double ?fontsize,
    FontWeight? fontWeight,
    String ?fontfamily,
    TextDecoration? textDecoration,
    TextAlign? textAlign}) {
  return Directionality(textDirection: TextDirection.rtl,
    child: Text(
         
      
      text,
       				overflow: TextOverflow.fade,
      
      textAlign: textAlign ?? TextAlign.start,
  maxLines: maxLines??10,
      style: TextStyle(
        overflow: TextOverflow.fade,
        
          decoration: textDecoration ?? TextDecoration.none,
          fontFamily: fontfamily ?? "font",
          color: color,
          fontSize: fontsize ?? 14.sp,
          fontWeight: fontWeight ?? FontWeight.normal),
    ),
  );
}
