import 'package:flutter/material.dart';
import 'package:selendra_marketplace_app/all_export.dart';
import 'package:provider/provider.dart';

String _firstName, _midName, _lastName, _mGender;

class ProfileForm extends StatelessWidget {
  final _formKey = GlobalKey<FormState>();

  void validataAndSubmit(Function setUserPf) {
    if (_formKey.currentState.validate()) {
      _formKey.currentState.save();
      print(_firstName);
      print(_midName);
      print(_lastName);
      setUserPf(_firstName, _midName, _lastName);
    }
  }

  @override
  Widget build(BuildContext context) {
    final data = Provider.of<ApiPostServices>(context);
    return Consumer<ApiGetServices>(
      builder: (context, value, child) => Container(
        child: Column(
          children: [
            Container(
              margin: EdgeInsets.all(10.0),
              child: Card(
                elevation: 0,
                shape: kDefaultShape,
                child: Container(
                  margin: EdgeInsets.all(10.0),
                  child: Form(
                    key: _formKey,
                    child: Column(
                      children: [
                        Container(
                          child: ReuseTextField(
                            labelText: AppLocalizeService.of(context)
                                .translate('first_name'),
                            initialValue: value.mUser.firstName,
                            onSaved: (newValue) => _firstName = newValue,
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Container(
                          child: ReuseTextField(
                            labelText: AppLocalizeService.of(context)
                                .translate('mid_name'),
                            initialValue: value.mUser.midName,
                            // ? 'Email'
                            //    : _mUser.midName,
                            onSaved: (newValue) => _midName = newValue,
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Container(
                          child: ReuseTextField(
                            labelText: AppLocalizeService.of(context)
                                .translate('last_name'),
                            initialValue: value.mUser.lastName,
                            onSaved: (newValue) => _lastName = newValue,
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Consumer<ApiGetServices>(
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
              margin: EdgeInsets.symmetric(horizontal: 10.0),
              child: Card(
                elevation: 0,
                child: Column(
                  children: [
                    item(
                        () {},
                        AppLocalizeService.of(context)
                            .translate('account_info'),
                        value.mUser.email ?? 'email'),
                    item(
                        () {},
                        AppLocalizeService.of(context).translate('phone_hint'),
                        value.mUser.phonenumber ?? 'phonenumber'),
                    item(
                        () {},
                        AppLocalizeService.of(context)
                            .translate('shipping_address'),
                        ''),
                  ],
                ),
              ),
            ),
            SizedBox(height: 20),
            Container(
              margin: EdgeInsets.all(30.0),
              child: ReuseButton.getItem(
                  AppLocalizeService.of(context).translate('save'), () {
                //onSave();
                _formKey.currentState.save();
                print(_firstName);
                print(_midName);
                print(_mGender);
                data
                    .setUserPf(_firstName, _midName ?? '', _lastName, _mGender,
                        context)
                    .then(
                  (value) {
                    ProfileDialog().successDialog(context, value);
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
        title: Text(title),
        trailing: Wrap(
          children: [
            Text(
              trailing,
              style: TextStyle(
                fontSize: 12,
              ),
            )
          ],
        ),
      ),
    );
  }
}
