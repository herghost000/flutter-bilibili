import 'package:chewie/chewie.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';
import '../../config/application.dart';
import 'brief_introduction.dart';
import 'comment.dart';

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
        'https://ts.caololita.com/video/play/1a2842400b8611e991fbf9d1c7c5a933/6e5fe7e0b77afb7a82e61eb4b648fe6a.m3u8');
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
                backgroundColor: Colors.black,
                bufferedColor: Colors.lightGreen,
              ),
              placeholder: Container(
                color: Colors.black,
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
                children: <Widget>[BriefIntroduction(), Comment()],
                controller: _tabController),
            height: MediaQuery.of(context).size.height,
            padding: EdgeInsets.only(
                top: MediaQuery.of(context).size.width / 1.5 + 40.0),
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
                    color: Colors.black,
                    height: MediaQuery.of(context).size.width / 1.5,
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
                              text: "简介",
                            ),
                            Tab(
                              text: "评论 1642",
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
              actions: <Widget>[
                IconButton(
                    icon: Icon(Icons.file_download),
                    onPressed: () {
                      showDialog(
                          context: context,
                          builder: (_) => new AlertDialog(
                                  title: new Text('提示'),
                                  content: new Text("是否下载此视频"),
                                  actions: <Widget>[
                                    new FlatButton(
                                      child: new Text("取消"),
                                      onPressed: () {
                                        Navigator.of(context).pop();
                                      },
                                    ),
                                    new FlatButton(
                                      child: new Text("下载"),
                                      onPressed: () {
                                        Navigator.of(context).pop();
                                      },
                                    )
                                  ]));
                    })
              ],
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
