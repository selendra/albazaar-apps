import 'package:flutter/material.dart';

class InteractView extends StatelessWidget {
  final String imgUrl;
  InteractView(this.imgUrl);
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Center(
        child: InteractiveViewer(
          maxScale: 5.0,
          child: FadeInImage(
              fit: BoxFit.cover,
              image: NetworkImage(
                imgUrl,
              ),
              placeholder: AssetImage('images/loading.gif')),
        ),
      ),
    );
  }
}
