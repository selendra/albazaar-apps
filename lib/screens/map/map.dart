import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:geolocator/geolocator.dart';
import 'package:latlong/latlong.dart';
import 'package:expandable_bottom_sheet/expandable_bottom_sheet.dart';
import 'package:selendra_marketplace_app/reuse_widget/reuse.inkwell.dart';
import 'package:selendra_marketplace_app/constants.dart';
import 'package:selendra_marketplace_app/services/auth/api_get_services.dart';
import 'type_head.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MapScreen extends StatefulWidget {
  @override
  _MapScreenState createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  MapController _mapController = MapController();
  Position _currentPosition;
  String locate;
  GlobalKey<ExpandableBottomSheetState> _key = GlobalKey();

  moveCamera(double lat, double lng) {
    if (_currentPosition.latitude != null &&
        _currentPosition.longitude != null) {
      _mapController.onReady.then((result) {
        _mapController.move(LatLng(lat, lng), 15.0);
      });
    }
  }

  _getCurrentLocation() async {
    final Geolocator geolocator = Geolocator()..forceAndroidLocationManager;
    geolocator
        .getCurrentPosition(desiredAccuracy: LocationAccuracy.high)
        .then((Position position) {
      if (mounted) {
        setState(() {
          _currentPosition = position;
          moveCamera(_currentPosition.latitude, _currentPosition.longitude);
        });
      }
      print(_currentPosition);
    }).catchError((e) {
      print(e);
    });
  }

  addressName(double lat, double lng) async {
    SharedPreferences isLocate = await SharedPreferences.getInstance();
    List<Placemark> placemark =
        await Geolocator().placemarkFromCoordinates(lat, lng);
    print(placemark[0].country);
    print(placemark[0].administrativeArea);
    print(placemark[0].locality);
    print(placemark[0].subAdministrativeArea);
    print(placemark[0].subThoroughfare);
    print(placemark[0].thoroughfare); //*
    print(placemark[0].subLocality); //*
    setState(() {
      moveCamera(lat, lng);
      //locate = placemark[0].thoroughfare + placemark[0].subLocality;

      locate = placemark[0].thoroughfare + placemark[0].subLocality;
      isLocate.setString('current', locate);
    });
    _key.currentState.expand();
  }

  searchPlace(String placeName) async {
    // _searchKey.currentState.save();
    try {
      List<Placemark> placemark =
          await Geolocator().placemarkFromAddress(placeName);
      print(placemark[0].country);
      print(placemark[0].administrativeArea);
      print(placemark[0].locality);
      print(placemark[0].subAdministrativeArea);
      print(placemark[0].subThoroughfare);
      print(placemark[0].thoroughfare); //*
      print(placemark[0].subLocality);
      print(placemark[0].position);
      moveCamera(
          placemark[0].position.latitude, placemark[0].position.longitude);
      ApiGetServices().fetchPlaceList(placeName).then((value) {
        print(value);
      });
    } on PlatformException {
      return;
    }
  }

  @override
  void initState() {
    super.initState();
    if (_currentPosition == null) {
      _getCurrentLocation();
    }
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: _currentPosition == null
            ? Center(
                child: CircularProgressIndicator(),
              )
            : SafeArea(child: _bottom()));
  }

  Widget _bottom() {
    return ExpandableBottomSheet(
      key: _key,
      animationCurveExpand: Curves.bounceOut,
      animationCurveContract: Curves.ease,
      background: Stack(
        children: [
          FlutterMap(
            mapController: _mapController,
            options: MapOptions(
              center:
                  LatLng(_currentPosition.latitude, _currentPosition.longitude),
              zoom: 15.0,
            ),
            layers: [
              TileLayerOptions(
                  maxZoom: 20.0,
                  keepBuffer: 100,
                  urlTemplate:
                      "https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png",
                  subdomains: ['a', 'b', 'c']),
              MarkerLayerOptions(
                markers: [
                  Marker(
                    width: 80,
                    height: 80,
                    anchorPos: AnchorPos.align(AnchorAlign.top),
                    point: LatLng(
                        _currentPosition.latitude, _currentPosition.longitude),
                    builder: (ctx) => Container(
                      child: InkWell(
                        onTap: () => addressName(_currentPosition.latitude,
                            _currentPosition.longitude),
                        child: Icon(
                          Icons.location_on,
                          color: Colors.blue,
                          size: 50,
                        ),
                      ),
                    ),
                  ),
                  Marker(
                    width: 80,
                    height: 80,
                    anchorPos: AnchorPos.align(AnchorAlign.top),
                    point: LatLng(11.56959, 104.92104),
                    builder: (ctx) => Container(
                      child: InkWell(
                        onTap: () => addressName(11.56959, 104.92104),
                        child: Icon(
                          Icons.location_on,
                          color: Colors.red,
                          size: 50,
                        ),
                      ),
                    ),
                  ),
                  Marker(
                    width: 80,
                    height: 80,
                    anchorPos: AnchorPos.align(AnchorAlign.top),
                    point: LatLng(11.98750, 105.46491),
                    builder: (ctx) => Container(
                      child: InkWell(
                        onTap: () => addressName(11.98750, 105.46491),
                        child: Icon(
                          Icons.location_on,
                          color: Colors.red,
                          size: 50,
                        ),
                      ),
                    ),
                  ),
                  Marker(
                    width: 80,
                    height: 80,
                    anchorPos: AnchorPos.align(AnchorAlign.top),
                    point: LatLng(11.60895, 102.98397),
                    builder: (ctx) => Container(
                      child: InkWell(
                        onTap: () => addressName(11.60895, 102.98397),
                        child: Icon(
                          Icons.location_on,
                          color: Colors.red,
                          size: 50,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
          SizedBox(
            height: 20,
          ),
          TypeHead(searchPlace),
          Align(
            alignment: Alignment.topRight,
            child: Container(
              margin: EdgeInsets.only(top: 100, right: 30),
              child: Column(
                children: [
                  InkWell(
                      onTap: () {
                        _getCurrentLocation();
                      },
                      child: Icon(Icons.zoom_in)),
                  SizedBox(
                    height: 10,
                  ),
                  Icon(Icons.zoom_out),
                ],
              ),
            ),
          ),
        ],
      ),
      persistentHeader: Container(
        height: 50,
        color: Colors.white,
        child: Center(
          child: Column(
            children: [
              SizedBox(
                height: 10,
              ),
              Align(
                  alignment: Alignment.topCenter,
                  child: Container(
                    height: 3,
                    width: 30,
                    color: Colors.grey,
                  )),
            ],
          ),
        ),
      ),
      expandableContent: Container(
          height: 500,
          color: Colors.white,
          child: Container(
            margin: EdgeInsets.symmetric(horizontal: 20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  child: Card(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(kDefualtRadius)),
                    elevation: 2,
                    child: ReuseInkwell.getItem(
                        locate ?? 'Location', Icons.location_on, () {}),
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Text(
                  'Nearby',
                  style: TextStyle(fontSize: 16),
                ),
              ],
            ),
          )),
    );
  }
}
