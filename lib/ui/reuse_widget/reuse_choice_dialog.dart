import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:selendra_marketplace_app/core/constants/constants.dart';
import 'package:selendra_marketplace_app/core/services/app_localize_service.dart';

enum Options { Camera, Gallery }

class ReuseChoiceDialog {
  final picker = ImagePicker();

  Future<void> choiceDialog(
      BuildContext context, Function galleryImage, Function cameraImage,
      {int index}) async {
    switch (await showDialog<Options>(
      context: context,
      builder: (context) {
        return SimpleDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(kDefaultRadius),
          ),
          title: Text(
              AppLocalizeService.of(context).translate('choose_an_option')),
          children: [
            Container(
              height: 40,
              child: SimpleDialogOption(
                child: Text(AppLocalizeService.of(context).translate('camera')),
                onPressed: () {
                  cameraImage();
                },
              ),
            ),
            Container(
              height: 40,
              child: SimpleDialogOption(
                child:
                    Text(AppLocalizeService.of(context).translate('gallery')),
                onPressed: () {
                  galleryImage(index);
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
        galleryImage(index);
        break;
    }
  }

  /* Future galleryImage() async {
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
*/

}
