import 'package:selendra_marketplace_app/all_export.dart';

class CustomAnimation{

  static Widget flareAnimation(FlareController flareControls, String filePath, String animation){
    return FlareActor(
      filePath,
      alignment: Alignment.center,
      fit: BoxFit.cover,
      animation: animation,
      controller: flareControls,
    );
  }
}