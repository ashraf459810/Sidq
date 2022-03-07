import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:share_plus/share_plus.dart';


// import 'package:flutter_math_fork/flutter_math.dart';

import 'package:sidq/App/app.dart';
import 'package:sidq/Widgets/container.dart';
import 'package:sidq/Widgets/custom_list_view.dart';

import 'package:sidq/Widgets/text.dart';
import 'package:sidq/Widgets/text_form.dart';
import 'package:sidq/core/consts.dart';
import 'package:sidq/features/news_details/data/models/news_details.dart';
import 'package:sidq/features/news_details/presentation/bloc/news_details_bloc.dart';
import 'package:sidq/features/news_details/presentation/widgets/add_vote.dart';

import 'package:sidq/features/news_details/presentation/widgets/loading_news_details.dart';

import 'package:url_launcher/url_launcher.dart';

import '../../../../injection_container.dart';

class SecondPageRoute extends CupertinoPageRoute {
  final String news;
  SecondPageRoute(this.news)
      : super(
            builder: (BuildContext context) => NewsDetails(
                  news: news,
                ));

  // OPTIONAL IF YOU WISH TO HAVE SOME EXTRA ANIMATION WHILE ROUTING
  @override
  Widget buildPage(BuildContext context, Animation<double> animation,
      Animation<double> secondaryAnimation) {
    return FadeTransition(
        opacity: animation,
        child: NewsDetails(
          news: news,
        ));
  }
}

class NewsDetails extends StatefulWidget {
  final String? news;
  const NewsDetails({Key? key, this.news}) : super(key: key);

  @override
  _NewsDetailsState createState() => _NewsDetailsState();
}

