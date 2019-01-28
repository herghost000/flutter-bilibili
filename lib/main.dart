import 'package:flutter/material.dart';
import 'component/testWidget.dart';
import 'view/index.dart';
import 'view/channel.dart';
import 'view/news.dart';
import 'view/personal.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme:
          ThemeData(primarySwatch: Colors.pink, primaryColor: Colors.pink[300]),
      home: MyHomePage(title: '二次Play'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> with TickerProviderStateMixin {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  TabController _tabController;
  ScrollController _scrollViewController;
  TabController _navController;

  List<Widget> navPages = <Widget>[];

  int _curNavIndex = 0;

  void nav2PageByIndex(int index) {
    setState(() {
      _curNavIndex = index;
    });
  }

  @override
  void initState() {
    super.initState();
    _tabController = TabController(vsync: this, length: 4);
    _scrollViewController = ScrollController(initialScrollOffset: 0.0);
    _navController = TabController(vsync: this, length: 4);
    _navController.addListener(() {
      nav2PageByIndex(_navController.index);
    });
  }

  @override
  Widget build(BuildContext context) {
    navPages = <Widget>[
      new IndexPage(
          homeKey: _scaffoldKey,
          scrollViewController: _scrollViewController,
          widget: widget,
          tabController: _tabController),
      ChannelPage(homeKey: _scaffoldKey,),
      NewsPage(homeKey: _scaffoldKey,),
      PersonalPage(homeKey: _scaffoldKey,),
    ];
    return Scaffold(
      key: _scaffoldKey,
      body: navPages[_curNavIndex],
      bottomNavigationBar:
          BottomNavigationBarFullDefault(tabController: _navController),
      drawer: Drawer(
        child: Stack(
          children: <Widget>[
            Positioned(
              bottom: 0.0,
              left: 0.0,
              right: 0.0,
              child: Container(
                decoration: BoxDecoration(
                    color: Colors.white,
                    border: Border(
                        top: BorderSide(
                            width: 1.0,
                            color: Colors.black12.withOpacity(0.06),
                            style: BorderStyle.solid))),
                height: MediaQuery.of(context).padding.bottom + 60.0,
                padding: EdgeInsets.only(
                    left: 16.0,
                    right: 16.0,
                    bottom: MediaQuery.of(context).padding.bottom),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Row(
                      children: <Widget>[Icon(Icons.settings), Text("设置")],
                    ),
                    Row(
                      children: <Widget>[Icon(Icons.color_lens), Text("主题")],
                    ),
                    Row(
                      children: <Widget>[Icon(Icons.brightness_3), Text("夜间")],
                    )
                  ],
                ),
              ),
            ),
            Column(
              children: <Widget>[
                const UserAccountsDrawerHeader(
                  accountName: Text('ZackAddy'),
                  accountEmail: Text('积分：0.0 钻石：0.0'),
                  currentAccountPicture: CircleAvatar(
                    backgroundImage:
                        AssetImage('assets/images/bili_default_avatar.png'),
                  ),
                  margin: EdgeInsets.zero,
                  otherAccountsPictures: <Widget>[
                    IconButton(
                      icon: Icon(
                        Icons.credit_card,
                        color: Colors.white,
                      ),
                      onPressed: null,
                    )
                  ],
                ),
                Container(
                  height: 40.0,
                  width: double.infinity,
                  color: Colors.amber,
                  padding: EdgeInsets.only(left: 16.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Text(
                        "进入只有会员才知道的世界",
                        style: TextStyle(color: Colors.white),
                      ),
                      Icon(
                        Icons.arrow_forward,
                        color: Colors.white,
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: Container(
                    margin: EdgeInsets.only(
                        bottom: MediaQuery.of(context).padding.bottom + 60.0),
                    child: ListView(
                      shrinkWrap: true,
                      padding: EdgeInsets.all(0.0),
                      children: <Widget>[
                        ListTile(
                          leading: Icon(Icons.home),
                          title: Text('首页'),
                        ),
                        ListTile(
                          leading: Icon(Icons.history),
                          title: Text('历史记录'),
                        ),
                        ListTile(
                          leading: Icon(Icons.cloud_download),
                          title: Text('离线缓存'),
                        ),
                        ListTile(
                          leading: Icon(Icons.star_half),
                          title: Text('我的收藏'),
                        ),
                        ListTile(
                          leading: Icon(Icons.video_library),
                          title: Text('稍后再看'),
                        ),
                        Divider(),
                        ListTile(
                          leading: Icon(Icons.file_upload),
                          title: Text('投稿成为UP主'),
                        ),
                        Divider(),
                        ListTile(
                          leading: Icon(Icons.videocam),
                          title: Text('直播中心'),
                        ),
                        ListTile(
                          leading: Icon(Icons.favorite),
                          title: Text('我的大会员'),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    _tabController.dispose();
    _scrollViewController.dispose();
    _navController.dispose();
    super.dispose();
  }
}

class BottomNavigationBarFullDefault extends StatefulWidget {
  const BottomNavigationBarFullDefault({
    Key key,
    @required TabController tabController,
  })  : tabController = tabController,
        super(key: key);

  final TabController tabController;

  @override
  State<StatefulWidget> createState() => _BottomNavigationBarFullDefault();
}

class _BottomNavigationBarFullDefault
    extends State<BottomNavigationBarFullDefault> {
  int _currentIndex = 0;

  void _onItemTapped(int index) {
    setState(() {
      _currentIndex = index;
      widget.tabController.index = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: BottomNavigationBar(
        type: BottomNavigationBarType
            .fixed, // BottomNavigationBarType 中定义的类型，有 fixed 和 shifting 两种类型
        iconSize: 24.0, // BottomNavigationBarItem 中 icon 的大小
        currentIndex: _currentIndex, // 当前所高亮的按钮index
        onTap: _onItemTapped, // 点击里面的按钮的回调函数，参数为当前点击的按钮 index
        fixedColor:
            Colors.pinkAccent, // 如果 type 类型为 fixed，则通过 fixedColor 设置选中 item 的颜色
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(
              title: new Text("首页"), icon: new Icon(Icons.home)),
          BottomNavigationBarItem(
              title: new Text("频道"), icon: new Icon(Icons.live_tv)),
          BottomNavigationBarItem(
              title: new Text("动态"), icon: new Icon(Icons.message)),
          BottomNavigationBarItem(
              title: new Text("我的"), icon: new Icon(Icons.my_location)),
        ],
      ),
    );
  }
}
