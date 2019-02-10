import 'package:flutter/material.dart';
import 'recommend.dart';
import 'hot.dart';
import 'animated_cartoon.dart';
import 'live.dart';
import '../component/search_input.dart';
import '../model/widget.dart';

class IndexPage extends StatefulWidget {
  const IndexPage({
    Key key,
    @required GlobalKey<ScaffoldState> homeKey,
    @required ScrollController scrollViewController,
    @required TabController tabController,
  })  : _homeKey = homeKey,
        _tabController = tabController,
        super(key: key);

  final TabController _tabController;
  final GlobalKey<ScaffoldState> _homeKey;

  void _leadPress() {
    _homeKey.currentState.openDrawer();
  }

  @override
  _IndexPageState createState() => _IndexPageState();
}

class _IndexPageState extends State<IndexPage> {
  ScrollController _scrollViewController;
  double _top = 0.0;
  WidgetControlModel widgetControl = new WidgetControlModel();

  @override
  void initState() {
    super.initState();
    _scrollViewController = ScrollController(initialScrollOffset: 0.0);
    _scrollViewController.addListener(() {
      double _pixels = _scrollViewController.position.pixels;
      double _height = kToolbarHeight;
      if (_pixels <= _height && _pixels >= 0) {
        setState(() {
          _top = -_scrollViewController.position.pixels;
        });
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


  Widget buildSearchInput(BuildContext context) {
    return new SearchInput((value) async {
      if (value != '') {
        List<WidgetPoint> list = await widgetControl.search(value);

        return list
            .map((item) => new MaterialSearchResult<String>(
          value: item.name,
          text: item.name,
          onTap: () {
            print("SearchInput");
          },
        ))
            .toList();
      } else {
        return null;
      }
    }, (value) {}, () {});
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
              LivePage()
            ],
            controller: widget._tabController,
          ),
          width: double.infinity,
          height: MediaQuery.of(context).size.height,
          padding: EdgeInsets.only(
              top: MediaQuery.of(context).padding.top +
                  kToolbarHeight +
                  40.0 +
                  _top),
        ),
        Container(
          height: MediaQuery.of(context).padding.top + kToolbarHeight + 40.0,
          width: double.infinity,
          child: Container(
            transform: Transform.translate(offset: Offset(0.0, _top)).transform,
            height: kToolbarHeight,
            child: Column(
              children: <Widget>[
                Container(
                  height: MediaQuery.of(context).padding.top + kToolbarHeight,
                  padding:
                      EdgeInsets.only(top: MediaQuery.of(context).padding.top),
                  child: Container(
                    color: Colors.pink[300],
                    height: kToolbarHeight,
                    child: Row(
                      children: <Widget>[
                        Container(
                          child: GestureDetector(
                            child: Icon(
                              Icons.menu,
                              color: Colors.white,
                            ),
                            onTap: widget._leadPress,
                          ),
                          transform: Transform.translate(offset: Offset(-12.0, 0.0)).transform,
                        ),
                        Container(
                          height: 34.0,
                          width: 34.0,
                          margin: EdgeInsets.only(right: 20.0),
                          child: CircleAvatar(
                            backgroundImage: AssetImage(
                                'assets/images/bili_default_avatar.png'),
                          ),
                        ),
                        Expanded(child: buildSearchInput(context)),
                        Container(
                          margin: EdgeInsets.symmetric(horizontal: 12.0),
                          child: Icon(Icons.videogame_asset, color: Colors.white,),
                        ),
                        Container(
                          margin: EdgeInsets.symmetric(horizontal: 12.0),
                          child: Icon(Icons.file_download, color: Colors.white,),
                        ),
                        Container(
                          margin: EdgeInsets.symmetric(horizontal: 12.0),
                          child: Icon(Icons.message, color: Colors.white,),
                        ),
                      ],
                    ),
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
}
