import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:sidq/App/app.dart';
import 'package:sidq/Widgets/nav.dart';
import 'package:sidq/Widgets/text.dart';
import 'package:sidq/core/consts.dart';
import 'package:sidq/features/home/presentation/pages/home.dart';
import 'package:sidq/features/index_page/presentation/widgets/about.dart';
import 'package:sidq/features/index_page/presentation/widgets/privacy.dart';

import 'package:sidq/features/reverse_serach/presentation/pages/reverse_image_search.dart';
import 'package:sidq/features/review_tickets/presentation/pages/review_tickets.dart';



class HomeDrawer extends StatefulWidget {
  const HomeDrawer({Key? key}) : super(key: key);

  @override
  _HomeDrawerState createState() => _HomeDrawerState();
}

class _HomeDrawerState extends State<HomeDrawer> {
  @override
  Widget build(BuildContext context) {
    return (
     
           Container(
            color: AppColor.purple,
            child: SizedBox(
              width: w(250),
              child: Column(
                children: [
                  SizedBox(
                    height: h(30),
                  ),
                  Row(
                    children: [
                      SizedBox(
                        width: w(10),
                      ),
                      IconButton(
                          icon: Icon(
                            Icons.close,
                            size: 40,
                            color: AppColor.yellow
                            ,
                          ),
                          onPressed: () => Navigator.of(context).pop()),
                    ],
                  ),
SizedBox(height: h(40),),

                 GestureDetector(
                   onTap: (){navigation(const HomeBar());},
                   child: SizedBox(
                     width: w(200),
                     child: Row(mainAxisAlignment: MainAxisAlignment.spaceAround,
                       children: [
                         
                         SizedBox(
                           width: w(150),
                           child: text(text: 'التحقيقات',color: AppColor.yellow,fontsize: 20.sp,fontWeight: FontWeight.bold,fontfamily: 'marai')),
                         Image.asset('assets/images/main 1.png',height: h(30),width: w(30),color: AppColor.yellow,)
                       ],
                     )),
                 ),



                   SizedBox(height: h(40),),


                    GestureDetector(onTap: (){navigation( const HomeBar(categoryId: '3d0a5e84-9c54-46c1-8522-39daf705ce13',));},
                      child: SizedBox(
                                       width: w(200),
                                       child: Row(mainAxisAlignment: MainAxisAlignment.spaceAround,
                                         children: [
                                           SizedBox(
                                             width: w(150),
                                             child: text(text: 'وعي وتعليم',color: AppColor.yellow,fontsize: 20.sp,fontWeight: FontWeight.bold,fontfamily: 'marai')),
                                                 Image.asset('assets/images/main 3.png',height: h(30),width: w(30),color: AppColor.yellow,)
                                         ],
                                       )),
                    ),


                         SizedBox(height: h(40),),


                    GestureDetector(onTap: (){navigation(const HomeBar(categoryId:'b520bade-3deb-4081-bb90-4b5094b8d522' ,));},
                      child: SizedBox(
                                       width: w(200),
                                       child: Row(mainAxisAlignment: MainAxisAlignment.spaceAround,
                                         children: [
                                           SizedBox(
                                             width: w(150),
                                             child: text(text: 'فيديوهات',color: AppColor.yellow,fontsize: 20.sp,fontWeight: FontWeight.bold,fontfamily: 'marai')),
                                           Image.asset('assets/images/MAIN 4.png',height: h(30),width: w(30),color: AppColor.yellow,)
                                         ],
                                       )),
                    )
               ,  SizedBox(height: h(40),),
                //  GestureDetector(onTap: (){
                //    navigation(const ReportFakeNews(isReport: false,title: 'أرسل  تحقيقًا',));
                //  },
                //    child: SizedBox(
                //      width: w(200),
                //      child: Row(mainAxisAlignment: MainAxisAlignment.spaceAround,
                //        children: [
                //          SizedBox
                //          (
                //            width: w(150),
                //            child: text(text:  'أرسل  تحقيقًا',color: AppColor.yellow,fontsize: 20.sp,fontWeight: FontWeight.bold,fontfamily: 'marai')),
                //            Image.asset('assets/images/main 5.png',height: h(30),width: w(30),color: AppColor.yellow,)
                //        ],
                //      )),
                //  )
                //  SizedBox(height: h(40),),
               GestureDetector(onTap: (){


                   navigation(const ReverseImageSearch());
                 },
                   child: SizedBox(
                     width: w(200),
                     child: Row(mainAxisAlignment: MainAxisAlignment.spaceAround,
                       children: [
                         SizedBox(
                           width: w(150),
                           child: text(text:'البحث العكسي',color: AppColor.yellow,fontsize: 20.sp,fontWeight: FontWeight.bold,fontfamily: 'marai')),
                             Image.asset('assets/images/main 6.png',height: h(30),width: w(30),color: AppColor.yellow,)
                         
                       ],
                     )),
                 )
                            ,  SizedBox(height: h(40),),
                 GestureDetector(onTap: (){


                   navigation(const ReviewTickets());
                 },
                   child: SizedBox(
                     width: w(200),
                     child: Row(mainAxisAlignment: MainAxisAlignment.spaceAround,
                       children: [
                         SizedBox(
                           width: w(150),
                           child: text(text: 'إبلاغاتي',color: AppColor.yellow,fontsize: 20.sp,fontWeight: FontWeight.bold,fontfamily: 'marai')),
                             Image.asset('assets/images/profile.png',height: h(30),width: w(30),color: AppColor.yellow,)
                         
                       ],
                     )),
                 )
                   ,  SizedBox(height: h(40),),
                 GestureDetector(onTap: (){nav(context, const About());},
                   child: SizedBox(
                     width: w(200),
                     child: Row(mainAxisAlignment: MainAxisAlignment.spaceAround,
                       children: [
                         SizedBox(
                           width: w(150),
                           child: text(text: 'عن صدق',color: AppColor.yellow,fontsize: 20.sp,fontWeight: FontWeight.bold,fontfamily: 'marai')),
                         Icon(Icons.error,color: AppColor.yellow,size: 30.sp,)
                       ],
                     )),
                 )
                
                     ,  SizedBox(height: h(30),),
                 GestureDetector(onTap: (){
                   nav(context, const Privacy());
                 },
                   child: SizedBox(
                     width: w(200),
                     child: Row(mainAxisAlignment: MainAxisAlignment.spaceAround,
                       children: [
                         SizedBox(
                           width: w(160
                           ),
                           child: text(text: 'سياسة الخصوصية والمعلومات',color: AppColor.yellow,fontsize: 19.sp,fontWeight: FontWeight.bold,fontfamily: 'marai')),
                         Icon(Icons.error_outline_outlined,color: AppColor.yellow,size: 30.sp,)
                       ],
                     )),
                 )
                
                
                
                
                
                
                
                
                    ],
                
                
              ),
            ),
          )
    );
  }
  navigation (Widget widget){
    Navigator.of(context).pop();
    nav(context, widget);
  }

}
