import 'package:flutter/material.dart';
import 'package:flutter/gestures.dart';

class BriefIntroduction extends StatefulWidget {
  @override
  _BriefIntroduction createState() => _BriefIntroduction();
}

class _BriefIntroduction extends State<BriefIntroduction> with TickerProviderStateMixin {
  final ScrollController _scrollController =
      new ScrollController(initialScrollOffset: 0.0);

  @override
  void initState() {
    super.initState();
    _scrollController
      ..addListener(() {
//      print(_scrollController.position.pixels);
      });
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
        key: PageStorageKey<String>('brief_introduction'),
        slivers: <Widget>[
          SliverToBoxAdapter(child: _PersonalBriefIntroduction()),
          SliverToBoxAdapter(child: _VideoBriefIntroduction()),
          SliverToBoxAdapter(child: _InteractionBar()),
          SliverToBoxAdapter(
            child: _TagsBar(),
          ),
          _Relevant()
        ],
      );
  }
}

class _Relevant extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SliverFixedExtentList(
      itemExtent: 140.0,
      delegate:
      SliverChildBuilderDelegate((BuildContext context, int index) {
        return Container(
          decoration: BoxDecoration(
              border: Border(
                  bottom: BorderSide(
                      color: Colors.black12.withOpacity(.05),
                      style: BorderStyle.solid))),
          padding: EdgeInsets.only(
              left: 20.0, right: 20.0, top: 10.0, bottom: 10.0),
          child: Row(
            children: <Widget>[
              ClipRRect(
                borderRadius: BorderRadius.circular(4.0),
                child: Image.asset(
                  'assets/images/${index + 1}.webp',
                  fit: BoxFit.cover,
                  width: 170.0,
                  height: double.infinity,
                ),
              ),
              Expanded(
                child: Container(
                  padding: EdgeInsets.only(left: 10.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Container(
                        child: Text(
                          "【C菌】B站三怂再次被吓飞！【生化危机2：重制版】长篇惺惺惜惺惺",
                          maxLines: 2,
//                                overflow: TextOverflow.ellipsis,
                          style: TextStyle(
//                                  color: Colors.black87,
//                                  fontWeight: FontWeight.bold
                          ),
                        ),
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Container(
                            padding: EdgeInsets.symmetric(
                                vertical: 1.0, horizontal: 4.0),
                            child: Align(
                              alignment: Alignment(0, 0),
                              widthFactor: 1.0,
                              child: Baseline(
                                baseline: 12.0,
                                baselineType: TextBaseline.alphabetic,
                                child: Text(
                                  "大家都在搜",
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 12.0,
                                  ),
                                ),
                              ),
                            ),
                            decoration: BoxDecoration(
                                color: Colors.orange,
                                borderRadius: BorderRadius.all(
                                    Radius.circular(4.0))),
                          ),
                          Text(
                            "渗透之C君",
                            style: TextStyle(color: Colors.black45),
                          ),
                          Text(
                            "131.4万观看·01-26",
                            style: TextStyle(color: Colors.black45),
                          )
                        ],
                      )
                    ],
                  ),
                ),
              )
            ],
          ),
        );
      }, childCount: 8 //50个列表项
      ),
    );
  }
}

class HorizontalText extends StatelessWidget {
  HorizontalText(
      {Key key,
      this.text,
      this.textColor = Colors.black54,
      this.fontSize = 12.0})
      : assert(text != null),
        assert(textColor != null),
        assert(fontSize != null),
        super(key: key);

  final String text;
  final Color textColor;
  final double fontSize;

  @override
  Widget build(BuildContext context) {
    return Baseline(
        child:
            Text(text, style: TextStyle(fontSize: fontSize, color: textColor)),
        baseline: fontSize,
        baselineType: TextBaseline.alphabetic);
  }
}

class HorizontalTextIcon extends StatelessWidget {
  HorizontalTextIcon(
      {Key key,
      this.fontSize = 12.0,
      this.text,
      this.textColor = Colors.black54,
      this.icon,
      this.iconColor = Colors.black26})
      : assert(fontSize != null),
        assert(text != null),
        assert(textColor != null),
        assert(icon != null),
        assert(iconColor != null),
        super(key: key);

  final double fontSize;
  final String text;
  final Color textColor;
  final IconData icon;
  final Color iconColor;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        Container(
          padding: EdgeInsets.only(right: 2.0),
          child: Baseline(
              child: Icon(
                icon,
                size: fontSize + 6.0,
                color: iconColor,
              ),
              baseline: fontSize + 6.0,
              baselineType: TextBaseline.alphabetic),
        ),
        Container(
          padding: EdgeInsets.only(right: 4.0),
          child: Baseline(
              child: Text(text,
                  style: TextStyle(fontSize: fontSize, color: textColor)),
              baseline: fontSize,
              baselineType: TextBaseline.alphabetic),
        ),
      ],
    );
  }
}

