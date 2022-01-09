import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sidq/App/app.dart';
import 'package:sidq/Widgets/container.dart';
import 'package:sidq/Widgets/nav.dart';
import 'package:sidq/Widgets/text.dart';
import 'package:sidq/core/consts.dart';
import 'package:sidq/features/navigation_bar/presentation/pages/navigation_bar.dart';
import 'package:sidq/features/report_fake_news/presentation/pages/report_fake_news.dart';

class MainPage extends StatelessWidget {
  const MainPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.purple,
      body: Center(
        child: ListView(
          children: [
            SizedBox(
              height: h(50),
            ),
            SizedBox(
                height: h(150),
                width: w(200),
                child: Image.asset('assets/images/logo.png')),
            SizedBox(
              height: h(50),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                item('البحث \nالعكسي', () {}),
                item('تصفح \nالتحقيقات', () {
                  nav(context, const HomeBar());
                })
              ],
            ),
            SizedBox(
              height: h(25),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [item('وعي', () {}), item('فديو', () {})],
            ),
            SizedBox(
              height: h(25),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                item('ارسل  \nتحقيقا', () {
                  () {};
                }),
                item('ابلغ عن  \nخبر زائف', () {
                  nav(
                      context,
                      const ReportFakeNews(
                        title: 'الابلاغ عن خبر زائف',
                      ));
                })
              ],
            ),
            SizedBox(
              height: h(70),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                socialMediaIcon('assets/images/facebook.png'),
                SizedBox(
                  width: w(20),
                ),
                socialMediaIcon('assets/images/twitter.png'),
                SizedBox(
                  width: w(20),
                ),
                socialMediaIcon('assets/images/telegram.png'),
                SizedBox(
                  width: w(20),
                ),
                socialMediaIcon('assets/images/instagram.png'),
              ],
            ),
            SizedBox(
              height: h(10),
            ),
            Center(
              child: text(
                  text: "www.sidqyem.com",
                  color: Colors.white,
                  fontfamily: 'marai'),
            )
          ],
        ),
      ),
    );
  }
}

Widget item(String title, Function navigat) {
  return InkWell(
    onTap: () {
      navigat();
    },
    child: container(
        hight: h(90),
        width: w(100),
        color: Colors.white,
        borderRadius: 20,
        child: Center(
          child: text(
              text: title,
              fontfamily: 'marai',
              fontWeight: FontWeight.bold,
              textAlign: TextAlign.center,
              fontsize: 18.sp),
        )),
  );
}

Widget socialMediaIcon(String image) {
  return Center(
    child: Image.asset(
      image,
      fit: BoxFit.contain,
      height: h(20),
      width: w(20),
      color: Colors.white,
    ),
  );
}
