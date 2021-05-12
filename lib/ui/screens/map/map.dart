import 'package:albazaar_app/core/components/location_marker_c.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:geolocator/geolocator.dart';
import 'package:latlong/latlong.dart';
import 'package:albazaar_app/all_export.dart';

class MapScreen extends StatefulWidget {
  @override
  _MapScreenState createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> with TickerProviderStateMixin {

  bool isGuestAcc = false;

  LocationMarker _locationMarker = LocationMarker();

  MapController _mapController = MapController();
  Position _currentPosition;
  LatLng kDefualtLatLng = LatLng(12.509, 105.634);
  String locate;
  bool _isLive = false;

  List<Placemark> placemark;

  void getName() {}

  _getCurrentLocation() async {
    setState(() {
      _isLive = !_isLive;
    });
    if (_isLive) {
      final Geolocator geolocator = Geolocator()..forceAndroidLocationManager;
      geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high).then((Position position) {
        if (mounted) {
          setState(() {
            _currentPosition = position;

            // Make Move To Current Location
            AppServices.mapAnimateMove(
              _mapController,
              LatLng(_currentPosition.latitude, _currentPosition.longitude),
              kDefaultMaxZoom - 2,
              this
            );
            addressName(LatLng(_currentPosition.latitude, _currentPosition.longitude));

            // Mark Pin on current location
            AppServices.markPin(_locationMarker, _currentPosition.latitude, _currentPosition.longitude);
            // _locationMarker.markers.add(Marker(
            //   point: LatLng(_currentPosition.latitude, _currentPosition.longitude),
            //   builder: (context) => Container(
            //     child: Icon(
            //       Icons.location_on,
            //       color: kDefaultColor,
            //       size: 50,
            //     ),
            //   ),
            // ));
          });
        }
      }).catchError((e) {});
    } else {
      _locationMarker.markers.removeLast();
      // _key.currentState.contract();
      AppServices.mapAnimateMove(_mapController, kDefualtLatLng, kDefaultMapZoom, this);
    }
    //if (!mounted) return;
  }

  addressName(LatLng place) async {
    placemark = await Geolocator().placemarkFromCoordinates(place.latitude, place.longitude);
    //pattern for saving address throughtfare(st) +
    //subadministrative(sangkat) + sublocality(khan) + locality(province or city)

    setState(() {
      AppServices.mapAnimateMove(_mapController, place, 15.0, this);
      locate = placemark[0].thoroughfare + placemark[0].subLocality;
    });
    //_key.currentState.expand();
  }

  searchPlace(String placeName) async {
    // _searchKey.currentState.save();
    try {
      List<Placemark> placemark = await Geolocator().placemarkFromAddress(placeName);
      AppServices.mapAnimateMove(_mapController, LatLng(placemark[0].position.latitude, placemark[0].position.longitude), kDefaultMapZoom, this);
      // UserProvider).fetchPlaceList(placeName).then((value) {
      // });
    } on PlatformException {
      return;
    }
  }

  void guestAccCheck() async {
    await StorageServices.fetchData(DbKey.guestAcc).then((value) {
      print(value);
      if (value != null){
        setState((){
          isGuestAcc = value;
        });
      }
    });
  }

  @override
  void initState() {
    guestAccCheck();
    _locationMarker = LocationMarker(lat: 11.56959, long: 104.92104);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [

          FlutterMap(
            mapController: _mapController,
            options: MapOptions(
              center: _currentPosition != null
               ? LatLng(_currentPosition.latitude, _currentPosition.longitude)
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
                subdomains: ['a', 'b', 'c'],
              ),
              MarkerLayerOptions(
                markers: _locationMarker.markers
              ),
            ],
          ),
          Container(
            margin: const EdgeInsets.only(top: 20),
            child: TypeHead(searchPlace),
          ),
          Container(
            margin: const EdgeInsets.only(top: 20),
            child: ZoomButtons(_mapController),
          ),

          Positioned(
            bottom: 72,
            right: 12,
            child: FloatingActionButton(
              backgroundColor: kDefaultColor,
              onPressed: () => _getCurrentLocation(),
              child: _isLive
              ? Icon(
                Icons.gps_not_fixed,
                color: Colors.white,
              )
              : Icon(
                Icons.gps_fixed,
                color: Colors.white,
              ),
              //  backgroundColor: Colors.white,
            )
          ),

          Positioned(
            bottom: 0,
            child:  MyFlatButton(
              borderRadius: 0,
              height: 60,
              width: MediaQuery.of(context).size.width,
              buttonColor: AppColors.primary,
              child: MyText(
                text: "Confirm location",
                fontSize: 16,
                color: AppColors.white,
              ),
              action: (){
                Navigator.pop(context, _currentPosition ?? placemark);
              }
            )
          ),

          isGuestAcc == false ? Container() : GestureDetector(
            onTap: () async {
              await requestSignUpDialog(context);
              
            },
            child: SizedBox(
              height: MediaQuery.of(context).size.height,
              width: MediaQuery.of(context).size.width,
              child: Text(""),
            ),
          )
        ],
      ),
    ); //SafeArea(child: _bottom()));
  }
}
