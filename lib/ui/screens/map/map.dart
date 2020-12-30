import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:geolocator/geolocator.dart';
import 'package:latlong/latlong.dart';
import 'package:selendra_marketplace_app/all_export.dart';
import 'package:selendra_marketplace_app/ui/reuse_widget/responsive_widget.dart';

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

  void animateMove(LatLng desPlace, double desZoom) {
    var _latTween = Tween<double>(
        begin: _mapController.center.latitude, end: desPlace.latitude);
    var _longTween = Tween<double>(
        begin: _mapController.center.longitude, end: desPlace.longitude);
    var _zoomTween = Tween<double>(begin: _mapController.zoom, end: desZoom);

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
      }).catchError((e) {});
    } else {
      markers.removeLast();
      // _key.currentState.contract();
      animateMove(kDefualtLatLng, kDefaultMapZoom);
    }
    //if (!mounted) return;
  }

  addressName(LatLng place) async {
    List<Placemark> placemark = await Geolocator()
        .placemarkFromCoordinates(place.latitude, place.longitude);
    //pattern for saving address throughtfare(st) +
    //subadministrative(sangkat) + sublocality(khan) + locality(province or city)

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
      // UserProvider).fetchPlaceList(placeName).then((value) {
      // });
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
      builder: (ctx) => IconButton(
        icon: Icon(Icons.location_on),
        onPressed: () {
          showBottomSheet(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.vertical(
                top: Radius.circular(kDefaultRadius * 3),
              ),
            ),
            context: ctx,
            builder: (context) => Container(
              height: MediaQuery.of(ctx).size.height / 3,
              color: Colors.transparent,
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(
                    topLeft: const Radius.circular(
                      kDefaultRadius * 3,
                    ),
                    topRight: const Radius.circular(kDefaultRadius * 3),
                  ),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Align(
                      alignment: Alignment.center,
                      child: Icon(
                        Icons.drag_handle,
                        color: kDefaultColor,
                      ),
                    ),
                    SizedBox(
                      height: 20.0,
                    ),
                    Consumer<ProductsProvider>(
                      builder: (context, value, child) => Container(
                        height: 100,
                        child: ListView.builder(
                          shrinkWrap: true,
                          scrollDirection: Axis.horizontal,
                          itemCount: value.imageList.length,
                          itemBuilder: (context, index) => Container(
                            margin: const EdgeInsets.symmetric(horizontal: 5.0),
                            width: MediaQuery.of(context).size.width / 2,
                            height: 50.0,
                            child: ClipRRect(
                              borderRadius: BorderRadius.all(
                                Radius.circular(5.0),
                              ),
                              child: Container(
                                width: double.infinity,
                                height: MediaQuery.of(context).size.width * 0.4,
                                decoration: BoxDecoration(
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.white,
                                      spreadRadius: 5.0,
                                      blurRadius: 5.0,
                                    )
                                  ],
                                ),
                                child: FadeInImage(
                                  fit: BoxFit.cover,
                                  image: NetworkImage(value.imageList[0].url),
                                  placeholder: AssetImage('images/loading.gif'),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                    ListTile(
                      onTap: () {},
                      hoverColor: Colors.grey,
                      title: Text(
                        'Bonchay Ouk',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      subtitle: Text('st5 toul sangke phnom penh'),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
        color: Colors.red,
        iconSize: 40,
      ),
    ),
    // Marker(
    //   width: 80,
    //   height: 80,
    //   anchorPos: AnchorPos.align(AnchorAlign.top),
    //   point: LatLng(11.98750, 105.46491),
    //   builder: (ctx) => Container(
    //     child: InkWell(
    //       onTap: () {},
    //       child: Icon(
    //         Icons.location_on,
    //         color: Colors.red,
    //         size: 40,
    //       ),
    //     ),
    //   ),
    // ),
    // Marker(
    //   width: 80,
    //   height: 80,
    //   anchorPos: AnchorPos.align(AnchorAlign.top),
    //   point: LatLng(11.60895, 102.98397),
    //   builder: (ctx) => Container(
    //     child: InkWell(
    //       onTap: () {},
    //       child: Icon(
    //         Icons.location_on,
    //         color: Colors.red,
    //         size: 40,
    //       ),
    //     ),
    //   ),
    // ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
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
                subdomains: ['a', 'b', 'c'],
              ),
              MarkerLayerOptions(
                markers: markers,
              ),
            ],
          ),
          Responsive.isDesktop(context)
              ? Align(
                  alignment: Alignment.topCenter,
                  child: Container(
                    margin: const EdgeInsets.only(top: 20),
                    width: MediaQuery.of(context).size.width * 0.3,
                    child: TypeHead(searchPlace),
                  ),
                )
              : Container(
                  margin: const EdgeInsets.only(top: 20),
                  child: TypeHead(searchPlace),
                ),
          Container(
            margin: const EdgeInsets.only(top: 20),
            child: ZoomButtons(_mapController),
          ),
        ],
      ),
    ); //SafeArea(child: _bottom()));
  }
}
