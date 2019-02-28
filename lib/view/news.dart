import 'package:flutter/material.dart';
import 'package:sticky_headers/sticky_headers.dart';

class NewsPage extends StatefulWidget {
  const NewsPage({
    Key key,
    @required GlobalKey<ScaffoldState> homeKey,
  })  : _homeKey = homeKey,
        super(key: key);

  final GlobalKey<ScaffoldState> _homeKey;

  void _leadPress() {
    _homeKey.currentState.openDrawer();
  }

  @override
  _NewsPage createState() => _NewsPage();
}

class _NewsPage extends State<NewsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("动态"),
        leading: IconButton(icon: Icon(Icons.menu),onPressed: widget._leadPress,),
      ),
      body: Container(
        child: Example(),
      ),
    );
  }
}

class Example extends StatelessWidget {
  // 滑动速度(ms)为单位
  double scrollSpeed = 0.0;
  double lastPixels = 0.0;
  int lastTimeStamp = new DateTime.now().millisecondsSinceEpoch;

  // 计算滑动速度
  void computeScrollSpeed(double pixels) async {
    int nowTimeStamp = new DateTime.now().millisecondsSinceEpoch;
    int time = nowTimeStamp - lastTimeStamp;
    if (time != 0) {
      double nowScrollSpeed = (lastPixels - pixels) / time;
      if (nowScrollSpeed != 0) {
        scrollSpeed = nowScrollSpeed;
      }
    }
    lastPixels = pixels;
    lastTimeStamp = nowTimeStamp;
  }

  @override
  Widget build(BuildContext context) {
    return NotificationListener(
      onNotification: (ScrollNotification notification) {
        ScrollMetrics metrics = notification.metrics;
        computeScrollSpeed(metrics.pixels);
        if (notification is ScrollStartNotification) {
          print(notification.dragDetails);
          print('ScrollStartNotification');
        } else if (notification is ScrollUpdateNotification) {
          print('ScrollUpdateNotification');
        } else if (notification is ScrollEndNotification) {
          print('ScrollEndNotification');
        } else if (notification is UserScrollNotification) {
          print('UserScrollNotification');
        } else if (notification is OverscrollNotification) {
          print('OverscrollNotification');
        }
      },
      child: new ListView.builder(itemBuilder: (context, index) {
        return Text("xxx-${index}");
      }),
    );
  }
}