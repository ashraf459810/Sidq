import 'dart:developer';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:new_version/new_version.dart';
import 'package:shimmer/shimmer.dart';
import 'package:sidq/App/app.dart';
import 'package:sidq/Widgets/container.dart';
import 'package:sidq/Widgets/custom_list_view.dart';
import 'package:sidq/Widgets/nav.dart';

import 'package:sidq/Widgets/text.dart';
import 'package:sidq/Widgets/text_form.dart';
import 'package:sidq/core/consts.dart';
import 'package:sidq/core/navigatuin_service/navigation.dart';
import 'package:sidq/features/home/data/models/category_model.dart';
import 'package:sidq/features/home/data/models/news_model.dart';
import 'package:sidq/features/home/data/models/search_params_model.dart';
import 'package:sidq/features/home/presentation/bloc/home_page_bloc.dart';
import 'package:sidq/features/home/presentation/widgets/loading_categories.dart';
import 'package:sidq/features/main_page/presentation/pages/main_page.dart';

import 'package:sidq/features/news_details/presentation/pages/news_details.dart';
import 'package:sidq/features/report_fake_news/presentation/pages/report_fake_news.dart';


import 'package:sidq/features/reverse_serach/presentation/pages/reverse_image_search.dart';

import '../../../../injection_container.dart';

class HomeBar extends StatefulWidget {
  const HomeBar({GlobalKey? key}) : super(key: key);

  @override
  _HomeBarState createState() => _HomeBarState();
}

class _HomeBarState extends State<HomeBar> with RouteAware {
   final GlobalKey _fabKey = GlobalKey();
  bool fabVisible = true;

  List<Result> categoryModel = [];
  String? categoryId;
  List<News> list = [];
  String? serach;
  TextEditingController searchc = TextEditingController();
  int currentIndex = 2;
  int page = 0;
  int pageSize = 10;
  ScrollController scrollController = ScrollController();

  setBottomBarIndex(index) {

    setState(() {
      currentIndex = index;
      
    });
  }
  @override
  didChangeDependencies() {
    super.didChangeDependencies();
    routeObserver.subscribe(this, ModalRoute.of(context) as PageRoute);
  }

 @override
  void initState() {
    super.initState();

    // Instantiate NewVersion manager object (Using GCP Console app as example)
    final newVersion = NewVersion(
      iOSId: 'com.example.sidq',
      androidId: 'com.example.sidq',
    );

    // You can let the plugin handle fetching the status and showing a dialog,
    // or you can fetch the status and display your own dialog, or no dialog.
    const simpleBehavior = true;

    if (simpleBehavior) {
      basicStatusCheck(newVersion);
    }
     
  
  }

