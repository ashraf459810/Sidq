import 'dart:io';

import 'package:flutter/material.dart';
import 'package:sidq/App/app.dart';
import 'package:sidq/Widgets/container.dart';
import 'package:sidq/Widgets/text.dart';
import 'package:webview_flutter/webview_flutter.dart';

class ReverseSearchResult extends StatefulWidget {
  final String? imageLink;
  const ReverseSearchResult({Key? key, this.imageLink}) : super(key: key);

  @override
  _ReverseSearchResultState createState() => _ReverseSearchResultState();
}

class _ReverseSearchResultState extends State<ReverseSearchResult> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[50],
      body: Column(
        children: [
          SizedBox(
            height: h(40),
          ),
          Row(
            children: [
              container(
                  hight: h(20),
                  width: w(60),
                  borderRadius: 20,
                  color: Colors.white,
                  child: text(text: "Google"))
            ],
          ),
          container(
              hight: h(600),
              child: WebView(
                  initialUrl:
                      'https://www.google.com/searchbyimage?site=search&sa=X&image_url=${widget.imageLink}'))
        ],
      ),
    );
  }
}
