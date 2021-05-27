import 'package:albazaar_app/core/models/profile_m.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:latlong/latlong.dart';
import 'package:albazaar_app/all_export.dart';
import 'package:provider/provider.dart';

class ProfileForm extends StatefulWidget {

  final String imageUrl;

  final ProfileModel profileModel;

  ProfileForm({this.imageUrl, this.profileModel});
  
  @override
  _ProfileFormState createState() => _ProfileFormState();
}

class _ProfileFormState extends State<ProfileForm> {

  void validataAndSubmit(Function setUserPf) {
    if (widget.profileModel.formKey.currentState.validate()) {
      widget.profileModel.formKey..currentState.save();
      setUserPf(widget.profileModel.first, widget.profileModel.mid, widget.profileModel.last);
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

    List<Placemark> placemark = await Geolocator().placemarkFromCoordinates(_place.latitude, _place.longitude);
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
    // print('Admnistrative:' + placemark[0].administrativeArea);
    // print('Country:' + placemark[0].country);
    // print('Locality:' + placemark[0].locality);
    // print('Name:' + placemark[0].name);
    // print(placemark[0].position);
    // print('Postal code:' + placemark[0].postalCode);

    // print('SubAdministrative: ' + placemark[0].subAdministrativeArea);
    // print('SubLocality: ' + placemark[0].subLocality);
    // print('Throughfare: ' + placemark[0].thoroughfare);
    // print('SubThoroughfare: ' + placemark[0].subThoroughfare);
    final data = Provider.of<UserProvider>(context, listen: false);

    if (_location != null) {
      data.setLocation(_location);
      setState(() {
        widget.profileModel.address.text = _location;
      });
      Navigator.pop(context);
    }

    //_key.currentState.expand();
  }

  @override
  void initState() {
    // final data = Provider.of<UserProvider>(context, listen: false);
    // _shippingController.text = data.mUser.address;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final data = Provider.of<UserProvider>(context);
    var _lang = AppLocalizeService.of(context);
    return Scaffold(
      appBar: ReuseSimpleAppBar.getItem(_lang.translate('edit_profile'), context),
      body: SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        child: Consumer<UserProvider>(
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
                        key: widget.profileModel.formKey,
                        child: Column(
                          children: [

                            Container(
                              child: ReuseTextField(
                                theme: AppColors.secondary,
                                labelText: _lang.translate('first_name'),
                                initialValue: value.mUser.firstName,
                                onSaved: (newValue) => widget.profileModel.first.text = newValue,
                              ),
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Container(
                              child: ReuseTextField(
                                theme: AppColors.secondary,
                                labelText: _lang.translate('mid_name'),
                                initialValue: value.mUser.midName,
                                onSaved: (newValue) => widget.profileModel.mid.text = newValue,
                              ),
                            ),

                            SizedBox(
                              height: 10,
                            ),
                            Container(
                              child: ReuseTextField(
                                theme: AppColors.secondary,
                                labelText: _lang.translate('last_name'),
                                initialValue: value.mUser.lastName,
                                onSaved: (newValue) => widget.profileModel.last.text = newValue,
                              ),
                            ),

                            SizedBox(
                              height: 10,
                            ),
                            Consumer<UserProvider>(
                              builder: (context, value, child) => GenderDropdown(
                                initialValue: widget.profileModel.mGender = value.mUser.gender,
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
                
                Card(
                  margin: const EdgeInsets.all(10.0),
                  elevation: 0,
                  child:Container(
                    margin: const EdgeInsets.all(10.0),
                    child: Column(
                      children: [

                        Container(
                          child: ReuseTextField(
                            theme: AppColors.secondary,
                            labelText: _lang.translate('account_info'),
                            initialValue: value.mUser.firstName,
                            onSaved: (newValue) => widget.profileModel.email.text = newValue,
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Container(
                          child: ReuseTextField(
                            theme: AppColors.secondary,
                            labelText: _lang.translate('phone_hint'),
                            initialValue: value.mUser.midName,
                            onSaved: (newValue) => widget.profileModel.phone.text = newValue,
                          ),
                        ),

                        SizedBox(
                          height: 10,
                        ),
                        Container(
                          child: ReuseTextField(
                            theme: AppColors.secondary,
                            labelText: 'Shipping Address',
                            controller: widget.profileModel.address,
                            initialValue: value.mUser.lastName,
                            onSaved: (newValue) => widget.profileModel.address.text = newValue,
                          ),
                        ),

                        // item(
                        //   () {}, 
                        //   _lang.translate('account_info'),
                        //   value.mUser.email ?? _lang.translate('no_email')
                        // ),

                        // item(
                        //   () {}, 
                        //   _lang.translate('phone_hint'),
                        //   value.mUser.phonenumber ?? 'phonenumber'
                        // ),

                        // item(
                        //   () {
                        //     showModalBottomSheet(
                        //       isScrollControlled: true,
                        //       context: context,
                        //       builder: (context) => SingleChildScrollView(
                        //         child: Column(
                        //           children: [
                        //             ListTile(
                        //               title: Text(
                        //                 'Add Shipping Address',
                        //                 style: TextStyle(fontWeight: FontWeight.bold, color: AppServices.hexaCodeToColor(AppColors.secondary)),
                        //               ),
                        //               trailing: IconButton(
                        //                 icon: Icon(
                        //                   Icons.add,
                        //                   color: kDefaultColor,
                        //                 ),
                        //                 onPressed: () {
                        //                   _formKey.currentState.save();

                        //                   if (_shippingController.text != null) {
                        //                     Navigator.pop(context);
                        //                     data.setLocation(_shippingController.text);
                        //                   }
                        //                 },
                        //               ),
                        //             ),

                        //             Container(
                        //               margin: const EdgeInsets.only(top: 20.0, left: 20.0, right: 20.0),
                        //               padding: EdgeInsets.only(
                        //                 bottom: MediaQuery.of(context).viewInsets.bottom
                        //               ),
                        //               child: ReuseTextField(
                        //                 labelText: 'Shipping Address',
                        //                 controller: _shippingController,
                        //                 theme: AppColors.secondary,
                        //                 maxLine: 1,
                        //                 // initialValue: _shippingController.text,
                        //               ),
                        //             ),
                        //             Align(
                        //               alignment: Alignment.topRight,
                        //               child: Container(
                        //                 margin: const EdgeInsets.only(right: 10.0),
                        //                 child: FlatButton(
                        //                   child: Text(
                        //                     'Select Current Address',
                        //                     style: TextStyle(
                        //                       color: kDefaultColor,
                        //                       fontWeight: FontWeight.bold,
                        //                     ),
                        //                   ),
                        //                   onPressed: () {
                        //                     _getCurrentLocation();
                        //                   },
                        //                   // color: kDefaultColor,
                        //                 ),
                        //               ),
                        //             ),
                        //             SizedBox(height: 20),
                        //           ],
                        //         ),
                        //       ),
                        //     );
                        //   }, 

                        //   _lang.translate('shipping_address'),
                          
                        //   value.mUser.address ?? 'edit'
                        // ),
                      ],
                    ),
                  ),
                ),

                SizedBox(height: 10),
                Container(
                  width: MediaQuery.of(context).size.width,
                  margin: const EdgeInsets.all(30.0),
                  child: MyFlatButton(
                    child: MyText(
                      pTop: 20,
                      pBottom: 20,
                      text: _lang.translate('save')
                    ),
                    buttonColor: AppColors.secondary,
                    action: (){
                      
                      widget.profileModel.prefService.read('token').then(
                        (onValue) {
                          if (onValue != null) {
                            widget.profileModel.formKey.currentState.save();

                            if (widget.profileModel.first.text != '' &&
                                widget.profileModel.last.text != '' &&
                                widget.profileModel.mGender != null) {
                              data
                                  .updateUserPf(
                                widget.profileModel.first.text,
                                widget.profileModel.mid.text ?? '',
                                widget.profileModel.last.text,
                                widget.profileModel.mGender,
                                widget.imageUrl ?? '',
                                value.mUser.address ?? '',
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
                    }
                  )
                ),
              ],
            ),
          ),
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
