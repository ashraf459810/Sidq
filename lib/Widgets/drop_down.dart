import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sidq/App/app.dart';
import 'package:sidq/Core/consts.dart';

class DropDown extends StatefulWidget {
  final String? chosenvalue;
  final String? hint;
  final List<dynamic>? list;
  final Function? onchanged;
  final Function? getindex;
  // ignore: use_key_in_widget_constructors
  const DropDown(
      {this.chosenvalue, this.hint, this.list, this.onchanged, this.getindex});

  @override
  _DropDownState createState() => _DropDownState();
}

class _DropDownState extends State<DropDown> {
  String? chosenvalue;
  @override
  Widget build(BuildContext context) {
    return DropdownButton<dynamic>(
      // focusNode: FocusNode(canRequestFocus: false, skipTraversal: false),
      isExpanded: true,
      underline: const SizedBox(),
      hint: chosenvalue == null
          ? Padding(
              padding: EdgeInsets.only(left: w(10)),
              child: Text(
                widget.hint!,
                textAlign: TextAlign.center,
                style: TextStyle(color: AppColor.hintcolor, fontSize: 12.sp),
              ),
            )
          : Padding(
              padding: EdgeInsets.only(left: w(10)),
              child: Text(chosenvalue!,
                  textAlign: TextAlign.start,
                  style: TextStyle(
                    fontSize: 14.sp,
                    color: Colors.black,
                  )),
            ),
      items: widget.list?.map((dynamic value) {
        return DropdownMenuItem<dynamic>(
            value: value,
            child: value is String
                ? Center(
                    child: Text(
                    value,
                    style: value != "6"
                        ? TextStyle(
                            fontSize: 12.sp,
                          )
                        : TextStyle(
                            fontSize: 15.sp,
                            color: AppColor.blue,
                            fontWeight: FontWeight.bold),
                  ))
                : Center(
                    child: Text(
                    value.name,
                    style: TextStyle(fontSize: 12.sp),
                  )));
      }).toList(),
      onChanged: (value) {
        setState(() {
          widget.onchanged!(value);
          value is String ? chosenvalue = value : chosenvalue = value.name;
          int index = 0;
          index = widget.list!.indexOf(value);
          widget.getindex!(index);
        });
      },
    );
  }
}
