import 'dart:developer';
import 'dart:io';

import 'package:cool_alert/cool_alert.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sidq/App/app.dart';
import 'package:sidq/Widgets/container.dart';
import 'package:sidq/Widgets/nav.dart';
import 'package:sidq/Widgets/text.dart';
import 'package:sidq/core/consts.dart';
import 'package:sidq/features/home/presentation/pages/home.dart';
import 'package:sidq/features/index_page/presentation/bloc/index_page_bloc.dart';
import 'package:sidq/features/reverse_serach/presentation/pages/reverse_image_search.dart';
import 'package:sidq/features/review_tickets/presentation/pages/review_tickets.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../../injection_container.dart';


class IndexPage extends StatefulWidget {
  IndexPage({Key? key}) : super(key: key);

  @override
  State<IndexPage> createState() => _IndexPageState();
}

class _IndexPageState extends State<IndexPage> {
     IndexPageBloc indexPageBloc = sl<IndexPageBloc>();
 bool acceptPrivacy = true;
 @override
  void initState() {
      indexPageBloc.add(GetUserIdEvent());
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
      return Scaffold(
      backgroundColor: AppColor.purple,
      body: Center(
        child: BlocListener(
          bloc: indexPageBloc,
          listener: (context, state) {
            if (state is GetUserIdState) {
              log(state.id);
              if (sl<SharedPreferences>().getBool(Con.privacyAccepted) !=
                  true) {
          _showDialog(context);
            }
            }},
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(
                height: h(60),
              ),
              SizedBox(
                  height: h(150),
                  width: w(200),
                  child: Image.asset('assets/images/logo.png')),
              SizedBox(
                height: h(50),
              ),
              item('الـــتـــحقـــيقـــات', () {
                nav(context, const HomeBar());
              }, 'main 1.png'),

              SizedBox(
                height: h(25),
              ),

              item('البحث  العكسي', () {
                nav(context, const ReverseImageSearch());
              }, 'main2.png'),
              SizedBox(
                height: h(25),
              ),
              item(' وعي وتـــعـــليـــم', () {
                nav(
                    context,
                    const HomeBar(
                      categoryId: '3d0a5e84-9c54-46c1-8522-39daf705ce13',
                    ));
              }, 'main 3.png'),
              SizedBox(
                height: h(25),
              ),
              item(
                'فــيديـــوهـــات',
                () {
                  nav(
                      context,
                      const HomeBar(
                        categoryId: 'b520bade-3deb-4081-bb90-4b5094b8d522',
                      ));
                },
                'MAIN 4.png',
              ),
              SizedBox(
                height: h(25),
              ),
              item('إبـــلاغـــاتــــــي', () {
                nav(context, const ReviewTickets());
              }, 'profile.png'),
              SizedBox(
                height: h(20),
              ),
              // item('أبلغ عن  إشاعة', () {
              //   nav(
              //       context,
              //       const ReportFakeNews(
              //         title: 'أبلغ عن  إشاعة',
              //         isReport: true,
              //       ));
              // },'main 6.png'),
              SizedBox(
                height: h(60),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  GestureDetector(
                      onTap: () async {
                        String fbProtocolUrl;
                        if (Platform.isIOS) {
                          fbProtocolUrl = 'fb://profile/103579731015629';
                        } else {
                          fbProtocolUrl = 'fb://page/103579731015629';
                        }

                        String fallbackUrl = 'https://www.facebook.com/SidqYem';

                        try {
                          bool launched =
                              await launch(fbProtocolUrl, forceSafariVC: false);

                          if (!launched) {
                            await launch(fallbackUrl, forceSafariVC: false);
                          }
                        } catch (e) {
                          await launch(fallbackUrl, forceSafariVC: false);
                        }
                      },
                      child: socialMediaIcon('assets/images/facebook.png',
                          'https://www.facebook.com/SidqYem/')),
                  SizedBox(
                    width: w(5),
                  ),
                  GestureDetector(
                      onTap: () async {
                        var url = 'https://twitter.com/sidqyem';

                        if (await canLaunch(url)) {
                          await launch(
                            url,
                            universalLinksOnly: true,
                          );
                        } else {
                          launchInWebViewOrVC(url);
                        }
                      },
                      child: socialMediaIcon('assets/images/twitter.png',
                          'https://twitter.com/sidqyem')),
                  SizedBox(
                    width: w(5),
                  ),
                  GestureDetector(
                      onTap: () async {
                        var url = 'https://t.me/SidqYem';

                        if (await canLaunch(url)) {
                          await launch(
                            url,
                            universalLinksOnly: true,
                          );
                        } else {
                          launchInWebViewOrVC(url);
                        }
                      },
                      child: socialMediaIcon('assets/images/telegram.png',
                          'https://t.me/SidqYem')),
                  SizedBox(
                    width: w(5),
                  ),
                  GestureDetector(
                      onTap: () async {
                        var url = 'https://www.instagram.com/sidqyem/';

                        if (await canLaunch(url)) {
                          await launch(
                            url,
                            universalLinksOnly: true,
                          );
                        } else {
                          launchInWebViewOrVC(url);
                        }
                      },
                      child: socialMediaIcon('assets/images/instagram.png',
                          'https://www.instagram.com/sidqyem')),
                ],
              ),
              SizedBox(
                height: h(10),
              ),
              Center(
                child: GestureDetector(
                  onTap: () {
                    launchInWebViewOrVC("https://www.sidqyem.com/");
                  },
                  child: text(
                      text: "www.sidqyem.com",
                      color: Colors.white,
                      fontfamily: 'marai'),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
  void _showDialog(BuildContext context) {
  showDialog(
      barrierDismissible: false,
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        
        title:  Directionality(
          textDirection: TextDirection.rtl,
          child: Text("تنبيه")),
        content:  Row(
          children: [
            
            Checkbox( 
            activeColor:AppColor.purple,
              value: acceptPrivacy, onChanged: ((value) {
                print(value);
              acceptPrivacy = !value!;
              setState(() {
                
              });
        
            })),
            GestureDetector(
              onTap: (){
                  launch("https://kernel.services/sidq/sidq.pdf");
              },
              child: Text("الموافقة على سياسة الخصوصية",textDirection: TextDirection.rtl,style: TextStyle(  decoration: TextDecoration.underline,),)),
          ],
        ),
        actions: <Widget>[
             TextButton(
            child:  GestureDetector(
              onTap: (() {
          
       SystemNavigator.pop();
                
              }),
              child: Text("الغاء",style: TextStyle(color: AppColor.yellow),)),style: ButtonStyle(backgroundColor:  MaterialStatePropertyAll<Color>(AppColor.purple!),),
            
            
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
           TextButton(
            child:  GestureDetector(
              onTap: (() {
                if (acceptPrivacy==true){
                  sl<SharedPreferences>().setBool(Con.privacyAccepted, true)
;                  Navigator.of(context).pop();
                }
                else {
                  Fluttertoast.showToast(msg: 'نرجوا الموافقة على سياسة الخصوصية اولا');
                }
              }),
              child: Text("موافق",style: TextStyle(color: AppColor.yellow),)),style: ButtonStyle(backgroundColor:  MaterialStatePropertyAll<Color>(AppColor.purple!),),
            
            
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
        
        ],
      );
    },
  );
}
}

Widget item(String title, Function navigat, String image) {
  return InkWell(
    onTap: () {
      navigat();
    },
    child: container(
        hight: h(50),
        width: w(250),
        borderRadius: 20,
        child: Center(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              SizedBox(
                width: w(150),
                child: text(
                    color: AppColor.purple,
                    text: title,
                    fontfamily: 'marai',
                    fontWeight: FontWeight.bold,
                    textAlign: TextAlign.center,
                    fontsize: 20.sp),
              ),
              Image.asset(
                'assets/images/' + image,
                height: h(35),
                width: w(30),
                fit: BoxFit.contain,
                color: AppColor.purple,
              )
            ],
          ),
        )),
  );
}

Widget socialMediaIcon(String image, String url) {
  return Center(
    child: Container(
      height: h(30),
      width: w(30),
      decoration: BoxDecoration(shape: BoxShape.circle, color: AppColor.yellow),
      child: Center(
        child: Image.asset(
          image,
          fit: BoxFit.contain,
          height: h(20),
          width: w(20),
          color: AppColor.purple,
        ),
      ),
    ),
  );
}

  
