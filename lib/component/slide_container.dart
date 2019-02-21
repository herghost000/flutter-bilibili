import 'package:flutter/gestures.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter/material.dart';

/// the direction drawer opens from.
enum SlideDirection {
  left,
  right,
  top,
  bottom,
}

class SlideStack extends StatefulWidget {
  /// The main widget.
  final SlideContainer child;

  /// The drawer hidden below.
  final Widget drawer;

  const SlideStack({
    @required this.child,
    @required this.drawer,
  }) : super();

  @override
  State<StatefulWidget> createState() => _StackState();
}

class _StackState extends State<SlideStack> {
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        widget.drawer,
        widget.child,
      ],
    );
  }
}

/// 可以滑动的容器。
///
/// 拖动手势结束时将自动完成幻灯片动画。
class SlideContainer extends StatefulWidget {
  final Widget child;

  /// 抽屉从哪个方向打开。
  final SlideDirection slideDirection;

  /// 默认为持续时间（毫秒：250）
  final Duration autoSlideDuration;

  /// 当slideDirection向左或向右时，这意味着抽屉的宽度。
  /// 当slideDirection为top或bottom时，这意味着抽屉的高度。
  final double drawerSize;

  /// 如果拖动手势足够快，它将自动完成幻灯片。
  final double minAutoSlideDragVelocity;

  /// 如果拖动手势比[minAutoSlideDragVelocity]慢并且滑动距离小于[minAutoSlideDistance]，
  /// 容器回到起始位置。
  ///
  ///
  /// 否则容器移动到[drawerSize]（抽屉全开）。
  ///
  /// Default to be [drawerSize] * 0.5.
  final double minAutoSlideDistance;

  /// 拖动手势的阻尼系数。
  /// 该值应等于或高于1.0。
  final double dragDampening;

  /// 抽屉开始打开时调用。
  final VoidCallback onSlideStarted;

  /// 抽屉完全打开时调用。
  final VoidCallback onSlideCompleted;

  /// 取消拖动手势时调用（容器返回到起始位置）。
  final VoidCallback onSlideCanceled;

  /// 每次滑动手势处于活动状态时调用。
  ///
  /// 返回抽屉在0.0和1.0之间的位置（取决于动画的进度）。
  final ValueChanged<double> onSlide;

  final Matrix4 transform;

  SlideContainer({
    Key key,
    @required this.child,
    this.slideDirection = SlideDirection.left,
    this.minAutoSlideDragVelocity = 600.0,
    this.autoSlideDuration = const Duration(milliseconds: 250),
    this.dragDampening = 1.0,
    this.minAutoSlideDistance,
    this.drawerSize,
    this.onSlideStarted,
    this.onSlideCompleted,
    this.onSlideCanceled,
    this.onSlide,
    this.transform,
  })  : assert(child != null),
        assert(slideDirection != null),
        assert(minAutoSlideDragVelocity != null),
        assert(autoSlideDuration != null),
        assert(dragDampening != null && dragDampening >= 1.0),
        super(key: key);

  @override
  ContainerState createState() => ContainerState();
}

