import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:sidq/App/app.dart';
import 'package:sidq/core/consts.dart';


class HomeDrawer extends StatefulWidget {
  const HomeDrawer({Key? key}) : super(key: key);

  @override
  _HomeDrawerState createState() => _HomeDrawerState();
}

class _HomeDrawerState extends State<HomeDrawer> {
  @override
  Widget build(BuildContext context) {
    return (
     
           Container(
            color: AppColor.purple,
            child: SizedBox(
              width: w(250),
              child: Column(
                children: [
                  SizedBox(
                    height: h(30),
                  ),
                  Row(
                    children: [
                      SizedBox(
                        width: w(10),
                      ),
                      IconButton(
                          icon: Icon(
                            Icons.close,
                            size: 40,
                            color: AppColor.yellow
                            ,
                          ),
                          onPressed: () => Navigator.of(context).pop()),
                    ],
                  ),
                 
                    ],
                
                
              ),
            ),
          )
    );
  }
}