class _InteractionBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Container(
          padding: EdgeInsets.only(top: 16.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              Column(
                children: <Widget>[
                  Container(
                    child: Icon(
                      Icons.favorite,
                      color: Colors.black54,
                      size: 24,
                    ),
                    height: 36.0,
                  ),
                  HorizontalText(
                      text: '2万', fontSize: 14.0, textColor: Colors.black45),
                ],
              ),
              Column(
                children: <Widget>[
                  Container(
                    height: 36.0,
                    child: Icon(
                      Icons.favorite_border,
                      color: Colors.black54,
                      size: 24,
                    ),
                  ),
                  HorizontalText(
                      text: '不喜欢', fontSize: 14.0, textColor: Colors.black45),
                ],
              ),
              Column(
                children: <Widget>[
                  Container(
                    height: 36.0,
                    child: Icon(
                      Icons.monetization_on,
                      color: Colors.black54,
                      size: 24,
                    ),
                  ),
                  HorizontalText(
                      text: '2.1万', fontSize: 14.0, textColor: Colors.black45),
                ],
              ),
              Column(
                children: <Widget>[
                  Container(
                    height: 36.0,
                    child: Icon(
                      Icons.star,
                      color: Colors.black54,
                      size: 24,
                    ),
                  ),
                  HorizontalText(
                      text: '1.4万', fontSize: 14.0, textColor: Colors.black45),
                ],
              ),
              Column(
                children: <Widget>[
                  Container(
                    height: 36.0,
                    child: Icon(
                      Icons.share,
                      color: Colors.black54,
                      size: 24,
                    ),
                  ),
                  HorizontalText(
                      text: '2443', fontSize: 14.0, textColor: Colors.black45),
                ],
              ),
            ],
          ),
        ),
        Divider(
          height: 20.0,
        )
      ],
    );
  }
}

class _TagsBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20.0),
      child: Wrap(
        alignment: WrapAlignment.start,
        crossAxisAlignment: WrapCrossAlignment.center,
        spacing: 10.0,
        runSpacing: 6.0,
        children: <Widget>[
          Container(
            padding: EdgeInsets.symmetric(vertical: 4.0, horizontal: 10.0),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20.0),
                color: Colors.grey[200]),
            child: Text("繁华"),
          ),
          Container(
            padding: EdgeInsets.symmetric(vertical: 4.0, horizontal: 10.0),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20.0),
                color: Colors.grey[200]),
            child: Text("我踩踩踩"),
          ),
          Container(
            padding: EdgeInsets.symmetric(vertical: 4.0, horizontal: 10.0),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20.0),
                color: Colors.grey[200]),
            child: Text("老家伙"),
          ),
        ],
      ),
    );
  }
}

class _VideoBriefIntroduction extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50.0,
      padding: EdgeInsets.only(left: 20.0, right: 20.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text('【肥皂菌】繁华唱遍'),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                mainAxisSize: MainAxisSize.max,
                children: <Widget>[
                  Container(
                      padding: EdgeInsets.only(right: 6.0),
                      child: HorizontalTextIcon(
                        fontSize: 12.0,
                        icon: Icons.play_arrow,
                        text: '27万',
                      )),
                  Container(
                      padding: EdgeInsets.only(right: 6.0),
                      child: HorizontalTextIcon(
                        fontSize: 12.0,
                        icon: Icons.note,
                        text: '1459',
                      )),
                  Container(
                    padding: EdgeInsets.only(right: 6.0),
                    child: HorizontalText(text: '2-8'),
                  ),
                  Container(
                      padding: EdgeInsets.only(right: 6.0),
                      child: HorizontalText(text: 'AV42700612')),
                ],
              )
            ],
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: <Widget>[
              Icon(Icons.keyboard_arrow_down),
              Row(
                children: <Widget>[
                  Container(
                    margin: EdgeInsets.only(right: 4.0),
                    child: Icon(
                      Icons.block,
                      color: Colors.red,
                      size: 18.0,
                    ),
                  ),
                  Text('未经作者授权禁止转载', style: TextStyle(fontSize: 12.0))
                ],
              )
            ],
          )
        ],
      ),
    );
  }
}

class _PersonalBriefIntroduction extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding:
          EdgeInsets.only(left: 20.0, right: 20.0, top: 10.0, bottom: 10.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Row(
            children: <Widget>[
              Stack(
                alignment: AlignmentDirectional(0.6, 0.6),
                children: [
                  Container(
                    width: 38.0,
                    height: 38.0,
                    child: new CircleAvatar(
                      backgroundImage: new AssetImage('assets/images/1.webp'),
                      radius: 100.0,
                    ),
                  ),
                  new Container(
                    decoration: new BoxDecoration(
                      color: Colors.black45,
                    ),
                    child: new Text(
                      '',
                      style: new TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ],
              ),
              Container(
                padding: EdgeInsets.only(left: 10.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[Text('肥皂菌 | 茗茗的猫咪'), Text('47.1万粉丝')],
                ),
              )
            ],
          ),
          FlatButton.icon(
            onPressed: () {},
            icon: Icon(Icons.add, color: Colors.white),
            label: Text(
              '关注',
              style: TextStyle(color: Colors.white),
            ),
            color: Colors.pink[300].withOpacity(0.9),
          ),
        ],
      ),
    );
  }
}
