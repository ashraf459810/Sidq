import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

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

import 'package:url_launcher/url_launcher.dart';

import '../../../../injection_container.dart';

class SecondPageRoute extends CupertinoPageRoute {
  final News news;
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
  final News? news;
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
  var newsDetailsModel = NewsDetailsModel();
  List<String> comments = [];
  @override
  void initState() {
    newsDetailsBloc.add(GetNewsDetailsEvent(widget.news!.id!));
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(body: BlocBuilder(
          bloc: newsDetailsBloc,
            builder: (context, state) {
          if (state is NewsDetailsInitial) {
            log('here  initial state ');
            return loadingNewsDetils();
          }
          if (state is Loading) {
            log('here loadin state ');
            return loadingNewsDetils();
          }
          if (state is GetnewsDetailsState) {
            log('here  details state ');
            newsDetailsModel = state.newsDetailsModel;
            trueVotesNumber = state.newsDetailsModel.result!.trueVotesCount!;
            falseVotesNumber = state.newsDetailsModel.result!.falseVotesCount!;
            comments = state.newsDetailsModel.result!.comments!;
          }
          if (state is Error) {
            return text(text: state.error);
          }

          return SafeArea(
            top: true,
            child: CustomScrollView(
              shrinkWrap: true,
              physics:
                  const ScrollPhysics(parent: AlwaysScrollableScrollPhysics()),
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
                        newsDetailsModel.result!.fileLink!,
                        fit: BoxFit.fill,
                      )),

                  // titlePadding: EdgeInsets.symmetric(vertical: w(50)),
                ),
                SliverList(
                    delegate: SliverChildListDelegate([
                  // SizedBox(height: h(50),),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        // SizedBox(height: h(50),),

                        text(
                            text: newsDetailsModel.result!.title!,
                            fontsize: 16.sp,
                            color: Colors.black,
                            fontfamily: 'marai',
                            fontWeight: FontWeight.bold),
                        SizedBox(
                          height: h(15),
                        ),
                        text(
                            text: newsDetailsModel.result!.briefDescription!,
                            fontsize: 14.sp,
                            color: Colors.black,
                            fontfamily: 'marai'),
                        SizedBox(
                          height: h(20),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            children: [
                              ListView(
                                shrinkWrap: true,
                                physics: const ScrollPhysics(
                                    parent: NeverScrollableScrollPhysics()),
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
                                      data:
                                          newsDetailsModel.result!.description!,
                                    ),
                                  ),
                                  SizedBox(
                                    height: h(10),
                                  ),
                                  newsDetailsModel
                                          .result!.falseLinks!.isNotEmpty
                                      ? Column(
                                          children: [
                                            text(
                                                text: 'روابط مزيفة',
                                                color: Colors.black,
                                                fontsize: 20.sp,
                                                fontWeight: FontWeight.bold),
                                            customlistview(
                                                padding: 10,
                                                scroll: false,
                                                hight: newsDetailsModel.result!
                                                        .falseLinks!.isNotEmpty
                                                    ? newsDetailsModel
                                                            .result!
                                                            .falseLinks!
                                                            .length *
                                                        h(100)
                                                    : h(30),
                                                direction: 'vertical',
                                                itemcount: newsDetailsModel
                                                    .result!.falseLinks!.length,
                                                controller: ScrollController(),
                                                function: (context, index) {
                                                  return GestureDetector(
                                                    onTap: () async {
                                                      await launchInWebViewOrVC(
                                                          newsDetailsModel
                                                                  .result!
                                                                  .trueLinks![
                                                              index]);
                                                    },
                                                    child: Padding(
                                                      padding:
                                                          const EdgeInsets.all(
                                                              8.0),
                                                      child: container(
                                                          color:
                                                              AppColor.purple,
                                                          hight: h(60),
                                                          width: w(200),
                                                          borderRadius: 10,
                                                          child: Padding(
                                                            padding:
                                                                const EdgeInsets
                                                                    .all(8.0),
                                                            child: Text(
                                                              newsDetailsModel
                                                                      .result!
                                                                      .trueLinks![
                                                                  index],
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
                                  newsDetailsModel.result!.trueLinks!.isNotEmpty
                                      ? Column(
                                          children: [
                                            text(
                                                text: 'روابط حقيقية',
                                                color: Colors.black,
                                                fontsize: 20.sp,
                                                fontWeight: FontWeight.bold),
                                            customlistview(
                                                padding: 10,
                                                scroll: false,
                                                hight: newsDetailsModel.result!
                                                        .trueLinks!.isNotEmpty
                                                    ? newsDetailsModel
                                                            .result!
                                                            .falseLinks!
                                                            .length *
                                                        h(180)
                                                    : h(30),
                                                direction: 'vertical',
                                                itemcount: newsDetailsModel
                                                    .result!.trueLinks!.length,
                                                controller: ScrollController(),
                                                function: (context, index) {
                                                  return Padding(
                                                    padding:
                                                        const EdgeInsets.all(
                                                            8.0),
                                                    child: GestureDetector(
                                                      onTap: () async {
                                                        await launchInWebViewOrVC(
                                                            newsDetailsModel
                                                                    .result!
                                                                    .trueLinks![
                                                                index]);
                                                      },
                                                      child: container(
                                                          color:
                                                              AppColor.purple,
                                                          hight: h(60),
                                                          width: w(200),
                                                          borderRadius: 10,
                                                          child: Padding(
                                                            padding:
                                                                const EdgeInsets
                                                                    .all(8.0),
                                                            child: Text(
                                                              newsDetailsModel
                                                                      .result!
                                                                      .trueLinks![
                                                                  index],
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
                                  newsDetailsModel.result!.trueLinks!.length > 1
                                      ? SizedBox(
                                          height: h(30),
                                        )
                                      : const SizedBox(),
                                  newsDetailsModel.result!.isVotable!
                                      ? BlocBuilder(
                                        bloc: newsDetailsBloc,
                                          builder: (context, state) {
                                            if (state is LoadingVote){}
                                                    if (state is AddVoteState) {
            log('here add vote state ');
            log(state.voteResponseModel.result!.trueVotesCounts!.toString());

            trueVotesNumber = state.voteResponseModel.result!.trueVotesCounts!;
            falseVotesNumber =
                state.voteResponseModel.result!.falseVotesCounts!;
          }
                                            return Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.spaceAround,
                                              children: [
                                                GestureDetector(
                                                  onTap: () {
                                                    setState(() {
                                                      voteTrue = true;
                                                      voteFalse = false;
                                                    });
                                              newsDetailsBloc.add(AddVoteEvent(
                                                            newsDetailsModel
                                                                .result!.id!,
                                                            true));
                                                  },
                                                  child: container(
                                                
                                                    borderRadius: 10,
                                                    width: w(150),
                                                    color: voteTrue
                                                        ? Colors.green[900]
                                                        : AppColor.purple,
                                                    child: Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .spaceEvenly,
                                                      children: [
                                                        Icon(
                                                          Icons.check,
                                                          color: Colors.white,
                                                          size: 35.sp,
                                                        ),
                                                        text(
                                                            text: 'خبر صحيح',
                                                            color:
                                                                Colors.white),
                                                        // SizedBox(width: w(10),),
                                                        text(
                                                            text:
                                                                trueVotesNumber
                                                                    .toString(),
                                                            color:
                                                                Colors.white),
                                                      ],
                                                    ),
                                                  ),
                                                ),
                                                GestureDetector(
                                                  onTap: () {
                                                    voteTrue = false;
                                                    voteFalse = true;
                                                    setState(() {});
                                         newsDetailsBloc   .add(AddVoteEvent(
                                                            newsDetailsModel
                                                                .result!.id!,
                                                            false));
                                                  },
                                                  child: container(
                                                    borderRadius: 10,
                                                    width: w(150),
                                                    color: voteFalse
                                                        ? Colors.green[900]
                                                        : AppColor.purple,
                                                    child: Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .spaceEvenly,
                                                      children: [
                                                        Icon(
                                                          Icons.clear,
                                                          color: Colors.white,
                                                          size: 35.sp,
                                                        ),
                                                        text(
                                                            text: 'خبر خاطئ',
                                                            color:
                                                                Colors.white),
                                                        // SizedBox(width: w(10),),
                                                        text(
                                                            text:
                                                                falseVotesNumber
                                                                    .toString(),
                                                            color:
                                                                Colors.white),
                                                      ],
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            );
                                          },
                                        )
                                      : const SizedBox(
                                          height: 1,
                                        ),
                                  SizedBox(
                                    height: h(30),
                                  ),
                                  text(text: 'اكتب تعليقا', fontsize: 20.sp),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    children: [
                                      GestureDetector(
                                          onTap: () {
                                            if (comment != null) {
                                              newsDetailsBloc.add(
                                                  AddCommentEvent(
                                                      widget.news!.id
                                                          .toString(),
                                                      comment.toString()));
                                            }
                                          },
                                          child: BlocBuilder(
                                            bloc: newsDetailsBloc,
                                            builder: (context, state) {
                                              if (state is LoadingComment) {
                                                return Center(
                                                    child:
                                                        CircularProgressIndicator(
                                                  backgroundColor: Colors.grey,
                                                  color: Colors.grey[50],
                                                ));
                                              }
                                              return container(
                                                  hight: h(50),
                                                  width: w(80),
                                                  borderRadius: 10,
                                                  color: Colors.green[900],
                                                  child: text(
                                                      text: 'ارسال',
                                                      color: Colors.white));
                                            },
                                          )),
                                      container(
                                        color: Colors.grey[200],
                                        hight: h(100),
                                        width: w(240),
                                        borderRadius: 10,
                                        child: textform(
                                            padding: EdgeInsets.only(
                                                bottom: h(40), right: w(5)),
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
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: [
                                      SizedBox(
                                        width: w(150),
                                        child: text(
                                            text: 'التعليقات', fontsize: 24.sp),
                                      )
                                    ],
                                  ),
                                  comments.isNotEmpty
                                      ? BlocBuilder(
                                          bloc: newsDetailsBloc,
                                          builder: (context, state) {
                                            if (state is AddCommentState) {
                                              comments = state.comments;
                                            }

                                            return customlistview(
                                              scroll: false,
                                              direction: 'vertical',
                                              padding: 10,
                                              hight: comments.length * h(100),
                                              controller: ScrollController(),
                                              itemcount: comments.length,
                                              function: (context, index) {
                                                return Padding(
                                                  padding:
                                                      const EdgeInsets.all(8.0),
                                                  child: Column(
                                                    children: [
                                                      Container(
                                                          alignment: Alignment
                                                              .topRight,
                                                          decoration: BoxDecoration(
                                                              shape: BoxShape
                                                                  .rectangle,
                                                              color:
                                                                  Colors.grey[
                                                                      200],
                                                              borderRadius: const BorderRadius
                                                                  .all(Radius
                                                                      .circular(
                                                                          10))),
                                                          // constraints: BoxConstraints(minHeight: h(50),maxWidth: w(250),maxHeight: h(120),minWidth:w(250) ),

                                                          child: Padding(
                                                            padding:
                                                                const EdgeInsets
                                                                    .all(8.0),
                                                            child: text(
                                                              text: comments[
                                                                  index],
                                                              color:
                                                                  Colors.black,
                                                            ),
                                                          )),
                                                    ],
                                                  ),
                                                );
                                              },
                                            );
                                          },
                                        )
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
          );
        }));
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
