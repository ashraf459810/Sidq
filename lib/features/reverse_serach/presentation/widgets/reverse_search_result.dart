import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sidq/App/app.dart';
import 'package:sidq/Widgets/container.dart';
import 'package:sidq/Widgets/text.dart';
import 'package:sidq/core/consts.dart';
import 'package:webview_flutter/webview_flutter.dart';

class ReverseSearchResult extends StatefulWidget {
  final String? imageLink;
  const ReverseSearchResult({Key? key, this.imageLink}) : super(key: key);

  @override
  _ReverseSearchResultState createState() => _ReverseSearchResultState();
}

class _ReverseSearchResultState extends State<ReverseSearchResult> {
  List<String> sites = ['Google', 'Bing', 'TinEye', 'Yandex'];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[50],
      body: SafeArea(
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
                    itemCount: 4,
                    itemBuilder: (context, index) => Padding(
                      padding: EdgeInsets.symmetric(horizontal: w(10)),
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
            container(
                hight: h(700),
                child: WebView(
                    javascriptMode: JavascriptMode.unrestricted,
                    initialUrl:
                        'https://images.google.com/searchbyimage?image_url=${widget.imageLink}'))
          ],
        ),
      ),
    );
  }
}
