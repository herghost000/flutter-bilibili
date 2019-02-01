import 'package:flutter/material.dart';

class PersonalPage extends StatefulWidget {
  const PersonalPage({
    Key key,
    @required GlobalKey<ScaffoldState> homeKey,
  })  : _homeKey = homeKey,
        super(key: key);

  final GlobalKey<ScaffoldState> _homeKey;

  void _leadPress() {
    _homeKey.currentState.openDrawer();
  }

  @override
  _PersonalPage createState() => _PersonalPage();
}

class _PersonalPage extends State<PersonalPage>
    with SingleTickerProviderStateMixin {
  AnimationController _controller;
  ScrollController _scrollController;
  double op = 0.0;

  @override
  void initState() {
    super.initState();
    _scrollController = new ScrollController();
    _scrollController.addListener(() {
      if (_scrollController.position.pixels <= 255) {
        op = _scrollController.position.pixels / 255 * 2;
        if (op > 0.9) op = 1.0;
      }
    });
    _controller = new AnimationController(
        vsync: this, duration: const Duration(seconds: 5), upperBound: 40.0)
      ..addStatusListener((status) {
        if (status == AnimationStatus.completed) {
          _controller.reverse();
        } else if (status == AnimationStatus.dismissed) {
          _controller.forward();
        }
      })
      ..addListener(() {
        setState(() {});
      });
    _controller.value = 0.0;
    _controller.forward();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        CustomScrollView(
          controller: _scrollController,
          slivers: <Widget>[
            SliverToBoxAdapter(
              child: Column(
                children: <Widget>[
                  Stack(
                    children: <Widget>[
                      Container(
                        height: 290.0,
                        child: Image.asset(
                          'assets/images/5.webp',
                          fit: BoxFit.cover,
                        ),
                      ),
                    ],
                  ),
                  Container(
                    height: 65.0,
                    decoration: BoxDecoration(
                        color: Colors.white,
                        boxShadow: <BoxShadow>[
                          BoxShadow(color: Colors.black12)
                        ]),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: <Widget>[
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Icon(
                              Icons.photo,
                              color: Colors.pink[300],
                            ),
                            Text(
                              '相册',
                              style: TextStyle(color: Colors.pink[300]),
                            )
                          ],
                        ),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Icon(
                              Icons.message,
                              color: Colors.pink[300],
                            ),
                            Text(
                              '说说',
                              style: TextStyle(color: Colors.pink[300]),
                            )
                          ],
                        ),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Icon(
                              Icons.extension,
                              color: Colors.pink[300],
                            ),
                            Text(
                              '个性化',
                              style: TextStyle(color: Colors.pink[300]),
                            )
                          ],
                        ),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Icon(
                              Icons.videogame_asset,
                              color: Colors.pink[300],
                            ),
                            Text(
                              '小游戏',
                              style: TextStyle(color: Colors.pink[300]),
                            )
                          ],
                        ),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Icon(
                              Icons.play_circle_filled,
                              color: Colors.pink[300],
                            ),
                            Text(
                              '小视频',
                              style: TextStyle(color: Colors.pink[300]),
                            )
                          ],
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
            SliverFixedExtentList(
                delegate: SliverChildBuilderDelegate(
                    (BuildContext context, int index) {
                  return ListTile(
                    title: Text('666-${index}'),
                  );
                }, childCount: 20),
                itemExtent: 50.0)
          ],
        ),
        Container(
          height: MediaQuery.of(context).padding.top + kToolbarHeight,
          width: double.infinity,
          child: Container(
            height: kToolbarHeight,
            child: AppBar(
              title: Text(
                "空间",
//                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              centerTitle: true,
              elevation: 0.0,
              backgroundColor: Colors.pink[300].withOpacity(op),
            ),
          ),
        ),
      ],
    );
    return Scaffold(
        appBar: AppBar(
          title: Text("xxx"),
        ),
        body: Column(
          children: <Widget>[
            ClipPath(
              clipper: BottomClipper(animation: _controller),
              child: Container(
                color: Colors.pink[300],
                height: 200,
              ),
            )
          ],
        ));
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}

