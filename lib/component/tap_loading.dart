import 'package:flutter/material.dart';

typedef TapCallback = Function(AnimationController controller);

class TapLoading extends StatefulWidget {
  TapLoading({Key key}):super(key: key);
  @override
  _TapLoading createState() => _TapLoading();
}

class _TapLoading extends State<TapLoading> with SingleTickerProviderStateMixin {
  AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = new AnimationController(
        vsync: this, duration: const Duration(milliseconds: 400))
      ..addStatusListener((status) {
        if (status == AnimationStatus.completed) {
          _controller.reset();
//          _controller.forward();
        }
      });
  }

  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);
    return InkWell(
      splashColor: Colors.pink[50],
      highlightColor: Colors.pink[50],
      onTap: () {
        _controller.forward();
      },
        child: Container(
          height: 40.0,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              RotationTransition(
                  turns: _controller,
                  child: Icon(
                    Icons.refresh,
                    color: Colors.pink[300],
                    size: 22.0,
                  )),
              Padding(padding: EdgeInsets.only(left: 2.0),child: Text('换一换',style: TextStyle(color: Colors.pink[300]),))
            ],
          ),
        ),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}
