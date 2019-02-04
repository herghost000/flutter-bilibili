import 'package:flutter/material.dart';
import 'package:sticky_headers/sticky_headers.dart';

class NewsPage extends StatefulWidget {
  const NewsPage({
    Key key,
    @required GlobalKey<ScaffoldState> homeKey,
  })  : _homeKey = homeKey,
        super(key: key);

  final GlobalKey<ScaffoldState> _homeKey;

  void _leadPress() {
    _homeKey.currentState.openDrawer();
  }

  @override
  _NewsPage createState() => _NewsPage();
}

class _NewsPage extends State<NewsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("动态"),
        leading: IconButton(icon: Icon(Icons.menu),onPressed: widget._leadPress,),
      ),
      body: Container(
        child: Example(),
      ),
    );
  }
}

class Example extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new ListView.builder(itemBuilder: (context, index) {
      if (index == 0) {
        return new StickyHeader(
          header: new Container(
            height: 50.0,
            color: Colors.blueGrey[700],
            padding: new EdgeInsets.symmetric(horizontal: 16.0),
            alignment: Alignment.centerLeft,
            child: new Text('Header #$index',
              style: const TextStyle(color: Colors.white),
            ),
          ),
          content: new Container(
            child: Text("x"),
          ),
        );
      }
      return Text("xxx");
    });
  }
}