  basicStatusCheck(NewVersion newVersion) {
    newVersion.showAlertIfNecessary(context: context);
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
                bottom: -6,
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
            buildFAB(context,_fabKey),
                      SizedBox(
                        width: size.width,
                        height: h(80),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            GestureDetector(
                              onTap: () {
                                setBottomBarIndex(0);
                                nav(context, const ReportFakeNews(isReport: false,title: 'ارسل تحقيق',));
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
                                          text: "تحقيق",
                                          color: currentIndex == 0
                                              ? AppColor.purple
                                              : Colors.grey,
                                          fontWeight: FontWeight.bold,
                                          textAlign: TextAlign.center))),
                            ),
                            GestureDetector(
                              onTap: () {
                                setBottomBarIndex(1);
                                      nav(context, const ReportFakeNews(isReport: true,title: 'ارسل ابلاغ',));
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
                                          text: "ابلاغ",
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
                                          text: 'الاخبار',
                                          color: currentIndex == 2
                                              ? AppColor.purple
                                              : Colors.grey,
                                       
                                          fontWeight: FontWeight.bold,
                                          textAlign: TextAlign.center))),
                            ),
                            GestureDetector(
                              onTap: () {
                                setBottomBarIndex(3);
                                navWithReplaceAll(context, const MainPage());
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
        body: SingleChildScrollView(
          child: Column(
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
                    if (state is GetNewsState) {
                      list = state.newsmodel.result!;
                    }
                    
                    if (state is LoadingCategory) {
                      log('here loading categories');
                      return loadingcategories();
                    }
                    if (state is GetCategoriesState) {
                      categoryModel = state.categoryModel.result;
                      SearchParamsModel searchParamsModel = SearchParamsModel(
                        
                          searchQuery: '',
                          orderDescending: true,
                          pageNumber: page,
                          pageLength: pageSize);
                      context
                          .read<NavigationBarBloc>()
                          .add(GetNewsEvent(searchParamsModel,false));
                    }
                    if (state is Error) {
                      Fluttertoast.showToast(
                          msg: state.error,
                          toastLength: Toast.LENGTH_SHORT,
                          gravity: ToastGravity.CENTER,
                          timeInSecForIosWeb: 1,
                          backgroundColor: Colors.grey[600],
                          textColor: Colors.white,
                          fontSize: 16.0);
                    }
                    return
                     categoryModel.isNotEmpty
                        ? customlistview(
                            padding: 10,
                            scroll: true,
                            // controller: scrollController,
                            itemcount: categoryModel.length,
                            function: (BuildContext context, index) {
                              return GestureDetector(onTap: (){
                                page = 0;
                                categoryId = categoryModel[index].id;
                                             SearchParamsModel searchParamsModel =
                                  SearchParamsModel(
                                    categoryId: categoryId,
                                      searchQuery: '',
                                      orderDescending: true,
                                      pageNumber: page,
                                      pageLength: pageSize);
                              context.read<NavigationBarBloc>()
                                  .add(GetNewsEvent(searchParamsModel,true));
                            
        
                              },
                                child: Padding(
                                  padding: EdgeInsets.symmetric(horizontal: w(7)),
                                  child: container(
                                      width: w(80),
                                      hight: h(60),
                                      color: Colors.white,
                                      borderRadius: 20,
                                      child: text(
                                          text: categoryModel[index].name ?? '',
                                          fontfamily: 'marai')),
                                ),
                              );
                            })
                        : const SizedBox();
                  },
                ),
              ),
              SingleChildScrollView(
                child: SizedBox(
                  height: MediaQuery.of(context).size.height * 0.653,
                  child: BlocBuilder<NavigationBarBloc, NavigationBarBlocState>(
                    builder: (context, state) {
           
        
                      return NotificationListener<ScrollNotification>(
                          onNotification: (notification) {
                            if (notification is ScrollEndNotification &&
                                scrollController.position.extentAfter == 0) {
                              page++;
                              
                              SearchParamsModel searchParamsModel =
                                  SearchParamsModel(
                                    categoryId: categoryId,
                                      searchQuery: '',
                                      orderDescending: true,
                                      pageNumber: page,
                                      pageLength: pageSize);
                              context
                                  .read<NavigationBarBloc>()
                                  .add(GetNewsEvent(searchParamsModel,false));
                            }
        
                            return false;
                          },
                          child: customlistview(
                              padding: 10,
                              direction: 'vertical',
                              scroll: true,
                              controller: scrollController,
                              itemcount: list.length + 1,
                              function: (context, index) {
                                if (index <list.length) {
                                  return Padding(
                                      padding:
                                          EdgeInsets.symmetric(vertical: h(8)),
                                      child: GestureDetector(
                                        onTap: (){
                                          Navigator.of(context).push( SecondPageRoute(list[index]));
                                        },
                                        child: newsSample(
                                            list[index].fileLink!,
                                            list[index].briefDescription!,
                                            list[index].title!),
                                      ));
                                } else {
                                  return BlocBuilder<NavigationBarBloc, NavigationBarBlocState>(
                                    builder: (context, state) {
                                      if (state is LoadingNews){
                                        log('here from loading');
                                                      return Center(child: CircularProgressIndicator(backgroundColor: Colors.grey,color: Colors.grey[50],));
                                      }
                                      return  SizedBox(height: h(100),);
                                    },
                                  );
                                }
                              }));
                    },
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget newsSample(String image, String desc, String title) {
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
                Flexible(child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: text(text: title, fontsize: 13.sp, fontWeight: FontWeight.bold),
                )),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: text(text: desc, fontsize: 11.sp),
                ),
              ],
            )),
        ClipRRect(
          borderRadius: const BorderRadius.all(Radius.circular(10)),

          // ignore: unnecessary_null_comparison
          child: image!=null? CachedNetworkImage(         height: h(120),
            width: w(120),
            fit: BoxFit.fitHeight,
        imageUrl: image,
        placeholder: (context, url) => Shimmer(child: Container(height: h(120),), gradient:const LinearGradient(
              begin: Alignment.topRight,
              end: Alignment.bottomLeft,
              colors: [
                Colors.grey,
                Colors.black,
              ],
            )
          ),

        errorWidget: (context, url, error) => const Icon(Icons.error),
     ):const SizedBox(),
          
          
          
    
        )
      ],
    );
  }
    onFabTap(BuildContext context) {
    
    // Hide the FAB on transition start
    setState(() => fabVisible = false);

    final RenderBox fabRenderBox = sl<NavigationService>().navigatorKey.currentContext
                                             !.findRenderObject() as RenderBox;  
    final fabSize = fabRenderBox.size /4;
    final fabOffset = fabRenderBox.localToGlobal(Offset(w(120), h(400)));

    Navigator.of(context).push(PageRouteBuilder(
      transitionDuration: duration,
      pageBuilder: (BuildContext context, Animation<double> animation,
              Animation<double> secondaryAnimation) =>
const ReverseImageSearch(),
      transitionsBuilder: (BuildContext context, Animation<double> animation,
              Animation<double> secondaryAnimation, Widget child) =>
          buildTransition(child, animation, fabSize, fabOffset),
    ));
  }

   buildTransition(
    Widget page,
    Animation<double> animation,
    Size fabSize,
    Offset fabOffset,
  ) {
    if (animation.value == 1) return page;

    final borderTween = BorderRadiusTween(
      begin: BorderRadius.circular(fabSize.width / 2),
      end: BorderRadius.circular(0.0),
    );
    final sizeTween = SizeTween(
      begin: fabSize,
      end: MediaQuery.of(context).size,
    );
    final offsetTween = Tween<Offset>(
      begin: fabOffset,
      end: Offset.zero,
    );

    final easeInAnimation = CurvedAnimation(
      parent: animation,
      curve: Curves.easeIn,
    );
    final easeAnimation = CurvedAnimation(
      parent: animation,
      curve: Curves.easeOut,
    );

    final radius = borderTween.evaluate(easeInAnimation);
    final offset = offsetTween.evaluate(animation);
    final size = sizeTween.evaluate(easeInAnimation);

    final transitionFab = Opacity(
      opacity: 1 - easeAnimation.value,
      child: buildFAB(context,_fabKey),
    );

    Widget positionedClippedChild(Widget child) => Positioned(
        width: size?.width,
        height: size?.height,
        left: offset.dx,
        top: offset.dy,
        child: ClipRRect(
          borderRadius: radius,
          child: child,
          
        ));

    return Stack(
      children: [
        positionedClippedChild(page),
        positionedClippedChild(transitionFab),
      ],
    );
        
}

  buildFAB( context, GlobalKey fabKey) {
        return  Center(
                        heightFactor: 0.6,
                        child: FloatingActionButton(
                            backgroundColor: Colors.white,
                            child: const Icon(
                              Icons.search,
                              color: Colors.black,
                              size: 40,
                            ),
                            elevation: 0.1,
                            onPressed: () {  onFabTap(context);}),
                      );
  }}

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

