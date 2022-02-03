 import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sidq/App/app.dart';
import 'package:sidq/Widgets/text.dart';
import 'package:sidq/core/consts.dart';
navigationSample (String title , String icon , [double ?  fontSize]){
return Container(
                             
                                  height: h(80),
                                  width: w(50),
                                  decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      color:
                                 
                                            AppColor.yellow,),
                                  child: Center(
                                      child: ListView(shrinkWrap: true ,
                                        children: [
                                          Image.asset('assets/images/'+icon,height: h(22),width: w(20),fit: BoxFit.contain,color: AppColor.purple,),
                                          
                                          text(
                                              fontfamily: 'marai',
                                              text: title,
                                              fontsize: fontSize ?? 10.sp,
                                         
                                          color:        AppColor.purple,
                                          
                                              fontWeight: FontWeight.bold,
                                              textAlign: TextAlign.center),
                                        ],
                                      )));}