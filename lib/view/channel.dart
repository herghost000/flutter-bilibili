import 'package:flutter/material.dart';

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
        leading: IconButton(icon: Icon(Icons.menu),onPressed: widget._leadPress,),
      ),
    );
  }
}
