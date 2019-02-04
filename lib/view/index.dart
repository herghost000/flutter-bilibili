import 'package:flutter/material.dart';
import '../component/testWidget.dart';
import '../main.dart';
import 'recommend.dart';
import 'hot.dart';
import 'animated_cartoon.dart';

class IndexPage extends StatefulWidget {
  const IndexPage({
    Key key,
    @required GlobalKey<ScaffoldState> homeKey,
    @required ScrollController scrollViewController,
    @required this.widget,
    @required TabController tabController,
  })  : _homeKey = homeKey,
        _tabController = tabController,
        super(key: key);

  final MyHomePage widget;
  final TabController _tabController;
  final GlobalKey<ScaffoldState> _homeKey;

  @override
  _IndexPageState createState() => _IndexPageState();
}

class _IndexPageState extends State<IndexPage> {

  ScrollController _scrollViewController;
  double _top = 0.0;

  @override
  void initState() {
    super.initState();
    _scrollViewController = ScrollController(initialScrollOffset: 0.0);
    _scrollViewController.addListener((){
      double _pixels = _scrollViewController.position.pixels;
      double _height = kToolbarHeight;
      if (_pixels <= _height && _pixels >= 0) {
        setState(() {
          _top = -_scrollViewController.position.pixels;
        });

        print(widget._tabController.index);
        print(_scrollViewController.position.pixels);
      }
      if (_pixels > _height && -_top < _height) {
        setState(() {
          _top = -_height;
        });
      }
    });
  }

  @override
  void dispose() {
    _scrollViewController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        Container(
          child: TabBarView(
            children: <Widget>[
              RecommendPage(scrollViewController: _scrollViewController),
              HotPage(scrollViewController: _scrollViewController),
              AnimatedCartoon(scrollViewController: _scrollViewController),
              PageFour()
            ],
            controller: widget._tabController,
          ),
          width: double.infinity,
          height: MediaQuery.of(context).size.height,
          padding: EdgeInsets.only(top: MediaQuery.of(context).padding.top + kToolbarHeight + 40.0 + _top),
        ),
        Container(
          height: MediaQuery.of(context).padding.top + kToolbarHeight + 40.0,
          width: double.infinity,
          child: Container(
            transform: Transform.translate(offset: Offset(0.0, _top)).transform,
            height: kToolbarHeight,
            child: Column(
              children: <Widget>[
                AppBar(
                  title: Text(
                    "bilibili",
//                style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  centerTitle: false,
                  elevation: 0.0,
                  backgroundColor: Colors.pink[300],
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
                        controller: widget._tabController,
                        tabs: <Widget>[
                          Tab(
                            text: "推荐",
                          ),
                          Tab(
                            text: "热门",
                          ),
                          Tab(
                            text: '动漫',
                          ),
                          Tab(
                            text: '直播',
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
        Positioned(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).padding.top,
          child: Container(
            color: Colors.pink[300],
            child: null,
          ),
        ),
      ],
    );
  }

  void _leadPress() {
    widget._homeKey.currentState.openDrawer();
  }
}
