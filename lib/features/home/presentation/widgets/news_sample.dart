import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:shimmer/shimmer.dart';
import 'package:sidq/App/app.dart';
import 'package:sidq/Widgets/container.dart';
import 'package:sidq/Widgets/text.dart';
import 'package:sidq/core/consts.dart';

Widget newsSample(String image, String desc, String title,String date,int views) {
    return Stack(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            container(
        
                color: Colors.white,
                hight: h(125),
                width: w(220),
                
                borderRadius: 10,
                
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                        constraints: BoxConstraints(minHeight: h(22),maxHeight: h(40)),
                      // color: Colors.red,
                          alignment: Alignment.topCenter,
                 
                  
                        width: w(200),
                        child: Row(mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Flexible(child: text(text: title, fontsize: 12.sp, fontWeight: FontWeight.bold,fontfamily: 'marai')),
                          ],
                        ),
                      ),
                    ),
                    Container(
                      alignment: Alignment.topCenter,
                    // color: Colors.green,
                      height: h(61),
                      width: w(250),
                      // color: Colors.red,
                      child: Padding(
                        padding:  EdgeInsets.symmetric(horizontal: w(10)),
                        child: Row(mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Flexible(
                              child: text(maxLines: 3,
                              fontfamily: 'marai',
                              // fontWeight: FontWeight.bold,
                                text: desc, fontsize: 10.sp,),
                            ),
                          ],
                        ),
                      ),
                    ),
              
                  ],
                )),
            ClipRRect(
              borderRadius: const BorderRadius.all(Radius.circular(10)),

              // ignore: unnecessary_null_comparison
              child: image!=null? CachedNetworkImage(         height: h(125),
                width: w(120),
                fit: BoxFit.fitHeight,
            imageUrl: image,
            placeholder: (context, url) => Shimmer(child: Container(height: h(120),), gradient:const LinearGradient(
                  begin: Alignment.topRight,
                  end: Alignment.bottomLeft,
                  colors: [
                    Colors.grey,
                    Colors.black,
                  ],
                )
              ),

            errorWidget: (context, url, error) => const Icon(Icons.error),
         ):const SizedBox(),
              
              
              
        
            )
          ],
        ),
              Positioned(
                bottom: h(-2),
                right: w(150),

                child: Container(
                        alignment: Alignment.centerRight,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: text(text: date,color: AppColor.purple,fontWeight: FontWeight.bold,fontsize: 10.sp),
                    )),
              ),
                Positioned(
                bottom: h(-2),
                right: w(300),

                child: Container(
                        alignment: Alignment.centerRight,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        children: [
                          SvgPicture.asset('assets/images/views.svg',height: h(8),width: w(8),color: AppColor.purple,),
                          SizedBox(width: w(5),),
                          text(text: views.toString(),color: AppColor.purple,fontWeight: FontWeight.bold,fontsize: 9.sp),
                          
                        ],
                      ),
                    )),
              )
      ],
    );
  }