class _NewsDetailsState extends State<NewsDetails> {
  // YoutubePlayerController youtubePlayerController  = YoutubePlayerController(initialVideoId: initialVideoId)
  final newsDetailsBloc = sl<NewsDetailsBloc>();
  bool voteTrue = false;
  bool voteFalse = false;
  TextEditingController commentc = TextEditingController();
  String ? name;
    TextEditingController namec = TextEditingController();
  String? comment;
  ScrollController scrollController = ScrollController();
  ScrollController scrollController2 = ScrollController();
  int trueVotesNumber = 0;
  int falseVotesNumber = 0;
    NewsDetailsModel? newsDetailsModel;
  List<Comment> comments = [];
  @override
  void initState() {
    // newsDetailsBloc.add(GetNewsDetailsEvent(widget.news!.id!));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => sl<NewsDetailsBloc>()..add(GetNewsDetailsEvent(widget.news!)),
      child: Scaffold(
        backgroundColor: Colors.grey[50],
          body: BlocConsumer<NewsDetailsBloc , NewsDetailsState>(listener: (context , state ){

    if (state is GetnewsDetailsState) {
                  log('here  details state ');
           
                  trueVotesNumber =
                      state.newsDetailsModel.result!.trueVotesCount!;
                  falseVotesNumber =
                      state.newsDetailsModel.result!.falseVotesCount!;
                  comments = state.newsDetailsModel.result!.comments!;

                  newsDetailsModel = state.newsDetailsModel;
                }
                if (state is Error) {
                                             Fluttertoast.showToast(
        msg: state.error,
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.CENTER,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.grey[600],
        textColor: Colors.white,
        fontSize: 16.sp
    );
                }
            
          },


              builder: (context, state) {
              
                if (state is NewsDetailsInitial) {
                  log('here  initial state ');
                  return loadingNewsDetils();
                }
                if (state is Loading) {
                  log('here loadin state ');
                  return loadingNewsDetils();
                }
            

                return newsDetailsModel!=null? SafeArea(
                  
                  top: true,
                  child: Scrollbar(
                    child: CustomScrollView(
                      shrinkWrap: true,
                      physics: const ScrollPhysics(
                          parent: AlwaysScrollableScrollPhysics()),
                      controller: scrollController,
                      slivers: <Widget>[
                           
                        SliverAppBar(
                                 
                          
                          backgroundColor: Colors.grey[300],
                             iconTheme:const IconThemeData(
                                  color: Colors.white,
                                ),
                          shadowColor: Colors.white,
                          expandedHeight: h(275),
                          flexibleSpace: FlexibleSpaceBar(
                            
                              centerTitle: true,
                              
                              // title: Text(newsDetailsModel.result!.title!),
                              background: Center(
                                child: Stack(
                                  children: [
                         
                                    Image.network(
                                      newsDetailsModel!.result!.fileLink!,
                                      fit: BoxFit.cover,
                                      height: h(380),
                                      width: w(380),
                                    ),
                                          newsDetailsModel!.result!.isTrue!=null  ?  Positioned(
                                            top: h(20),
                                            right: w(20),
                                            child: container(color: AppColor.purple,
                                              borderRadius: 5,hight: h(40),width: w(60), child: text(text:  newsDetailsModel!.result!.isTrue! ? 'حقيقة' : 'إشاعة',color: Colors.white,fontfamily: 'marai')),
                                          ):const SizedBox(),
                                  ],
                                ),
                              )),
                  
                          // titlePadding: EdgeInsets.symmetric(vertical: w(50)),
                        ),
                        SliverList(
                            delegate: SliverChildListDelegate([
                             
                  
                                    Container(
                                      height: h(40),
                                      color: 
                                      AppColor.yellow,
                                      child: Row(mainAxisAlignment: MainAxisAlignment.spaceAround,
                                        children: [
                                          SizedBox(
                                                 width: MediaQuery.of(context).size.width / 3 ,
                                            child: container(hight: h(40),color: AppColor.purple,child: GestureDetector(onTap: () async {
                  
                  
                                                
                    final box = context.findRenderObject() as RenderBox?;
                  
                        
                        await Share.share(newsDetailsModel!.result!.shareableLink!,
                            // subject: subject,
                            sharePositionOrigin: box!.localToGlobal(Offset.zero) & box.size);
                                            
                               
                                            },
                                              child: Row(
                                                mainAxisAlignment: MainAxisAlignment.center,
                                                children: [
                                                text(text: "مشاركة",color: Colors.white,fontWeight: FontWeight.bold,fontfamily: 'marai'),
                                                text(text: "  "),
                                                Image.asset('assets/images/share.png',height: h(30),)
                                              ],),
                                            ))),
                                                         SizedBox(
                                                                width: MediaQuery.of(context).size.width / 3 ,
                                                           child: Row(mainAxisAlignment: MainAxisAlignment.center,
                                                                                                 children: [
                                                                                                   
                                                                                                   text(text:  '${newsDetailsModel!.result!.views!}' " "'مشاهدة' ,fontWeight: FontWeight.bold,fontfamily: 'marai'),
                                                                                                   text(text: " "),
                                                                                                        Image.asset('assets/images/eye.png',height: h(30),), 
                                                                                                  
                                                                                                 ],
                                                                                               ),
                                                         ),
                                          SizedBox(
                                            width: MediaQuery.of(context).size.width / 3 ,
                                            child: Row(mainAxisAlignment: MainAxisAlignment.center,
                                              children: [
                           
                                              text(text: newsDetailsModel!.result!.date.toString(),color: AppColor.purple,fontWeight: FontWeight.bold),
                                              text(text: " "),
                                                               Image.asset('assets/images/calender.png',height: h(30),),
                                            ],),
                                          ),
                  
                                          
                                          
                         
                                          // text(text: newsDetailsModel!.result!.isTrue! ? 'خبر صحيح':'اشاعة' ,fontWeight: FontWeight.bold,fontfamily: 'marai'),
                  
                  
                                      ]
                                      ,),
                                    ),
                          // SizedBox(height: h(20),),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                             
                              // SizedBox(height: h(50),),
                  
                              Padding(
                                padding:  EdgeInsets.all(w(25)),
                                child: Container(
                           
                                  child: text(
                                      text: newsDetailsModel!.result!.title!,
                                      fontsize: 16.sp,
                                      color: AppColor.purple,
                                      fontfamily: 'marai',
                                      
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                  // SizedBox(height: h(30),),
                            
                              Padding(
                                padding:  EdgeInsets.symmetric(horizontal: w(25)),
                                child: text(
                                    text: newsDetailsModel
                                        !.result!.briefDescription!,
                                    fontsize: 14.sp,
                                    color: Colors.black,
                                    fontfamily: 'marai'),
                              ),
                              // SizedBox(
                              //   height: h(20),
                              // ),
                              Padding(
                                padding:  EdgeInsets.symmetric(horizontal: w(18)),
                                child: Column(
                                  children: [
                                    ListView(
                                      shrinkWrap: true,
                                      physics: const ScrollPhysics(
                                          parent:
                                              NeverScrollableScrollPhysics()),
                                      children: [
                                        Directionality(
                                          textDirection: TextDirection.rtl,
                                          child:
                                           Html( 

                                                   onLinkTap: (String? url,
                                              RenderContext context,
                                              Map<String, String> attributes,
                                              element) {
                                            launchInWebViewOrVC(
                                              url!,
                                            );

                                            //open URL in webview, or launch URL in browser, or any other logic here
                                          },
  
                                          shrinkWrap: false,
                                            data: newsDetailsModel
                                               ! .result!.description!,
                                          ),
                                        ),
                                        SizedBox(
                                          height: h(10),
                                        ),
                                        newsDetailsModel
                                             !   .result!.falseLinks!.isNotEmpty
                                            ? Column(
                                                children: [
                                                  Container(
                                                     alignment: Alignment.center,
                                                        height: h(40),
                                                        width: w(330),
                                                        color: Colors.red[800],
                                                    child: Center(
                                                      child: text(
                                                          text: 'روابط الإشاعة',
                                                          color: Colors.white,
                                                          fontsize: 15.sp,
                                                          fontfamily: 'marai',
                                                          fontWeight:
                                                              FontWeight.bold),
                                                    ),
                                                  ),
                                                  customlistview(
                                                      padding: 10,
                                                      scroll: false,
                                                      hight: newsDetailsModel
                                                          !    .result!
                                                              .falseLinks!
                                                              .isNotEmpty
                                                          ? newsDetailsModel
                                                                  !.result!
                                                                  .falseLinks!
                                                                  .length *
                                                              h(50)
                                                          : h(30),
                                                      direction: 'vertical',
                                                      itemcount:
                                                          newsDetailsModel
                                                             ! .result!
                                                              .falseLinks!
                                                              .length,
                                                      controller:
                                                          ScrollController(),
                                                      function:
                                                          (context, index) {
                                                        return GestureDetector(
                                                          onTap: () async {
                                                        
                                                            await launchInWebViewOrVC(
                                                                newsDetailsModel
                                                                      !  .result!
                                                                        .falseLinks![
                                                                    index].link!);
                                                          },
                                                          child: Row(mainAxisAlignment: MainAxisAlignment.end ,
                                                            children: [
                                                              Padding(
                                                                padding:  EdgeInsets.symmetric(horizontal: w(10)),
                                                                child: Container(
                                                                    color:Colors.transparent,
                                                                    height: h(50),
                                                                    width: w(200),
                                                                   alignment: Alignment.topRight,
                                                                    child: Text(
                                                                      
                                                                      newsDetailsModel
                                                                          !.result!
                                                                          .falseLinks![index].name!,
                                                                          textAlign: TextAlign.right,
                                                                      maxLines: 1,
                                                                      overflow:
                                                                          TextOverflow
                                                                              .ellipsis,
                                                                      style: TextStyle(
                                                                          color: Colors
                                                                              .black,
                                                                          fontSize:
                                                                              15.sp),
                                                                    )),
                                                              ),
                                                            ],
                                                          ),
                                                        );
                                                      }),
                                                ],
                                              )
                                            : const SizedBox(),
                                        SizedBox(
                                          height: h(10),
                                        ),
                                        newsDetailsModel
                                                !.result!.trueLinks!.isNotEmpty
                                            ? Column(
                                                children: [
                                                  Container(
                                                    alignment: Alignment.center,
                                                        height: h(40),
                                                        width: w(330),
                                                        color: Colors.green[800],
                                                    child: Center(
                                                      
                                                      child: text(
                                                        textAlign: TextAlign.center,
                                                          text: 'روابط الحقيقية',
                                                          color: Colors.white,
                                                          fontsize: 15.sp,
                                                          fontfamily: 'marai',
                                                          fontWeight:
                                                              FontWeight.bold),
                                                    ),
                                                  ),
                                                  customlistview(
                                                      hight: newsDetailsModel
                                                          !    .result!
                                                              .trueLinks!
                                                              .isNotEmpty
                                                          ? newsDetailsModel
                                                                  !.result!
                                                                  .trueLinks!
                                                                  .length *
                                                              h(50)
                                                          : h(30),
                                                      padding: 10,
                                                      scroll: false,
                                               
                                                      direction: 'vertical',
                                                      itemcount:
                                                          newsDetailsModel
                                                             ! .result!
                                                              .trueLinks!
                                                              .length,
                                                      controller:
                                                          ScrollController(),
                                                      function:
                                                          (context, index) {
                                                        return GestureDetector(
                                                            onTap: () async {
                                                        await launchInWebViewOrVC(
                                                            newsDetailsModel
                                                               !     .result!
                                                                    .trueLinks![
                                                                index].link!);
                                                            },
                                                            child: Row(mainAxisAlignment: MainAxisAlignment.end,
                                                        children: [
                                                          Padding(
                                                            padding:  EdgeInsets.symmetric(horizontal: w(10)),
                                                            child: Container(
                                                                
                                                                height: h(50),
                                                                width: w(200),
                                                                alignment: Alignment.topRight,
                                                         
                                                                child: Text(
                                                                  newsDetailsModel
                                                                   !   .result!
                                                                      .trueLinks![index].name!,
                                                                  maxLines: 1,
                                                                  textAlign: TextAlign.right,
                                                                  overflow:
                                                                      TextOverflow
                                                                          .ellipsis,
                                                                  style: TextStyle(
                                                                      color: Colors
                                                                          .black,
                                                                          
                                                                      fontSize:
                                                                          15.sp),
                                                                )
                                                                ),
                                                          ),
                                                        ],
                                                            ),
                                                          );
                                                      }),
                                                ],
                                              )
                                            : const SizedBox(),
                  
                                   newsDetailsModel!.result!.isVotable!?            Row(
                                              mainAxisAlignment: MainAxisAlignment.end,
                                              children: [
                                                container(color: Colors.grey[50],
                                                  width: w(90),child: text(text: 'التصويت',fontfamily: 'marai',fontsize: 24.sp)),
                                              ],
                                            ):const SizedBox(),
                                            SizedBox(height: h(10),),
                                        newsDetailsModel
                                                   ! .result!.trueLinks!.length >
                                                1
                                            ? SizedBox(
                                                height: h(30),
                                              )
                                            : const SizedBox(),
                                        newsDetailsModel!.result!.isVotable!
                                            ? Builder(
                                              builder: (context) {
                                                return
                                           addVote(newsDetailsBloc,trueVotesNumber,falseVotesNumber,voteTrue,voteFalse,newsDetailsModel!);
                                              }
                                            )
                                            : const SizedBox(
                                                height: 1,
                                              ),
                                        // SizedBox(
                                        //   height: h(30),
                                        // ),
                                        text(
                                            text: 'اكتب تعليقا',
                                        fontfamily: 'marai',fontsize: 20.sp)
                                    ,
                                    SizedBox(height: h(20),),
                  
                                            Padding(
                                              padding: const EdgeInsets.all(8.0),
                                              child: Row(mainAxisAlignment: MainAxisAlignment.spaceAround,
                                                children: [
                                                     GestureDetector(
                                                onTap: () {
                                                  if (comment != null) {
                                                    newsDetailsBloc.add(
                                                        AddCommentEvent(
                                                            widget.news!
                                                                .toString(),
                                                            comment
                                                                .toString(),name));
                                                  }
                                                },
                                                child: Builder(
                                                  builder: (context) {
                                                    return 
                                                BlocBuilder(
                                                      bloc: newsDetailsBloc,
                                                      builder: (context, state) {
                                          
                                                        if (state
                                                            is LoadingComment) {
                                                              log('state is loading');
                                                          return Center(
                                                              child:
                                                                  CircularProgressIndicator(
                                                        backgroundColor: AppColor.yellow,color: AppColor.purple,)
                                                          );
                                                        }
                                                        
                                                    
                                                        return container(
                                                            hight: h(50),
                                                            width: w(80),
                                                            borderRadius: 10,
                                                            color:
                                                                AppColor.yellow,
                                                            child: text(
                                                              fontWeight: FontWeight.bold,
                                                                text: 'إرسال',
                                                                fontfamily: 'marai',
                                                                color:
                                                                    AppColor.purple));
                                                      },
                                                    );
                                                  }
                                                )),
                                        
                                                  Center(
                                                    child: container(
                                                      color: Colors.grey[200],
                                                      hight: h(50),
                                                      width: w(200),
                                                      borderRadius: 10,
                                                      child: textform(
                                                        maxlines: 1,
                                                          padding: EdgeInsets.only(
                                                              bottom: h(10),
                                                              right: w(10)),
                                                          hint: 'الاسم (اختياري)',
                                                          
                                                          hintsize: w(14),
                                                          controller: namec,
                                                          function: (val) {
                                                            name = val;
                                                          },
                                                          keyboard: 'name',
                                                          validation: (val) {
                                                            return val!;
                                                          }),
                                                    ),
                                                  ),
                                                  
                                                ],
                                              ),
                                            ),
                                            SizedBox(height: h(20),),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceEvenly,
                                          children: [
                                         
                                        
                                            container(
                                              color: Colors.grey[200],
                                              hight: h(100),
                                              width: w(300),
                                              borderRadius: 10,
                                              child: textform(
                                                maxlines: 6,
                                                  padding: EdgeInsets.only(
                                                      bottom: h(10),
                                                      right: w(5)),
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
                                            ),
                                          ],
                                        ),
                                        SizedBox(
                                          height: h(20),
                                        ),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.end,
                                          children: [
                                            SizedBox(
                                              width: w(150),
                                        
                                              child: text(fontfamily: 'marai',fontsize: 20.sp,
                                                  text: 'التعليقات',
                                                ),
                                            )
                                          ],
                                        ),
                                        
                                             BlocBuilder(
                                                bloc: newsDetailsBloc,
                                                builder: (context, state) {
                                                  if (state
                                                      is AddCommentState) {
                                                    comments = state.comments;
                                                    log('here from comments');
                                                  }
                  
                                                  return comments.isNotEmpty
                                            ?
                   customlistview(
                                                    scroll: false,
                                                    direction: 'vertical',
                                                    padding: 10,
                                                    controller:
                                                        ScrollController(),
                                                    itemcount: comments.length,
                                                    function: (context, index) {
                                                      return Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                .all(8.0),
                                                        child: Column(
                                                          children: [
                                                                  comments[
                                                                            index].name !=null?  
                                                                                   Padding(
                                                                                     padding:  EdgeInsets.symmetric(horizontal: w(10)),
                                                                                     child: Row(mainAxisAlignment: MainAxisAlignment.end,
                                                                                       children: [
                                                                                         text(
                                                                                          fontfamily: 'marai',
                                                                                          text: comments[
                                                                                              index].name!,
                                                                                          color: Colors
                                                                                              .black,
                                                                                              fontWeight: FontWeight.bold
                                                                                  
                                                                                         ),
                                                                                       ],
                                                                                     ),
                                                                                   ):const SizedBox(),
                                                                                   SizedBox(height: h(5),),
                                                            Container(
                                                                alignment: Alignment
                                                                    .topRight,
                                                                decoration: BoxDecoration(
                                                                    shape: BoxShape
                                                                        .rectangle,
                                                                    color: Colors
                                                                            .grey[
                                                                        200],
                                                                    borderRadius: const BorderRadius
                                                                            .all(
                                                                        Radius.circular(
                                                                            10))),
                                                                // constraints: BoxConstraints(minHeight: h(50),maxWidth: w(250),maxHeight: h(120),minWidth:w(250) ),
                  
                                                                child: Padding(
                                                                  padding:
                                                                      const EdgeInsets
                                                                              .all(
                                                                          8.0),
                                                                  child: text(
                                                                    fontfamily: 'marai',
                                                                    text: comments[
                                                                        index].text!,
                                                                    color: Colors
                                                                        .black,
                                                                  ),
                                                                )),
                                                          ],
                                                        ),
                                                      );
                                                    },
                                                  )    : const SizedBox(height: 10,);
                                                },
                                              )
                                    // commentsWidget(newsDetailsBloc,comments)
                                        
                                      ],
                                    ),
                                  ],
                                ),
                              )
                            ],
                          )
                        ]))
                      ],
                    ),
                  ),
                ):const SizedBox();
              })),
    );
  }

  

  Future<void> launchInWebViewOrVC(String url) async {
        if (await canLaunch(url)) {
                          await launch(
                            url,
                            universalLinksOnly: true,
                          );
                        } else {
                          launchInWebViewOrVC(url);
                        }
  }


}
