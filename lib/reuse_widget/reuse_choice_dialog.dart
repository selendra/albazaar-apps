import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'package:selendra_marketplace_app/constants.dart';
import 'package:flutter/services.dart';

enum Options { Camera, Gallery }

class ReuseChoiceDialog {
  File _myImage;
  final picker = ImagePicker();

  Future<void> choiceDialog(BuildContext context) async {
    switch (await showDialog<Options>(
      context: context,
      builder: (context) {
        return SimpleDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(kDefaultRadius),
          ),
          title: Text('Choose an option'),
          children: [
            Container(
              height: 40,
              child: SimpleDialogOption(
                child: Text('Camera'),
                onPressed: () {
                  cameraImage();
                },
              ),
            ),
            Container(
              height: 40,
              child: SimpleDialogOption(
                child: Text('Gallery'),
                onPressed: () {
                  galleryImage();
                },
              ),
            ),
          ],
        );
      },
    )) {
      case Options.Camera:
        cameraImage();
        break;
      case Options.Gallery:
        galleryImage();
        break;
    }
  }

  Future galleryImage() async {
    try {
      final pickedFile = await picker.getImage(source: ImageSource.gallery);

      _myImage = File(pickedFile.path);
      if (_myImage != null) {
        print('File: $_myImage');
        /*ApiPostServices().upLoadImage(_myImage).then((value){
          value.stream.transform(utf8.decoder).listen((data){

          });
        });*/

      }
    } on PlatformException {
      return null;
    }
  }

  Future cameraImage() async {
    try {
      final pickedFile = await picker.getImage(source: ImageSource.camera);
      _myImage = File(pickedFile.path);

      /*setState(() {
        _myImage = File(pickedFile.path);
      });*/
    } on PlatformException {
      return null;
    }
  }
}
