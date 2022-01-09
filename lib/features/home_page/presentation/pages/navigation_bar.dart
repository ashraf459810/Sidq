import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sidq/Widgets/text.dart';
import 'package:sidq/core/consts.dart';

class NavPage extends StatefulWidget {
  const NavPage({Key? key}) : super(key: key);

  @override
  _NavPageState createState() => _NavPageState();
}

class _NavPageState extends State<NavPage> {
  int currentIndex = 0;

  setBottomBarIndex(index) {
    setState(() {
      currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: AppColor.purple,
      body: Stack(
        children: [
          Positioned(
            bottom: 0,
            left: 0,
            child: SizedBox(
              width: size.width,
              height: 80,
              child: Stack(
                children: [
                  CustomPaint(
                    size: Size(size.width, 80),
                    painter: BNBCustomPainter(),
                  ),
                  Center(
                    heightFactor: 0.6,
                    child: FloatingActionButton(
                        backgroundColor: Colors.white,
                        child: const Icon(
                          Icons.search,
                          color: Colors.black,
                          size: 40,
                        ),
                        elevation: 0.1,
                        onPressed: () {}),
                  ),
                  SizedBox(
                    width: size.width,
                    height: 80,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        GestureDetector(
                          onTap: () {
                            setBottomBarIndex(0);
                          },
                          child: Container(
                              height: 50,
                              width: 50,
                              decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: currentIndex == 0
                                      ? Colors.white
                                      : Colors.grey[200]),
                              child: Center(
                                  child: text(
                                      fontfamily: 'marai',
                                      text: "وعي",
                                      color: currentIndex == 0
                                          ? AppColor.purple
                                          : Colors.grey,
                                      fontWeight: FontWeight.bold,
                                      textAlign: TextAlign.center))),
                        ),
                        GestureDetector(
                          onTap: () {
                            setBottomBarIndex(1);
                          },
                          child: Container(
                              height: 50,
                              width: 50,
                              decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: currentIndex == 1
                                      ? Colors.white
                                      : Colors.grey[200]),
                              child: Center(
                                  child: text(
                                      fontfamily: 'marai',
                                      text: "فديو",
                                      color: currentIndex == 1
                                          ? AppColor.purple
                                          : Colors.grey,
                                      fontWeight: FontWeight.bold,
                                      textAlign: TextAlign.center))),
                        ),
                        Container(
                          width: size.width * 0.20,
                        ),
                        GestureDetector(
                          onTap: () {
                            setBottomBarIndex(2);
                          },
                          child: Container(
                              height: 50,
                              width: 50,
                              decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: currentIndex == 2
                                      ? Colors.white
                                      : Colors.grey[200]),
                              child: Center(
                                  child: text(
                                      fontfamily: 'marai',
                                      text: "تصفح التحقيقات",
                                      color: currentIndex == 2
                                          ? AppColor.purple
                                          : Colors.grey,
                                      fontsize: 10.sp,
                                      fontWeight: FontWeight.bold,
                                      textAlign: TextAlign.center))),
                        ),
                        GestureDetector(
                          onTap: () {
                            setBottomBarIndex(3);
                          },
                          child: Container(
                              height: 50,
                              width: 50,
                              decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: currentIndex == 3
                                      ? Colors.white
                                      : Colors.grey[200]),
                              child: Center(
                                  child: text(
                                      fontfamily: 'marai',
                                      text: "الرئيسية",
                                      color: currentIndex == 3
                                          ? AppColor.purple
                                          : Colors.grey,
                                      fontsize: 11.sp,
                                      fontWeight: FontWeight.bold,
                                      textAlign: TextAlign.center))),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}

class BNBCustomPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    Paint paint = Paint()
      ..color = AppColor.grey ?? Colors.white
      ..style = PaintingStyle.fill;

    Path path = Path();
    path.moveTo(0, 20); // Start
    path.quadraticBezierTo(size.width * 0.20, 0, size.width * 0.40, 0);
    path.quadraticBezierTo(size.width * 0.40, 0, size.width * 0.40, 20);
    path.arcToPoint(Offset(size.width * 0.60, 10),
        radius: const Radius.circular(20.0), clockwise: false);
    path.quadraticBezierTo(size.width * 0.60, 0, size.width * 0.60, 0);
    path.quadraticBezierTo(size.width * 0.80, 0, size.width, 20);
    path.lineTo(size.width, size.height);
    path.lineTo(0, size.height);
    path.lineTo(0, 20);
    canvas.drawShadow(path, Colors.black, 5, true);
    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return false;
  }
}
