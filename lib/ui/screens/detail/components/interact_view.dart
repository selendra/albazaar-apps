import 'package:flutter/material.dart';
import 'package:selendra_marketplace_app/all_export.dart';

class InteractView extends StatelessWidget {
  final String imgUrl;
  InteractView(this.imgUrl);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        leading: IconButton(
          icon: Icon(Icons.clear),
          color: Colors.white,
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: Container(
        color: Colors.black,
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
      ),
    );
  }
}
