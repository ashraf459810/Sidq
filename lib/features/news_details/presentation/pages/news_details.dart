import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sidq/App/app.dart';
import 'package:sidq/Widgets/container.dart';
import 'package:sidq/Widgets/text.dart';
import 'package:sidq/features/home/data/models/news_model.dart';

class NewsDetails extends StatefulWidget {
  final News? news;
  const NewsDetails({Key? key, this.news}) : super(key: key);

  @override
  _NewsDetailsState createState() => _NewsDetailsState();
}

class _NewsDetailsState extends State<NewsDetails> {
   ScrollController scrollController = ScrollController();
  ScrollController scrollController2 = ScrollController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
    body:  SafeArea(top: true,
      child: CustomScrollView(
          shrinkWrap: true,
          physics:const ScrollPhysics(parent: AlwaysScrollableScrollPhysics()),
          controller: scrollController,
          slivers: <Widget>[
            SliverAppBar(
   backgroundColor: Colors.white,
              shadowColor: Colors.white,
                expandedHeight: h(300),
            flexibleSpace: FlexibleSpaceBar(
              centerTitle: true,
              title:  Text(widget.news!.title!),
              background: Image.network(
    
                    widget.news!.fileLink!,
                    fit: BoxFit.fill,
                  )),
             
               
        
                  // titlePadding: EdgeInsets.symmetric(vertical: w(50)),
            
            ),
            SliverList(delegate: SliverChildListDelegate([
                // SizedBox(height: h(50),),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    // SizedBox(height: h(50),),

                    text(text: widget.news!.title! ,fontsize: 16.sp,color: Colors.black,fontfamily: 'marai',fontWeight: FontWeight.bold),
                    SizedBox(height: h(15),),
                         text(text: widget.news!.briefDescription! ,fontsize: 14.sp,color: Colors.black,fontfamily: 'marai'),
                         container(hight: h(800),),

                         
                  ],
                ),
              )
  

            ]))
       
          ],
        ),
    ),
    

    );
  }

}