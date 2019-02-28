import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:flutter_easyrefresh/easy_refresh.dart';

class ChannelPage extends StatefulWidget {
  const ChannelPage({
    Key key,
    @required GlobalKey<ScaffoldState> homeKey,
  })  : _homeKey = homeKey,
        super(key: key);

  final GlobalKey<ScaffoldState> _homeKey;

  void _leadPress() {
    _homeKey.currentState.openDrawer();
  }

  @override
  _ChannelPageState createState() => _ChannelPageState();
}

class _ChannelPageState extends State<ChannelPage> {
  int count = 20;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("频道"),
          leading: IconButton(
            icon: Icon(Icons.menu),
            onPressed: widget._leadPress,
          ),
        ),
        body:BasicPage()
    );
  }
}

class BasicPage extends StatefulWidget {
  @override
  _BasicPageState createState() => _BasicPageState();
}

class _BasicPageState extends State<BasicPage> {
  List<String> addStr = ["1", "2", "3", "4", "5", "6", "7", "8", "9", "0"];
  List<String> str = ["1", "2", "3", "4", "5", "6", "7", "8", "9", "0"];
  GlobalKey<EasyRefreshState> _easyRefreshKey =
  new GlobalKey<EasyRefreshState>();
  GlobalKey<RefreshHeaderState> _headerKey =
  new GlobalKey<RefreshHeaderState>();
  GlobalKey<RefreshFooterState> _footerKey =
  new GlobalKey<RefreshFooterState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("EasyRefresh"),
      ),
      body: Center(
          child: new EasyRefresh(
            key: _easyRefreshKey,
            behavior: ScrollOverBehavior(),
//            refreshHeader: ClassicsHeader(
//              key: _headerKey,
//              bgColor: Colors.transparent,
//              textColor: Colors.black87,
//              moreInfoColor: Colors.black54,
//              showMore: true,
//            ),
//            refreshFooter: ClassicsFooter(
//              key: _footerKey,
//              bgColor: Colors.transparent,
//              textColor: Colors.black87,
//              moreInfoColor: Colors.black54,
//              showMore: true,
//            ),
            child: new ListView.builder(
              //ListView的Item
                itemCount: str.length,
                itemBuilder: (BuildContext context, int index) {
                  return new Container(
                      height: 70.0,
                      child: Card(
                        child: new Center(
                          child: new Text(
                            str[index],
                            style: new TextStyle(fontSize: 18.0),
                          ),
                        ),
                      ));
                }),
            onRefresh: () async {
              await new Future.delayed(const Duration(seconds: 1), () {
                setState(() {
                  str.clear();
                  str.addAll(addStr);
                });
              });
            },
            loadMore: () async {
              await new Future.delayed(const Duration(seconds: 1), () {
                if (str.length < 20) {
                  setState(() {
                    str.addAll(addStr);
                  });
                }
              });
            },
          )),
    );
  }
}