class BottomClipper extends CustomClipper<Path> {
  Animation<double> animation;

  BottomClipper({Animation<double> animation}) : animation = animation;

  @override
  Path getClip(Size size) {
    var path = Path();
    path.lineTo(0, size.height - 20 + animation.value / 2);
    var firstControlPoint =
        Offset(size.width / 4, size.height - animation.value);
    var firstEndPoint = Offset(size.width / 2.25, size.height - 30);
    path.quadraticBezierTo(firstControlPoint.dx, firstControlPoint.dy,
        firstEndPoint.dx, firstEndPoint.dy);
    var secondControlPoint =
        Offset(size.width / 4 * 3, size.height - 80 + animation.value * 2);
    var secondEndPoint =
        Offset(size.width, size.height - 40 + animation.value / 3);
    path.quadraticBezierTo(secondControlPoint.dx, secondControlPoint.dy,
        secondEndPoint.dx, secondEndPoint.dy);
    path.lineTo(size.width, size.height - 40);
    path.lineTo(size.width, 0);
    return path;
  }

  @override
  bool shouldReclip(BottomClipper oldClipper) {
    return true;
  }
}

class BottomClipperTest extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    var path = Path();
    path.lineTo(0, 0);
    path.lineTo(0, size.height - 30);
    var firstControlPoint = Offset(size.width / 2, size.height);
    var firstEndPoint = Offset(size.width, size.height - 30);
    path.quadraticBezierTo(firstControlPoint.dx, firstControlPoint.dy,
        firstEndPoint.dx, firstEndPoint.dy);
    path.lineTo(size.width, size.height - 30);
    path.lineTo(size.width, 0);
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) {
    return true;
  }
}

class CheckedPopupMenuItemDemo extends StatefulWidget {
  _CheckedPopupMenuItemDemoState createState() =>
      _CheckedPopupMenuItemDemoState();
}

class _CheckedPopupMenuItemDemoState extends State<CheckedPopupMenuItemDemo> {
  List<String> _checkedValues;

  final String _checkedValue1 = 'One';
  final String _checkedValue2 = 'Two';
  final String _checkedValue3 = 'Free';
  final String _checkedValue4 = 'Four';

  @override
  void initState() {
    super.initState();
    _checkedValues = <String>[_checkedValue3];
  }

  void showInSnackBar(String value) {}

  bool isChecked(String value) => _checkedValues.contains(value);

  void showCheckedMenuSelections(String value) {
    if (_checkedValues.contains(value)) {
      _checkedValues.remove(value);
    } else {
      _checkedValues.add(value);
    }
    showInSnackBar('Checked $_checkedValues');
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Theme.of(context).primaryColor,
      child: ListTile(
        title: const Text(
          'CheckedPopupMenuItem Demo',
          style: TextStyle(color: Colors.white),
        ),
        trailing: PopupMenuButton<String>(
          padding: EdgeInsets.zero,
          onSelected: showCheckedMenuSelections,
          icon: Icon(
            Icons.menu,
            color: Colors.white,
          ),
          itemBuilder: (BuildContext context) => <PopupMenuItem<String>>[
                CheckedPopupMenuItem<String>(
                    value: _checkedValue1,
                    checked: isChecked(_checkedValue1),
                    child: Text(_checkedValue1)),
                CheckedPopupMenuItem<String>(
                    value: _checkedValue2,
                    enabled: false,
                    checked: isChecked(_checkedValue2),
                    child: Text(_checkedValue2)),
                CheckedPopupMenuItem<String>(
                    value: _checkedValue3,
                    checked: isChecked(_checkedValue3),
                    child: Text(_checkedValue3)),
                CheckedPopupMenuItem<String>(
                    value: _checkedValue4,
                    checked: isChecked(_checkedValue4),
                    child: Text(_checkedValue4))
              ],
        ),
      ),
    );
  }
}
