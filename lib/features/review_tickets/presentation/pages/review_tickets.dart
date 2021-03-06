


import 'package:flutter/material.dart';

import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:sidq/App/app.dart';
import 'package:sidq/Widgets/container.dart';

import 'package:sidq/Widgets/nav.dart';
import 'package:sidq/Widgets/text.dart';
import 'package:sidq/core/consts.dart';
import 'package:sidq/features/home/presentation/widgets/bottom_bar.dart';
import 'package:sidq/features/home/presentation/widgets/drawer.dart';
import 'package:sidq/features/report_fake_news/presentation/pages/report_fake_news.dart';
import 'package:sidq/features/review_tickets/data/models/tickets_response_model.dart';

import 'package:sidq/features/review_tickets/presentation/widgets/tickets.dart';


class ReviewTickets extends StatefulWidget {
  const ReviewTickets({Key? key}) : super(key: key);

  @override
  State<ReviewTickets> createState() => _ReviewTicketsState();
}

class _ReviewTicketsState extends State<ReviewTickets> {
  List<Result>  tickets= [];
  @override
  Widget build(BuildContext context) {
    return 
         Scaffold(
           endDrawer:const HomeDrawer(),
           bottomNavigationBar: bottomBar(context,MediaQuery.of(context).size),
             appBar: AppBar(
               
               elevation: 0,
                 automaticallyImplyLeading: false,
               backgroundColor: AppColor.purple,

               actions: [

                 Builder(
                   builder: (context) {
                     return GestureDetector(
                       onTap: (){
                                   Scaffold.of(context).openEndDrawer();
                       },
                       child: Icon(Icons.menu,color: AppColor.yellow,size: 40,));
                   }
                 ),
                   SizedBox(width: w(10),),
                 ],
                // centerTitle: true,
                title:   container(
                  
                    width: w(350),
                    hight: h(50),
               
                    borderRadius: 20,
                    child: text(
                        text: '??????????????????????????????????',
                        fontfamily: 'marai',
                        color: AppColor.purple,
                        fontsize: 18.sp,
                        fontWeight: FontWeight.bold)),
              ),
            backgroundColor: AppColor.purple,
            body:

            Center(
              child: Column(
                
                children: [
                SizedBox(height: h(100),),


                                 
                  container(hight: h(180),width: w(350),
                  borderRadius: 12,
                    child: Center(
                      child: Column(
                        // crossAxisAlignment: CrossAxisAlignment.end,
                      // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          SizedBox(height: h(30),),
                          Row(mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              Column(  
                                children: [
                                  // SizedBox(height: h(10),),
                                  Row(mainAxisAlignment: MainAxisAlignment.spaceAround,
                                    children: [
                                      GestureDetector(
                                        onTap: (){
                  
                                           nav(context, const ReportFakeNews(isReport: false,title: '???????? ????????????',));
                  
                                        },
                                        child: container
                                                (width: w(240),
                                                  color: AppColor.purple,hight: h(50),borderRadius: 20,child: text(text: '?????????????? ????????????????????????????????????',color: AppColor.yellow,fontfamily: 'marai',fontWeight: FontWeight.bold,fontsize: 18.sp)),
                                      ),
                                                      
                                    ],
   
                                  ),
                  
                   SizedBox(height: h(10),),
                                          Row(mainAxisAlignment: MainAxisAlignment.spaceAround,
                                            children: [
       
                                         

                                              InkWell(
                                  onTap: (){
                                    nav(context,const Tickets(isFakeNews: false,title: '???????????????? ??????????????',));
                                  },
                                  child: container
                                                (width: w(240),
                                                  color: AppColor.purple,hight: h(50),borderRadius: 20,child: text(text: '???????????????? ??????????????',color: AppColor.yellow,fontfamily: 'marai',fontWeight: FontWeight.bold,fontsize: 18.sp)),
                                              ),
                                                                                  
                                            ],
                                          ),
                                ],
                              ),
                                        Column(
                                                          crossAxisAlignment: CrossAxisAlignment.center,
                                                          // mainAxisAlignment: MainAxisAlignment.center,
                                                          children: [
                                                            SizedBox(
                  height: h(60),
                  width: w(70),
                  child: Image.asset('assets/images/main 1.png')),

                  SizedBox(
                      width: w(90),
                      child: text(text: "??????????????",color: AppColor.purple,fontWeight: FontWeight.bold,fontsize: 19.sp,fontfamily: 'marai',textAlign: TextAlign.center)),
                                container(color: AppColor.purple,hight: h(1),width: w(80)),
                 text(text: "???? ???????????? ??????????",color: AppColor.purple,fontfamily: 'marai',fontsize: 11.sp,fontWeight: FontWeight.bold),
                  text(text: "???????????? ???? ????????????",color: AppColor.purple,fontfamily: 'marai',fontsize: 11.sp,fontWeight: FontWeight.bold)
                                                          ],
                                                                                                        ),
                            ],
                            
                          ),
                        ],
                      ),
                    ),
                  ),

                  SizedBox(height: h(90),),






                          container(hight: h(180),width: w(350),
                  borderRadius: 12,
                    child: Center(
                      child: Column(
                        // crossAxisAlignment: CrossAxisAlignment.end,
                      // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          SizedBox(height: h(30),),
                          Row(mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              Column(  
                                children: [
                                  // SizedBox(height: h(10),),
                                  Row(mainAxisAlignment: MainAxisAlignment.spaceAround,
                                    children: [
                                      GestureDetector(
                                        onTap: (){
                  
                                     nav(context, const ReportFakeNews(isReport: true,title: '?????????????? ???? ?????? ????????',));
                  
                                        },
                                        child: container
                                                (width: w(240),
                                                  color: AppColor.purple,hight: h(50),borderRadius: 20,child: text(text: '???????? ???? ??????????',color: AppColor.yellow,fontfamily: 'marai',fontWeight: FontWeight.bold,fontsize: 18.sp)),
                                      ),
                                                      
                                    ],
   
                                  ),
                  
                   SizedBox(height: h(10),),
                                          Row(mainAxisAlignment: MainAxisAlignment.spaceAround,
                                            children: [
       
                                         

                                              InkWell(
                                  onTap: (){
                                      nav(context,const Tickets(isFakeNews: true,title: '???????????????? ??????????????',));
                                  },
                                  child: container
                                                (width: w(240),
                                                  color: AppColor.purple,hight: h(50),borderRadius: 20,child: text(text: '???????????????? ??????????????',color: AppColor.yellow,fontfamily: 'marai',fontWeight: FontWeight.bold,fontsize: 18.sp)),
                                              ),
                                                                                  
                                            ],
                                          ),
                                ],
                              ),
                                        Column(
                                                          crossAxisAlignment: CrossAxisAlignment.center,
                                                          // mainAxisAlignment: MainAxisAlignment.center,
                                                          children: [
                                                            SizedBox(
                  height: h(60),
                  width: w(70),
                  child: Image.asset('assets/images/main 5.png')),

                  SizedBox(
                      width: w(90),
                      child: text(text: "????????????????????",color: AppColor.purple,fontWeight: FontWeight.bold,fontsize: 19.sp,fontfamily: 'marai',textAlign: TextAlign.center)),
                      SizedBox(height: h(2),),
                                container(color: AppColor.purple,hight: h(1),width: w(80)),
                 text(text: "???? ???????????? ??????????",color: AppColor.purple,fontfamily: 'marai',fontsize: 11.sp,fontWeight: FontWeight.bold),
                  text(text: "???????????? ??????",color: AppColor.purple,fontfamily: 'marai',fontsize: 11.sp,fontWeight: FontWeight.bold)
                                                          ],
                                                                                                        ),
                            ],
                            
                          ),
                        ],
                      ),
                    ),
                  ),


                      //       SizedBox(height: h(40),),

                      // InkWell(
                      //   onTap: (){
                      //   nav(context,const Tickets(isFakeNews: true,title: '???????????????? ??????????????',));    
                      //   },
                      //   child: container(width: w(100),
                      //     color: AppColor.yellow,hight: h(50),borderRadius: 20,child: text(text: '???????????????? ??????????????',color: AppColor.purple,fontfamily: 'marai',fontWeight: FontWeight.bold,fontsize: 18.sp)),
                      // ),
         
                      //       SizedBox(height: h(40),),

                      // GestureDetector(onTap: (){
                      //   nav(context, const ReportFakeNews(isReport: true,title: '?????????????? ???? ?????? ????????',));
                      // },
                      //   child: container(width: w(100),
                      //     color: AppColor.yellow,hight: h(50),borderRadius: 20,child: text(text: '???????? ???? ??????????',color: AppColor.purple,fontfamily: 'marai',fontWeight: FontWeight.bold,fontsize: 18.sp)),
                      // ),
                
              ],),
            )
            
            
        
          
          
        
      
    );
  }
}
