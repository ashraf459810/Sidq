import 'package:flutter/material.dart';

Widget customlistview(
  
    {final double? hight,
    final double? width,
    final bool ? reverse,
    final int? itemcount,
    final direction,
    final double? padding,
    final controller,
    final bool? scroll,
    @required final function}) {
  return SizedBox(
    height: hight,
    width: width,
    child: ListView.builder(
      
      reverse:  reverse??false,
        physics: ScrollPhysics(

            parent: scroll!
                ? const AlwaysScrollableScrollPhysics()
                : const NeverScrollableScrollPhysics()),
        shrinkWrap: true,
        controller: controller ?? ScrollController(),
        padding: EdgeInsets.symmetric(vertical: padding!),
        itemCount: itemcount,
        scrollDirection:
            direction == "vertical" ? Axis.vertical : Axis.horizontal,
        itemBuilder: function),
  );
}
