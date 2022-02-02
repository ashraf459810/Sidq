import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shimmer/shimmer.dart';
import 'package:sidq/App/app.dart';
import 'package:sidq/Widgets/container.dart';
import 'package:sidq/Widgets/text.dart';
import 'package:sidq/core/consts.dart';

Widget newsSample(String image, String desc, String title,String date) {
    return Stack(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            container(
                color: Colors.white,
                hight: h(145),
                width: w(220),
                borderRadius: 10,
                child: Column(
                  children: [
                    Container(
                      alignment: Alignment.centerRight,
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: text(text: title, fontsize: 13.sp, fontWeight: FontWeight.bold,maxLines: 1,fontfamily: 'marai'),
                      ),
                    ),
                    Container(
                      // color: Colors.grey,
                      alignment: Alignment.centerRight,
                      child: Padding(
                        padding:  EdgeInsets.only(right: w(8),left: w(8),),
                        child: Container(
                          // color: Colors.red,
                          child: text(maxLines: 5,
                          fontfamily: 'marai',
                          fontWeight: FontWeight.bold,
                            text: desc, fontsize: 11.sp,textAlign: TextAlign.right),
                        ),
                      ),
                    ),
              
                  ],
                )),
            ClipRRect(
              borderRadius: const BorderRadius.all(Radius.circular(10)),

              // ignore: unnecessary_null_comparison
              child: image!=null? CachedNetworkImage(         height: h(145),
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
                bottom: h(1),
                right: w(150),

                child: Container(
                        alignment: Alignment.centerRight,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: text(text: date,color: AppColor.purple,fontWeight: FontWeight.bold,fontsize: 10.sp),
                    )),
              )
      ],
    );
  }