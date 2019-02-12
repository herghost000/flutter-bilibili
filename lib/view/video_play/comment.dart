import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:html/dom.dart' as dom;
import '../../config/application.dart';

class LoadingDialog extends Dialog {
  String text;
  final TextEditingController _textEditingController = TextEditingController();
  final FocusNode focusNode = new FocusNode();

  LoadingDialog({Key key, @required this.text}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.of(context).pop();
      },
      child: Scaffold(
          //创建透明层
          backgroundColor: Colors.transparent,
          body: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: <Widget>[
              Container(
                  padding: const EdgeInsets.symmetric(vertical: 8.0),
                  color: Colors.white,
                  child: Row(
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10.0),
                        child: Image.asset(
                            'assets/images/ic_comment2_input_emoji.png'),
                      ),
                      Expanded(
                        child: Container(
                            height: 36.0,
                            alignment: Alignment.centerLeft,
                            padding: EdgeInsets.symmetric(horizontal: 10.0),
                            decoration: BoxDecoration(
                                border: Border.all(color: Colors.grey[300]),
                                color: Colors.grey[100],
                                borderRadius: BorderRadius.circular(16.0)),
                            child: TextField(
                              decoration: InputDecoration(
                                contentPadding: EdgeInsets.all(0.0),
                                labelStyle: TextStyle(height: 0),
                                hintText: '',
                                semanticCounterText: 'semanticCounterText',
                                border: InputBorder.none,
                              ),
                              autofocus: true,
                            )),
                      ),
                      GestureDetector(
                        onTap: (){
                          print('send text');
                        },
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 10.0),
                          child: Image.asset(
                            'assets/images/ic_comment2_input_send.png',
                            color: Colors.black38,
                          ),
                        ),
                      )
                    ],
                  )),
            ],
          )),
    );
  }
}

class Comment extends StatefulWidget {
  @override
  _CommentState createState() => _CommentState();
}

class _CommentState extends State<Comment> {
  @override
  Widget build(BuildContext context) {
    return Stack(
      key: PageStorageKey<String>('comment'),
      children: <Widget>[
        CustomScrollView(
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
            _CommentList()
          ],
        ),
          Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              child:Container(
                  padding: const EdgeInsets.symmetric(vertical: 8.0),
                  color: Colors.white,
                  child: Row(
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10.0),
                        child: Image.asset(
                            'assets/images/ic_comment2_input_emoji.png'),
                      ),
                      Expanded(
                        child: GestureDetector(
                          onTap: () {
                            showDialog(
                                context: context,
                                builder: (BuildContext context) {
                                  return new LoadingDialog(
                                    //调用对话框
                                    text: '正在获取详情...',
                                  );
                                });
                          },
                          child: Container(
                              height: 36.0,
                              alignment: Alignment.centerLeft,
                              padding: EdgeInsets.symmetric(horizontal: 10.0),
                              decoration: BoxDecoration(
                                  border: Border.all(color: Colors.grey[300]),
                                  color: Colors.grey[100],
                                  borderRadius: BorderRadius.circular(16.0)),
                              child: Text(
                                '说点什么吧',
                                style: TextStyle(color: Colors.black26),
                              )),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10.0),
                        child: Image.asset(
                          'assets/images/ic_comment2_input_send.png',
                          color: Colors.black38,
                        ),
                      )
                    ],
                  )),
          )
      ],
    );
  }
}

