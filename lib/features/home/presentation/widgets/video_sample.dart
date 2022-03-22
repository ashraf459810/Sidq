import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sidq/App/app.dart';
import 'package:sidq/Widgets/text.dart';

Widget videoSample (String image , String title){
return Column(children: [

  Padding(
    padding:  EdgeInsets.symmetric(horizontal: w(40)),
    child: text(text: title, color: Colors.white,fontfamily: 'marai',fontWeight: FontWeight.bold,fontsize: 16.sp,textAlign: TextAlign.center),
  ),
  SizedBox(height: h(15),),
  SizedBox(
    height: h(300),
    width: w(300),
    child: ClipRRect(
      borderRadius: const BorderRadius.all(Radius.circular(20)),
      child: Image.network(image,fit: BoxFit.cover,),),
  )

],);

}