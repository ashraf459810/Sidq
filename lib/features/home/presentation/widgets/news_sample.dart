import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shimmer/shimmer.dart';
import 'package:sidq/App/app.dart';
import 'package:sidq/Widgets/container.dart';
import 'package:sidq/Widgets/text.dart';

Widget newsSample(String image, String desc, String title) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        container(
            color: Colors.white,
            hight: h(140),
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
                Container(alignment: Alignment.centerRight,
                  child: Padding(
                    padding:  EdgeInsets.only(right: w(8),left: w(8),bottom: h(8)),
                    child: text(maxLines: 4,
                    fontfamily: 'marai',
                      text: desc, fontsize: 11.sp,textAlign: TextAlign.right),
                  ),
                ),
              ],
            )),
        ClipRRect(
          borderRadius: const BorderRadius.all(Radius.circular(10)),

          // ignore: unnecessary_null_comparison
          child: image!=null? CachedNetworkImage(         height: h(140),
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
    );
  }