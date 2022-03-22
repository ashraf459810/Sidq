import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sidq/App/app.dart';
import 'package:sidq/Widgets/nav.dart';
import 'package:sidq/core/consts.dart';
import 'package:sidq/features/home/presentation/pages/home.dart';
import 'package:sidq/features/index_page/presentation/pages/index.dart';
import 'package:sidq/features/reverse_serach/presentation/pages/reverse_image_search.dart';


import 'navigation_sample.dart';

bottomBar(BuildContext context , Size size , [int ? index] ){
   return   SizedBox(
          height: size.height * 0.10,
          child: Stack(
            children: [
              Positioned(
                bottom:0,
                left: 0,
                child: SizedBox(
                  width: size.width,
                  height: h(80),
                  child: Stack(
                    children: [
                      // CustomPaint(
                      //   size: Size(size.width, 80),
                      //   painter: BNBCustomPainter(),
                      // ),
          
                      SizedBox(
                        width: size.width,
                        height: h(80),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            GestureDetector(
                              onTap: () {
                           
                                // navWithReplacement(context, const ReviewTickets());
                              },
                              child:navigationSample('ابلاغاتي', 'profile.png')
                            ),
                            GestureDetector(
                              onTap: () {
                                 navWithReplacement(
                                                context,
                                                const HomeBar(
                                                  categoryId:
                                                      '3d0a5e84-9c54-46c1-8522-39daf705ce13',
                                                ));
                                //  navWithReplacement(context, const ReportFakeNews(isReport: true,title: 'الابلاغ عن خبر زائف',));
                              },
                              child: navigationSample('وعي', 'main 3.png')
                            ),
                             GestureDetector(onTap: (){
                               if (index != 2)
                    navWithReplacement(context, const ReverseImageSearch());
                             },
                               child: Center(
                                                       heightFactor: 1.2,
                                                       child:
                                                       Icon(
                                  Icons.search,
                                  color: AppColor.yellow,
                                  size: 60.sp,
                                ),
                                                         
                                                     ),
                             ),
                            // Container(
                            //   width: size.width * 0.20,
                            // ),
                            GestureDetector(
                              onTap: () {
                                   navWithReplacement(context, const HomeBar());
                              },
                              child:  navigationSample('تحقيقات', 'main 1.png',10.sp)
                            ),
                            GestureDetector(
                              onTap: () {
                        
                                navWithReplaceAll(context,  IndexPage());
                              },
                              child: navigationSample('الرئيسية', 'icon home.png',10.sp)
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              )
            ],
          ),
        );
       
       
}