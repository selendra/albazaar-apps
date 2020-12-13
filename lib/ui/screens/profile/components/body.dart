import 'package:flutter/material.dart';
import 'package:multi_image_picker/multi_image_picker.dart';
import 'package:selendra_marketplace_app/all_export.dart';
import 'package:flutter_absolute_path/flutter_absolute_path.dart';

class Body extends StatefulWidget {
  @override
  _BodyState createState() => _BodyState();
}

class _BodyState extends State<Body> {
  bool _isLoading = false;

  String imageUrl;
  Future<void> loadAsset() async {
    List<Asset> resultList = List<Asset>();

    try {
      resultList = await MultiImagePicker.pickImages(
        enableCamera: false,
        cupertinoOptions: CupertinoOptions(takePhotoIcon: "chat"),
        maxImages: 1,
        materialOptions: MaterialOptions(
          actionBarColor: '#${kDefaultColor.value.toRadixString(16)}',
          actionBarTitle: "Selendra App",
          allViewTitle: "All Photos",
          useDetailsView: false,
          selectCircleStrokeColor: "#000000",
        ),
      );
      getAssettoFile(resultList);
    } catch (e) {
      e.toString();
      //print(e);
    }
    if (!mounted) return;
  }

  Future<void> getAssettoFile(List<Asset> resultList) async {
    for (Asset asset in resultList) {
      final filePath =
          await FlutterAbsolutePath.getAbsolutePath(asset.identifier);
      if (filePath != null) {
        await Provider.of<UserProvider>(context, listen: false)
            .upLoadImage(File(filePath))
            .then((value) {
          setState(() {
            imageUrl = json.decode(value)['uri'];
            Provider.of<UserProvider>(context, listen: false).mUser.profileImg =
                imageUrl;
          });
        });
      }
    }
  }

  Widget build(BuildContext context) {
    // return buildDropDown();
    var user = Provider.of<UserProvider>(context).mUser;
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
                    margin: const EdgeInsets.only(
                      left: 10.0,
                      right: 10.0,
                      top: 10.0,
                    ),
                    child: Card(
                      shape: kDefaultShape,
                      elevation: 0,
                      child: Container(
                        margin: const EdgeInsets.symmetric(horizontal: 10),
                        child: ListTile(
                          onTap: () => loadAsset(),
                          title: Text(AppLocalizeService.of(context)
                              .translate('profile_photo')),
                          trailing: Consumer<UserProvider>(
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
                  ProfileForm(
                    imageUrl == null ? user.profileImg : imageUrl,
                  ),
                ],
              ),
            ),
    );
  }
}
