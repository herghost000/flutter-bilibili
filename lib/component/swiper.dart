import 'package:flutter/material.dart';
import 'infinity_page_view.dart';
import 'dart:async';

class Swiper extends StatefulWidget {
  Swiper({
    Key key,
    double radius = 0.0
  }):_radius = radius,super(key: key);
  final double _radius;
  @override
  _SwiperState createState() => _SwiperState();
}

class _SwiperState extends State<Swiper> with SingleTickerProviderStateMixin {
  String label;
  int itemCount;
  InfinityPageController infinityPageController;

  @override
  void initState() {
    super.initState();
    infinityPageController = new InfinityPageController(initialPage: 0);
    itemCount = 3;
    label = "1/${itemCount}";
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(0.0),
      child: Stack(
        children: <Widget>[
          Container(
            width: double.infinity,
            height: 116.0,
            child: LayoutBuilder(
                builder: (BuildContext context, BoxConstraints constraints) {
              return NotificationListener(
                onNotification: (ScrollNotification note) {},
                child: Container(
                    child: new InfinityPageView(
                  itemBuilder: (BuildContext context, int index) {
                    switch (index) {
                      case 0:
                        return Container(
                          child: ClipRRect(
                            borderRadius: BorderRadius.all(Radius.circular(widget._radius)),
                            child: Image.asset(
                              'assets/images/10.webp',
                              fit: BoxFit.fill,

                            ),
                          ),
                        );
                      case 1:
                        return ClipRRect(
                          borderRadius: BorderRadius.all(Radius.circular(widget._radius)),
                          child: Image.asset(
                            'assets/images/11.webp',
                            fit: BoxFit.cover,

                          ),
                        );
                    }
                    return ClipRRect(
                      borderRadius: BorderRadius.all(Radius.circular(widget._radius)),
                      child: Image.asset(
                        'assets/images/12.webp',
                        fit: BoxFit.cover,

                      ),
                    );
                  },
                  itemCount: itemCount,
                  onPageChanged: (int index) {
                    setState(() {
                      label = "${index + 1}/${itemCount}";
                    });
                  },
                  controller: infinityPageController,
                )),
              );
            }),
          ),
          Positioned(right: 0.0, bottom: 0.0, child: Text("666"))
        ],
      ),
    );
  }
}
