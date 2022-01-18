import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:sidq/App/app.dart';
import 'package:sidq/Widgets/container.dart';
import 'package:sidq/Widgets/custom_list_view.dart';

import 'package:sidq/Widgets/text.dart';
import 'package:sidq/Widgets/text_form.dart';
import 'package:sidq/core/consts.dart';
import 'package:sidq/features/home/data/models/category_model.dart';
import 'package:sidq/features/home/data/models/news_model.dart';
import 'package:sidq/features/home/data/models/search_params_model.dart';
import 'package:sidq/features/home/presentation/bloc/home_page_bloc.dart';
import 'package:sidq/features/home/presentation/widgets/loading_categories.dart';
import 'package:sidq/features/home/presentation/widgets/loading_news.dart';

import '../../../../injection_container.dart';

class HomeBar extends StatefulWidget {
  const HomeBar({Key? key}) : super(key: key);

  @override
  _HomeBarState createState() => _HomeBarState();
}

class _HomeBarState extends State<HomeBar> {
  CategoryModel categoryModel = CategoryModel();
  List<NewsModel> list = [];
  String? serach;
  TextEditingController searchc = TextEditingController();
  int currentIndex = 0;
  int page = 0;
  int pageSize = 10;
  ScrollController scrollController = ScrollController();

  setBottomBarIndex(index) {
    setState(() {
      currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return BlocProvider(
      create: (context) =>
          sl<NavigationBarBloc>()..add(const GetCategoriesEvent(0, 100)),
      child: Scaffold(
        backgroundColor: AppColor.purple,
        bottomNavigationBar: SizedBox(
          height: size.height * 0.12,
          child: Stack(
            children: [
              Positioned(
                bottom: 0,
                left: 0,
                child: SizedBox(
                  width: size.width,
                  height: h(80),
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
                        height: h(80),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            GestureDetector(
                              onTap: () {
                                setBottomBarIndex(0);
                                // nav(context, const HomeBar());
                              },
                              child: Container(
                                  height: h(50),
                                  width: w(50),
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
                                  height: h(50),
                                  width: w(50),
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
                                  height: h(50),
                                  width: w(50),
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
                                  height: h(50),
                                  width: w(50),
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
        ),
        body: Column(
          children: [
            SizedBox(
              height: h(50),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: w(20)),
              child: container(
                  width: w(320),
                  hight: h(50),
                  color: Colors.white,
                  borderRadius: 20,
                  child: SizedBox(
                    width: w(250),
                    child: textform(
                        hint: 'بحث',
                        hintsize: w(20),
                        controller: searchc,
                        function: (val) {
                          serach = val;
                        },
                        keyboard: 'name',
                        validation: (val) {
                          return val!;
                        }),
                  )),
            ),
            SizedBox(
              height: h(20),
            ),
            SizedBox(
              height: h(60),
              child: BlocBuilder<NavigationBarBloc, NavigationBarBlocState>(
                builder: (context, state) {
                  if (state is NavigationBarBlocInitial) {
                    return CircularProgressIndicator();
                  }
                  if (state is LoadingCategory) {
                    return loadingCategoreis();
                  }
                  if (state is GetCategoriesState) {
                    categoryModel = state.categoryModel;
                    SearchParamsModel searchParamsModel = SearchParamsModel(
                        categoryId: categoryModel.result![0].id,
                        isTrue: true,
                        isVotable: false,
                        pageNumber: page,
                        pageLength: pageSize);
                    context
                        .read<NavigationBarBloc>()
                        .add(GetNewsEvent(searchParamsModel));
                  }
                  if (state is Error) {
                    Fluttertoast.showToast(
                        msg: state.error,
                        toastLength: Toast.LENGTH_SHORT,
                        gravity: ToastGravity.CENTER,
                        timeInSecForIosWeb: 1,
                        backgroundColor: Colors.red,
                        textColor: Colors.white,
                        fontSize: 16.0);
                  }
                  return categoryModel.result!.isNotEmpty
                      ? customlistview(
                          padding: 10,
                          scroll: true,
                          controller: scrollController,
                          itemcount: categoryModel.result!.length,
                          function: (context, index) {
                            return Padding(
                              padding: EdgeInsets.symmetric(horizontal: w(7)),
                              child: container(
                                  width: w(80),
                                  hight: h(60),
                                  color: Colors.white,
                                  borderRadius: 20,
                                  child: text(
                                      text: categoryModel.result![index].name ??
                                          '',
                                      fontfamily: 'marai')),
                            );
                          })
                      : const SizedBox();
                },
              ),
            ),
            SingleChildScrollView(
              child: SizedBox(
                height: MediaQuery.of(context).size.height * 0.633,
                child: BlocBuilder<NavigationBarBloc, NavigationBarBlocState>(
                  builder: (context, state) {
                    if (state is LoadingNews) {
                      return loadingNews();
                    }

                    return NotificationListener<ScrollNotification>(
                        onNotification: (notification) {
                          if (notification is ScrollEndNotification &&
                              scrollController.position.extentAfter == 0) {
                            print("here from listener");
                            page++;
                            SearchParamsModel searchParamsModel =
                                SearchParamsModel(
                                    categoryId: categoryModel.result![0].id,
                                    isTrue: true,
                                    isVotable: false,
                                    pageNumber: page,
                                    pageLength: pageSize);
                            context
                                .read<NavigationBarBloc>()
                                .add(GetNewsEvent(searchParamsModel));
                          }

                          return false;
                        },
                        child: customlistview(
                            padding: 0,
                            direction: 'vertical',
                            scroll: true,
                            controller: ScrollController(),
                            itemcount: list.length,
                            function: (context, index) {
                              return Padding(
                                  padding: EdgeInsets.symmetric(vertical: h(8)),
                                  child: newsSample("d",
                                      "losdf asfasfasf asf asf asf as fasfas fasfsafasfasfasfasfas asfas fas fas fasfasfasfasfasfasf rem asasasda"));
                            }));
                  },
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget newsSample(String image, String desc) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        container(
            color: Colors.white,
            hight: h(120),
            width: w(220),
            borderRadius: 10,
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: text(text: desc),
                ),
              ],
            )),
        ClipRRect(
          borderRadius: const BorderRadius.all(Radius.circular(10)),
          child: Image.asset(
            "assets/images/news.jpeg",
            height: h(120),
            width: w(120),
            fit: BoxFit.fitHeight,
          ),
        )
      ],
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
