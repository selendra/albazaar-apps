import 'package:flutter/material.dart';

class ReuseIconBadge extends StatelessWidget {
  final Function _func;
  final IconData _icon;
  final Color _color;
  final double _size;

  ReuseIconBadge(this._func, this._icon, this._color, this._size);
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        IconButton(
          icon: Icon(
            _icon,
            color: _color,
          ),
          iconSize: _size,
          onPressed: () {
            _func();
          },
        ),
        Positioned(
          top: 0.0,
          right: 0.0,
          child: Container(
            margin: const EdgeInsets.symmetric(horizontal: 7, vertical: 2),
            child: Icon(
              Icons.brightness_1,
              color: Colors.red,
              size: 20.0,
            ),
          ),
        ),
      ],
    );
  }
}
