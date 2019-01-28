import 'package:flutter/material.dart';

class RecommendPage extends StatefulWidget {
  @override
  _RecommendPageState createState() => _RecommendPageState();
}

class _RecommendPageState extends State<RecommendPage> {
  ScrollController _scrollController = ScrollController();

  @override
  Future<void> initState() {
    super.initState();
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
        child: new GridView.count(
          crossAxisCount: 2,
          mainAxisSpacing: 10.0,
          crossAxisSpacing: 12.0,
          padding: const EdgeInsets.all(14.0),
          childAspectRatio: 0.9,
          controller: _scrollController,
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
          ],
        ));
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
              height: 116.0,
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
