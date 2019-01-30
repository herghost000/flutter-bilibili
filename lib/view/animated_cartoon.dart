import 'package:flutter/material.dart';
import '../component/swiper.dart';

class AnimatedCartoon extends StatefulWidget {
  AnimatedCartoon({Key key, ScrollController scrollViewController})
      : _scrollViewController = scrollViewController,
        super(key: key);
  final ScrollController _scrollViewController;

  @override
  _AnimatedCartoon createState() => _AnimatedCartoon();
}

class _AnimatedCartoon extends State<AnimatedCartoon> {
  ScrollController _scrollController;

  @override
  Future<void> initState() {
    super.initState();
    _scrollController = ScrollController();
    _scrollController.addListener(() {
      if (_scrollController.position.pixels <=
          widget._scrollViewController.position.maxScrollExtent) {
        widget._scrollViewController.position
            .jumpTo(_scrollController.position.pixels);
      }
      if (_scrollController.position.pixels ==
          _scrollController.position.maxScrollExtent) {
        print('滑动到了最底部');
        _getMore();
      }
    });
    return null;
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
    return RefreshIndicator(
      onRefresh: _onRefresh,
      child: CustomScrollView(
        controller: _scrollController,
        slivers: <Widget>[
          SliverList(
              delegate: SliverChildListDelegate([
            Container(
              child: Column(
                children: <Widget>[
                  Image.asset(
                    'assets/images/bangumi_home_login_guide.png',
                    fit: BoxFit.cover,
                    width: double.infinity,
                    height: 156.0,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: <Widget>[
                      Column(
                        children: <Widget>[
                          Image.asset('assets/images/ic_fab_play.png',color: Colors.pink[300],),
                          Text("番剧")
                        ],
                      ),
                      Column(
                        children: <Widget>[
                          Image.asset('assets/images/ic_tv_play.png',color: Colors.pink[300],),
                          Text("番剧")
                        ],
                      ),
                      Column(
                        children: <Widget>[
                          Image.asset('assets/images/ic_tv_play.png',color: Colors.pink[300],),
                          Text("番剧")
                        ],
                      ),
                      Column(
                        children: <Widget>[
                          Image.asset('assets/images/ic_tv_play.png',color: Colors.pink[300],),
                          Text("番剧")
                        ],
                      ),
                      Column(
                        children: <Widget>[
                          Image.asset('assets/images/ic_tv_play.png',color: Colors.pink[300],),
                          Text("番剧")
                        ],
                      )
                    ],
                  )
                ],
              ),
            )
          ])),
          SliverFixedExtentList(
            itemExtent: 140.0,
            delegate:
                SliverChildBuilderDelegate((BuildContext context, int index) {
              return Container(
                decoration: BoxDecoration(
                    border: Border(
                        bottom: BorderSide(
                            color: Colors.black12, style: BorderStyle.solid))),
                padding: EdgeInsets.only(
                    left: 20.0, right: 20.0, top: 10.0, bottom: 10.0),
                child: Row(
                  children: <Widget>[
                    Image.asset(
                      'assets/images/${index + 1}.webp',
                      fit: BoxFit.cover,
                      width: 170.0,
                      height: double.infinity,
                    ),
                    Expanded(
                      child: Container(
                        padding: EdgeInsets.only(left: 10.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisSize: MainAxisSize.max,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Container(
                              child: Text(
                                "【C菌】B站三怂再次被吓飞！【生化危机2：重制版】长篇惺惺惜惺惺",
                                maxLines: 2,
//                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(
                                    color: Colors.black87,
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Container(
                                  padding: EdgeInsets.symmetric(
                                      vertical: 1.0, horizontal: 4.0),
                                  child: Text(
                                    "大家都在搜",
                                    style: TextStyle(color: Colors.white),
                                  ),
                                  decoration: BoxDecoration(
                                      color: Colors.orange,
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(4.0))),
                                ),
                                Text(
                                  "渗透之C君",
                                  style: TextStyle(color: Colors.black45),
                                ),
                                Text(
                                  "131.4万观看·01-26",
                                  style: TextStyle(color: Colors.black45),
                                )
                              ],
                            )
                          ],
                        ),
                      ),
                    )
                  ],
                ),
              );
            }, childCount: 8 //50个列表项
                    ),
          ),
        ],
      ),
    );
  }
}
