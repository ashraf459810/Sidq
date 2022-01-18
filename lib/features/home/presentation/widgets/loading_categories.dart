import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

loadingCategoreis() {
  return SizedBox(
    width: 200.0,
    height: 100.0,
    child: Shimmer.fromColors(
      baseColor: Colors.red,
      highlightColor: Colors.yellow,
      child: Container(),
    ),
  );
}
