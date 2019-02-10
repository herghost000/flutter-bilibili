import 'package:flutter/material.dart';
import 'package:flutter/gestures.dart';

class Comment extends StatefulWidget {
  @override
  _CommentState createState() => _CommentState();
}

class _CommentState extends State<Comment> with TickerProviderStateMixin{
  final ScrollController _scrollController = new ScrollController(initialScrollOffset: 0.0);

  @override
  void initState() {
    super.initState();
    _scrollController..addListener(() {
      print(_scrollController.position.pixels);
    });
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onVerticalDragUpdate: (DragUpdateDetails details){
        _scrollController.jumpTo(_scrollController.position.pixels + -details.delta.dy);
      },
      onVerticalDragEnd: (DragEndDetails details){
        print(details.velocity.pixelsPerSecond);
        AnimationController m = AnimationController(vsync: this);
        VelocityTracker v = VelocityTracker();
        m.addListener((){
          _scrollController.jumpTo(_scrollController.position.pixels - details.primaryVelocity);
          print('value:${m.value}-${details.primaryVelocity}-${details.velocity.pixelsPerSecond.direction}');
        });
        m.fling(velocity: details.velocity.pixelsPerSecond.dy);
//        m.forward();
      },
      child: ListView.builder(
        physics: new NeverScrollableScrollPhysics(),
        controller: _scrollController,
        itemExtent: 250.0,
        itemBuilder: (context, index) => Container(
          padding: EdgeInsets.all(10.0),
          child: Material(
            elevation: 4.0,
            borderRadius: BorderRadius.circular(5.0),
            color: index % 2 == 0 ? Colors.cyan : Colors.deepOrange,
            child: Center(
              child: Text(index.toString()),
            ),
          ),
        ),
      ),
    );
  }
}
