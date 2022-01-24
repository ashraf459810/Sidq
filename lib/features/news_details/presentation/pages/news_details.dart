import 'dart:developer';

import 'package:analyzer/dart/ast/ast.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shimmer/shimmer.dart';
import 'package:sidq/App/app.dart';
import 'package:sidq/Widgets/container.dart';
import 'package:sidq/Widgets/custom_list_view.dart';

import 'package:sidq/Widgets/text.dart';
import 'package:sidq/Widgets/text_form.dart';
import 'package:sidq/core/consts.dart';
import 'package:sidq/features/home/data/models/news_model.dart';
import 'package:sidq/features/news_details/data/models/news_details.dart';
import 'package:sidq/features/news_details/presentation/bloc/news_details_bloc.dart';
import 'package:sidq/features/news_details/presentation/widgets/loading_news_details.dart';
import 'package:test/test.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../../injection_container.dart';


class SecondPageRoute extends CupertinoPageRoute {
final  News news;
  SecondPageRoute(this.news)
      : super(builder: (BuildContext context) =>  NewsDetails(news: news,));


  // OPTIONAL IF YOU WISH TO HAVE SOME EXTRA ANIMATION WHILE ROUTING
  @override
  Widget buildPage(BuildContext context, Animation<double> animation,
      Animation<double> secondaryAnimation) {
    return  FadeTransition(opacity: animation, child:  NewsDetails(news: news,));
  }
}

class NewsDetails extends StatefulWidget {
  final News? news;
  const NewsDetails({Key? key, this.news}) : super(key: key);

  @override
  _NewsDetailsState createState() => _NewsDetailsState();
}

