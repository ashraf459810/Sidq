import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sidq/App/app.dart';
import 'package:sidq/Widgets/container.dart';
import 'package:sidq/Widgets/nav.dart';
import 'package:sidq/Widgets/text.dart';
import 'package:sidq/core/consts.dart';
import 'package:webview_flutter/webview_flutter.dart';

class ReverseSearchResult extends StatefulWidget {
  final String? imageLink;
  final String ? site;
  const ReverseSearchResult({Key? key, this.imageLink, this.site}) : super(key: key);

  @override
  _ReverseSearchResultState createState() => _ReverseSearchResultState();
}

class _ReverseSearchResultState extends State<ReverseSearchResult> {
  // String bingExtention = '&idpbck=1&selectedindex=0&id=https%3A%2F%2Fstatic01.nyt.com%2Fimages%2F2021%2F09%2F14%2Fscience%2F07CAT-STRIPES%2F07CAT-STRIPES-superJumbo.jpg%3Fquality%3D75%26amp%3Bauto%3Dwebp&ccid=MWtidL3P&vt=2&sim=11';
    bool isLoading=true;
  String url ='https://images.google.com/searchbyimage?image_url=' ;
  List<String> sites = ['Google', 'Bing', 'Yandex'];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[50],
      body:
  
                      SafeArea(
        top: true,
        child: Column(
          children: [
            Container(
              color: Colors.white,
              height: h(70),
              child: Center(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: sites.length,
                    itemBuilder: (context, index) => Padding(
                      padding: EdgeInsets.symmetric(horizontal: w(25)),
                      child: GestureDetector(onTap: (){
                        log('here');
                        switch(index){
                 
                          case 0 :
                          
                      url = 'https://images.google.com/searchbyimage?image_url=';
                      navWithReplacement(context, ReverseSearchResult(site: url,imageLink: widget.imageLink)) ;     
                         
                          break;
                          case 1 :
                     
                             url ='https://www.bing.com/images/search?view=detailv2&iss=sbi&form=SBIVSP&sbisrc=UrlPaste&q=imgurl:';
                                  navWithReplacement(context, ReverseSearchResult(site: url,imageLink: widget.imageLink,)) ;     
                         
                          break;
                          
                    
                          case 2 : 
                 
                            url = 'https://yandex.com/images/search?rpt=imageview&url=';
                               navWithReplacement(context, ReverseSearchResult(site: url,imageLink: widget.imageLink)) ;     
                         
                          break;
                        }
                      },
                        child: container(
                            hight: h(50),
                            width: w(70),
                            borderRadius: 10,
                            color: AppColor.purple,
                            child: text(
                                text: sites[index],
                                fontsize: 12.sp,
                                color: Colors.white)),
                      ),
                    ),
                  ),
                ),
              ),
            ),
            Stack(
              children: [
         
                container(
                    hight: h(700),
                    child: WebView(
                
onPageFinished: (val){

  setState(() {
      isLoading = false;
  }); 
},

                        javascriptMode: JavascriptMode.unrestricted,
                        initialUrl:
                       widget.site! + widget.imageLink!)),
                                     isLoading ?  Center( child: SizedBox(height: h(400),
                    child: Center(child: CircularProgressIndicator(backgroundColor: Colors.grey[600],color: Colors.white,))),):const SizedBox(),
                               
              ],
            )
          ],
        ),
      ),
    );
  }
}

