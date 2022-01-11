import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:sidq/App/app.dart';
import 'package:sidq/Widgets/container.dart';
import 'package:sidq/Widgets/text.dart';

import 'package:sidq/core/consts.dart';

class ReverseImageSearch extends StatefulWidget {
  const ReverseImageSearch({Key? key}) : super(key: key);

  @override
  _ReverseImageSearchState createState() => _ReverseImageSearchState();
}

class _ReverseImageSearchState extends State<ReverseImageSearch> {
  final ImagePicker picker = ImagePicker();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.purple,
      body: ListView(
        children: [
          SizedBox(
            height: h(30),
          ),
          Image.asset(
            'assets/images/search.png',
            fit: BoxFit.cover,
            height: h(250),
            width: w(200),
          ),
          SizedBox(
            height: h(80),
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: w(30)),
            child: container(
                borderRadius: 20,
                color: Colors.green[900],
                hight: h(60),
                width: w(100),
                child: text(
                    text: "بحث نصي",
                    color: Colors.white,
                    fontWeight: FontWeight.bold)),
          ),
          SizedBox(
            height: h(80),
          ),
          GestureDetector(
            onTap: () async {
              final XFile? image =
                  await picker.pickImage(source: ImageSource.gallery);
            },
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: w(30)),
              child: container(
                  borderRadius: 20,
                  color: Colors.green[900],
                  hight: h(60),
                  width: w(100),
                  child: text(
                      text: "بحث صورة",
                      color: Colors.white,
                      fontWeight: FontWeight.bold)),
            ),
          )
        ],
      ),
    );
  }
}
