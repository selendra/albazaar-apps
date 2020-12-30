import 'package:flutter/material.dart';
import 'package:flutter_absolute_path/flutter_absolute_path.dart';
import 'package:selendra_marketplace_app/all_export.dart';
import 'package:selendra_marketplace_app/ui/screens/profile/components/body.dart';

import '../../../all_export.dart';
import '../../../all_export.dart';

class ProfileScreen extends StatefulWidget {
  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen>
    with SingleTickerProviderStateMixin {
  TabController _controller;

  @override
  void initState() {
    super.initState();
    _controller = new TabController(vsync: this, length: 6);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: ReuseSimpleAppBar.getItem('Profile', context),
      body: Responsive(
        desktop: ReuseDesktop(
          widget: ProfileDesktop(),
        ),
        mobile: Body(),
      ),
    );
  }
}

class ProfileDesktop extends StatefulWidget {
  @override
  _ProfileDesktopState createState() => _ProfileDesktopState();
}

class _ProfileDesktopState extends State<ProfileDesktop> {
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
          : SingleChildScrollView(
              child: Container(
                height: MediaQuery.of(context).size.height,
                width: MediaQuery.of(context).size.width,
                child: Column(
                  children: <Widget>[
                    Responsive.isDesktop(context)
                        ? const SizedBox(
                            height: 40,
                          )
                        : SizedBox(),
                    Responsive.isDesktop(context)
                        ? Consumer<UserProvider>(
                            builder: (context, value, child) => Stack(
                              children: [
                                Container(
                                  height: 120,
                                  width: 120,
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    image: DecorationImage(
                                      image: value.mUser.profileImg != null
                                          ? NetworkImage(value.mUser.profileImg)
                                          : AssetImage('images/avatar.png'),
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                ),
                                Positioned(
                                  top: 90,
                                  left: 90,
                                  child: InkWell(
                                    onTap: () => loadAsset(),
                                    child: Container(
                                      height: 30.0,
                                      width: 30.0,
                                      decoration: BoxDecoration(
                                        shape: BoxShape.circle,
                                        color: Colors.grey.withOpacity(0.7),
                                      ),
                                      child: Icon(
                                        Icons.edit,
                                        color: Theme.of(context).primaryColor,
                                        size: 20.0,
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          )
                        : Container(
                            margin: const EdgeInsets.only(
                              left: 10.0,
                              right: 10.0,
                              top: 10.0,
                            ),
                            child: Card(
                              shape: kDefaultShape,
                              elevation: 0,
                              child: Container(
                                margin:
                                    const EdgeInsets.symmetric(horizontal: 10),
                                child: ListTile(
                                  onTap: () => loadAsset(),
                                  title: Text(AppLocalizeService.of(context)
                                      .translate('profile_photo')),
                                  trailing: Consumer<UserProvider>(
                                    builder: (context, value, child) =>
                                        CircleAvatar(
                                      backgroundImage: value.mUser.profileImg !=
                                              null
                                          ? NetworkImage(value.mUser.profileImg)
                                          : AssetImage('images/avatar.png'),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                    Responsive.isDesktop(context)
                        ? const SizedBox(
                            height: 30,
                          )
                        : SizedBox(),
                    ProfileForm(
                      imageUrl == null ? user.profileImg : imageUrl,
                    ),
                  ],
                ),
              ),
            ),
    );
  }
}
