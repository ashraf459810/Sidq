import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sidq/App/app.dart';
import 'package:sidq/Widgets/text.dart';
import 'package:sidq/core/consts.dart';

class About extends StatefulWidget {
 const About({Key? key}) : super(key: key);

  @override
  State<About> createState() => _AboutState();
}

class _AboutState extends State<About> {
  String? data;
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
            text(text: 'عن صدق',color: AppColor.yellow,fontsize: 24.sp,fontfamily: 'marai'),
            SizedBox(height: h(30),),
text(maxLines: 1000,
  text: data??'',fontsize: 16.sp,fontfamily: 'marai',color: AppColor.yellow),





        ],),
      ),
    );
  }


  void loadData() async {
    final _loadedData = await rootBundle.loadString("assets/privacy/about.txt");
    setState(() {
      data = _loadedData;
    });
  }

}