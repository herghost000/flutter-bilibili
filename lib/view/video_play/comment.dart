import 'package:flutter/material.dart';

class Comment extends StatefulWidget {
  @override
  _Comment createState() => _Comment();
}

class _Comment extends State<Comment> {
  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      slivers: <Widget>[
        SliverToBoxAdapter(
          child: _Alert(
            iconHead: Icon(
              Icons.lightbulb_outline,
              color: Colors.orange[900],
            ),
            color: Colors.amber[100].withOpacity(0.5),
            text: Text(
              '大会员组队买一送一，只剩最后一天！',
              style: TextStyle(color: Colors.orange[900]),
            ),
            clickEvent: () {
              print('click');
            },
            closeEvent: () {
              print('close');
            },
            iconClose: Icon(
              Icons.close,
              color: Colors.orange[900],
            ),
          ),
        ),
        SliverToBoxAdapter(
          child: Container(
            padding: EdgeInsets.only(left: 20.0),
            height: 50.0,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Text('评论(1642)'),
                IconButton(
                    icon: Icon(
                      Icons.more_vert,
                      color: Colors.black26,
                    ),
                    onPressed: () {})
              ],
            ),
          ),
        ),
        SliverList(
            delegate:
                SliverChildBuilderDelegate((BuildContext context, int index) {
          return Container(
            child: Flex(
              direction: Axis.horizontal,
              children: <Widget>[
                Container(
                  color: Colors.grey,
                  width: 80.0,
                  height: 60.0,
                  alignment: Alignment.center,
                  child: new CircleAvatar(
                    backgroundImage:
                        new AssetImage('assets/images/${index + 1}.webp'),
                    radius: 30.0,
                  ),
                ),

//            color: Colors.grey,
//            alignment: Alignment.topLeft,
//            child: Column(
//              crossAxisAlignment: CrossAxisAlignment.stretch,
//              children: <Widget>[
//                Row(
//                  children: <Widget>[Text('这是第二行'), Text('这是第二行')],
//                ),
//                Text('这是第二行')
//              ],
//            )
                Expanded(
                  flex: 1,
                  child: Container(
                    color: Colors.grey,
                    child: Column(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: <Widget>[
                        Text('ss'),
                        Text('ss'),
                        Text('ss'),
                        Text('ss'),
                      ],
                    ),
                  ),
                )
              ],
            ),
          );
        }, childCount: 8))
      ],
    );
  }
}

class _Alert extends StatelessWidget {
  _Alert(
      {Key key,
      this.iconHead,
      this.text,
      this.color,
      this.iconClose = const Icon(Icons.close),
      this.clickEvent,
      this.closeEvent})
      : assert(iconHead != null),
        assert(text != null),
        assert(color != null),
        assert(iconClose != null),
        assert(clickEvent != null),
        assert(closeEvent != null),
        super(key: key);

  final Widget iconHead;
  final Widget iconClose;
  final Widget text;
  final Color color;
  final VoidCallback closeEvent;
  final VoidCallback clickEvent;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: clickEvent,
      child: Container(
        padding: EdgeInsets.only(left: 20.0),
        color: color,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Row(
              children: <Widget>[
                iconHead,
                Container(margin: EdgeInsets.only(left: 6.0), child: text)
              ],
            ),
            IconButton(icon: iconClose, onPressed: closeEvent)
          ],
        ),
      ),
    );
  }
}