class ContainerState extends State<SlideContainer>
    with TickerProviderStateMixin {
  final Map<Type, GestureRecognizerFactory> gestures =
      <Type, GestureRecognizerFactory>{};

  // 用户的手指移动值。
  double dragValue = 0.0;

  // How long should the container move (relate to the [dragDampening])
  //容器应该移动多长时间（与[dragDampening]相关）
  double dragTarget = 0.0;
  bool isFirstDragFrame;
  AnimationController animationController;
  Ticker fingerTicker;

  bool get isSlideVertical {
    return widget.slideDirection == SlideDirection.top ||
        widget.slideDirection == SlideDirection.bottom;
  }

  double get maxDragDistance {
    return widget.drawerSize ??
        (isSlideVertical
            ? MediaQuery.of(context).size.height
            : MediaQuery.of(context).size.width);
  }

  double get minAutoSlideDistance =>
      widget.minAutoSlideDistance ?? maxDragDistance * 0.5;

  // The translation offset of the container.(decides the position of the container)
  //容器的平移偏移量（决定容器的位置）
  double get containerOffset =>
      animationController.value * maxDragDistance * dragTarget.sign;

  @override
  void initState() {
    animationController =
        AnimationController(vsync: this, duration: widget.autoSlideDuration)
          ..addListener(() {
            if (widget.onSlide != null)
              widget.onSlide(animationController.value);
            setState(() {});
          });

    fingerTicker = createTicker((_) {
//      print('${dragValue}');
      if ((dragValue - dragTarget).abs() <= 1.0) {
        dragTarget = dragValue;
      } else {
        dragTarget += (dragValue - dragTarget) / widget.dragDampening;
      }
      animationController.value = dragTarget.abs() / maxDragDistance;
    });

    _registerGestureRecognizer();

    super.initState();
  }

  @override
  void dispose() {
    animationController?.dispose();
    fingerTicker?.dispose();
    super.dispose();
  }

  GestureRecognizerFactoryWithHandlers<T>
      createGestureRecognizer<T extends DragGestureRecognizer>(
          GestureRecognizerFactoryConstructor<T> constructor) {
    return GestureRecognizerFactoryWithHandlers<T>(
      constructor,
      (T instance) {
        instance
          ..onStart = handleDragStart
          ..onUpdate = handleDragUpdate
          ..onEnd = handleDragEnd;
      },
    );
  }

  void _registerGestureRecognizer() {
    if (isSlideVertical) {
      gestures[VerticalDragGestureRecognizer] =
          createGestureRecognizer<VerticalDragGestureRecognizer>(
              () => VerticalDragGestureRecognizer());
    } else {
      gestures[HorizontalDragGestureRecognizer] =
          createGestureRecognizer<HorizontalDragGestureRecognizer>(
              () => HorizontalDragGestureRecognizer());
    }
  }

  double getVelocity(DragEndDetails details) => isSlideVertical
      ? details.velocity.pixelsPerSecond.dy
      : details.velocity.pixelsPerSecond.dx;

  double getDelta(DragUpdateDetails details) =>
      isSlideVertical ? details.delta.dy : details.delta.dx;

  void openOrClose() {
    final AnimationStatus status = animationController.status;
    final bool isOpen = status == AnimationStatus.completed ||
        status == AnimationStatus.forward;
    // Reset dragTarget in close state. It's import!!!
    // Or the containerOffset value will be zero.
    dragTarget = isOpen ? dragTarget : 1.0;
    animationController.fling(velocity: isOpen ? -2.0 : 2.0).then((_) {
      print(
          "animationController.value:${animationController.value},dragTarget:$dragTarget");
    });
  }

  void _completeSlide() => animationController.forward().then((_) {
        if (widget.onSlideCompleted != null) widget.onSlideCompleted();
      });

  void _cancelSlide() => animationController.reverse().then((_) {
        if (widget.onSlideCanceled != null) widget.onSlideCanceled();
      });

  void handleDragStart(DragStartDetails details) {
    isFirstDragFrame = true;
    dragValue = animationController.value * maxDragDistance * dragTarget.sign;
    dragTarget = dragValue;
    fingerTicker.start();
    if (widget.onSlideStarted != null) widget.onSlideStarted();
  }

  void handleDragUpdate(DragUpdateDetails details) {
    if (isFirstDragFrame) {
      isFirstDragFrame = false;
      return;
    }
//    print('${dragValue}-${dragTarget}');
    dragValue = (dragValue + getDelta(details))
        .clamp(-maxDragDistance, maxDragDistance);
    if (widget.slideDirection == SlideDirection.top ||
        widget.slideDirection == SlideDirection.left) {
      dragValue = dragValue.clamp(0.0, maxDragDistance);
    } else if (widget.slideDirection == SlideDirection.bottom ||
        widget.slideDirection == SlideDirection.right) {
      dragValue = dragValue.clamp(-maxDragDistance, 0.0);
    }
  }

  void handleDragEnd(DragEndDetails details) {
//    print('${getVelocity(details)}-${dragTarget.sign}-${dragTarget}');
    if (getVelocity(details) * dragTarget.sign >
        widget.minAutoSlideDragVelocity) {
      _completeSlide();
    } else if (getVelocity(details) * dragTarget.sign <
        -widget.minAutoSlideDragVelocity) {
      _cancelSlide();
    } else {
      dragTarget.abs() > minAutoSlideDistance
          ? _completeSlide()
          : _cancelSlide();
    }
    fingerTicker.stop();
  }

  Widget _getContainer() {
    return Container(
      child: widget.child,
      transform: widget.transform,
    );
  }

  @override
  Widget build(BuildContext context) => RawGestureDetector(
        gestures: gestures,
        child: Transform.translate(
          offset: isSlideVertical
              ? Offset(
                  0.0,
                  containerOffset,
                )
              : Offset(
                  containerOffset,
                  0.0,
                ),
          child: _getContainer(),
        ),
      );
}
