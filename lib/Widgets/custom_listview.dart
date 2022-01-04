import 'package:flutter/material.dart';

Widget sliverAppBarWithListviews(
    {Widget? image,
    String? title,
    Widget? listViewWidget1,
    Widget? listViewWidget2,
    int? listView1Length,
    int? listView2Length,
    EdgeInsetsGeometry? listView1Padding,
    EdgeInsetsGeometry? listView2Padding,
    Function? ontap2,
    Function? ontap1}) {
  return CustomScrollView(shrinkWrap: true, slivers: [
    SliverAppBar(
      // pinned: true,
      // snap: true,
      // floating: false,
      expandedHeight: 160.0,
      flexibleSpace: FlexibleSpaceBar(
        title: Text(title!),
        background: image,
      ),
    ),
    SliverList(
      delegate: SliverChildBuilderDelegate(
        (context, index) => GestureDetector(
          onTap: () {
            ontap1!();
          },
          child: Padding(padding: listView1Padding!, child: listViewWidget1),
        ),
        childCount: listView1Length,
      ),
    ),
    SliverList(
      delegate: SliverChildBuilderDelegate(
        (context, index) => GestureDetector(
          onTap: () {
            ontap2!();
          },
          child: Padding(padding: listView2Padding!, child: listViewWidget2),
        ),
        childCount: listView2Length,
      ),
    )
  ]);
}
