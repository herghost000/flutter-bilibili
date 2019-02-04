import 'package:flutter/material.dart';
import '../component/swiper.dart';

class LivePage extends StatefulWidget {
  LivePage({Key key, ScrollController scrollViewController})
      : _scrollViewController = scrollViewController,
        super(key: key);
  final ScrollController _scrollViewController;

  @override
  _LivePage createState() => _LivePage();
}

class _LivePage extends State<LivePage> {
  List tags = [];

  @override
  Future<void> initState() {
    super.initState();
    tags = [
      <String, dynamic>{
        'name': '英雄联盟',
        'img': 'assets/images/live_home_all_category.png'
      },
      <String, dynamic>{
        'name': '绝地求生',
        'img': 'assets/images/live_home_all_category.png'
      },
      <String, dynamic>{
        'name': '雀姬',
        'img': 'assets/images/live_home_all_category.png'
      },
      <String, dynamic>{
        'name': '视频聊天',
        'img': 'assets/images/music_ic__section_video.png'
      },
      <String, dynamic>{
        'name': '全部标签',
        'img': 'assets/images/live_home_all_category.png'
      },
      <String, dynamic>{
        'name': '游戏',
        'img': 'assets/images/2.0x/ic_live_home_game.png'
      },
      <String, dynamic>{
        'name': '手游',
        'img': 'assets/images/live_home_all_category.png'
      },
      <String, dynamic>{
        'name': '娱乐',
        'img': 'assets/images/live_home_all_category.png'
      },
      <String, dynamic>{
        'name': '电台',
        'img': 'assets/images/live_home_all_category.png'
      },
      <String, dynamic>{
        'name': '绘画',
        'img': 'assets/images/live_home_all_category.png'
      },
    ];
  }

  Future<void> _onRefresh() async {
    await Future.delayed(Duration(seconds: 3), () {
      print('refresh');
      setState(() {});
    });
    return null;
  }

  Future _getMore() async {}

  @override
  Widget build(BuildContext context) {
    return Builder(builder: (BuildContext context) {
      return RefreshIndicator(
        onRefresh: _onRefresh,
        child: NotificationListener(
          onNotification: (ScrollNotification note) {
            if (note.metrics.pixels == note.metrics.maxScrollExtent) {
              print('滑动到了最底部');
              _getMore();
            }
          },
          child: CustomScrollView(
            key: PageStorageKey<String>('live'),
            slivers: <Widget>[
              SliverToBoxAdapter(
                child: Container(
                  margin: EdgeInsets.only(left: 20.0, right: 20.0, top: 20.0),
                  child: Swiper(
                    radius: 8.0,
                  ),
                ),
              ),
              SliverGrid(
                  delegate: SliverChildBuilderDelegate(
                      (BuildContext context, int index) {
                    return Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      mainAxisSize: MainAxisSize.max,
                      children: <Widget>[
                        Image.asset(tags[index]['img']),
                        Padding(
                            padding: EdgeInsets.only(top: 4.0),
                            child: Text(tags[index]['name'])),
                      ],
                    );
                  }, childCount: tags.length),
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    childAspectRatio: 1.0,
                    crossAxisSpacing: 0.0,
                    mainAxisSpacing: 0.0,
                    crossAxisCount: 5,
                  ))
            ],
          ),
        ),
      );
    });
  }
}
