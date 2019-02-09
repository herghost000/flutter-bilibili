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
        'img': 'assets/images/2.0x/music_ic__section_video.png'
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
                  margin: EdgeInsets.only(left: 10.0, right: 10.0, top: 10.0),
                  child: Swiper(
                    radius: 6.0,
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
                        Image.asset(tags[index]['img'], fit: BoxFit.fill,width: 30.0, height: 30.0,),
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
                  )),
              SliverToBoxAdapter(
                child: Column(
                  children: <Widget>[
                    Divider(),
                    Padding(
                      padding: EdgeInsets.only(left: 10.0, right: 8.0, top: 8.0, bottom: 8.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Text.rich(TextSpan(
                              children: <TextSpan>[
                                TextSpan(text: '我的关注'),
                                TextSpan(text: '13小时前'),
                                TextSpan(text: 'YUKlri'),
                                TextSpan(text: '直播了唱见电台')
                              ]
                          )),
                          Icon(Icons.keyboard_arrow_right)
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              SliverToBoxAdapter(
                child: Column(
                  children: <Widget>[
                    Divider(),
                    Padding(
                      padding: EdgeInsets.only(left: 10.0, right: 8.0, top: 8.0, bottom: 8.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Text.rich(TextSpan(
                              children: <TextSpan>[
                                TextSpan(text: '推荐直播'),
                              ]
                          )),
                          Icon(Icons.keyboard_arrow_right)
                        ],
                      ),
                    ),
                    Divider(),
                  ],
                ),
              ),
              SliverPadding(
                padding: EdgeInsets.symmetric(horizontal: 10.0),
                sliver: SliverGrid.count(
                    crossAxisSpacing: 10.0,
                    mainAxisSpacing: 10.0,
                    crossAxisCount: 2,
                    childAspectRatio: 0.98,
                    children: <Widget>[
                      buildInkWell(1),
                      buildInkWell(2),
                      buildInkWell(3),
                      buildInkWell(4),
                      buildInkWell(5),
                      buildInkWell(6),
                      buildInkWell(7),
                      buildInkWell(8),
                    ]),
              ),
            ],
          ),
        ),
      );
    });
  }

  InkWell buildInkWell(int index) {
    return InkWell(
      child: Card(
        margin: EdgeInsets.all(0.0),
        elevation: 1.0,
        shape: RoundedRectangleBorder(
            borderRadius: new BorderRadius.circular(6.0)), // 圆角
        child: Column(
          children: <Widget>[
            Image.asset(
              'assets/images/${index}.webp',
              fit: BoxFit.cover,
              width: double.infinity,
              height: MediaQuery.of(context).size.width / 2 - 100.0,
            ),
            Expanded(
                child: Container(
                  padding: EdgeInsets.all(11.42),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      Text(
                        '哈哈哈哈！1月新番大吐槽第三弹！男主竟和多名女性轮流约会？！「泛式/新番妙妙屋14」',
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(color: Colors.black),
                      ),
                      Text(
                        "Population: avida",
                        style: TextStyle(color: Colors.black45),
                      ),
                    ],
                  ),
                ))
          ],
        ),
      ),
    );
  }
}
