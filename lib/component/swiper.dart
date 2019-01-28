import 'package:flutter/material.dart';

class Swiper extends StatefulWidget {
  @override
  _SwiperState createState() => _SwiperState();
}

class _SwiperState extends State<Swiper> {
  final PageController _pageController = new PageController();
  double _currentPage = 0.0;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 116.0,
      color: Colors.white,
      child: LayoutBuilder(builder: (BuildContext context, BoxConstraints constraints){
        return NotificationListener(
          onNotification: (ScrollNotification note) {
            setState(() {
              _currentPage = _pageController.page;
            });
          },
          child: Container(
            color: Colors.black,
            child: PageView.custom(
              physics: const PageScrollPhysics(
                  parent: const BouncingScrollPhysics()),
              controller: _pageController,
              childrenDelegate: SliverChildBuilderDelegate(
                    (context, index) => _SimplePage(
                  '$index',
                  parallaxOffset:
                  constraints.maxWidth / 2.0 * (index - _currentPage),
                  // 小字 Text 在页面滑动时要比整体移动速度快一倍，所以小字的 translate X 为 \tt{pageWidth / 2 * progress} 。
                ),
                childCount: 10,
              ),
            ),
          ),
        );
      }),
    );
  }
}

class _SimplePage extends StatelessWidget {
  _SimplePage(this.data, {Key key, this.parallaxOffset = 0.0})
      : super(key: key);

  final String data;
  final double parallaxOffset;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        Container(
          color: Colors.black,
          padding: EdgeInsets.all(10.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              new Text(
                data,
                style: const TextStyle(fontSize: 60.0,color: Colors.white),
              ),
              new Transform(
                transform:
                new Matrix4.translationValues(parallaxOffset, 0.0, 0.0),
                child: const Text('左右滑动，这是第二行滚动速度更快的小字',style: const TextStyle(fontSize: 16.0,color: Colors.white),),
              ),
            ],
          ),
        )
      ],
    );
  }

}
