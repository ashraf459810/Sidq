import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

loadingNews() {
  return Column(
    children: [
      Shimmer.fromColors(
        baseColor: Colors.red,
        highlightColor: Colors.yellow,
        child: Container(),
      ),
      Shimmer.fromColors(
        baseColor: Colors.red,
        highlightColor: Colors.yellow,
        child: Container(),
      ),
      Shimmer.fromColors(
        baseColor: Colors.red,
        highlightColor: Colors.yellow,
        child: Container(),
      ),
    ],
  );
}
