import 'package:albazaar_app/all_export.dart';
import 'package:flutter_absolute_path/flutter_absolute_path.dart';

class MyImagePicker {

  static Future<List> imagePicker({int maxImages = 1}) async {
    return await MultiImagePicker.pickImages(
      enableCamera: false,
      cupertinoOptions: CupertinoOptions(takePhotoIcon: "chat"),
      maxImages: maxImages,
      materialOptions: MaterialOptions(
        actionBarColor: '#${kDefaultColor.value.toRadixString(16)}',
        actionBarTitle: "Albazaar Apps",
        allViewTitle: "All Photos",
        useDetailsView: false,
        selectCircleStrokeColor: "#000000",
      ),
    );
  }

  static Future<List<String>> getAssettoFile(List<Asset> resultList) async {
    List<String> _filePath = [] ;
    for (Asset asset in resultList) {
      _filePath.add(await FlutterAbsolutePath.getAbsolutePath(asset.identifier));
    }
    return _filePath;
  }
}