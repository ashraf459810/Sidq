import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';
import 'package:sidq/App/app.dart';

Widget loadingNewsDetils(){return
 Padding(
            padding:  EdgeInsets.only(top: h(50)),
            child: Shimmer.fromColors(
      baseColor: Colors.grey[300]!,
      highlightColor: Colors.grey,
      child: ListView(children:
   
   [
       Card(
         elevation: 1.0,
         shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
         ),
         child: const SizedBox(height: 200),
        ),


         Card(
         elevation: 1.0,
         shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
         ),
         child: const SizedBox(height: 80),
        ),

            Card(
         elevation: 1.0,
         shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
         ),
         child: const SizedBox(height: 40),
        ),

            Card(
         elevation: 1.0,
         shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
         ),
         child: const SizedBox(height: 60),
        ),

        



        
   ]
      ),
    ),
          );}