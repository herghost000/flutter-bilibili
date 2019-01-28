import 'package:flutter/material.dart';
import '../component/testWidget.dart';
import '../main.dart';
import 'recommend.dart';

class IndexPage extends StatelessWidget {
  const IndexPage({
    Key key,
    @required GlobalKey<ScaffoldState> homeKey,
    @required ScrollController scrollViewController,
    @required this.widget,
    @required TabController tabController,
  })  : _homeKey = homeKey, _scrollViewController = scrollViewController,
        _tabController = tabController,
        super(key: key);

  final ScrollController _scrollViewController;
  final MyHomePage widget;
  final TabController _tabController;
  final GlobalKey<ScaffoldState> _homeKey;

  @override
  Widget build(BuildContext context) {
    return NestedScrollView(
      controller: _scrollViewController,
      headerSliverBuilder: (BuildContext context, bool boxIsScrolled) {
        return <Widget>[
          SliverAppBar(
              title: Text(widget.title),
              pinned: true,
              floating: true,
              forceElevated: boxIsScrolled,
              expandedHeight: 100.0,
              leading: IconButton(icon: Icon(Icons.menu),onPressed: _leadPress,),
//              flexibleSpace: Container(child: null),
              bottom: PreferredSize(
                preferredSize: Size(double.infinity, 40.0),
                child: Container(
                  color: Colors.white,
                  width: double.infinity,
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
              ),
              actions: <Widget>[
                PopupMenuButton<String>(
                  onSelected: null,
                  itemBuilder: (BuildContext context) =>
                  <PopupMenuEntry<String>>[
                    const PopupMenuItem<String>(
                      value: 'doc',
                      child: ListTile(
                        leading: Icon(
                          Icons.library_books,
                          size: 22.0,
                        ),
                        title: Text('查看文档'),
                      ),
                    ),
                    const PopupMenuDivider(),
                    const PopupMenuItem<String>(
                      value: 'code',
                      child: ListTile(
                        leading: Icon(
                          Icons.code,
                          size: 22.0,
                        ),
                        title: Text('查看Demo'),
                      ),
                    ),
                  ],
                ),
              ])
        ];
      },
      body: TabBarView(
        children: <Widget>[RecommendPage(scrollViewController: _scrollViewController), PageTwo(), PageThree(), PageFour()],
        controller: _tabController,
      ),
    );
  }

  void _leadPress() {
    _homeKey.currentState.openDrawer();
  }

}

