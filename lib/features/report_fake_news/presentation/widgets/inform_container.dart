
import 'package:flutter/cupertino.dart';
import 'package:sidq/App/app.dart';
import 'package:sidq/Widgets/container.dart';
import 'package:sidq/Widgets/text.dart';
import 'package:sidq/Widgets/text_form.dart';

Widget inputForm(
    double hight,
    double width,
    String title,
    TextEditingController controller,
    Function textInputed,
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
                        EdgeInsets.only(bottom: padding ?? 0, right: w(10),left: w(10)),
                    controller: controller,
                    function: (val) {
                      textInputed(val);
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