class _NewsDetailsState extends State<NewsDetails> {
  TextEditingController commentc = TextEditingController();
  String? comment;
   ScrollController scrollController = ScrollController();
  ScrollController scrollController2 = ScrollController();
  var newsDetailsModel = NewsDetailsModel() ;
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => sl<NewsDetailsBloc>()..add(GetNewsDetailsEvent(widget.news!.id!)),
      child: Scaffold(
      body:   BlocBuilder<NewsDetailsBloc, NewsDetailsState>(
        builder: (context, state) {
          // if (state is NewsDetailsInitial){
          //   return const Center(child: CircularProgressIndicator());
          // }
          // if (state is Loading){
          //   return const Center(child: CircularProgressIndicator());
          // }
          if (state is GetnewsDetailsState){
            newsDetailsModel= state.newsDetailsModel;

          }
          if (state is Error){
            return text(text: state.error);
          }
          if (state is GetnewsDetailsState){
            log('here from tate ');
            newsDetailsModel = state.newsDetailsModel;
          
          return
            SafeArea(top: true,
                child: CustomScrollView(
                    shrinkWrap: true,
                    physics:const ScrollPhysics(parent: AlwaysScrollableScrollPhysics()),
                    controller: scrollController,
                    slivers: <Widget>[
                      SliverAppBar(
             backgroundColor: Colors.white,
                        shadowColor: Colors.white,
                          expandedHeight: h(300),
                      flexibleSpace: FlexibleSpaceBar(
                        centerTitle: true,
                        title:  Text(newsDetailsModel.result!.title!),
                        background: Image.network(
              
                              newsDetailsModel.result!.fileLink!,
                              fit: BoxFit.fill,
                            )),
                       
                         
                  
                            // titlePadding: EdgeInsets.symmetric(vertical: w(50)),
                      
                      ),
                      SliverList(delegate: SliverChildListDelegate([
                        
                          // SizedBox(height: h(50),),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              // SizedBox(height: h(50),),
          
                              text(text: newsDetailsModel.result!.title! ,fontsize: 16.sp,color: Colors.black,fontfamily: 'marai',fontWeight: FontWeight.bold),
                              SizedBox(height: h(15),),
                                   text(text: newsDetailsModel.result!.briefDescription! ,fontsize: 14.sp,color: Colors.black,fontfamily: 'marai'),
                                   SizedBox(height: h(20),),
                                   Padding(
                                     padding: const EdgeInsets.all(8.0),
                                     child: Column(
                                     
                                       children: [
                                         ListView(shrinkWrap: true,
                                         physics: const ScrollPhysics(parent: NeverScrollableScrollPhysics()),
                                           children: [
                                                 Directionality(
                                                   
                                                   textDirection: TextDirection.rtl,
                                                   child: Html(
                                                 
                                                     shrinkWrap: true,
                                                     data: newsDetailsModel.result!.description!,),
                                                 ),
                                                 SizedBox(height: h(10),),
                                         newsDetailsModel.result!.falseLinks!.isNotEmpty?           Column(
                                                   children: [
                                                     text(text: 'روابط مريفة',color: Colors.black,fontsize: 20.sp,fontWeight: FontWeight.bold),
                                         
                                                     customlistview(
                                                       padding: 10,
                                                       scroll: false,
                                                       hight:  newsDetailsModel.result!.falseLinks!.isNotEmpty?
                                                       newsDetailsModel.result!.falseLinks!.length * h(100) :h(30),
                                                       direction: 'vertical',
                                                       itemcount: newsDetailsModel.result!.falseLinks!.length,
                                                       controller: ScrollController(),
                                                       function: (context , index){
                                                       return  Padding(
                                                         padding: const EdgeInsets.all(8.0),
                                                         child: container(color: AppColor.purple,
                                                           hight: h(60), width: w(200),borderRadius: 10,child: text(text: newsDetailsModel.result!.falseLinks![index],color: Colors.white)),
                                                       );
                                                     }),
                                                   ],
                                                 ):const SizedBox(),
                                                         SizedBox(height: h(10),),
                                            newsDetailsModel.result!.trueLinks!.isNotEmpty?      Column(
                                                   children: [
                                                     text(text: 'روابط حقيقية',color: Colors.black,fontsize: 20.sp,fontWeight: FontWeight.bold),
                                         
                                                     customlistview(
                                                       padding: 10,
                                                       scroll: false,
                                                       hight:  newsDetailsModel.result!.trueLinks!.isNotEmpty?
                                                       newsDetailsModel.result!.falseLinks!.length * h(150) :h(30),
                                                       direction: 'vertical',
                                                       itemcount: newsDetailsModel.result!.trueLinks!.length,
                                                       controller: ScrollController(),
                                                       function: (context , index){
                                                       return  Padding(
                                                         padding: const EdgeInsets.all(8.0),
                                                         child: GestureDetector(onTap: () async{
                                                                                                                 await   launchInWebViewOrVC(newsDetailsModel.result!.trueLinks![index]);
                                                         
                                                         },
                                                           child: container(color: AppColor.purple,
                                                             hight: h(60), width: w(200),borderRadius: 10,child: text(text: newsDetailsModel.result!.trueLinks![index],color: Colors.white)),
                                                         ),
                                                       );
                                                     }),
                                                   ],
                                                 ):const SizedBox(),


                                                //  SizedBox(height: h(30),), 

                                                 Row(mainAxisAlignment: MainAxisAlignment.spaceAround,
                                                   children: [
                                                   container(
                                                     borderRadius: 5,
                                                     width: w(150),
                                                     color: AppColor.purple,

                                                     child: Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                                       children: [
                                                         Icon(Icons.check,color: Colors.white,size: 35.sp,),
                                                         text(text: 'خبر صحيح',color: Colors.white),
                                                        // SizedBox(width: w(10),),
                                                                text(text:  newsDetailsModel.result!.trueVotesCount.toString(),color: Colors.white),
                                                       ],
                                                     ),
                                                   ),
                                                           container(
                                                     borderRadius: 5,
                                                     width: w(150),
                                                     color: AppColor.purple,

                                                     child: Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                                       children: [
                                                         Icon(Icons.clear,color: Colors.white,size: 35.sp,),
                                                         text(text: 'خبر خاطئ',color: Colors.white),
                                                        // SizedBox(width: w(10),),
                                                                text(text:  newsDetailsModel.result!.falseVotesCount.toString(),color: Colors.white),
                                                       ],
                                                     ),
                                                   ),
                                                 ],),
                                           newsDetailsModel.result!.comments!.isNotEmpty?      customlistview(
                                                direction: 'vertical',
                                                   padding: 10,
                                                   hight: newsDetailsModel.result!.comments!.length * h(100),
                                                   controller: ScrollController(),
                                                   itemcount: newsDetailsModel.result!.comments!.length,
                                                   function: (context , index){
                                                          return Column(children: [
                                                            text(text: newsDetailsModel.result!.comments![index])
                                                          ]);
                                            
                                          
                                                    } ):const SizedBox(

                                                    ),
                                                    SizedBox(height: h(30),),
                                                    text(text: 'اكتب تعليقا',fontsize: 30),

                                         ],),
                                                     container(color: Colors.grey[200],
                                                     
                                                     
                                                      hight: h(100),
                                                      width: w(330),
                                                      borderRadius: 10,
                                                        child: textform(
                                                          padding : EdgeInsets.only(bottom: h(40),right: w(5)),
                        hint: '',
                        hintsize: w(20),
                        controller: commentc,
                        function: (val) {
                          comment = val;
                        },
                        keyboard: 'name',
                        validation: (val) {
                          return val!;
                        }),
                                                                                            )
                                       ],
                                     ),
                                   )
          
                                   
                            ],
                          ),
                        )
            
          
                      ]))
                 
                    ],
                  ),
              );
              
          }
          return loadingNewsDetils();

          })));
  }
    Future<void> launchInWebViewOrVC(String url) async {
    if (!await launch(
      url,
      forceSafariVC: true,
      forceWebView: true,
      headers: <String, String>{'my_header_key': 'my_header_value'},
    )) {
      throw 'Could not launch $url';
    }
  }


}