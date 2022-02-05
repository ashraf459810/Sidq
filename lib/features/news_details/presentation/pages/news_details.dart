import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';

import 'package:sidq/App/app.dart';
import 'package:sidq/Widgets/container.dart';
import 'package:sidq/Widgets/custom_list_view.dart';

import 'package:sidq/Widgets/text.dart';
import 'package:sidq/Widgets/text_form.dart';
import 'package:sidq/core/consts.dart';
import 'package:sidq/features/news_details/data/models/news_details.dart';
import 'package:sidq/features/news_details/presentation/bloc/news_details_bloc.dart';
import 'package:sidq/features/news_details/presentation/widgets/add_vote.dart';
import 'package:sidq/features/news_details/presentation/widgets/comments.dart';
import 'package:sidq/features/news_details/presentation/widgets/loading_news_details.dart';
import 'package:sidq/features/news_details/presentation/widgets/send_comment.dart';

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
  final newsDetailsBloc = sl<NewsDetailsBloc>();
  bool voteTrue = false;
  bool voteFalse = false;
  TextEditingController commentc = TextEditingController();
  String? comment;
  ScrollController scrollController = ScrollController();
  ScrollController scrollController2 = ScrollController();
  int trueVotesNumber = 0;
  int falseVotesNumber = 0;
    NewsDetailsModel? newsDetailsModel;
  List<String> comments = [];
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
          body: BlocConsumer<NewsDetailsBloc , NewsDetailsState>(listener: (context , state ){

    if (state is GetnewsDetailsState) {
                  log('here  details state ');
                  newsDetailsModel = state.newsDetailsModel;
                  trueVotesNumber =
                      state.newsDetailsModel.result!.trueVotesCount!;
                  falseVotesNumber =
                      state.newsDetailsModel.result!.falseVotesCount!;
                  comments = state.newsDetailsModel.result!.comments!;
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
                  child: CustomScrollView(
                    shrinkWrap: true,
                    physics: const ScrollPhysics(
                        parent: AlwaysScrollableScrollPhysics()),
                    controller: scrollController,
                    slivers: <Widget>[
                      SliverAppBar(
                        backgroundColor: Colors.white,
                        shadowColor: Colors.white,
                        expandedHeight: h(300),
                        flexibleSpace: FlexibleSpaceBar(
                            centerTitle: true,
                            // title: Text(newsDetailsModel.result!.title!),
                            background: Image.network(
                              newsDetailsModel!.result!.fileLink!,
                              fit: BoxFit.fill,
                            )),

                        // titlePadding: EdgeInsets.symmetric(vertical: w(50)),
                      ),
                      SliverList(
                          delegate: SliverChildListDelegate([
                            SizedBox(height: h(10),),

                                  Row(mainAxisAlignment: MainAxisAlignment.spaceAround,
                                    children: [
                                    text(text:'المشاهدات''    '  '${newsDetailsModel!.result!.views!}' ,fontWeight: FontWeight.bold,fontfamily: 'marai'),
                                      text(text: newsDetailsModel!.result!.isTrue! ? 'خبر صحيح':'اشاعة' ,fontWeight: FontWeight.bold,fontfamily: 'marai'),


                                  ]
                                  ,),
                        // SizedBox(height: h(50),),
                        Padding(
                          padding: const EdgeInsets.all(12.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              // SizedBox(height: h(50),),

                              text(
                                  text: newsDetailsModel!.result!.title!,
                                  fontsize: 16.sp,
                                  color: Colors.black,
                                  fontfamily: 'marai',
                                  fontWeight: FontWeight.bold),
// SizedBox(height: h(30),),
                              SizedBox(
                                height: h(15),
                              ),
                              text(
                                  text: newsDetailsModel
                                      !.result!.briefDescription!,
                                  fontsize: 14.sp,
                                  color: Colors.black,
                                  fontfamily: 'marai'),
                              // SizedBox(
                              //   height: h(20),
                              // ),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
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
                                          child: Html(
                                            onLinkTap: (String? url,
                                                RenderContext context,
                                                Map<String, String> attributes,
                                                element) {
                                              launchInWebViewOrVC(
                                                url!,
                                              );

                                              //open URL in webview, or launch URL in browser, or any other logic here
                                            },
                                            shrinkWrap: true,
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
                                                  text(
                                                      text: 'روابط مزيفة',
                                                      color: Colors.black,
                                                      fontsize: 20.sp,
                                                      fontfamily: 'marai',
                                                      fontWeight:
                                                          FontWeight.bold),
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
                                                              h(100)
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
                                                                        .trueLinks![
                                                                    index]);
                                                          },
                                                          child: Padding(
                                                            padding:
                                                                const EdgeInsets
                                                                    .all(8.0),
                                                            child: container(
                                                                color: AppColor
                                                                    .purple,
                                                                hight: h(60),
                                                                width: w(200),
                                                                borderRadius:
                                                                    10,
                                                                child: Padding(
                                                                  padding:
                                                                      const EdgeInsets
                                                                              .all(
                                                                          8.0),
                                                                  child: Text(
                                                                    newsDetailsModel
                                                                        !.result!
                                                                        .falseLinks![index],
                                                                    maxLines: 1,
                                                                    overflow:
                                                                        TextOverflow
                                                                            .ellipsis,
                                                                    style: TextStyle(
                                                                        color: Colors
                                                                            .white,
                                                                        fontSize:
                                                                            12.sp),
                                                                  ),
                                                                )),
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
                                                  text(
                                                      text: 'روابط حقيقية',
                                                      color: Colors.black,
                                                      fontsize: 20.sp,
                                                      fontfamily: 'marai',
                                                      fontWeight:
                                                          FontWeight.bold),
                                                  customlistview(
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
                                                        return Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                  .all(8.0),
                                                          child:
                                                              GestureDetector(
                                                            onTap: () async {
                                                              await launchInWebViewOrVC(
                                                                  newsDetailsModel
                                                                     !     .result!
                                                                          .trueLinks![
                                                                      index]);
                                                            },
                                                            child: container(
                                                                color: AppColor
                                                                    .purple,
                                                                hight: h(60),
                                                                width: w(200),
                                                                borderRadius:
                                                                    10,
                                                                child: Padding(
                                                                  padding:
                                                                      const EdgeInsets
                                                                              .all(
                                                                          8.0),
                                                                  child: Text(
                                                                    newsDetailsModel
                                                                     !   .result!
                                                                        .trueLinks![index],
                                                                    maxLines: 1,
                                                                    overflow:
                                                                        TextOverflow
                                                                            .ellipsis,
                                                                    style: TextStyle(
                                                                        color: Colors
                                                                            .white,
                                                                        fontSize:
                                                                            12.sp),
                                                                  ),
                                                                )),
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
                                        SizedBox(
                                          height: h(30),
                                        ),
                                        text(
                                            text: 'اكتب تعليقا',
                                        fontfamily: 'marai',fontsize: 24.sp)
                                    ,
                                    SizedBox(height: h(20),),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceEvenly,
                                          children: [
                                            GestureDetector(
                                                onTap: () {
                                                  if (comment != null) {
                                                    newsDetailsBloc.add(
                                                        AddCommentEvent(
                                                            widget.news!
                                                                .toString(),
                                                            comment
                                                                .toString()));
                                                  }
                                                },
                                                child: Builder(
                                                  builder: (context) {
                                                    return 
                                                 sendComment(newsDetailsBloc);
                                                  }
                                                )),
                                            container(
                                              color: Colors.grey[200],
                                              hight: h(100),
                                              width: w(240),
                                              borderRadius: 10,
                                              child: textform(
                                                  padding: EdgeInsets.only(
                                                      bottom: h(40),
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
                                        
                                              child: text(fontfamily: 'marai',fontsize: 24.sp,
                                                  text: 'التعليقات',
                                                ),
                                            )
                                          ],
                                        ),
                                        comments.isNotEmpty
                                            ?
                                    commentsWidget(newsDetailsBloc,comments)
                                            : const SizedBox(),
                                      ],
                                    ),
                                  ],
                                ),
                              )
                            ],
                          ),
                        )
                      ]))
                    ],
                  ),
                ):const SizedBox();
              })),
    );
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
