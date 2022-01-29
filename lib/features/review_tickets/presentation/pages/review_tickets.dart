import 'dart:developer';

import 'package:expandable_text/expandable_text.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sidq/App/app.dart';
import 'package:sidq/Widgets/container.dart';
import 'package:sidq/Widgets/custom_list_view.dart';
import 'package:sidq/Widgets/text.dart';
import 'package:sidq/core/consts.dart';
import 'package:sidq/features/review_tickets/data/models/tickets_response_model.dart';
import 'package:sidq/features/review_tickets/presentation/bloc/review_tickets_bloc.dart';

import '../../../../injection_container.dart';

class ReviewTickets extends StatefulWidget {
  const ReviewTickets({Key? key}) : super(key: key);

  @override
  State<ReviewTickets> createState() => _ReviewTicketsState();
}

class _ReviewTicketsState extends State<ReviewTickets> {
  List<Result>  tickets= [];
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => sl<ReviewTicketsBloc>()..add(GetTicketsEvent()),
      child: Scaffold(
        body: ListView(
          shrinkWrap: true,
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: container(
                  width: w(300),
                  hight: h(50),
                  color: Colors.white,
                  borderRadius: 20,
                  child: text(
                      text: 'التحقيقات',
                      fontfamily: 'marai',
                      fontsize: 18.sp,
                      fontWeight: FontWeight.bold)),
            ),
            BlocBuilder<ReviewTicketsBloc, ReviewTicketsState>(
              builder: (context, state) {
                if (state is Loading){
                  return  SizedBox(height: h(300),
                    child: Center(child: CircularProgressIndicator(backgroundColor: Colors.grey,color: Colors.grey[50],)));
                }
                if (state is GetTicketsState){
                  log('here from tickets');
                  tickets= state.ticketsResponseModel.result!;
                
                }
                return tickets.isNotEmpty? SizedBox(

                  height: h(700),
                  width: w(300),
                  child: customlistview(
                      direction: 'vertical',
                      padding: 10,
                      itemcount: tickets.length,
                      scroll: true,
                      function: (context, index) {
                        return Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Card(
                            child: container(
                      
                                shadow: true,
                               
                                
                              
                                
                                // boxConstraints: BoxConstraints(
                                
                                //   minHeight: h(200),maxHeight: h(300),minWidth: w(300),maxWidth: w(300)),
                                child: SizedBox(
                                  width: w(320),
                                 
                                  child: Padding(
                                    padding:  EdgeInsets.only(left: w(10),right: w(20),bottom: h(10)),
                                    child: Column(
                                    
                                      crossAxisAlignment: CrossAxisAlignment.end,
           
                                      children: [
                                        SizedBox(
                                          height: h(20),
                                        ),
                                        text(
                                            text: tickets[index].answer !=null ? 'تم التحقق' : 'قيد التحقيق',
                                            fontfamily: 'marai',
                                            fontsize: 15.sp),
                                                       SizedBox(
                                          height: h(10),
                                        ),
                              
                                        text(
                                            text:  tickets[index].text!,
                                            fontfamily: 'marai',
                                            fontsize: 15.sp),
                                        SizedBox(
                                          width: w(10),
                                        ),
                ExpandableText(
   tickets[index].answer!=null ?   "${tickets[index].answer}":'',
        expandText: 'اظهار المزيد',
        collapseText: 'اخفاء',
        maxLines: 2,
        linkColor: AppColor.purple,
    ),

                                      ],
                                    ),
                                  ),
                                )),
                          ),
                        );
                      }),
                ):Icon(Icons.sentiment_dissatisfied_outlined,color: Colors.grey[500],);
              },
            )
          ],
        ),
      ),
    );
  }
}
