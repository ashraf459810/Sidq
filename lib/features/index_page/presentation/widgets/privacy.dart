import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sidq/App/app.dart';
import 'package:sidq/Widgets/text.dart';
import 'package:sidq/core/consts.dart';

class Privacy extends StatefulWidget {
 const Privacy({Key? key}) : super(key: key);

  @override
  State<Privacy> createState() => _PrivacyState();
}

class _PrivacyState extends State<Privacy> {
  String  ?data;

  @override
  void initState() {
    loadData();
    super.initState();
    
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.purple,
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: ListView(
          shrinkWrap: true,
          
          children: [
            text(text: 'سياسة الخصوصية',fontsize: 25.sp,color: AppColor.yellow,fontfamily: 'marai'),
            SizedBox(height: h(20),),
           text(maxLines: 1000,
             text: data ?? "", textAlign: TextAlign.right,color: AppColor.yellow,fontsize: 16.sp,fontfamily: 'marai'),
          
        ],),
      ),);
  }




  void loadData() async {
    final _loadedData = await rootBundle.loadString("assets/privacy/privacy.txt");
    setState(() {
      data = _loadedData;
    });
  }
}