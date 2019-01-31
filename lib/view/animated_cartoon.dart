import 'package:flutter/material.dart';
import '../component/swiper.dart';
import '../component/tap_loading.dart';

class AnimatedCartoon extends StatefulWidget {
  AnimatedCartoon({Key key, ScrollController scrollViewController})
      : _scrollViewController = scrollViewController,
        super(key: key);
  final ScrollController _scrollViewController;

  @override
  _AnimatedCartoon createState() => _AnimatedCartoon();
}

class _AnimatedCartoon extends State<AnimatedCartoon> with SingleTickerProviderStateMixin{
  ScrollController _scrollController;

  @override
  Future<void> initState() {
    super.initState();
    _scrollController = ScrollController();
    _scrollController.addListener(() {
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
              color: Colors.white,
              child: Column(
                children: <Widget>[
                  Image.asset(
                    'assets/images/bangumi_home_login_guide.png',
                    fit: BoxFit.cover,
                    width: double.infinity,
                    height: 156.0,
                  ),
                  Container(
                    margin: EdgeInsets.only(
                        top: 20.0, bottom: 20.0, left: 40.0, right: 40.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Column(
                          children: <Widget>[
                            Image.asset(
                              'assets/images/ic_fab_play.png',
                              color: Colors.pink[300],
                            ),
                            Text("番剧")
                          ],
                        ),
                        Column(
                          children: <Widget>[
                            Image.asset(
                              'assets/images/bangumi_follow_home_ic_domestic.png',
                              color: Colors.pink[300],
                            ),
                            Text("国创")
                          ],
                        ),
                        Column(
                          children: <Widget>[
                            Image.asset(
                                'assets/images/bangumi_follow_home_ic_timeline.png'),
                            Text("时间表")
                          ],
                        ),
                        Column(
                          children: <Widget>[
                            Image.asset(
                              'assets/images/bangumi_follow_home_ic_index.png',
                            ),
                            Text("索引")
                          ],
                        ),
                        Column(
                          children: <Widget>[
                            Image.asset(
                              'assets/images/bangumi_follow_home_ic_review.png',
                            ),
                            Text("点评")
                          ],
                        )
                      ],
                    ),
                  ),
                  Container(
                      margin: EdgeInsets.only(left: 20.0, right: 20.0),
                      child: Swiper(
                        radius: 8.0,
                      ))
                ],
              ),
            )
          ])),
          SliverList(
              delegate: SliverChildListDelegate([
            Divider(
              height: 40.0,
            ),
            Container(
              padding: EdgeInsets.only(left: 20.0, right: 10.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Baseline(
                    child: Text(
                      "番剧推荐",
                      style: TextStyle(
                          fontWeight: FontWeight.bold, fontSize: 16.0),
                    ),
                    baseline: 16.0,
                    baselineType: TextBaseline.alphabetic,
                  ),
                  Row(
                    children: <Widget>[
                      Text(
                        "查看更多",
                        style: TextStyle(color: Colors.black38),
                      ),
                      Icon(
                        Icons.keyboard_arrow_right,
                        color: Colors.black38,
                      )
                    ],
                  )
                ],
              ),
            )
          ])),
          SliverPadding(
              padding: const EdgeInsets.only(
                  left: 20.0, right: 20.0, bottom: 10.0, top: 10.0),
              sliver: SliverToBoxAdapter(
                child: Column(
                  children: <Widget>[
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Container(
                          width: MediaQuery.of(context).size.width / 3 - 20.0,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              ClipRRect(
                                  borderRadius: BorderRadius.circular(8.0),
                                  child: Image.asset(
                                    'assets/images/13.webp',
                                    fit: BoxFit.cover,
                                    width: double.infinity,
                                    height:
                                        (MediaQuery.of(context).size.width / 3 -
                                                20.0) /
                                            0.75,
                                  )),
                              Text(
                                "傻吊教师",
                                maxLines: 2,
                                style: TextStyle(
                                    fontSize: 16.0,
                                    fontWeight: FontWeight.bold),
                              ),
                              Text("更新至第4话")
                            ],
                          ),
                        ),
                        Container(
                          width: MediaQuery.of(context).size.width / 3 - 20.0,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              ClipRRect(
                                  borderRadius: BorderRadius.circular(8.0),
                                  child: Image.asset(
                                    'assets/images/14.webp',
                                    fit: BoxFit.cover,
                                    width: double.infinity,
                                    height:
                                        (MediaQuery.of(context).size.width / 3 -
                                                20.0) /
                                            0.75,
                                  )),
                              Text(
                                "齐木兄的灾难得瑟得瑟得瑟",
                                maxLines: 2,
                                style: TextStyle(
                                    fontSize: 16.0,
                                    fontWeight: FontWeight.bold),
                              ),
                              Text("更新至第17话")
                            ],
                          ),
                        ),
                        Container(
                          width: MediaQuery.of(context).size.width / 3 - 20.0,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              ClipRRect(
                                  borderRadius: BorderRadius.circular(8.0),
                                  child: Image.asset(
                                    'assets/images/15.webp',
                                    fit: BoxFit.cover,
                                    width: double.infinity,
                                    height:
                                        (MediaQuery.of(context).size.width / 3 -
                                                20.0) /
                                            0.75,
                                  )),
                              Text(
                                "忘了",
                                maxLines: 2,
                                style: TextStyle(
                                    fontSize: 16.0,
                                    fontWeight: FontWeight.bold),
                              ),
                              Text("更新完毕")
                            ],
                          ),
                        )
                      ],
                    ),
                    TapLoading(),
                  ],
                ),
              )),
          SliverList(
              delegate: SliverChildListDelegate([
            Divider(
              height: 40.0,
            ),
            Container(
              padding: EdgeInsets.only(left: 20.0, right: 10.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Baseline(
                    child: Text(
                      "编辑推荐",
                      style: TextStyle(
                          fontWeight: FontWeight.bold, fontSize: 16.0),
                    ),
                    baseline: 16.0,
                    baselineType: TextBaseline.alphabetic,
                  ),
                  Row(
                    children: <Widget>[
                      Text(
                        "查看更多",
                        style: TextStyle(color: Colors.black38),
                      ),
                      Icon(
                        Icons.keyboard_arrow_right,
                        color: Colors.black38,
                      )
                    ],
                  )
                ],
              ),
            )
          ])),
          SliverFixedExtentList(
            itemExtent: 200.0,
            delegate:
                SliverChildBuilderDelegate((BuildContext context, int index) {
              return Container(
                color: Colors.white,
                padding: EdgeInsets.only(
                    left: 20.0, right: 20.0, top: 10.0, bottom: 10.0),
                child: Column(
                  children: <Widget>[
                    Image.asset(
                      'assets/images/${index + 9}.webp',
                      fit: BoxFit.cover,
                      width: double.infinity,
                      height: 110.0,
                    ),
                    Expanded(
                        child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Padding(
                          child: Text(
                            "AIR",
                            style: TextStyle(
                                fontSize: 14.0, fontWeight: FontWeight.bold),
                          ),
                          padding: EdgeInsets.only(top: 10.0),
                        ),
                        Text(
                          "夏天，在靠近海边小小的街道上\n一位青年从公共汽车站下车了...",
                          style:
                              TextStyle(fontSize: 12.0, color: Colors.black54),
                        )
                      ],
                    ))
                  ],
                ),
              );
            }, childCount: 4 //50个列表项
                    ),
          )
        ],
      ),
    );
  }
}
