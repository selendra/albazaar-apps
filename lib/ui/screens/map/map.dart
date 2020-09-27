import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:geolocator/geolocator.dart';
import 'package:latlong/latlong.dart';
import 'package:selendra_marketplace_app/all_export.dart';

class MapScreen extends StatefulWidget {
  @override
  _MapScreenState createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> with TickerProviderStateMixin {
  MapController _mapController = MapController();
  Position _currentPosition;
  LatLng kDefualtLatLng = LatLng(12.509, 105.634);
  String locate;
  bool _isLive = false;
  //GlobalKey<ExpandableBottomSheetState> _key = GlobalKey();

  animateMove(LatLng desPlace, double desZoom) {
    final _latTween = Tween<double>(
        begin: _mapController.center.latitude, end: desPlace.latitude);
    final _longTween = Tween<double>(
        begin: _mapController.center.longitude, end: desPlace.longitude);
    final _zoomTween = Tween<double>(begin: _mapController.zoom, end: desZoom);

    var controller = AnimationController(
        duration: const Duration(milliseconds: 300), vsync: this);

    Animation<double> animation =
        CurvedAnimation(parent: controller, curve: Curves.fastOutSlowIn);
    controller.addListener(() {
      _mapController.move(
          LatLng(_latTween.evaluate(animation), _longTween.evaluate(animation)),
          _zoomTween.evaluate(animation));
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

  void getName() {}

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
            animateMove(
                LatLng(_currentPosition.latitude, _currentPosition.longitude),
                kDefaultMaxZoom - 2);
            addressName(
                LatLng(_currentPosition.latitude, _currentPosition.longitude));

            markers.add(Marker(
              point:
                  LatLng(_currentPosition.latitude, _currentPosition.longitude),
              builder: (context) => Container(
                child: Icon(
                  Icons.location_on,
                  color: kDefaultColor,
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
      // _key.currentState.contract();
      animateMove(kDefualtLatLng, kDefaultMapZoom);
    }
  }

  addressName(LatLng place) async {
    List<Placemark> placemark = await Geolocator()
        .placemarkFromCoordinates(place.latitude, place.longitude);
    //*
    setState(() {
      animateMove(place, 15.0);
      locate = placemark[0].thoroughfare + placemark[0].subLocality;
    });
    //_key.currentState.expand();
  }

  searchPlace(String placeName) async {
    // _searchKey.currentState.save();
    try {
      List<Placemark> placemark =
          await Geolocator().placemarkFromAddress(placeName);
      animateMove(
          LatLng(
              placemark[0].position.latitude, placemark[0].position.longitude),
          kDefaultMapZoom);
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
            size: 40,
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
            size: 40,
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
            size: 40,
          ),
        ),
      ),
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () => _getCurrentLocation(),
        child: _isLive
            ? Icon(
                Icons.gps_not_fixed,
                color: kDefaultColor,
              )
            : Icon(
                Icons.gps_fixed,
                color: kDefaultColor,
              ),
        backgroundColor: Colors.white,
      ),
      body: Stack(
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
          ZoomButtons(_mapController),
        ],
      ),
    ); //SafeArea(child: _bottom()));
  }

  /*Widget _bottom() {
    return ExpandableBottomSheet(
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
          ZoomButtons(_mapController),
        ],
      ),
      persistentHeader: PersistentHeader(),
      expandableContent: ExpandableContent(locate),
    );
  }*/
}