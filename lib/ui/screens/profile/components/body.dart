import 'package:flutter/material.dart';
import 'package:multi_image_picker/multi_image_picker.dart';
import 'package:selendra_marketplace_app/all_export.dart';
import 'package:provider/provider.dart';

class Body extends StatefulWidget {
  @override
  _BodyState createState() => _BodyState();
}

class _BodyState extends State<Body> {
  bool _isLoading = false;
  List<Asset> _images = List<Asset>();

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
    } catch (e) {
      e.toString();
      //print(e);
    }
    if (!mounted) return;
    setState(() {
      _images = resultList;
    });
  }

  Widget build(BuildContext context) {
    // return buildDropDown();
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
                  ProfileForm(),
                ],
              ),
            ),
    );
  }

  String dropdownValue = 'one';
  Widget buildDropDown() {
    return DropdownButton<String>(
      value: dropdownValue,
      icon: Icon(Icons.arrow_downward),
      iconSize: 24,
      elevation: 16,
      style: TextStyle(color: Colors.deepPurple),
      underline: Container(
        height: 2,
        color: Colors.deepPurpleAccent,
      ),
      onChanged: (String newValue) {
        setState(() {
          dropdownValue = newValue;
        });
      },
      items: <String>['One', 'Two', 'Free', 'Four']
          .map<DropdownMenuItem<String>>((String value) {
        return DropdownMenuItem<String>(
          value: value,
          child: Text(value),
        );
      }).toList(),
    );
  }
}
