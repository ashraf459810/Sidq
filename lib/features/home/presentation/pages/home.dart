import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';

import 'package:new_version/new_version.dart';

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
import 'package:sidq/features/home/presentation/widgets/drawer.dart';
import 'package:sidq/features/home/presentation/widgets/loading_categories.dart';
import 'package:sidq/features/home/presentation/widgets/navigation_sample.dart';
import 'package:sidq/features/home/presentation/widgets/news_sample.dart';
import 'package:sidq/features/home/presentation/widgets/video_sample.dart';
import 'package:sidq/features/home/presentation/widgets/videos_category.dart';
import 'package:sidq/features/index_page/presentation/pages/index.dart';

import 'package:sidq/features/news_details/presentation/pages/news_details.dart';
import 'package:sidq/features/reverse_serach/presentation/pages/reverse_image_search.dart';
import 'package:sidq/features/review_tickets/presentation/pages/review_tickets.dart';
import '../../../../injection_container.dart';

class HomeBar extends StatefulWidget {
  final String? categoryId;
  const HomeBar({GlobalKey? key, this.categoryId}) : super(key: key);

  @override
  _HomeBarState createState() => _HomeBarState();
}

class _HomeBarState extends State<HomeBar> with RouteAware {
  final GlobalKey _fabKey = GlobalKey();
  bool fabVisible = true;
  int chosenIndex = -1;
  List<Result> categoryModel = [];
  String? categoryId;
  List<News> newslist = [];
  String? serach;
  TextEditingController searchc = TextEditingController();
  int currentIndex = 1;
  int page = 0;
  int pageSize = 20;
  bool isVideoTaps = false;
  ScrollController scrollController = ScrollController();
  bool isWa3i = false;

  setBottomBarIndex(index) {
    // setState(() {
    currentIndex = index;

    // });
  }

  @override
  didChangeDependencies() {
    super.didChangeDependencies();
    routeObserver.subscribe(this, ModalRoute.of(context) as PageRoute);
  }

