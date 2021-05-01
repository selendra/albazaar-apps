import 'dart:async';

import 'package:geolocator/geolocator.dart';
import 'package:http/http.dart';
import 'package:albazaar_app/all_export.dart';
import 'package:latlong/latlong.dart';

class AppServices {
  
  static Color hexaCodeToColor(String hexaCode) {
    return Color(convertHexaColor(hexaCode));
  }

  static int convertHexaColor(String colorhexcode) { /* Convert Hexa Color */
    String colornew = '0xff' + colorhexcode;
    colornew = colornew.replaceAll('#', '');
    int colorint = int.parse(colornew);
    return colorint;
  }

  static String getDataFromStream(StreamedResponse stream, AddProduct addProduct){
    String value;
    stream.stream.transform(utf8.decoder).listen((data){
      value = json.decode(data)['uri'];
    });
    // Wait 500 milliseconds For Add Data To Value Before Return
    Timer(Duration(milliseconds: 500), (){});
    return value;
  }

  static String removeZero(String number){
    if (number.startsWith("0")){
      number = number.replaceRange(0, 1, '');
    }
    return number;
  }

  static Future<void> clearStorage() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    await sharedPreferences.clear();
  }

  static Future<String> getLocation(double lat, double long) async {

    String location;
    await Geolocator().placemarkFromCoordinates(lat, long).then((value) {
      location = "${value[0].thoroughfare}, ${value[0].subAdministrativeArea}, ${value[0].subLocality}, ${value[0].locality}";
    });

    return location;
  }

  static Future<Position> getLatLng() async {
    Position position = await Geolocator().getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
    return position;
  }

  static void mapAnimateMove(MapController mapController, LatLng desPlace, double desZoom, TickerProvider vsync){
    var _latTween = Tween<double>(begin: mapController.center.latitude, end: desPlace.latitude);

    var _longTween = Tween<double>(begin: mapController.center.longitude, end: desPlace.longitude);

    var _zoomTween = Tween<double>(begin: mapController.zoom, end: desZoom);

    var controller = AnimationController(duration: const Duration(milliseconds: 300), vsync: vsync);

    Animation<double> animation = CurvedAnimation(parent: controller, curve: Curves.fastOutSlowIn);
    controller.addListener(() {
      mapController.move(LatLng(_latTween.evaluate(animation), _longTween.evaluate(animation)), _zoomTween.evaluate(animation));
    });

    animation.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        controller.dispose();
      } else if (status == AnimationStatus.dismissed) {
        controller.dispose();
      }
    });

    controller.forward();
  }

  static void markPin(LocationMarker marker, double lat, double long){
    marker.markers.add(Marker(
      point: LatLng(lat, long),
      builder: (context) => Container(
        child: Icon(
          Icons.location_on,
          color: AppServices.hexaCodeToColor(AppColors.secondary),
          size: 50,
        ),
      ),
    ));
  }
  
}