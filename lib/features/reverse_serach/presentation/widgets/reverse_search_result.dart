
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sidq/App/app.dart';
import 'package:sidq/Widgets/container.dart';
import 'package:sidq/Widgets/nav.dart';
import 'package:sidq/Widgets/text.dart';
import 'package:sidq/core/consts.dart';
import 'package:sidq/features/reverse_serach/data/model.dart/tineye_model.dart';
import 'package:sidq/features/reverse_serach/presentation/bloc/reverse_serach_bloc.dart';
import 'package:sidq/features/reverse_serach/presentation/widgets/tineye_search.dart';
import 'package:webview_flutter/webview_flutter.dart';

import '../../../../injection_container.dart';

class ReverseSearchResult extends StatefulWidget {
  final bool? isTinyEyeSearch;

  final String? imageLink;
  final String? site;
  const ReverseSearchResult(
      {Key? key, this.imageLink, this.site, this.isTinyEyeSearch})
      : super(key: key);

  @override
  _ReverseSearchResultState createState() => _ReverseSearchResultState();
}

class _ReverseSearchResultState extends State<ReverseSearchResult> {
  late TinyEyeModel tinyEyeModel;
  ReverseSerachBloc reverseSerachBloc  = sl<ReverseSerachBloc>();
  late WebViewController webViewController;
  // String bingExtention = '&idpbck=1&selectedindex=0&id=https%3A%2F%2Fstatic01.nyt.com%2Fimages%2F2021%2F09%2F14%2Fscience%2F07CAT-STRIPES%2F07CAT-STRIPES-superJumbo.jpg%3Fquality%3D75%26amp%3Bauto%3Dwebp&ccid=MWtidL3P&vt=2&sim=11';
  bool loading = true;
  String url = 'https://images.google.com/searchbyimage?image_url=';
  List<String> sites = ['Google', 'Bing', 'Yandex', "Tineye"];
  @override
  void initState() {

   

    log(widget.imageLink!);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        if (await webViewController.canGoBack()) {
          webViewController.goBack();

          return false;
        } else {
          Navigator.of(context).pop();
          return true;
        }
      },
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          actions: [
            Container(
              color: Colors.white,
              height: h(70),
              width: MediaQuery.of(context).size.width,
              child: Center(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: sites.length,
                    itemBuilder: (context, index) => Padding(
                      padding: EdgeInsets.symmetric(horizontal: w(10)),
                      child: GestureDetector(
                        onTap: () {
                          log('here');
                          switch (index) {
                            case 0:
                              url =
                                  'https://images.google.com/searchbyimage?image_url=';
                              navWithReplacement(
                                  context,
                                  ReverseSearchResult(
                                      site: url, imageLink: widget.imageLink));

                              break;
                            case 1:
                              url =
                                  'https://www.bing.com/images/search?view=detailv2&iss=sbi&form=SBIVSP&sbisrc=UrlPaste&q=imgurl:';
                              navWithReplacement(
                                  context,
                                  ReverseSearchResult(
                                    site: url,
                                    imageLink: widget.imageLink,
                                  ));

                              break;

                            case 2:
                              url =
                                  'https://yandex.com/images/search?rpt=imageview&url=';
                              navWithReplacement(
                                  context,
                                  ReverseSearchResult(
                                      site: url, imageLink: widget.imageLink));
                              break;
                            case 3:
                       
                              reverseSerachBloc.add(TinyEyeEvent(widget.imageLink!));

                              break;
                          }
                        },
                        child: container(
                            hight: h(50),
                            width: w(70),
                            borderRadius: 10,
                            color: Colors.white,
                            child: text(
                                text: sites[index],
                                fontsize: 12.sp,
                                fontWeight: FontWeight.bold,
                                color: Colors.grey)),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
        body:
             BlocConsumer(
            bloc: reverseSerachBloc,
                builder: (context, state) {
                 

                if (state is Loading){
                  return Center(child:  CircularProgressIndicator(backgroundColor: AppColor.purple,color: AppColor.yellow,));
                

                
              }
        
                  return
                 Column(
                  //  shrinkWrap: true,
                   children: [
            loading ?         SizedBox(height: loading? h(700): h(1),
              child: Center(child: CircularProgressIndicator(color: AppColor.purple,backgroundColor: AppColor.yellow ,))):const SizedBox(),
                     SizedBox(
                       height: loading? h(1): h(700),
                       child: WebView(
                            onPageFinished: (val) {
                              loading = false;
                              setState(() {
                                
                              });
                          
                            },
                            onWebViewCreated: (controller) {
                           
                              
                       
                              webViewController = controller;
                             
                            },
                            javascriptMode: JavascriptMode.unrestricted,
                            initialUrl: widget.site! + widget.imageLink!),
                     ),
                   ],
                 );
                }, listener: (BuildContext context, Object? state) {

                  if (state is TinyEyeState ){
                            tinyEyeModel = state.tinyEyeModel;

                    navWithReplacement(context, TinEyeSearchResult(tinyEyeModel: tinyEyeModel,imageUrl: widget.imageLink!,));
                  }
                  },
              )
            // : Center(
            //     child: SizedBox(
            //         height: h(400),
            //         child: Center(
            //             child: CircularProgressIndicator(
            //           backgroundColor: AppColor.yellow,
            //           color: AppColor.purple,
            //         ))),
            //   ),
      ),
    );
  }
}
