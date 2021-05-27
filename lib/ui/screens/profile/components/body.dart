import 'package:albazaar_app/core/models/profile_m.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:multi_image_picker/multi_image_picker.dart';
import 'package:albazaar_app/all_export.dart';
import 'package:flutter_absolute_path/flutter_absolute_path.dart';

class Body extends StatefulWidget {

  final ProfileModel profileModel;

  Body({this.profileModel});

  @override
  _BodyState createState() => _BodyState();
}

class _BodyState extends State<Body> {

  bool _isLoading = false;
  String imageUrl;

  Future<void> loadAsset() async {

    List<Asset> resultList = List<Asset>.empty(growable: true);

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
      final filePath = await FlutterAbsolutePath.getAbsolutePath(asset.identifier);
      if (filePath != null) {
        await Provider.of<UserProvider>(context, listen: false).upLoadImage(File(filePath)).then((value) {
          setState(() {
            imageUrl = json.decode(value)['uri'];
            Provider.of<UserProvider>(context, listen: false).mUser.profileImg = imageUrl;
          });
        });
      }
    }
  }

  Widget build(BuildContext context) {
    var user = Provider.of<UserProvider>(context).mUser;
    return SingleChildScrollView(
      physics: BouncingScrollPhysics(),
      child: _isLoading
      ? Container(
          height: MediaQuery.of(context).size.height,
          child: Center(
            child: CircularProgressIndicator(),
          ),
        )
      : Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        padding: EdgeInsets.only(
          left: 54, right: 54
        ),
        child: Column(
          // mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            MyCard(
              hexaColor: AppColors.secondary,
              width: 100, height: 100,
              child: SvgPicture.asset('assets/avatar_user.svg'),
              mBottom: 20,
              mTop: 50,
            ),

            MyText(
              text: "${widget.profileModel.first.text} ${widget.profileModel.last.text.isEmpty ? ' ' : widget.profileModel.last.text}${widget.profileModel.last.text}", 
              fontSize: 25,
              fontWeight: FontWeight.bold,
              bottom: 50,
            ),
            
            Container(
              margin: EdgeInsets.only(bottom: 20),
              child: Row(
                children: [
                  SvgPicture.asset("${AppConfig.iconPath}gender.svg", color: AppServices.hexaCodeToColor(AppColors.secondary), width: 30, height: 30,),
                  MyText(
                    left: 12,
                    text: "${widget.profileModel.mGender}",
                  )
                ],
              ),
            ),

            Container(
              margin: EdgeInsets.only(bottom: 20),
              child: Row(
                children: [
                  SvgPicture.asset("${AppConfig.iconPath}location.svg", color: AppServices.hexaCodeToColor(AppColors.secondary), width: 30, height: 30),
                  MyText(
                    left: 12,
                    text: "${widget.profileModel.address.text}",
                  )
                ],
              ),
            ),

            Container(
              margin: EdgeInsets.only(bottom: 20),
              child: Row(
                children: [
                  SvgPicture.asset("${AppConfig.iconPath}phone-call.svg", color: AppServices.hexaCodeToColor(AppColors.secondary), width: 30, height: 30),
                  MyText(
                    left: 12,
                    text: "${widget.profileModel.phone.text}",
                  )
                ],
              ),
            ),
            
            Container(
              margin: EdgeInsets.only(bottom: 20),
              child: Row(
                children: [
                  SvgPicture.asset("${AppConfig.iconPath}mail.svg", color: AppServices.hexaCodeToColor(AppColors.secondary), width: 30, height: 30),
                  MyText(
                    left: 12,
                    text: "${widget.profileModel.email.text}",
                  )
                ],
              ),
            ),

            Container(
              margin: EdgeInsets.only(bottom: 70),
              child: Row(
                children: [
                  SvgPicture.asset("${AppConfig.iconPath}goods.svg", color: AppServices.hexaCodeToColor(AppColors.secondary), width: 30, height: 30),
                  MyText(
                    left: 12,
                    text: "830 Products",
                  )
                ],
              ),
            ),

            MyFlatButton(
              child: MyText(
                pTop: 20,
                pBottom: 20,
                text: "Edit profile"
              ),
              buttonColor: AppColors.secondary,
              action: (){
                Navigator.push(context, MaterialPageRoute(builder: (context) => ProfileForm(imageUrl: '', profileModel: widget.profileModel,)));
              }
            )
            
            // Container(
            //   margin: const EdgeInsets.only(
            //     left: 10.0,
            //     right: 10.0,
            //     top: 10.0,
            //   ),
            //   child: Card( 
            //     shape: kDefaultShape,
            //     elevation: 0,
            //     child: Container(
            //       margin: const EdgeInsets.symmetric(horizontal: 10),
            //       child: ListTile(
            //         onTap: () => loadAsset(),
            //         title: Text(AppLocalizeService.of(context)
            //             .translate('profile_photo')),
            //         trailing: Consumer<UserProvider>(
            //           builder: (context, value, child) => CircleAvatar(
            //             backgroundImage: value.mUser.profileImg != ''
            //                 ?NetworkImage(value.mUser.profileImg)
            //                 : AssetImage('assets/avatar.png'),
            //           ),
            //         ),
            //       ),
            //     ),
            //   ),
            // ),
            // ProfileForm(
            //   imageUrl == null ? user.profileImg : imageUrl,
            // ),
          ],
        ),
      ),
    );
  }
}
