import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:selendra_marketplace_app/all_export.dart';
import 'package:provider/provider.dart';

class Body extends StatefulWidget {
  @override
  _BodyState createState() => _BodyState();
}

class _BodyState extends State<Body> {
  bool _isLoading = false;
  File _myImage;
  final picker = ImagePicker();

  Future galleryImage() async {
    try {
      final pickedFile = await picker.getImage(source: ImageSource.gallery);

      if (_myImage != null) {
        print('File: $_myImage');
        /*ApiPostServices().upLoadImage(_myImage).then((value){
          value.stream.transform(utf8.decoder).listen((data){

          });
        });*/
        setState(() {
          _myImage = File(pickedFile.path);
        });
      }
      Navigator.pop(context);
    } on PlatformException {
      return null;
    }
  }

  Future cameraImage() async {
    try {
      final pickedFile = await picker.getImage(source: ImageSource.camera);

      setState(() {
        _myImage = File(pickedFile.path);
      });
    } on PlatformException {
      return null;
    }
  }

  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: _isLoading
          ? Container(
              height: MediaQuery.of(context).size.height,
              child: Center(
                child: CircularProgressIndicator(),
              ),
            )
          : Container(
              width: double.infinity,
              child: Column(
                children: <Widget>[
                  Container(
                    margin: EdgeInsets.only(left: 10.0, right: 10.0, top: 10.0),
                    child: Card(
                      shape: kDefaultShape,
                      elevation: 0,
                      child: Container(
                        margin: EdgeInsets.symmetric(horizontal: 10),
                        child: ListTile(
                          onTap: () async {
                            final pickedFile = await picker.getImage(
                                source: ImageSource.gallery);
                            setState(() {
                              _myImage = File(pickedFile.path);
                            });
                            //choiceDialog();
                            // ReuseChoiceDialog().choiceDialog(
                            //     context, galleryImage, cameraImage);
                          },
                          title: Text(AppLocalizeService.of(context)
                              .translate('profile_photo')),
                          trailing: Consumer<ApiGetServices>(
                            builder: (context, value, child) => CircleAvatar(
                              backgroundImage: value.mUser.profileImg != null
                                  ? NetworkImage(value.mUser.profileImg)
                                  : AssetImage('images/avatar.png'),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  ProfileForm(),
                ],
              ),
            ),
    );
  }
}
