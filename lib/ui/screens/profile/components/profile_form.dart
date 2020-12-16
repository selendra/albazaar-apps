import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:latlong/latlong.dart';
import 'package:selendra_marketplace_app/all_export.dart';

class ProfileForm extends StatefulWidget {
  final String _imageUrl;
  ProfileForm(this._imageUrl);
  @override
  _ProfileFormState createState() => _ProfileFormState();
}

class _ProfileFormState extends State<ProfileForm> {
  final _formKey = GlobalKey<FormState>();

  PrefService _prefService = PrefService();
  String _firstName, _midName, _lastName, _mGender;

  final TextEditingController _shippingController = TextEditingController();

  void validataAndSubmit(Function setUserPf) {
    if (_formKey.currentState.validate()) {
      _formKey.currentState.save();
      setUserPf(_firstName, _midName, _lastName);
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

    _location = place.subAdministrativeArea +
        ', ' +
        place.subLocality +
        ', ' +
        place.locality +
        ', ' +
        place.country;

    final data = Provider.of<UserProvider>(context, listen: false);

    if (_location != null) {
      data.setLocation(_location);
      setState(() {
        _shippingController.text = _location;
      });
      Navigator.pop(context);
    }
  }

  @override
  void initState() {
    final data = Provider.of<UserProvider>(context, listen: false);
    _shippingController.text = data.mUser.address;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final data = Provider.of<UserProvider>(context);
    var _lang = AppLocalizeService.of(context);
    return Consumer<UserProvider>(
      builder: (context, value, child) => Container(
        child: Column(
          children: [
            Container(
              margin: const EdgeInsets.all(10.0),
              child: Card(
                elevation: 0,
                shape: kDefaultShape,
                child: Container(
                  margin: const EdgeInsets.all(10.0),
                  child: Form(
                    key: _formKey,
                    child: Column(
                      children: [
                        Container(
                          child: ReuseTextField(
                            labelText: _lang.translate('first_name'),
                            initialValue: value.mUser.firstName,
                            onSaved: (newValue) => _firstName = newValue,
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Container(
                          child: ReuseTextField(
                            labelText: _lang.translate('mid_name'),
                            initialValue: value.mUser.midName,
                            onSaved: (newValue) => _midName = newValue,
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Container(
                          child: ReuseTextField(
                            labelText: _lang.translate('last_name'),
                            initialValue: value.mUser.lastName,
                            onSaved: (newValue) => _lastName = newValue,
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Consumer<UserProvider>(
                          builder: (context, value, child) => GenderDropdown(
                            initialValue: _mGender = value.mUser.gender,
                            onChanged: (myValue) {
                              value.setGender(myValue);
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 10.0),
              child: Card(
                elevation: 0,
                child: Column(
                  children: [
                    item(() {}, _lang.translate('account_info'),
                        value.mUser.email ?? _lang.translate('no_email')),
                    item(() {}, _lang.translate('phone_hint'),
                        value.mUser.phonenumber ?? 'phonenumber'),
                    item(() {
                      showModalBottomSheet(
                        isScrollControlled: true,
                        context: context,
                        builder: (context) => SingleChildScrollView(
                          child: Column(
                            children: [
                              ListTile(
                                title: Text(
                                  'Add Shipping Address',
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                ),
                                trailing: IconButton(
                                  icon: Icon(
                                    Icons.add,
                                    color: kDefaultColor,
                                  ),
                                  onPressed: () {
                                    _formKey.currentState.save();

                                    if (_shippingController.text != null) {
                                      Navigator.pop(context);
                                      data.setLocation(
                                          _shippingController.text);
                                    }
                                  },
                                ),
                              ),
                              Container(
                                margin: const EdgeInsets.only(
                                    top: 20.0, left: 20.0, right: 20.0),
                                padding: EdgeInsets.only(
                                    bottom: MediaQuery.of(context)
                                        .viewInsets
                                        .bottom),
                                child: ReuseTextField(
                                  labelText: 'Shipping Address',
                                  controller: _shippingController,
                                  maxLine: 1,
                                  // initialValue: _shippingController.text,
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
                              SizedBox(height: 20),
                            ],
                          ),
                        ),
                      );
                    }, _lang.translate('shipping_address'),
                        value.mUser.address ?? 'edit'),
                  ],
                ),
              ),
            ),
            SizedBox(height: 10),
            Container(
              margin: const EdgeInsets.all(30.0),
              child: ReuseButton.getItem(_lang.translate('save'), () {
                _prefService.read('token').then(
                  (onValue) {
                    if (onValue != null) {
                      _formKey.currentState.save();

                      if (_firstName != '' &&
                          _lastName != '' &&
                          _mGender != null) {
                        data
                            .updateUserPf(
                          _firstName,
                          _midName ?? '',
                          _lastName,
                          _mGender,
                          widget._imageUrl,
                          value.mUser.address ?? '',
                          context,
                        )
                            .then(
                          (value) async {
                            await ProfileDialog().successDialog(context, value);
                          },
                        );
                      } else {
                        ProfileDialog().successDialog(
                            context, 'Please fill in username and gender');
                      }
                    }
                  },
                );
              }, context),
            ),
          ],
        ),
      ),
    );
  }

  Widget item(Function onTap, String title, String trailing) {
    return InkWell(
      onTap: onTap,
      splashColor: Colors.grey,
      child: ListTile(
        title: Text(
          title,
          maxLines: 1,
        ),
        trailing: Container(
          width: MediaQuery.of(context).size.width / 2.5,
          child: Align(
            alignment: Alignment.centerRight,
            child: Text(
              trailing,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                fontSize: 12,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