  @override
  void initState() {
    if (
    widget.categoryId!=null){
      if(widget.categoryId!.contains(  '39daf705ce13')){

        isWa3i = true;

      }
    }
                                                      
                                                          
    if (widget.categoryId != null) {
      if (widget.categoryId!.contains('3d0a5e84-9c54-46c1-8522-39daf705ce13')) {
        currentIndex = 3;
      } else if (widget.categoryId!
          .contains('b520bade-3deb-4081-bb90-4b5094b8d522')) {
        currentIndex = 0;

        isVideoTaps = true;
      } else {
        currentIndex = 1;
      }
    }
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
        create: (context) => sl<NavigationBarBloc>()
          ..add(widget.categoryId == null
              ? const GetCategoriesEvent(0, 1000)
              : GetNewsEvent(
                  SearchParamsModel(
                      categoryId: widget.categoryId,
                      pageNumber: 0,
                      pageLength: 100,
                      searchQuery: '',
                      orderDescending: true),
                  false)),
        child: !isVideoTaps
            ? Scaffold(
                appBar: AppBar(
                  automaticallyImplyLeading: false,
                  iconTheme: const IconThemeData(color: Colors.white, size: 40),
                  elevation: 0,
                  backgroundColor: AppColor.purple,
                  actions: [
                    Padding(
                      padding: EdgeInsets.symmetric(vertical: h(7)),
                      child: container(
                          width: w(310),
                          hight: h(30),
                          // color: Colors.white,
                          borderRadius: 20,
                          child: SizedBox(
                            width: w(250),
                            child: Builder(builder: (context) {
                              return textform(
                                  padding: EdgeInsets.only(right: w(-10)),
                                  hint: 'بحث',
                                  hintsize: w(20),
                                  hintColor: AppColor.purple,
                                  controller: searchc,
                                  function: (val) {
                                    serach = val;
                                    context.read<NavigationBarBloc>().add(
                                        SearchNewsEvent(SearchParamsModel(
                                            searchQuery: val,
                                            pageNumber: 0,
                                            pageLength: 100,
                                            orderDescending: true)));
                                  },
                                  keyboard: 'name',
                                  validation: (val) {
                                    return val!;
                                  });
                            }),
                          )),
                    ),
                    SizedBox(
                      width: w(10),
                    ),
                    Builder(builder: (context) {
                      return GestureDetector(
                        onTap: () {
                          Scaffold.of(context).openEndDrawer();
                        },
                        child: Icon(
                          Icons.menu,
                          color: AppColor.yellow,
                        ),
                      );
                    }),
                    SizedBox(
                      width: w(5),
                    ),
                  ],
                ),
                endDrawer: const HomeDrawer(),
                backgroundColor: AppColor.purple,
                bottomNavigationBar: SizedBox(
                  height: h(75),
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
                              // CustomPaint(
                              //   size: Size(size.width, 80),
                              //   painter: BNBCustomPainter(),
                              // ),
                              buildFAB(context, _fabKey),
                              SizedBox(
                                width: size.width,
                                height: h(80),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: [
                                    GestureDetector(
                                        onTap: () {
                                          setBottomBarIndex(4);
                                          nav(context, const ReviewTickets());
                                        },
                                        child: navigationSample(
                                            'ابلاغاتي', 'profile.png')),
                                    GestureDetector(
                                        onTap: () {
                                          if (currentIndex == 3) {
                                          } else {
                                            setBottomBarIndex(3);
                                            nav(
                                                context,
                                                const HomeBar(
                                                  categoryId:
                                                      '3d0a5e84-9c54-46c1-8522-39daf705ce13',
                                                ));
                                          }
                                        },
                                        child: navigationSample(
                                            'وعي', 'main 3.png')),
                                    Container(
                                      width: size.width * 0.20,
                                    ),
                                    GestureDetector(
                                        onTap: () {
                                          if (currentIndex == 1) {
                                          } else {
                                            nav(context, const HomeBar());
                                            setBottomBarIndex(1);
                                          }
                                        },
                                        child: navigationSample(
                                            'تحقيقات', 'main 1.png', 10.sp)),
                                    GestureDetector(
                                        onTap: () {
                                          setBottomBarIndex(2);
                                          navWithReplaceAll(
                                              context,  IndexPage());
                                        },
                                        child: navigationSample('الرئيسية',
                                            'icon home.png', 10.sp)),
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
                  child: ListView(
                    shrinkWrap: true,
                    children: [
                      SizedBox(
                        height: h(10),
                      ),
                      SizedBox(
                        // height: h(60),
                        child: BlocBuilder<NavigationBarBloc,
                            NavigationBarBlocState>(
                          builder: (context, state) {
                            if (state is SearchNewsState) {
                              newslist = state.newsmodel.result!;
                            }
                            if (state is GetNewsState) {
              
                              newslist = state.newsmodel.result!;
                            }

                            if (state is LoadingCategory) {
                              log('here loading categories');
                              return loadingcategories();
                            }
                            if (state is GetCategoriesState) {
                              categoryModel = state.categoryModel.result;
                              SearchParamsModel searchParamsModel =
                                  SearchParamsModel(
                                      categoryId: widget.categoryId,
                                      searchQuery: '',
                                      orderDescending: true,
                                      pageNumber: page,
                                      pageLength: pageSize);
                              context
                                  .read<NavigationBarBloc>()
                                  .add(GetNewsEvent(searchParamsModel, false));
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
                            return (categoryModel.isNotEmpty &&
                                    widget.categoryId == null)
                                ? Container(
                                    alignment: Alignment.centerRight,
                                    height: h(60),
                                    child: customlistview(
                                        reverse: true,
                                        padding: 10,
                                        scroll: true,
                                        // controller: scrollController,
                                        itemcount: categoryModel.length,
                                        function:
                                            (BuildContext context, index) {
                                          return GestureDetector(
                                            onTap: () {
                                              if (chosenIndex == index) {
                                                chosenIndex = -1;
                                                page =0;
                                                         SearchParamsModel searchParamsModel =
                                  SearchParamsModel(
                                      categoryId: widget.categoryId,
                                      searchQuery: '',
                                      orderDescending: true,
                                      pageNumber: page,
                                      pageLength: pageSize);
                              context
                                  .read<NavigationBarBloc>()
                                  .add(GetNewsEvent(searchParamsModel, true));
                                                

                                              } else {
                                                chosenIndex = index;
                                                 page = 0;
                                              categoryId =
                                                  categoryModel[index].id;
                                              SearchParamsModel
                                                  searchParamsModel =
                                                  SearchParamsModel(
                                                      categoryId: categoryId,
                                                      searchQuery: '',
                                                      orderDescending: true,
                                                      pageNumber: page,
                                                      pageLength: pageSize);
                                              context
                                                  .read<NavigationBarBloc>()
                                                  .add(GetNewsEvent(
                                                      searchParamsModel, true));
                                              }

                                             
                                            },
                                            child: Padding(
                                              padding: EdgeInsets.symmetric(
                                                  horizontal: w(9)),
                                              child: container(
                                                  width: w(55),
                                                  hight: h(60),
                                                  color: chosenIndex == index
                                                      ? Colors.yellow[200]
                                                      : AppColor.yellow,
                                                  borderRadius: 20,
                                                  child: text(
                                                      fontsize: 12.sp,
                                                      color: AppColor.purple,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      text: categoryModel[index]
                                                              .name ??
                                                          '',
                                                      fontfamily: 'marai')),
                                            ),
                                          );
                                        }),
                                  )
                                : const SizedBox();
                          },
                        ),
                      ),
                      SizedBox(
                        height: h(600),
                        child: BlocBuilder<NavigationBarBloc,
                            NavigationBarBlocState>(
                          builder: (context, state) {
                            return NotificationListener<ScrollNotification>(
                                onNotification: (notification) {
                                  if (notification is ScrollEndNotification &&
                                      scrollController.position.extentAfter ==
                                          0) {
                                    page++;

                                    SearchParamsModel searchParamsModel =
                                        SearchParamsModel(
                                            categoryId:
                                                widget.categoryId == null
                                                    ? categoryId
                                                    : categoryId,
                                            searchQuery: '',
                                            orderDescending: true,
                                            pageNumber: page,
                                            pageLength: pageSize);
                                    context.read<NavigationBarBloc>().add(
                                        GetNewsEvent(searchParamsModel, false));
                                  }

                                  return false;
                                },
                                child: customlistview(
                                    padding: 10,
                                    direction: 'vertical',
                                    scroll: true,
                                    controller: scrollController,
                                    itemcount: newslist.length + 1,
                                    function: (context, index) {
                                      if (index < newslist.length) {
                                        return Padding(
                                            padding: EdgeInsets.symmetric(
                                                vertical: h(10)),
                                            child: GestureDetector(
                                                onTap: () {
                                                  Navigator.of(context).push(
                                                      SecondPageRoute(
                                                          newslist[index].id!));
                                                },
                                                child: (!isWa3i)
                                                    ? newsSample(
                                                        newslist[index]
                                                            .fileLink!,
                                                        newslist[index]
                                                            .briefDescription!,
                                                        newslist[index].title!,
                                                        newslist[index].date!,
                                                        newslist[index].views!)
                                                    : videoSample(
                                                        newslist[index]
                                                            .fileLink!,
                                                        newslist[index]
                                                            .title!)));
                                      } else {
                                        return BlocBuilder<NavigationBarBloc,
                                            NavigationBarBlocState>(
                                          builder: (context, state) {
                                            if (state is LoadingNews) {
                                              log('here from loading');
                                              return Center(
                                                  child:
                                                      CircularProgressIndicator(
                                                backgroundColor:
                                                    AppColor.yellow,
                                                color: AppColor.purple,
                                              ));
                                            }
                                            return SizedBox(
                                              height: h(25),
                                            );
                                          },
                                        );
                                      }
                                    }));
                          },
                        ),
                      )
                    ],
                  ),
                ),
              )
        :VideoCategory(categorId: 'b520bade-3deb-4081-bb90-4b5094b8d522' , newslist: newslist,)
           
           
                );
  }

  //////animation
  onFabTap(BuildContext context) {
    // Hide the FAB on transition start
    setState(() => fabVisible = false);

    final RenderBox fabRenderBox = sl<NavigationService>()
        .navigatorKey
        .currentContext!
        .findRenderObject() as RenderBox;
    final fabSize = fabRenderBox.size / 4;
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
      child: buildFAB(context, _fabKey),
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

  buildFAB(context, GlobalKey fabKey) {
    return GestureDetector(
      onTap: () {
        onFabTap(context);
      },
      child: Center(
        heightFactor: 1.2,
        child: Icon(
          Icons.search,
          color: AppColor.yellow,
          size: 60.sp,
        ),
      ),
    );
  }
}
