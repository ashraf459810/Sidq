import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sidq/App/app.dart';
import 'package:sidq/Widgets/container.dart';
import 'package:sidq/Widgets/nav.dart';
import 'package:sidq/Widgets/text.dart';
import 'package:sidq/core/consts.dart';
import 'package:sidq/features/reverse_serach/data/model.dart/tineye_model.dart';

import 'package:sidq/features/reverse_serach/presentation/widgets/reverse_search_result.dart';
import 'package:url_launcher/url_launcher.dart';

class TinEyeSearchResult extends StatefulWidget {
  final String  imageUrl;
  final TinyEyeModel tinyEyeModel ;

 const  TinEyeSearchResult({Key? key, required this.tinyEyeModel,required this.imageUrl}) : super(key: key);

  @override
  State<TinEyeSearchResult> createState() => _TinEyeSearchResultState();
}

class _TinEyeSearchResultState extends State<TinEyeSearchResult> {
    String url = 'https://images.google.com/searchbyimage?image_url=';
  List<String> sites = ['Google', 'Bing', 'Yandex', "Tineye"];
  @override
  Widget build(BuildContext context) {
    return Scaffold(appBar: 

AppBar(
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
                        
                          switch (index) {
                            case 0:
                              url =
                                  'https://images.google.com/searchbyimage?image_url=';
                              navWithReplacement(
                                  context,
                                  ReverseSearchResult(
                                      site: url, imageLink: widget.imageUrl));

                              break;
                            case 1:
                              url =
                                  'https://www.bing.com/images/search?view=detailv2&iss=sbi&form=SBIVSP&sbisrc=UrlPaste&q=imgurl:';
                              navWithReplacement(
                                  context,
                                  ReverseSearchResult(
                                    site: url,
                                    imageLink: widget.imageUrl,
                                  ));

                              break;

                            case 2:
                              url =
                                  'https://yandex.com/images/search?rpt=imageview&url=';
                              navWithReplacement(
                                  context,
                                  ReverseSearchResult(
                                      site: url, imageLink: widget.imageUrl));
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
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: GridView.builder(
                gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                    maxCrossAxisExtent: 200,
                    childAspectRatio: 0.8,
                    crossAxisSpacing: 20,
                    mainAxisSpacing: 20),
                itemCount: widget.tinyEyeModel.results.matches.length,
                itemBuilder: (BuildContext ctx, index) {
                  return

                   GestureDetector(onTap: () async {
if (!await launch(
    widget.tinyEyeModel.results.matches[index].backlinks[0].backlink,
    forceSafariVC: true,
    forceWebView: true,
    headers: <String, String>{'my_header_key': 'my_header_value'},
  )) {
    throw 'Could not launch $url';
  }
                                

                   }, child :
                  
                   Card(
                    
                    child: Column(
        
    
                      children: [
                        Image.network(widget.tinyEyeModel.results.matches[index].imageUrl,fit: BoxFit.contain,height: h(150),),
                   
                          // height: h(30),
                          // alignment: Alignment.center,
                          

                        Column(
                              children: [
                                SizedBox(
                                  height: h(50),
                                  child: Text(widget.tinyEyeModel.results.matches[index].backlinks[0].backlink,style: TextStyle(color: AppColor.purple),),),
                              ],
                            ),
                          
                     
                        
                      ],
                    ),
                     ),   );
                }),
        ),
      ),
    );
  }
}