import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

enum ThumbAnimation {
  IN,
  OUT,
}

const DEFAULT_MIN_WIDTH = 6.0;
const DEFAULT_MAX_WIDTH = 15.0;
const DEFAULT_ANIMATION_LENGTH_MS = 200;
const DEFAULT_SCROLL_THUMB_COLOR = const Color(0xCC9E9E9E);
const DEFAULT_SCROLLBAR_COLOR = const Color(0x77FFFFFF);

class WebScroll extends StatefulWidget {
  ///Same ScrollController as the child widget's.
  final ScrollController controller;

  ///Child widget.
  final Widget child;

  ///The height of the child widget.
  final double visibleHeight;

  ///Lenght of the Thumb fade in out animations in milliseconds.
  final int animationLength;

  ///The color of the scroll thumb
  final Color scrollThumbColor;

  ///The background color of the scrollbar.
  final Color scrollbarColor;

  ///The width of the scrollbar, when it is 'hidden'
  final double scrollbarMinWidth;

  ///The width of the scrollbar, when it is 'showing'
  final double scrollbarMaxWidth;

  WebScroll({
    @required this.controller,
    @required this.child,
    @required this.visibleHeight,
    this.scrollbarMinWidth = DEFAULT_MIN_WIDTH,
    this.scrollbarMaxWidth = DEFAULT_MAX_WIDTH,
    this.animationLength = DEFAULT_ANIMATION_LENGTH_MS,
    this.scrollThumbColor = DEFAULT_SCROLL_THUMB_COLOR,
    this.scrollbarColor = DEFAULT_SCROLLBAR_COLOR,
  });

  @override
  _WebScrollState createState() => _WebScrollState();
}

class _WebScrollState extends State<WebScroll> {
  double offsetTop = 0;
  double ratio;
  double thumbHeight;
  double fullHeight;
  ThumbAnimation thumbAnimation = ThumbAnimation.IN;

  @override
  void initState() {
    widget.controller.addListener(() {
      setState(() {});
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    if (fullHeight == null) {
      Future.delayed(Duration.zero, () {
        setState(() {
          fullHeight = widget.controller.position.maxScrollExtent +
              widget.controller.position.viewportDimension;
        });
      });
      return widget.child;
    }

    final remainder = (fullHeight - widget.visibleHeight);

    if (remainder < 0) {
      return widget.child;
    }

    ratio = fullHeight / widget.visibleHeight;
    thumbHeight = (1 / ratio) * widget.visibleHeight;

    return _getAnimatedScrollbar();
  }

  Widget _getAnimatedScrollbar() {
    Tween tween;

    if (thumbAnimation == ThumbAnimation.OUT) {
      tween = Tween<double>(
          begin: widget.scrollbarMinWidth, end: widget.scrollbarMaxWidth);
    } else {
      tween = Tween<double>(
          begin: widget.scrollbarMaxWidth, end: widget.scrollbarMinWidth);
    }

    return TweenAnimationBuilder<double>(
      tween: tween,
      duration: Duration(milliseconds: widget.animationLength),
      curve: Curves.bounceIn,
      builder: (BuildContext cont, double width, Widget w) {
        return Stack(
          fit: StackFit.loose,
          alignment: Alignment.topRight,
          children: [
            widget.child,
            _getMouseRegion(_getScrollbarBackground(width)),
            _getScrollThumb(width),
          ],
        );
      },
    );
  }

  Widget _getMouseRegion(Widget child) {
    return MouseRegion(
      onEnter: (s) {
        setState(() {
          thumbAnimation = ThumbAnimation.OUT;
        });
      },
      onExit: (s) {
        setState(() {
          thumbAnimation = ThumbAnimation.IN;
        });
      },
      child: child,
    );
  }

  Widget _getScrollbarBackground(double width) {
    return Container(
      width: width,
      height: widget.visibleHeight,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(3),
        color: widget.scrollbarColor,
        border: Border.all(color: widget.scrollbarColor, width: 1),
      ),
    );
  }

  Widget _getScrollThumb(double width) {
    return Positioned(
      top: fullHeight != null ? calculateTop() : 0,
      child: _getMouseRegion(
        GestureDetector(
          onVerticalDragDown: (s) {
            offsetTop = widget.controller.offset.toDouble() -
                (s.localPosition.dy * ratio);
          },
          onVerticalDragUpdate: (dragDetails) {
            final newPosition =
                (dragDetails.localPosition.dy * ratio) + offsetTop;
            widget.controller.jumpTo(newPosition);
          },
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(3),
              color: widget.scrollThumbColor,
              border: Border.all(color: widget.scrollThumbColor, width: 1),
            ),
            width: width,
            height: thumbHeight,
          ),
        ),
      ),
    );
  }

  double calculateTop() {
    return (widget.visibleHeight / fullHeight) *
        widget.controller.position.extentBefore;
  }
}
