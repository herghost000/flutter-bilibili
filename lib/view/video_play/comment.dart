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
          return Column(
            children: <Widget>[
              Row(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Container(
//                color: Colors.grey,
                    width: 80.0,
                    alignment: Alignment.topCenter,
                    child: new CircleAvatar(
                      backgroundImage:
                          new AssetImage('assets/images/${index + 1}.webp'),
                      radius: 30.0,
                    ),
                  ),
                  Expanded(
                    child: Container(
//                  color: Colors.grey,
                      child: Column(
                        children: <Widget>[
                          Row(
                            children: <Widget>[
                              Row(
                                children: <Widget>[
                                  Text(
                                    '雪哥-NeroSparda',
                                    style: TextStyle(color: Colors.red),
                                  ),
                                  Padding(
                                      padding: EdgeInsets.only(left: 6.0),
                                      child: Image.asset(
                                          'assets/images/ic_user_level_4.png')),
                                ],
                              ),
                              Container(
                                height: 30.0,
                                  child: FlatButton.icon(
                                      textColor: Colors.red,
                                      onPressed: () {},
                                      icon: Icon(Icons.add),
                                      label: Text('关注')))
                            ],
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          ),
                          Text('ss'),
                          Text('ss'),
                          Text('ss'),
                          Text('ss'),
                          Text('ss'),
                          Text('ss'),
                          Text('ss'),
                          Text('ss+'),
                        ],
                        crossAxisAlignment: CrossAxisAlignment.start,
                      ),
                      constraints: BoxConstraints(minHeight: 60.0),
                    ),
                    flex: 1,
                  )
                ],
              ),
              Divider()
            ],
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
