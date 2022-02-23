


import 'package:flutter/material.dart';

import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:sidq/App/app.dart';
import 'package:sidq/Widgets/container.dart';

import 'package:sidq/Widgets/nav.dart';
import 'package:sidq/Widgets/text.dart';
import 'package:sidq/core/consts.dart';
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
             appBar: AppBar(
               elevation: 0,
                 automaticallyImplyLeading: false,
               backgroundColor: AppColor.purple,

               
                centerTitle: true,
                title:   container(
                    width: w(330),
                    hight: h(50),
               
                    borderRadius: 20,
                    child: text(
                        text: 'إبلاغاتي',
                        fontfamily: 'marai',
                        color: AppColor.purple,
                        fontsize: 18.sp,
                        fontWeight: FontWeight.bold)),
              ),
            backgroundColor: AppColor.purple,
            body:

            Padding(
              padding: const EdgeInsets.all(20.0),
              child: ListView(children: [
                SizedBox(height: h(50),),

                InkWell(
                  onTap: (){
                    nav(context,const Tickets(isFakeNews: false,title: 'تحقيقاتي السابقة',));
                  },
                  child: container
                            (width: w(100),
                              color: AppColor.yellow,hight: h(50),borderRadius: 20,child: text(text: 'تحقيقاتي السابقة',color: AppColor.purple,fontfamily: 'marai',fontWeight: FontWeight.bold,fontsize: 18.sp)),
                ),

                            SizedBox(height: h(40),),

                      InkWell(
                        onTap: (){
                            nav(context,const Tickets(isFakeNews: true,title: 'إبلاغاتي السابقة',));
                        },
                        child: container(width: w(100),
                          color: AppColor.yellow,hight: h(50),borderRadius: 20,child: text(text: 'إبلاغاتي السابقة',color: AppColor.purple,fontfamily: 'marai',fontWeight: FontWeight.bold,fontsize: 18.sp)),
                      ),
                           SizedBox(height: h(40),),
                  GestureDetector(
                    onTap: (){

                       nav(context, const ReportFakeNews(isReport: false,title: 'أرسل تحقيقا',));

                    },
                    child: container
                            (width: w(100),
                              color: AppColor.yellow,hight: h(50),borderRadius: 20,child: text(text: 'أرسل تحقيقا',color: AppColor.purple,fontfamily: 'marai',fontWeight: FontWeight.bold,fontsize: 18.sp)),
                  ),

                            SizedBox(height: h(40),),

                      GestureDetector(onTap: (){
                        nav(context, const ReportFakeNews(isReport: true,title: 'الإبلاغ عن خبر زائف',));
                      },
                        child: container(width: w(100),
                          color: AppColor.yellow,hight: h(50),borderRadius: 20,child: text(text: 'أبلغ عن إشاعة',color: AppColor.purple,fontfamily: 'marai',fontWeight: FontWeight.bold,fontsize: 18.sp)),
                      ),
                
              ],),
            )
            
            
        
          
          
        
      
    );
  }
}
