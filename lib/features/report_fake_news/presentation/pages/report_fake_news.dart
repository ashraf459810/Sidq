import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sidq/App/app.dart';
import 'package:sidq/Widgets/container.dart';
import 'package:sidq/Widgets/text.dart';
import 'package:sidq/Widgets/text_form.dart';
import 'package:sidq/core/consts.dart';

class ReportFakeNews extends StatefulWidget {
  final String? title;

  const ReportFakeNews({Key? key, this.title}) : super(key: key);

  @override
  _ReportFakeNewsState createState() => _ReportFakeNewsState();
}

class _ReportFakeNewsState extends State<ReportFakeNews> {
  String? name = '';
  String? claim = '';
  String? clamisLinks = '';
  TextEditingController namec = TextEditingController();
  TextEditingController claimsc = TextEditingController();
  TextEditingController clamisLinksc = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.purple,
      body: Center(
        child: ListView(
          children: [
            SizedBox(
              height: h(30),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: container(
                  width: w(300),
                  hight: h(50),
                  color: Colors.white,
                  borderRadius: 20,
                  child: text(
                      text: widget.title!,
                      fontfamily: 'marai',
                      fontsize: 18.sp)),
            ),
            SizedBox(
              height: h(50),
            ),
            inputForm(h(50), w(100), 'الاسم', namec, name!, w(250), 1, 0),
            SizedBox(
              height: h(20),
            ),
            inputForm(h(80), w(100), 'الادعاء', claimsc, claim!, w(250), 3, 10),
            SizedBox(
              height: h(20),
            ),
            inputForm(h(120), w(100), 'روابط \nناشري\n الادعاء', clamisLinksc,
                claim!, w(250), 5, 20),
          ],
        ),
      ),
    );
  }
}

Widget inputForm(
    double hight,
    double width,
    String title,
    TextEditingController controller,
    String textInputed,
    double width2,
    int? maxlines,
    double? padding) {
  return Column(
    children: [
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          container(
              hight: hight,
              width: width2,
              borderRadius: 20,
              child: Center(
                child: textform(
                    maxlines: maxlines ?? 1,
                    padding:
                        EdgeInsets.only(bottom: padding ?? 0, right: w(10)),
                    controller: controller,
                    function: (val) {
                      textInputed = val;
                    },
                    keyboard: 'name',
                    validation: (val) {
                      return val!;
                    }),
              )),
          container(
              width: width,
              hight: hight,
              borderRadius: 20,
              child: text(
                  text: title,
                  fontfamily: 'marai',
                  fontWeight: FontWeight.bold)),
        ],
      )
    ],
  );
}
