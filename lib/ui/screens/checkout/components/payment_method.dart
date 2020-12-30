import 'package:flutter/material.dart';
import 'package:selendra_marketplace_app/all_export.dart';
import 'package:latlong/latlong.dart';
import 'package:geolocator/geolocator.dart';

class ShippingInformation extends StatefulWidget {
  final String _character;
  final Function setVal;

  ShippingInformation(this._character, this.setVal);

  @override
  _ShippingInformationState createState() => _ShippingInformationState();
}

class _ShippingInformationState extends State<ShippingInformation> {
  String _address;
  final _formKey = GlobalKey<FormState>();

  void validateAndSubmit() {
    if (_formKey.currentState.validate()) {
      _formKey.currentState.save();
      widget.setVal(_address);
      Navigator.pop(context);
    }
  }

  _getCurrentLocation() async {
    final Geolocator geolocator = Geolocator()..forceAndroidLocationManager;
    geolocator
        .getCurrentPosition(desiredAccuracy: LocationAccuracy.high)
        .then((Position position) {
      addressName(LatLng(position.latitude, position.longitude));
      // if (mounted) {
      //   setState(() {
      //     _currentPosition = position;
      //     animateMove(
      //         LatLng(_currentPosition.latitude, _currentPosition.longitude),
      //         kDefaultMaxZoom - 2);
      //     addressName(
      //         LatLng(_currentPosition.latitude, _currentPosition.longitude));

      //     markers.add(Marker(
      //       point:
      //           LatLng(_currentPosition.latitude, _currentPosition.longitude),
      //       builder: (context) => Container(
      //         child: Icon(
      //           Icons.location_on,
      //           color: kDefaultColor,
      //           size: 50,
      //         ),
      //       ),
      //     ));
      //   });
      // }
    }).catchError((e) {});

    //if (!mounted) return;
  }

  addressName(LatLng _place) async {
    String _location;

    List<Placemark> placemark = await Geolocator()
        .placemarkFromCoordinates(_place.latitude, _place.longitude);
    var place = placemark[0];

    //pattern for saving address throughtfare(st) +
    //subadministrative(sangkat) + sublocality(khan) + locality(province or city)
    //country
    _location = place.subAdministrativeArea +
        ', ' +
        place.subLocality +
        ', ' +
        place.locality +
        ', ' +
        place.country;
    print('Admnistrative:' + placemark[0].administrativeArea);
    print('Country:' + placemark[0].country);
    print('Locality:' + placemark[0].locality);
    print('Name:' + placemark[0].name);
    print(placemark[0].position);
    print('Postal code:' + placemark[0].postalCode);

    print('SubAdministrative: ' + placemark[0].subAdministrativeArea);
    print('SubLocality: ' + placemark[0].subLocality);
    print('Throughfare: ' + placemark[0].thoroughfare);
    print('SubThoroughfare: ' + placemark[0].subThoroughfare);
    final data = Provider.of<UserProvider>(context, listen: false);

    if (_location != null) {
      data.setLocation(_location);
      setState(() {
        _address = _location;
      });
      Navigator.pop(context);
    }

    //_key.currentState.expand();
  }

  @override
  Widget build(BuildContext context) {
    var _lang = AppLocalizeService.of(context);
    return InkWell(
      onTap: () {
        showBottomSheet(
          shape: kDefaultShape,
          context: context,
          builder: (context) => StatefulBuilder(
            builder: (context, setState) {
              return Container(
                color: Colors.white,
                height: MediaQuery.of(context).size.height / 2,
                // margin: EdgeInsets.symmetric(horizontal: 20.0),
                child: Column(
                  children: [
                    ListTile(
                      trailing: IconButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        icon: Icon(
                          Icons.clear,
                          color: kDefaultColor,
                        ),
                      ),
                      title: Text(_lang.translate('shipping_information')),
                    ),
                    SizedBox(
                      height: 10.0,
                    ),
                    Consumer<UserProvider>(
                      builder: (context, value, child) => Container(
                        margin: EdgeInsets.symmetric(horizontal: 20.0),
                        child: Form(
                          key: _formKey,
                          child: ReuseTextField(
                            hintText: 'Address',
                            initialValue: value.mUser.address == null
                                ? ''
                                : value.mUser.address,
                            validator: (value) => value.isEmpty
                                ? 'Address cannot be empty'
                                : null,
                            onSaved: (newValue) => _address = newValue,
                          ),
                        ),
                      ),
                    ),
                    Align(
                      alignment: Alignment.topRight,
                      child: Container(
                        margin: const EdgeInsets.only(right: 10.0),
                        child: FlatButton(
                          child: Text(
                            'Select Current Address',
                            style: TextStyle(
                              color: kDefaultColor,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          onPressed: () {
                            _getCurrentLocation();

                            print('my current address');
                          },
                          // color: kDefaultColor,
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 40.0,
                    ),
                    Container(
                      margin: EdgeInsets.symmetric(horizontal: 20.0),
                      child: ReuseButton.getItem('Add', () {
                        validateAndSubmit();
                      }, context),
                    ),
                    // RadioListTile(
                    //   activeColor: kDefaultColor,
                    //   title: Text('Direct Payment'),
                    //   value: 'Direct Payment',
                    //   groupValue: widget._character,
                    //   onChanged: (value) {
                    //     print(value);
                    //     widget.setVal(value);
                    //     setState(() {});
                    //   },
                    // ),
                    // RadioListTile(
                    //   activeColor: kDefaultColor,
                    //   title: Text('Escrow Payment'),
                    //   value: 'Escrow Payment',
                    //   groupValue: widget._character,
                    //   onChanged: (value) {
                    //     print(value);
                    //     widget.setVal(value);
                    //     setState(() {});
                    //   },
                    // )
                  ],
                ),
              );
            },
          ),
        );
      },
      child: Card(
        elevation: 0,
        shape: kDefaultShape,
        child: Container(
          child: ListTile(
            title: Text(
              widget._character,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(fontSize: 14.0, fontWeight: FontWeight.bold),
            ),
            // leading: Icon(Icons.payment),
            trailing: Icon(
              Icons.edit,
              color: kDefaultColor,
            ),
          ),
        ),
      ),
    );
  }
}
