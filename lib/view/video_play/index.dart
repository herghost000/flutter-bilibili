import 'package:chewie/chewie.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';
import '../../config/application.dart';
import 'comment.dart';
import 'recommend.dart';

class VideoPlayPage extends StatefulWidget {
  VideoPlayPage({this.title = '视频播放'});

  final String title;

  @override
  State<StatefulWidget> createState() {
    return _VideoPlayPage();
  }
}

class _VideoPlayPage extends State<VideoPlayPage>
    with SingleTickerProviderStateMixin {
  TargetPlatform _platform;
  VideoPlayerController _videoPlayerController1;
  ChewieController _chewieController;
  bool isInitPlay = false;
  TabController _tabController;
  ScrollController _scrollViewController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(vsync: this, length: 2);
    _scrollViewController = ScrollController(initialScrollOffset: 0.0);
    _videoPlayerController1 = VideoPlayerController.network(
        'http://192.168.250.10/www.runoob.com/try/demo_source/movie.mp4');
    _videoPlayerController1.addListener(() {
      if (_videoPlayerController1.value.size != null &&
          _videoPlayerController1.value.isPlaying == false) {
        if (isInitPlay == false) {
          isInitPlay = true;
          setState(() {
            _chewieController = ChewieController(
              videoPlayerController: _videoPlayerController1,
              autoPlay: false,
              looping: false,
              aspectRatio: _videoPlayerController1.value.size.width /
                  _videoPlayerController1.value.size.height,
              materialProgressColors: ChewieProgressColors(
                playedColor: Colors.red,
                handleColor: Colors.blue,
//                backgroundColor: Colors.black,
                bufferedColor: Colors.lightGreen,
              ),
              placeholder: Container(
//                color: Colors.black,
              ),
              autoInitialize: false,
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
      theme: Application.theme,
      onGenerateRoute: Application.router.generator,
      home: Scaffold(
          body: Stack(
            children: <Widget>[
              Container(
                child: TabBarView(
                    children: <Widget>[Comment(), Recommend()],
                    controller: _tabController),
                height: MediaQuery.of(context).size.height,

              ),
              Container(
//            height: MediaQuery.of(context).padding.top + kToolbarHeight + 40.0,
                child: Container(
                  transform:
                  Transform.translate(offset: Offset(0.0, 0.0)).transform,
//              height: kToolbarHeight,
                  child: Column(
                    children: <Widget>[
                      Container(
//                    height: MediaQuery.of(context).padding.top + kToolbarHeight,
                        child: _chewieController == null
                            ? null
                            : Chewie(
                          controller: _chewieController,
                        ),
                      ),
                      Container(
                        width: double.infinity,
                        color: Colors.white,
                        child: UnconstrainedBox(
                          child: Container(
                            height: 40.0,
                            color: Colors.white,
                            alignment: Alignment(0, 0),
                            width: MediaQuery.of(context).size.width - 4.0 * 32.0,
                            child: TabBar(
                              isScrollable: true,
                              indicatorSize: TabBarIndicatorSize.label,
                              indicatorColor: Colors.pink[200],
                              labelColor: Colors.pink[300],
                              unselectedLabelColor: Colors.black38,
                              controller: _tabController,
                              tabs: <Widget>[
                                Tab(
                                  text: "评论",
                                ),
                                Tab(
                                  text: "推荐",
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Container(
                height: MediaQuery.of(context).padding.top + kToolbarHeight,
                child: AppBar(
                  elevation: 0.0,
                  backgroundColor: Colors.transparent,
                  leading: GestureDetector(
                    child: Icon(Icons.arrow_back),
                    onTap: () {
                      Application.router.pop(context);
                    },
                  ),
                ),
              )
            ],
          )),
//      Scaffold(
//        appBar: AppBar(
//          leading: GestureDetector(onTap: (){
//            Application.router.pop(context);
//          }, child: Icon(Icons.arrow_back),),
//          title: Text(widget.title),
//        ),
//        body: Column(
//          children: <Widget>[
//            _chewieController == null ? null : Chewie(
//              controller: _chewieController,
//            ),
//          ],
//        ),
//      ),
    );
  }
}