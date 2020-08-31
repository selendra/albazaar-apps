import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:geolocator/geolocator.dart';
import 'package:latlong/latlong.dart';
import 'package:expandable_bottom_sheet/expandable_bottom_sheet.dart';
import 'package:selendra_marketplace_app/all_export.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MapScreen extends StatefulWidget {
  @override
  _MapScreenState createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  MapController _mapController = MapController();
  Position _currentPosition;
  LatLng kDefualtLatLng = LatLng(12.509, 105.634);
  String locate;
  bool _isLive = false;
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
    setState(() {
      _isLive = !_isLive;
    });
    if (_isLive) {
      final Geolocator geolocator = Geolocator()..forceAndroidLocationManager;
      geolocator
          .getCurrentPosition(desiredAccuracy: LocationAccuracy.high)
          .then((Position position) {
        if (mounted) {
          setState(() {
            _currentPosition = position;
            moveCamera(_currentPosition.latitude, _currentPosition.longitude);
            markers.add(Marker(
              point:
                  LatLng(_currentPosition.latitude, _currentPosition.longitude),
              builder: (context) => Container(
                child: Icon(
                  Icons.location_on,
                  color: kDefualtColor,
                  size: 50,
                ),
              ),
            ));
          });
        }
        print(_currentPosition);
      }).catchError((e) {
        print(e);
      });
    } else {
      markers.removeLast();
      _mapController.move(kDefualtLatLng, kDefaultMapZoom);
    }
  }

  Future<void> zoomIn() async {
    final z = _mapController.zoom + 1;
    if (z < 20.0) {
      print(z);
      _mapController.move(_mapController.center, z);
    } else {
      return null;
    }
  }

  Future<void> zoomOut() async {
    final z = _mapController.zoom - 1;
    _mapController.move(_mapController.center, z);
  }

  addressName(LatLng place) async {
    SharedPreferences isLocate = await SharedPreferences.getInstance();
    List<Placemark> placemark = await Geolocator()
        .placemarkFromCoordinates(place.latitude, place.longitude);
    //*
    setState(() {
      moveCamera(place.latitude, place.longitude);
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
      moveCamera(
          placemark[0].position.latitude, placemark[0].position.longitude);
      ApiGetServices().fetchPlaceList(placeName).then((value) {
        print(value);
      });
    } on PlatformException {
      return;
    }
  }

  var markers = <Marker>[
    Marker(
      width: 80,
      height: 80,
      anchorPos: AnchorPos.align(AnchorAlign.top),
      point: LatLng(11.56959, 104.92104),
      builder: (ctx) => Container(
        child: InkWell(
          onTap: () {},
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
          onTap: () {},
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
          onTap: () {},
          child: Icon(
            Icons.location_on,
            color: Colors.red,
          ),
        ),
      ),
    ),
  ];

  @override
  void initState() {
    super.initState();
    /*if (_currentPosition == null) {
      _getCurrentLocation();
    }*/
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            _getCurrentLocation();
          },
          child: _isLive
              ? Icon(
                  Icons.gps_not_fixed,
                  color: kDefualtColor,
                )
              : Icon(
                  Icons.gps_fixed,
                  color: kDefualtColor,
                ),
          backgroundColor: Colors.white,
        ),
        body:
            /* Center(
                child: CircularProgressIndicator(),
              )
            :*/
            SafeArea(child: _bottom()));
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
              center: _currentPosition != null
                  ? LatLng(
                      _currentPosition.latitude, _currentPosition.longitude)
                  : kDefualtLatLng,
              zoom: kDefaultMapZoom,
              screenSize: MediaQuery.of(context).size,
              slideOnBoundaries: true,
              maxZoom: kDefaultMaxZoom,
              minZoom: kDefaultMinZoom,
            ),
            layers: [
              TileLayerOptions(
                  tileFadeInStart: 0.1,
                  maxZoom: kDefaultMaxZoom,
                  keepBuffer: 100,
                  urlTemplate: osmMapTemplate,
                  subdomains: ['a', 'b', 'c']),
              MarkerLayerOptions(
                markers: markers,
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
                    onTap: () => zoomIn(),
                    child: Container(
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(kDefualtRadius),
                          color: Colors.white),
                      width: 40,
                      height: 40,
                      child: Icon(
                        Icons.add,
                        color: kDefualtColor,
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  InkWell(
                    onTap: () => zoomOut(),
                    child: Container(
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(kDefualtRadius),
                          color: Colors.white),
                      width: 40,
                      height: 40,
                      child: Icon(
                        Icons.remove,
                        color: kDefualtColor,
                      ),
                    ),
                  ),
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