class _CommentList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SliverList(
        delegate: SliverChildBuilderDelegate((BuildContext context, int index) {
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
                      Row(
                        children: <Widget>[
                          Text(
                            '#1',
                            style: TextStyle(color: Colors.black38),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 8.0),
                            child: Text(
                              '2-8',
                              style: TextStyle(color: Colors.black38),
                            ),
                          )
                        ],
                      ),
                      Html(
                        data: """
    <!--For a much more extensive example, look at example/main.dart-->
      <p>第一！！！！！</p><p>疯狂表白皂老师！</p><p>给皂老师疯狂打call！</p><p>我皂老师天下第一</p><p>我皂老师举世无双</p><p>皂皂每个月前十五天上午直播，会有冠世一战和繁华唱遍的现场版！记得来直播间430听拜年祭现场版😄</p>
  """,
                        blockSpacing: 0.0,
                        padding: EdgeInsets.only(right: 20.0),
                        backgroundColor: Colors.transparent,
                        onLinkTap: (url) {
                          // open url in a webview
                        },
                        customRender: (node, children) {
                          if (node is dom.Element) {}
                        },
                      ),
                      Row(
                        children: <Widget>[
                          Container(
                            child: Row(
                              children: <Widget>[
                                Image.asset(
                                  'assets/images/ic_player_endpage_recommend.png',
                                  color: Colors.black38,
                                  height: 16.0,
                                  fit: BoxFit.fitHeight,
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(left: 8.0),
                                  child: Text(
                                    '1777',
                                    style: TextStyle(color: Colors.black38),
                                  ),
                                )
                              ],
                            ),
                            padding: EdgeInsets.only(right: 20.0),
                          ),
                          Container(
                            child: Row(
                              children: <Widget>[
                                Image.asset(
                                  'assets/images/ic_player_endpage_dislike.png',
                                  color: Colors.black38,
                                  height: 16.0,
                                  fit: BoxFit.fitHeight,
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(left: 8.0),
                                  child: Text(
                                    '',
                                    style: TextStyle(color: Colors.black38),
                                  ),
                                )
                              ],
                            ),
                            padding: EdgeInsets.only(right: 20.0),
                          ),
                          Container(
                            child: Row(
                              children: <Widget>[
                                Image.asset(
                                  'assets/images/ic_player_share_new.png',
                                  color: Colors.black38,
                                  height: 16.0,
                                  fit: BoxFit.fitHeight,
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(left: 8.0),
                                  child: Text(
                                    '',
                                    style: TextStyle(color: Colors.black38),
                                  ),
                                )
                              ],
                            ),
                            padding: EdgeInsets.only(right: 20.0),
                          ),
                        ],
                      ),
                      Container(
                        child: Column(
                          children: <Widget>[
                            RichText(
                                text: TextSpan(
                                    text: '科夫莱特恩',
                                    style: TextStyle(color: Colors.blue),
                                    children: [
                                  TextSpan(
                                      text: ':',
                                      style: TextStyle(color: Colors.black)),
                                  TextSpan(
                                      text: '差了一点！！生气',
                                      style: TextStyle(color: Colors.black))
                                ])),
                            RichText(
                                text: TextSpan(
                                    text: '白山青雪',
                                    style: TextStyle(color: Colors.blue),
                                    children: [
                                  TextSpan(
                                      text: ':',
                                      style: TextStyle(color: Colors.black)),
                                  TextSpan(
                                      text: '你这是什么网速',
                                      style: TextStyle(color: Colors.black))
                                ])),
                            RichText(
                                text: TextSpan(
                                    text: '尺尺素素',
                                    style: TextStyle(color: Colors.blue),
                                    children: [
                                  TextSpan(
                                      text: ':',
                                      style: TextStyle(color: Colors.black)),
                                  TextSpan(
                                      text: '你这可怕的手速[小电视_赞]',
                                      style: TextStyle(color: Colors.black))
                                ])),
                          ],
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                        ),
                        color: Colors.grey[200],
                        alignment: Alignment.topLeft,
                        padding: EdgeInsets.all(8.0),
                        margin: EdgeInsets.only(top: 16.0, right: 20.0),
                      ),
                    ],
                  ),
                  constraints: BoxConstraints(minHeight: 60.0),
                ),
                flex: 1,
              )
            ],
          ),
          index == 7
              ? Padding(
                  padding: EdgeInsets.only(bottom: 50.0),
                  child: Divider(),
                )
              : Divider()
        ],
      );
    }, childCount: 8));
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
