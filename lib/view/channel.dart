import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

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
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("频道"),
        leading: IconButton(icon: Icon(Icons.menu),onPressed: widget._leadPress,),
      ),
      body: MyHomePage(title: '456')
    );
  }
}


class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => new _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  SlidableController slidableController;
  final List<_HomeItem> items = List.generate(
    20,
        (i) => new _HomeItem(
      i,
      'Tile n°$i',
      _getSubtitle(i),
      _getAvatarColor(i),
    ),
  );

  @protected
  void initState() {
    slidableController = new SlidableController();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text(widget.title),
      ),
      body: new Center(
        child: new OrientationBuilder(
          builder: (context, orientation) => _buildList(
              context,
              orientation == Orientation.portrait
                  ? Axis.vertical
                  : Axis.horizontal),
        ),
      ),
    );
  }

  Widget _buildList(BuildContext context, Axis direction) {
    return new ListView.builder(
      scrollDirection: direction,
      itemBuilder: (context, index) {
        final Axis slidableDirection =
        direction == Axis.horizontal ? Axis.vertical : Axis.horizontal;
        return _getSlidableWithLists(context, index, slidableDirection);
      },
      itemCount: items.length,
    );
  }

  Widget _buildVerticalListItem(BuildContext context, int index) {
    final _HomeItem item = items[index];
    return new Container(
      color: Colors.white,
      child: new ListTile(
        leading: new CircleAvatar(
          backgroundColor: item.color,
          child: new Text('${item.index}'),
          foregroundColor: Colors.white,
        ),
        title: new Text(item.title),
        subtitle: new Text(item.subtitle),
      ),
    );
  }

  Widget _buildhorizontalListItem(BuildContext context, int index) {
    final _HomeItem item = items[index];
    return new Container(
      color: Colors.white,
      width: 160.0,
      child: new Column(
        mainAxisSize: MainAxisSize.max,
        children: <Widget>[
          new Expanded(
            child: new CircleAvatar(
              backgroundColor: item.color,
              child: new Text('${item.index}'),
              foregroundColor: Colors.white,
            ),
          ),
          new Expanded(
            child: Center(
              child: new Text(
                item.subtitle,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _getSlidableWithLists(
      BuildContext context, int index, Axis direction) {
    final _HomeItem item = items[index];
    //final int t = index;
    return new Slidable(
      key: new Key(item.title),
      controller: slidableController,
      direction: direction,
      delegate: _getDelegate(item.index),
      actionExtentRatio: 0.25,
      child: direction == Axis.horizontal
          ? _buildVerticalListItem(context, index)
          : _buildhorizontalListItem(context, index),
      actions: <Widget>[
        new IconSlideAction(
          caption: 'Archive',
          color: Colors.blue,
          icon: Icons.archive,
          onTap: () => _showSnackBar(context, 'Archive'),
        ),
        new IconSlideAction(
          caption: 'Share',
          color: Colors.indigo,
          icon: Icons.share,
          onTap: () => _showSnackBar(context, 'Share'),
        ),
      ],
      secondaryActions: <Widget>[
        new IconSlideAction(
          caption: 'More',
          color: Colors.grey.shade200,
          icon: Icons.more_horiz,
          onTap: () => _showSnackBar(context, 'More'),
          closeOnTap: false,
        ),
        new IconSlideAction(
          caption: 'Delete',
          color: Colors.red,
          icon: Icons.delete,
          onTap: () => _showSnackBar(context, 'Delete'),
        ),
      ],
    );
  }

  static SlidableDelegate _getDelegate(int index) {
    switch (index % 4) {
      case 0:
        return new SlidableBehindDelegate();
      case 1:
        return new SlidableStrechDelegate();
      case 2:
        return new SlidableScrollDelegate();
      case 3:
        return new SlidableDrawerDelegate();
      default:
        return null;
    }
  }

  static Color _getAvatarColor(int index) {
    switch (index % 4) {
      case 0:
        return Colors.red;
      case 1:
        return Colors.green;
      case 2:
        return Colors.blue;
      case 3:
        return Colors.indigoAccent;
      default:
        return null;
    }
  }

  static String _getSubtitle(int index) {
    switch (index % 4) {
      case 0:
        return 'SlidableBehindDelegate';
      case 1:
        return 'SlidableStrechDelegate';
      case 2:
        return 'SlidableScrollDelegate';
      case 3:
        return 'SlidableDrawerDelegate';
      default:
        return null;
    }
  }

  void _showSnackBar(BuildContext context, String text) {
    Scaffold.of(context).showSnackBar(SnackBar(content: new Text(text)));
  }
}

class _HomeItem {
  const _HomeItem(
      this.index,
      this.title,
      this.subtitle,
      this.color,
      );

  final int index;
  final String title;
  final String subtitle;
  final Color color;
}