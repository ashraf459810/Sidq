import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';
import 'package:sidq/App/app.dart';

Widget loadingcategories(){return
 SizedBox(
   height: h(50),
   
   child: Shimmer.fromColors(
        baseColor: Colors.grey[300]!,
        highlightColor: Colors.grey,
        child: ListView(
          shrinkWrap: true,
          scrollDirection: Axis.horizontal,
          children:
     
     [
         Card(
           elevation: 1.0,
           shape: RoundedRectangleBorder(
   borderRadius: BorderRadius.circular(16),
           ),
           child: const SizedBox(height: 50,width: 60,),
          ),


           Card(
           elevation: 1.0,
           shape: RoundedRectangleBorder(
   borderRadius: BorderRadius.circular(16),
           ),
           child: const SizedBox(height: 50,width: 60,),
          ),

   Card(
           elevation: 1.0,
           shape: RoundedRectangleBorder(
   borderRadius: BorderRadius.circular(16),
           ),
           child: const SizedBox(height: 50,width: 60,),
          ),

   Card(
           elevation: 1.0,
           shape: RoundedRectangleBorder(
   borderRadius: BorderRadius.circular(16),
           ),
           child: const SizedBox(height: 50,width: 60,),
          ),

                Card(
           elevation: 1.0,
           shape: RoundedRectangleBorder(
   borderRadius: BorderRadius.circular(16),
           ),
           child: const SizedBox(height: 50,width: 60,),
          ),
      Card(
           elevation: 1.0,
           shape: RoundedRectangleBorder(
   borderRadius: BorderRadius.circular(16),
           ),
           child: const SizedBox(height: 50,width: 60,),
          ),
      Card(
           elevation: 1.0,
           shape: RoundedRectangleBorder(
   borderRadius: BorderRadius.circular(16),
           ),
           child: const SizedBox(height: 50,width: 60,),
          ),




          
     ]
        ),
      ),
 );}