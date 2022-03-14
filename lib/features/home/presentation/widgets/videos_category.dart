
   // ignore_for_file: must_be_immutable
   
   import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sidq/App/app.dart';
import 'package:sidq/Widgets/custom_list_view.dart';
import 'package:sidq/Widgets/nav.dart';
import 'package:sidq/Widgets/text.dart';
import 'package:sidq/core/consts.dart';
import 'package:sidq/features/home/data/models/search_params_model.dart';
import 'package:sidq/features/home/presentation/bloc/home_page_bloc.dart';
import 'package:sidq/features/home/presentation/pages/home.dart';
import 'package:sidq/features/home/presentation/widgets/navigation_sample.dart';
import 'package:sidq/features/home/presentation/widgets/video_sample.dart';
import 'package:sidq/features/index_page/presentation/pages/index.dart';

import 'package:sidq/features/news_details/presentation/pages/news_details.dart';
import 'package:sidq/features/reverse_serach/presentation/pages/reverse_image_search.dart';
import 'package:sidq/features/review_tickets/presentation/pages/review_tickets.dart';

import '../../../../injection_container.dart';
import 'drawer.dart';

class VideoCategory extends StatefulWidget {
  final String categorId ;
   dynamic newslist ;


      VideoCategory({Key ?key, required this.categorId, this.newslist}) : super(key: key);
   
     @override
     State<VideoCategory> createState() => _VideoCategoryState();
   }
   
   class _VideoCategoryState extends State<VideoCategory> {
     late String  categoryId;
     ScrollController scrollController = ScrollController();
        int page = 0;

        @override
  void initState() {
    categoryId = widget.categorId;
    super.initState();
  }
     @override
     
     Widget build(BuildContext context) {
          var size= MediaQuery.of(context).size;
       return 
     DefaultTabController(
                length: 2,
                child: BlocProvider(
                  create: (context) => sl<NavigationBarBloc>()..add(GetNewsEvent(
                  SearchParamsModel(
                      categoryId: widget.categorId,
                      pageNumber: 0,
                      pageLength: 10,
                      searchQuery: '',
                      orderDescending: true),
                  false)),
                  child: Builder(
                    builder: (context) {
                      return Scaffold(
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
                              GestureDetector(
                                onTap:  (){
                                  nav(context,const ReverseImageSearch());
                                },
                                child: Center(
                                      heightFactor: 1.2,
                                      child: Icon(
                                        Icons.search,
                                        color: AppColor.yellow,
                                        size: 60.sp,
                                      ),
                                    ),
                              ),

                              SizedBox(
                                width: size.width,
                                height: h(80),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: [
                                    GestureDetector(
                                        onTap: () {
                             
                                          nav(context, const ReviewTickets());
                                        },
                                        child: navigationSample(
                                            'ابلاغاتي', 'profile.png')),
                                    GestureDetector(
                                        onTap: () {
                                  
                                            nav(
                                                context,
                                                const HomeBar(
                                                  categoryId:
                                                      '3d0a5e84-9c54-46c1-8522-39daf705ce13',
                                                ));
                                          
                                        },
                                        child: navigationSample(
                                            'وعي', 'main 3.png')),
                                    Container(
                                      width: size.width * 0.20,
                                    ),
                                    GestureDetector(
                                        onTap: () {
                                    
                                            nav(context, const HomeBar());
                                         
                                        },
                                        child: navigationSample(
                                            'تحقيقات', 'main 1.png', 10.sp)),
                                    GestureDetector(
                                        onTap: () {
                                 
                                          navWithReplaceAll(
                                              context,  IndexPage());
                                        },
                                        child: navigationSample('الرئيسية',
                                            'icon home.png', 10.sp)),
                                  ],
                                ),
                              )])))])),
                        endDrawer:const HomeDrawer(),
                        backgroundColor: AppColor.purple,
                        appBar: AppBar(
                          iconTheme: IconThemeData(color: AppColor.yellow),
                          centerTitle: true,
                          title: text(text: 'فيديوهات',color: AppColor.yellow,fontfamily: 'marai',fontsize: 20.sp,fontWeight: FontWeight.bold),
                          backgroundColor: AppColor.purple,
                            bottom:  TabBar(
                              onTap: (value) {
                                page = 0;
                        
                                if (value ==0){
                                  categoryId= 'b520bade-3deb-4081-bb90-4b5094b8d522';
                                      
                          context.read<NavigationBarBloc>().add(GetNewsEvent(  SearchParamsModel(
                          categoryId: 'b520bade-3deb-4081-bb90-4b5094b8d522',
                          pageNumber: 0,
                          pageLength: 10,
                          searchQuery: '',
                          orderDescending: true),true));

                          


                                  
                                }
                                else {
                                  page =   0 ;
                                  categoryId = '3756919b-f9e3-42e1-bfb9-1eef1d6aef6b';
                                              context.read<NavigationBarBloc>().add(GetNewsEvent(  SearchParamsModel(
                          categoryId: '3756919b-f9e3-42e1-bfb9-1eef1d6aef6b',
                          pageNumber: 0,
                          pageLength: 10,
                          searchQuery: '',
                          orderDescending: true),true));

                                }
                              },
                              indicatorColor: AppColor.yellow,
                          tabs: [
                            Tab(child: text(text: 'توعوية',color: AppColor.yellow,fontfamily: 'marai',fontsize: 16.sp)),
                 Tab(child: text(text: 'تحقیقات',color: AppColor.yellow,fontfamily: 'marai',fontsize: 16.sp)),
                          ],
                        )),

                        body:  SizedBox(
                        height: h(600),
                        child: BlocBuilder<NavigationBarBloc,
                            NavigationBarBlocState>(
                          builder: (context, state) {
                         if (state is GetNewsState) {
                             widget.newslist = state.newsmodel.result!;
                            }
                            return NotificationListener<ScrollNotification>(
                                onNotification: (notification) {
                                  if (notification is ScrollEndNotification &&
                                      scrollController.position.extentAfter ==
                                          0) {
                                    page++;

                                    SearchParamsModel searchParamsModel =
                                        SearchParamsModel(
                                            categoryId:
                                                categoryId,
                                            searchQuery: '',
                                            orderDescending: true,
                                            pageNumber: page,
                                            pageLength: 10);
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
                                    itemcount: widget.newslist.length + 1,
                                    function: (context, index) {
                                      if (index < widget.newslist.length) {
                                        return Padding(
                                            padding: EdgeInsets.symmetric(
                                                vertical: h(10)),
                                            child: GestureDetector(
                                                onTap: () {
                                                  Navigator.of(context).push(
                                                      SecondPageRoute(
                                                          widget.newslist[index].id!));
                                                },
                                                child:  videoSample(
                                                        widget.newslist[index]
                                                            .fileLink!,
                                                        widget.newslist[index]
                                                            .title!)));
                                      } else {
                                        return BlocBuilder<NavigationBarBloc,
                                            NavigationBarBlocState>(
                                          builder: (context, state) {
                                            if (state is LoadingNews) {
                                            
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
                      ) ,
                      );
                    }
                  ),
                ));
           

             }
             
   }