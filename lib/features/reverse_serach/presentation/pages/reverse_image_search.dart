import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';

import 'package:sidq/App/app.dart';
import 'package:sidq/Widgets/container.dart';
import 'package:sidq/Widgets/nav.dart';
import 'package:sidq/Widgets/text.dart';

import 'package:sidq/core/consts.dart';
import 'package:sidq/features/reverse_serach/presentation/bloc/reverse_serach_bloc.dart';
import 'package:sidq/features/reverse_serach/presentation/widgets/reverse_search_result.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../../injection_container.dart';

class ReverseImageSearch extends StatefulWidget {
  const ReverseImageSearch({Key? key}) : super(key: key);

  @override
  _ReverseImageSearchState createState() => _ReverseImageSearchState();
}

class _ReverseImageSearchState extends State<ReverseImageSearch> {
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
            GestureDetector(onTap: (){
              
launchInWebViewOrVC('https://www.google.com');

            },
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: w(30)),
                child: container(
                    borderRadius: 20,
                    color: Colors.green[900],
                    hight: h(50),
                    width: w(100),
                    child: text(
                        text: "بحث نصي",
                        color: Colors.white,
                        fontWeight: FontWeight.bold)),
              ),
            ),
            SizedBox(
              height: h(50),
            ),
            Builder(builder: (context) {
              return GestureDetector(
                onTap: () async {
                  // ignore: unused_local_variable
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
                              .read<ReverseSerachBloc>()
                              .add(UploadImageEvent(value!))));
                },
                child: BlocConsumer<ReverseSerachBloc, ReverseSerachState>(
                  listener: (context, state) {
                    if (state is UploadImageState) {
                      nav(
                          context,
                          ReverseSearchResult(
                            imageLink: state.result,site: 'https://images.google.com/searchbyimage?image_url=',
                          ));
                    }
                  },
                  builder: (context, state) {
                    if (state is Loading) {
                      return Center(child: CircularProgressIndicator(backgroundColor: Colors.grey,color: Colors.grey[50],));
                    }
                    return Padding(
                      padding: EdgeInsets.symmetric(horizontal: w(30)),
                      child: container(
                          borderRadius: 20,
                          color: Colors.green[900],
                          hight: h(50),
                          width: w(100),
                          child: text(
                              text: "بحث صورة",
                              color: Colors.white,
                              fontWeight: FontWeight.bold)),
                    );
                  },
                ),
              );
            })
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
