import 'package:flutter/material.dart';
import 'dart:html' as html;

import 'package:selendra_marketplace_app/core/animation_styles/hover_animation.dart';

extension Hover on Widget {
  static final appContainer =
      html.window.document.getElementById('app-container');

  Widget get showCursorOnHover {
    return MouseRegion(
      child: this,
      onHover: (event) => appContainer.style.cursor = 'pointer',
      onExit: (event) => appContainer.style.cursor = 'default',
    );
  }

  Widget get hoverAnimation {
    return HoverAnimation(child: this);
  }
}
