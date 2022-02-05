import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:sidq/App/app.dart';
import 'package:sidq/Widgets/nav.dart';
import 'package:sidq/Widgets/text.dart';
import 'package:sidq/core/consts.dart';
import 'package:sidq/features/home/presentation/pages/home.dart';
import 'package:sidq/features/report_fake_news/presentation/pages/report_fake_news.dart';


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
                     child: text(text: 'التحقيقات',color: AppColor.yellow,fontsize: 20.sp,fontWeight: FontWeight.bold,fontfamily: 'marai')),
                 ),



                   SizedBox(height: h(40),),


                    GestureDetector(onTap: (){navigation( const HomeBar(categoryId: '3d0a5e84-9c54-46c1-8522-39daf705ce13',));},
                      child: SizedBox(
                                       width: w(200),
                                       child: text(text: 'وعي وتعليم',color: AppColor.yellow,fontsize: 20.sp,fontWeight: FontWeight.bold,fontfamily: 'marai')),
                    ),


                         SizedBox(height: h(40),),


                    GestureDetector(onTap: (){navigation(const HomeBar(categoryId:'b520bade-3deb-4081-bb90-4b5094b8d522' ,));},
                      child: SizedBox(
                                       width: w(200),
                                       child: text(text: 'فديوهات',color: AppColor.yellow,fontsize: 20.sp,fontWeight: FontWeight.bold,fontfamily: 'marai')),
                    )
               ,  SizedBox(height: h(40),),
                 GestureDetector(onTap: (){
                   navigation(const ReportFakeNews(isReport: false,title: 'ارسل تحقيقا',));
                 },
                   child: SizedBox(
                     width: w(200),
                     child: text(text: 'ارسل تحقيقا',color: AppColor.yellow,fontsize: 20.sp,fontWeight: FontWeight.bold,fontfamily: 'marai')),
                 )
               ,  SizedBox(height: h(40),),
                 GestureDetector(onTap: (){


                   navigation(const ReportFakeNews(isReport: false,title: 'ابلغ عن اشاعة',));
                 },
                   child: SizedBox(
                     width: w(200),
                     child: text(text: 'ابلغ عن اشاعة',color: AppColor.yellow,fontsize: 20.sp,fontWeight: FontWeight.bold,fontfamily: 'marai')),
                 )
                   ,  SizedBox(height: h(40),),
                 SizedBox(
                   width: w(200),
                   child: text(text: 'عن صدق',color: AppColor.yellow,fontsize: 20.sp,fontWeight: FontWeight.bold,fontfamily: 'marai'))
                
                     ,  SizedBox(height: h(40),),
                 SizedBox(
                   width: w(200),
                   child: text(text: 'سياسة الخصوصية والمعلومات',color: AppColor.yellow,fontsize: 20.sp,fontWeight: FontWeight.bold,fontfamily: 'marai'))
                
                
                
                
                
                
                
                
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
