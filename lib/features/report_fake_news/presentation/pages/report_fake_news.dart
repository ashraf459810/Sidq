import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:sidq/App/app.dart';
import 'package:sidq/Widgets/container.dart';
import 'package:sidq/Widgets/text.dart';
import 'package:sidq/core/consts.dart';
import 'package:sidq/features/report_fake_news/data/model/ticket_request_model.dart';
import 'package:sidq/features/report_fake_news/presentation/bloc/report_fake_news_bloc.dart';
import 'package:sidq/features/report_fake_news/presentation/widgets/inform_container.dart';

import '../../../../injection_container.dart';

class ReportFakeNews extends StatefulWidget {
  final String? title;
  @required
  final bool isReport;

  const ReportFakeNews({Key? key, this.title, required this.isReport})
      : super(key: key);

  @override
  _ReportFakeNewsState createState() => _ReportFakeNewsState();
}

class _ReportFakeNewsState extends State<ReportFakeNews> {
  String? name = '';
  String? claim = '';
  String? clamisLinks = '';
  String? truth = '';
  String? truthLinks = '';
  TextEditingController truthLinksc = TextEditingController();
  TextEditingController truthc = TextEditingController();
  TextEditingController namec = TextEditingController();
  TextEditingController claimsc = TextEditingController();
  TextEditingController clamisLinksc = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => sl<ReportFakeNewsBloc>(),
      child: Scaffold(
        backgroundColor: AppColor.purple,
        body: Center(
          child: ListView(
            children: [
              SizedBox(
                height: h(30),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: container(
                    width: w(300),
                    hight: h(50),
                    
                    borderRadius: 20,
                    child: text(
                        text: widget.title!,
                        fontfamily: 'marai',
                        fontsize: 18.sp,
                        
                        fontWeight: FontWeight.bold)),
              ),
              SizedBox(
                height: h(50),
              ),
              inputForm(h(50), w(100), 'الاسم', namec, (val){name = val;}, w(250), 1, 0),
              SizedBox(
                height: h(20),
              ),
              inputForm(
                  h(80), w(100), 'الادعاء', claimsc, (val){claim =val;}, w(250), 3, h(10)),
              SizedBox(
                height: h(20),
              ),
              inputForm(
                  widget.isReport ? h(120) : h(80),
                  w(100),
                  'روابط \nناشري\n الادعاء',
                  clamisLinksc,
                (val){  clamisLinks = val;},
                  w(250),
                  5,
                  h(20)),
              Visibility(
                visible: !widget.isReport,
                child: Column(
                  children: [
                    SizedBox(
                      height: h(20),
                    ),
                    inputForm(h(80), w(100), 'الحقيقة', truthc, (val){truth = val;}, w(250),
                        5, h(20)),
                    SizedBox(
                      height: h(20),
                    ),
                    inputForm(h(80), w(100), 'روابط \nالحقيقة', truthLinksc,
                        (val){truthLinks = val;}, w(250), 5, h(25)),
                  ],
                ),
              ),
              SizedBox(
                height: h(30),
              ),
              Padding(
                padding: EdgeInsets.all(h(12.0)),
                child: BlocConsumer<ReportFakeNewsBloc, ReportFakeNewsState>(
                  listener: (context, state) {
                                  log('error state is here');
                    if (state is Error){
                               Fluttertoast.showToast(
        msg: state.error,
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.CENTER,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.grey[600],
        textColor: Colors.white,
        fontSize: 16.sp
    );
                    }
                    if (state is AddTicketState){
                      log('state is here');
                      Fluttertoast.showToast(
        msg: 'تم اضافة طلبك بنجاح',
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.CENTER,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.grey[600],
        textColor: Colors.white,
        fontSize: 16.sp
    );
               
                    }
                  },
                  builder: (context, state) {
                    if (state is Loading){
                      return   Center(child: CircularProgressIndicator(backgroundColor: Colors.grey,color: Colors.grey[50],));
                    }
                    return GestureDetector(onTap: (){
                      log(name!);
                      log(claim!);
                if (widget.isReport==true && name!="" && claim!="" && clamisLinks !=null)  {
                   context.read<ReportFakeNewsBloc>().add(AddTicketEvent(TicketRequestBody(name: name,text: claim,falseLinks: clamisLinks,type: 5)));
                   } 
 

               else if (!widget.isReport  && name!="" && claim!="" && clamisLinks !=null && truthLinks!=null && truth!=null){
                 context.read<ReportFakeNewsBloc>().add(AddTicketEvent(TicketRequestBody(type: 4,name: name,text: claim,falseLinks: clamisLinks,truthLinks:truthLinks,truth: truth )) )   ;
                       } 
                                    else {                               Fluttertoast.showToast(
        msg: 'يرجى استكمال جميع المعلومات',
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.CENTER,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.grey[600],
        textColor: Colors.white,
        fontSize: 16.sp
    );}  },
                      child: container(
                          borderRadius: 20,
                          hight: h(50),
                          width: w(200),
                          // color: Colors.green[900],
                          child: Center(
                              child: text(
                                  text: "ارسال",
                                  color: AppColor.purple,
                                  fontfamily: 'marai',
                                  fontsize: 18.sp,
                                  fontWeight: FontWeight.bold,
                                  textAlign: TextAlign.center))),
                    );
                  },
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

