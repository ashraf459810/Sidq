import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:sidq/App/app.dart';
import 'package:sidq/Widgets/container.dart';
import 'package:sidq/Widgets/text.dart';
import 'package:sidq/Widgets/text_form.dart';
import 'package:sidq/core/consts.dart';
import 'package:sidq/features/report_fake_news/data/model/ticket_request_model.dart';
import 'package:sidq/features/report_fake_news/presentation/bloc/report_fake_news_bloc.dart';

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
                    color: Colors.white,
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
                  h(80), w(100), 'الادعاء', claimsc, (val){claim =val;}, w(250), 3, 10),
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
                  20),
              Visibility(
                visible: !widget.isReport,
                child: Column(
                  children: [
                    SizedBox(
                      height: h(20),
                    ),
                    inputForm(h(80), w(100), 'الحقيقة', truthc, (val){truth = val;}, w(250),
                        5, 20),
                    SizedBox(
                      height: h(20),
                    ),
                    inputForm(h(80), w(100), 'روابط \nالحقيقة', truthLinksc,
                        (val){truthLinks = val;}, w(250), 5, 20),
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
                    if (state is AddTicketState){
                      log('state is here');
                      Fluttertoast.showToast(
        msg: 'تم اضافة طلبك بنجاح',
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.CENTER,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.red,
        textColor: Colors.white,
        fontSize: 16.0
    );
               
                    }
                  },
                  builder: (context, state) {
                    if (state is Loading){
                      return const Center(child: CircularProgressIndicator());
                    }
                    return GestureDetector(onTap: (){
                      log(name!);
                      log(claim!);
                   widget.isReport?   context.read<ReportFakeNewsBloc>().add(AddTicketEvent(TicketRequestBody(name: name,text: claim,falseLinks: clamisLinks,type: 5)) ):
                 context.read<ReportFakeNewsBloc>().add(AddTicketEvent(TicketRequestBody(type: 4,name: name,text: claim,falseLinks: clamisLinks,truthLinks:truthLinks,truth: truth )) )   ;
                    },
                      child: container(
                          borderRadius: 20,
                          hight: h(50),
                          width: w(200),
                          color: Colors.green[900],
                          child: Center(
                              child: text(
                                  text: "ارسال",
                                  color: Colors.white,
                                  fontfamily: 'marai',
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

Widget inputForm(
    double hight,
    double width,
    String title,
    TextEditingController controller,
    Function textInputed,
    double width2,
    int? maxlines,
    double? padding) {
  return Column(
    children: [
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          container(
              hight: hight,
              width: width2,
              borderRadius: 20,
              child: Center(
                child: textform(
                    maxlines: maxlines ?? 1,
                    padding:
                        EdgeInsets.only(bottom: padding ?? 0, right: w(10)),
                    controller: controller,
                    function: (val) {
                      textInputed(val);
                    },
                    keyboard: 'name',
                    validation: (val) {
                      return val!;
                    }),
              )),
          container(
              width: width,
              hight: hight,
              borderRadius: 20,
              child: text(
                  text: title,
                  fontfamily: 'marai',
                  fontWeight: FontWeight.bold)),
        ],
      )
    ],
  );
}
