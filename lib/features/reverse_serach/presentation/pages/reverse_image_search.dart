
import 'dart:io';



import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:image_cropper/image_cropper.dart';

import 'package:image_picker/image_picker.dart';




import 'package:sidq/App/app.dart';
import 'package:sidq/Widgets/container.dart';
import 'package:sidq/Widgets/nav.dart';
import 'package:sidq/Widgets/text.dart';

import 'package:sidq/core/consts.dart';
import 'package:sidq/features/reverse_serach/presentation/bloc/reverse_serach_bloc.dart';
import 'package:sidq/features/reverse_serach/presentation/widgets/reverse_search_result.dart';
import 'package:sidq/features/reverse_serach/presentation/widgets/video_reverse_search.dart';

import 'package:url_launcher/url_launcher.dart';


import '../../../../injection_container.dart';

class ReverseImageSearch extends StatefulWidget {
  const ReverseImageSearch({Key? key}) : super(key: key);

  @override
  _ReverseImageSearchState createState() => _ReverseImageSearchState();
}

class _ReverseImageSearchState extends State<ReverseImageSearch> {
  dynamic pickedVideo;
  final videoPicker = ImagePicker();
  String? file;

  ImageCropper imageCropper = ImageCropper();
  //   VideoPlayerController? _controller;
  // VideoPlayerController? _toBeDisposed;
  File? imageFile;
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => sl<ReverseSerachBloc>(),
      child: Scaffold(
        backgroundColor: AppColor.purple,
        body: ListView(
          children: [
            SizedBox(
              height: h(30),
            ),
            Image.asset(
              'assets/images/search.png',
              fit: BoxFit.cover,
              height: h(250),
              width: w(200),
            ),
            SizedBox(
              height: h(80),
            ),

            SizedBox(
              height: h(50),
            ),
          
            GestureDetector(
              onTap: () async {
                // ignore: unused_local_variable
                var pickedVideo = await ImagePicker()
                    .pickVideo(source: ImageSource.gallery)
                    .then((value) {

                      if (value !=null){
                  nav(
                      context,
                      PlayerVideoAndPopPage(
                        video: value,
                      ));
                      }  });
              },
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: w(30)),
                child: container(
                    borderRadius: 20,
                    // color: Colors.green[900],
                    hight: h(50),
                    width: w(100),
                    child: text(
                        text: "البحث العكسي عن فيديو",
                        fontsize: 18.sp,
                        fontfamily: 'marai',
                        color: AppColor.purple,
                        fontWeight: FontWeight.bold)),
              ),
            ),

              SizedBox(
              height: h(40),
            ),
            Builder(builder: (context) {
              return GestureDetector(
                onTap: () async {
                  // ignore: unused_local_variable
                  final pickedImage = await ImagePicker()
                      .pickImage(source: ImageSource.gallery)
                      .then((value) => imageCropper
                          .cropImage(
                              sourcePath: value!.path,
                              aspectRatioPresets: [
                                CropAspectRatioPreset.square,
                                CropAspectRatioPreset.ratio3x2,
                                CropAspectRatioPreset.original,
                                CropAspectRatioPreset.ratio4x3,
                                CropAspectRatioPreset.ratio16x9
                              ],
                              androidUiSettings: const AndroidUiSettings(
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
                              .read<ReverseSerachBloc>()
                              .add(UploadImageEvent(value!))));
                },
                child: BlocConsumer<ReverseSerachBloc, ReverseSerachState>(
                  listener: (context, state) {
                    if (state is UploadImageState) {
                      nav(
                          context,
                          ReverseSearchResult(
                            imageLink: state.result,
                            site:
                                'https://images.google.com/searchbyimage?image_url=',
                          ));
                    }
                  },
                  builder: (context, state) {
                    if (state is Loading) {
                      return Center(
                          child: CircularProgressIndicator(
                        backgroundColor: AppColor.yellow,
                        color: AppColor.purple,
                      ));
                    }
                    return Padding(
                      padding: EdgeInsets.symmetric(horizontal: w(30)),
                      child: container(
                          borderRadius: 20,
                          // color: Colors.green[900],
                          hight: h(50),
                          width: w(100),
                          child: text(
                              text: "البحث العكسي عن صورة",
                              fontsize: 18.sp,
                              fontfamily: 'marai',
                              color: AppColor.purple,
                              fontWeight: FontWeight.bold)),
                    );
                  },
                ),
              );
            }),

            SizedBox(
              height: h(50),
            ),
            // pickedVideo!=null?  _PlayerVideoAndPopPage(video: pickedVideo,):SizedBox()
          ],
        ),
      ),
    );
  }
}

Future<void> launchInWebViewOrVC(String url) async {
  if (!await launch(
    url,
    forceSafariVC: true,
    forceWebView: true,
    headers: <String, String>{'my_header_key': 'my_header_value'},
  )) {
    throw 'Could not launch $url';
  }
}

