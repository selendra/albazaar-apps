import 'package:flutter/material.dart';
import 'package:multi_image_picker/multi_image_picker.dart';
import 'package:selendra_marketplace_app/all_export.dart';

class ImageList extends StatelessWidget {
  final List<Asset> images;
  ImageList(this.images);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: ReuseSimpleAppBar.getItem('All Images', context),
      body: Container(
        margin: EdgeInsets.all(5.0),
        child: ListView.builder(
          itemCount: images.length,
          itemBuilder: (context, index) {
            return AssetThumb(
              quality: 100,
              asset: images[index],
              height: 600,
              width: 600,
            );
          },
        ),
      ),
    );
  }
}
