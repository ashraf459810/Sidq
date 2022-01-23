import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';
import 'package:sidq/App/app.dart';

Widget loadingNews() {
  return SizedBox(height: h(400),
    child: Column(
      children: [
           SizedBox(height: h(100),),
        Shimmer.fromColors(
          baseColor: Colors.grey,
          highlightColor: Colors.grey[50]!,
          child: Container(height: h(100),),
        ),
        SizedBox(height: h(100),),
          Shimmer.fromColors(
          baseColor: Colors.grey,
          highlightColor: Colors.grey[50]!,
          child: Container(height: h(100),),
        ),
           SizedBox(height: h(100),),
         Shimmer.fromColors(
          baseColor: Colors.grey,
          highlightColor: Colors.grey[50]!,
          child: Container(height: h(100),),
        ),
      ],
    ),
  );
}
