import 'package:chewie/chewie.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';
import '../config/application.dart';

class VideoPlayPage extends StatefulWidget {
  VideoPlayPage({this.title = '视频播放'});

  final String title;

  @override
  State<StatefulWidget> createState() {
    return _VideoPlayPage();
  }
}

class _VideoPlayPage extends State<VideoPlayPage> {
  TargetPlatform _platform;
  VideoPlayerController _videoPlayerController1;
  ChewieController _chewieController;
  bool isInitPlay = false;

  @override
  void initState() {
    super.initState();
    _videoPlayerController1 = VideoPlayerController.network(
        '');
    _videoPlayerController1.addListener((){
      if (_videoPlayerController1.value.size != null && _videoPlayerController1.value.isPlaying == false) {
        if (isInitPlay == false) {
          isInitPlay = true;
          setState(() {
            _chewieController = ChewieController(
              videoPlayerController: _videoPlayerController1,
              autoPlay: true,
              looping: true,
              aspectRatio: _videoPlayerController1.value.size.width / _videoPlayerController1.value.size.height,
              materialProgressColors: ChewieProgressColors(
                playedColor: Colors.red,
                handleColor: Colors.blue,
                backgroundColor: Colors.black,
                bufferedColor: Colors.lightGreen,
              ),
              placeholder: Container(
                color: Colors.black,
              ),
              autoInitialize: true,
            );
          });
        }
      }

    });
    _videoPlayerController1.initialize();
  }

  @override
  void dispose() {
    _videoPlayerController1.dispose();
    _chewieController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: Application.theme.copyWith(
        platform: TargetPlatform.iOS,
      ),
      onGenerateRoute: Application.router.generator,
      home: Scaffold(
        appBar: AppBar(
          leading: GestureDetector(onTap: (){
            Application.router.pop(context);
          }, child: Icon(Icons.arrow_back),),
          title: Text(widget.title),
        ),
        body: Column(
          children: <Widget>[
            Expanded(
              child: Center(
                child: _chewieController == null ? null : Chewie(
                  controller: _chewieController,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}