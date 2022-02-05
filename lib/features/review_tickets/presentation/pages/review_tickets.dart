import 'dart:developer';

import 'package:expandable_text/expandable_text.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
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
        backgroundColor: AppColor.purple,
        body: ListView(
          shrinkWrap: true,
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: container(
                  width: w(300),
                  hight: h(50),
           
                  borderRadius: 20,
                  child: text(
                      text: 'الردود',
                      fontfamily: 'marai',
                      fontsize: 18.sp,
                      fontWeight: FontWeight.bold)),
            ),
            BlocBuilder<ReviewTicketsBloc, ReviewTicketsState>(
              builder: (context, state) {
                if (state is Loading){
                  return  SizedBox(height: h(300),
                    child: Center(child: CircularProgressIndicator(backgroundColor: AppColor.yellow,color: AppColor.purple,)));
                }
                if (state is Error){
                     Fluttertoast.showToast(
                        msg: state.error,
                        toastLength: Toast.LENGTH_SHORT,
                        gravity: ToastGravity.CENTER,
                        timeInSecForIosWeb: 1,
                        backgroundColor: Colors.grey[600],
                        textColor: Colors.white,
                        fontSize: 16.0);
                }
                if (state is GetTicketsState){
                  log('here from tickets');
                  tickets= state.ticketsResponseModel.result!;
                
                }
                return tickets.isNotEmpty? SizedBox(

                  height: h(700),
                  width: w(300),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
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
                        
                                  borderRadius: 10,
                                 
                                  
                                
                                  
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
                                          Row(mainAxisAlignment: MainAxisAlignment.end,
                                            children: [
                                             
                                              
                                              text(
                                                  text: tickets[index].answer !=null ? 'تم التحقق' : 'قيد التحقق',
                                                  fontfamily: 'marai',
                                                  color: AppColor.purple,
                                                  fontsize: 15.sp
                                                  ),
                                                  text(text: ' : '),
                                                   text(text: 'الحالة',
                                                   fontWeight: FontWeight.bold,
                                                     fontfamily: 'marai',
                                                  color: AppColor.purple,
                                                  fontsize: 15.sp

                                                   ),
                                            ],
                                          ),
                                                         SizedBox(
                                            height: h(10),
                                            
                                          ),
                                
                                          SizedBox(
                                            child: Row(mainAxisAlignment: MainAxisAlignment.end,
                                              children: [
                                                text(
                                                    text:  tickets[index].text!,
                                                    fontfamily: 'marai',
                                                     color: AppColor.purple,
                                                     fontWeight: FontWeight.bold,
                                                    fontsize: 15.sp),
                                                       text(text: ' : ',
                                                       
                                                       
                                                       ),

                                                                   text(
                                                    text: 'النص',
                                                    fontfamily: 'marai',
                                                    color: AppColor.purple,
                                                    fontWeight: FontWeight.bold,
                                                    fontsize: 15.sp
                                                    ),
                                                 
                                              ],
                                            ),
                                          ),
                                          SizedBox(
                                            height: w(10),
                                          ),
                Row(mainAxisAlignment: MainAxisAlignment.end,
                    children: [

                      SizedBox(

                        width: MediaQuery.of(context).size.width-140,
                        child: ExpandableText(
   tickets[index].answer!=null ?   "${tickets[index].answer}":'قيد الانتظار',
        expandText: 'اظهار المزيد',
        collapseText: 'اخفاء',
        maxLines: 2,
        
        linkColor: AppColor.purple,
    ),
                      ),
                         text(text: ' : ',
                                                       
                                                       
                                                       ),
                                         text(
                                                    text: '   الرد',
                                                    fontfamily: 'marai',
                                                    color: AppColor.purple,
                                                    fontWeight: FontWeight.bold,
                                                    fontsize: 15.sp
                                                    ),
                    ],
                ),

                                        ],
                                      ),
                                    ),
                                  )),
                            ),
                          );
                        }),
                  ),
                ):SizedBox(height: h(300),
                  child: Icon(Icons.sentiment_dissatisfied_outlined,color: Colors.grey[500],size: 50,));
              },
            )
          ],
        ),
      ),
    );
  }
}
