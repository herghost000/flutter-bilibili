import 'package:flutter/material.dart';

class Comment extends StatefulWidget {
  @override
  _CommentState createState() => _CommentState();
}

class _CommentState extends State<Comment> {
  final ScrollController _scrollController = new ScrollController(initialScrollOffset: 0.0);

  @override
  void initState() {
    super.initState();
//    _scrollController..addListener(() {
//      _scrollController.jumpTo(0.0);
//    });
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
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
