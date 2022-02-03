import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:sidq/App/app.dart';
import 'package:sidq/Widgets/container.dart';
import 'package:sidq/Widgets/nav.dart';
import 'package:sidq/Widgets/text.dart';
import 'package:sidq/core/consts.dart';
import 'package:sidq/features/home/presentation/pages/home.dart';
import 'package:sidq/features/home/presentation/widgets/bottom_bar.dart';
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
  String ? imafeId;
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
        bottomNavigationBar: bottomBar(context, MediaQuery.of(context).size),
        backgroundColor: AppColor.purple,
        body: Center(
          child: Column(
            children: [
              SizedBox(
                height: h(40),
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
                        color: AppColor.purple,
                        
                        fontWeight: FontWeight.bold)),
              ),
              SizedBox(
                height: h(30),
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
                    if (state is UploadPicState){
                      imafeId= state.id;

                               Fluttertoast.showToast(
        msg: 'تم اضافة الصورة بنجاح',
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
    navWithReplacement(context,const HomeBar());
               
                    }
                  },
                  builder: (context, state) {
                    if (state is Loading){
                      return   Center(child: CircularProgressIndicator(backgroundColor: AppColor.yellow,color: AppColor.purple,));
                    }
                    return 
                       Row(
                        children: [

                          GestureDetector(onTap: (){
                      log(name!);
                      log(claim!);
                if (widget.isReport==true && name!="" && claim!="" && clamisLinks !=null)  {
                   context.read<ReportFakeNewsBloc>().add(AddTicketEvent(TicketRequestBody(name: name,text: claim,falseLinks: clamisLinks,type: 5)));
                   } 
 

               else if (!widget.isReport  && name!="" && claim!="" && clamisLinks !=null && truthLinks!=null && truth!=null){
                 context.read<ReportFakeNewsBloc>().add(AddTicketEvent(TicketRequestBody(type: 4,name: name,text: claim,falseLinks: clamisLinks,truthLinks:truthLinks,truth: truth ,fileId: imafeId)) )   ;
                       } 
                                    else {                               Fluttertoast.showToast(
        msg: 'يرجى استكمال جميع المعلومات',
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.CENTER,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.grey[600],
        textColor: Colors.white,
        fontSize: 16.sp
    );}  },child:
                          container(
                              borderRadius: 20,
                              hight: h(50),
                              width: w(250),
                              // color: Colors.green[900],
                              child: text(
                                  text: "ارسال",
                                  color: AppColor.purple,
                                  fontfamily: 'marai',
                                  fontsize: 18.sp,
                                  fontWeight: FontWeight.bold,
                                  textAlign: TextAlign.center)),),
                                  SizedBox(width: w(30),),

                                        GestureDetector(onTap: () async {
                                           final pickedImage = await ImagePicker()
                      .pickImage(source: ImageSource.gallery)
                      .then((value) => ImageCropper.cropImage(
                              sourcePath: value!.path,
                              aspectRatioPresets: [
                                CropAspectRatioPreset.square,
                                CropAspectRatioPreset.ratio3x2,
                                CropAspectRatioPreset.original,
                                CropAspectRatioPreset.ratio4x3,
                                CropAspectRatioPreset.ratio16x9
                              ],
                              androidUiSettings:
                                  const AndroidUiSettings(
                                      toolbarTitle: 'Cropper',
                                      toolbarColor: Colors.deepOrange,
                                      toolbarWidgetColor: Colors.white,
                                      initAspectRatio:
                                          CropAspectRatioPreset.original,
                                      lockAspectRatio: false),
                              iosUiSettings: const IOSUiSettings(
                                minimumAspectRatio: 1.0,
                              ))
                          .then((value) => context
                              .read<ReportFakeNewsBloc>()
                              .add(UploadPicEvent(value!))));
                                        },
                                          child: GestureDetector(child: Icon(Icons.camera_alt,color: AppColor.yellow,size: 50,)))
                        ],
                      
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

