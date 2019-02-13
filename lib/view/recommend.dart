import 'package:flutter/material.dart';
import '../component/swiper.dart';
import '../config/application.dart';
import '../component/infinity_slider.dart';

class RecommendPage extends StatefulWidget {
  RecommendPage({Key key, ScrollController scrollViewController})
      : _scrollViewController = scrollViewController,
        super(key: key);
  final ScrollController _scrollViewController;

  @override
  _RecommendPageState createState() => _RecommendPageState();
}

class _RecommendPageState extends State<RecommendPage> {
  ScrollController _scrollController;

  @override
  Future<void> initState() {
    super.initState();
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
    return Builder(builder: (BuildContext context){
      return RefreshIndicator(
        key: PageStorageKey<String>('recommend'),
        onRefresh: _onRefresh,
        child: NotificationListener(
          onNotification: (ScrollNotification note){
            if (note.metrics.pixels == note.metrics.maxScrollExtent) {
              print('滑动到了最底部');
              _getMore();
            }
          },
          child: CustomScrollView(
            controller: widget._scrollViewController,
            slivers: <Widget>[
              SliverToBoxAdapter(
                child: new InfinitySlider(
                    items: [1,2,3,4,5].map((i) {
                      return new Builder(
                        builder: (BuildContext context) {
                          return new Container(
                              width: MediaQuery.of(context).size.width,
                              decoration: new BoxDecoration(
                                  color: Colors.amber
                              ),
                              child: new Text('text $i', style: new TextStyle(fontSize: 16.0),)
                          );
                        },
                      );
                    }).toList(),
                ),
              ),
              SliverList(
                  delegate: SliverChildListDelegate([
                    Container(margin: EdgeInsets.only(top: 8.0), child: Swiper())
                  ])),
              SliverPadding(
                padding: EdgeInsets.all(10.0),
                sliver: SliverGrid.count(
                    crossAxisSpacing: 10.0,
                    mainAxisSpacing: 10.0,
                    crossAxisCount: 2,
                    childAspectRatio: 0.98,
                    children: <Widget>[
                      GridTile(
                        child: Container(
                          padding: EdgeInsets.only(top: 10.0, bottom: 10.0),
                          color: Colors.white,
                          child: Image.asset(
                            'assets/images/ic_promo_index_sign3_v2.png',
                            fit: BoxFit.cover,
                            width: double.infinity,
                          ),
                        ),
                      ),
                      buildInkWell(1),
                      buildInkWell(2),
                      buildInkWell(3),
                      buildInkWell(4),
                      buildInkWell(5),
                      buildInkWell(6),
                      buildInkWell(7),
                      buildInkWell(8),
                    ]),
              )
            ],
          ),
        ),
      );
    });
  }

  InkWell buildInkWell(int index) {
    return InkWell(
      onTap: (){
        Application.router.navigateTo(context, "/video_play");
      },
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
