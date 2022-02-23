import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';
import 'package:screenshot/screenshot.dart';
import 'package:sidq/App/app.dart';
import 'package:sidq/Widgets/container.dart';
import 'package:sidq/Widgets/nav.dart';
import 'package:sidq/Widgets/text.dart';
import 'package:sidq/core/consts.dart';
import 'package:sidq/features/reverse_serach/presentation/bloc/reverse_serach_bloc.dart';
import 'package:sidq/features/reverse_serach/presentation/widgets/reverse_search_result.dart';
import 'package:video_player/video_player.dart';
import 'package:video_thumbnail/video_thumbnail.dart';

import '../../../../injection_container.dart';

class PlayerVideoAndPopPage extends StatefulWidget {
  final XFile video;

  const PlayerVideoAndPopPage({
    Key? key,
    required this.video,
  }) : super(key: key);
  @override
  PlayerVideoAndPopPageState createState() => PlayerVideoAndPopPageState();
}

class PlayerVideoAndPopPageState extends State<PlayerVideoAndPopPage> {
  int ?timMs;
  Image? image;

  ReverseSerachBloc reverseSerachBloc = sl<ReverseSerachBloc>();

  String? file;

  //Create an instance of ScreenshotController
  ScreenshotController screenshotController = ScreenshotController();

  static const allSpeeds = <double>[0.25, 0.5, 1, 1.5, 2, 3, 5, 10];

  VideoPlayerController? _videoPlayerController;
  bool startedPlaying = false;

  @override
  void initState() {
    _videoPlayerController =
        VideoPlayerController.file(File(widget.video.path));
    started();
    startedPlaying = true;

    super.initState();
  }

  @override
  void dispose() {
    _videoPlayerController!.dispose();
    super.dispose();
  }

  Future<bool> started() async {
    await _videoPlayerController!.initialize();
    await _videoPlayerController!.play();
    startedPlaying = true;
    return true;
  }

  @override
  Widget build(BuildContext context) {
    return Screenshot(
      controller: screenshotController,
      child: Scaffold(
        backgroundColor: AppColor.purple,
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(h(60)),
          child: AppBar(
              backgroundColor: AppColor.purple,
              centerTitle: true,
              title: text(text: 'البحث العكسي للفيديو', fontsize: 18.sp)),
        ),
        body: Column(
          children: [
            startedPlaying
                ? container(
                    hight: h(300),
                    child: videoPlayer(),
                  )
                : const SizedBox(),
            SizedBox(
              height: h(20),
            ),
            buildIndicator(),
            SizedBox(
              height: h(10),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                //  buildSpeed(),
                GestureDetector(
                  onTap: () {
                    _videoPlayerController!.play();
                  },
                  child: container(
                      color: AppColor.purple,
                      hight: h(40),
                      width: w(50),
                      borderRadius: 20,
                      child: const Icon(
                        Icons.play_arrow,
                        color: Colors.white,
                        size: 30,
                      )),
                ),

                GestureDetector(
                  onTap: () async {

                   
                         _videoPlayerController!.pause();
                            final Duration duration = _videoPlayerController!.value.duration;
      Duration position = _videoPlayerController!.value.position;
      position = (position > duration) ? duration : position;
                                    
                        timMs  = position.inMilliseconds;
                        
                      
          

             
   
               

                    Uint8List? bytes = await VideoThumbnail.thumbnailData(
                        video: widget.video.path, // Path of that video
                        imageFormat: ImageFormat.PNG,
                        quality: 0,
                        timeMs: timMs!  );
                    final tempDir = await getTemporaryDirectory();
                    File file =
                        await File('${tempDir.path}/image.png').create();
                    file.writeAsBytesSync(bytes!);

// image = Image.memory(bytes); // He
// setState(() {
  
// });

                   
                    reverseSerachBloc.add(UploadImageEvent(file));
                  },
                  child: BlocConsumer(
                    bloc: reverseSerachBloc,
                    listener: (context, state) {

                                            if (state is Error){
        
                        Fluttertoast.showToast(
          msg: state.result,
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.red,
          textColor: Colors.white,
          fontSize: 16.0
      );
                    
                      }
        
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
                      if (state is Loading){
                        return  Center(child: CircularProgressIndicator(backgroundColor: AppColor.yellow,color: AppColor.purple,));
                      }
                      return container(
                          color: AppColor.purple,
                          hight: h(40),
                          width: w(50),
                          borderRadius: 20,
                          child: const Icon(
                            Icons.camera,
                            color: Colors.white,
                            size: 30,
                          ));
                    },
                  ),
                ),


                GestureDetector(
                  onTap: () {
                    _videoPlayerController!.pause();
                  },
                  child: container(
                      color: AppColor.purple,
                      hight: h(40),
                      width: w(50),
                      borderRadius: 20,
                      child: const Icon(
                        Icons.pause,
                        color: Colors.white,
                        size: 30,
                      )),
                ),
              ],
            ),
          // image !=null?  Image(image: image!.image) :SizedBox()
          ],
        ),
      ),
    );
  }

  capturePhoto() async {}
  Widget buildIndicator() => Padding(
        padding: const EdgeInsets.all(8.0),
        child: Container(
          margin: const EdgeInsets.all(8).copyWith(right: 0),
          height: 16,
          child: VideoProgressIndicator(
            _videoPlayerController!,
            colors: VideoProgressColors(backgroundColor: AppColor.yellow),
            allowScrubbing: true,
          ),
        ),
      );



  Widget buildPlay() => AnimatedSwitcher(
        duration: const Duration(milliseconds: 50),
        reverseDuration: const Duration(milliseconds: 200),
        child: _videoPlayerController!.value.isPlaying
            ? Container()
            : Container(
                color: Colors.black26,
                child: const Center(
                  child: Icon(
                    Icons.play_arrow,
                    color: Colors.white,
                    size: 70,
                  ),
                ),
              ),
      );
  Widget videoPlayer() {
    return SizedBox(
    
      child: VideoPlayer(_videoPlayerController!),
    );
  }
}
