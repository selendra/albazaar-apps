import 'package:flutter/material.dart';
import 'package:selendra_marketplace_app/all_export.dart';

class SettingScreen extends StatefulWidget {
  @override
  _SettingScreenState createState() => _SettingScreenState();
}

class _SettingScreenState extends State<SettingScreen> {
  bool _isTouchIdOn = false;
  bool _isPinOn = false;

  void checkTouchID() {
    setState(() {
      _isTouchIdOn = !_isTouchIdOn;
      if (_isTouchIdOn == true) {}
    });
  }

  void checkPin() {
    setState(() {
      _isPinOn = !_isPinOn;
      if (_isPinOn == true) {}
    });
  }

  @override
  Widget build(BuildContext context) {
    final _lang = AppLocalizeService.of(context);
    return Scaffold(
      appBar: ReuseSimpleAppBar.getItem(
          AppLocalizeService.of(context).translate('setting'), context),
      body: Responsive(
        desktop: ReuseDesktop(
          widget: Container(
            height: MediaQuery.of(context).size.height,
            child: Column(
              children: <Widget>[
                Container(
                  child: ListTile(
                    title: Text(
                      _lang.translate('general'),
                      style: TextStyle(
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ),
                Container(
                  height: 2,
                  margin: const EdgeInsets.only(left: 20.0, right: 20.0),
                  color: Colors.grey[300],
                ),
                InkWell(
                  onTap: () {
                    Navigator.pushReplacementNamed(context, LangView);
                  },
                  splashColor: Colors.grey,
                  child: ListTile(
                    title: Text(_lang.translate('language')),
                    leading: Icon(
                      Icons.language,
                      color: kDefaultColor,
                    ),
                    trailing: Icon(
                      Icons.arrow_forward_ios,
                      color: kDefaultColor,
                    ),
                  ),
                ),
                InkWell(
                  onTap: () {},
                  splashColor: Colors.grey,
                  child: ListTile(
                    title: Text(_lang.translate('currency')),
                    leading: Icon(
                      Icons.monetization_on,
                      color: kDefaultColor,
                    ),
                    trailing: Icon(
                      Icons.arrow_forward_ios,
                      color: kDefaultColor,
                    ),
                  ),
                ),
                Container(
                  //color: Colors.grey[200],
                  child: ListTile(
                    title: Text(
                      _lang.translate('security'),
                      style: TextStyle(
                        fontWeight: FontWeight.w600,
                        //color: Colors.grey[600],
                      ),
                    ),
                  ),
                ),
                Container(
                  height: 2,
                  margin: const EdgeInsets.only(left: 20.0, right: 20.0),
                  color: Colors.grey[300],
                ),
                InkWell(
                  onTap: () {
                    Navigator.pushNamed(context, ResetChoiceView);
                  },
                  splashColor: Colors.grey,
                  child: ListTile(
                    title: Text(_lang.translate('reset_password')),
                    leading: Icon(
                      Icons.lock,
                      color: kDefaultColor,
                    ),
                    trailing: Icon(
                      Icons.arrow_forward_ios,
                      color: kDefaultColor,
                    ),
                  ),
                ),
                Container(
                    child: SwitchListTile(
                  title: Text('Touch ID'),
                  value: _isTouchIdOn,
                  onChanged: (value) {
                    checkTouchID();
                  },
                  secondary: Icon(
                    Icons.fingerprint,
                    color: kDefaultColor,
                  ),
                )),
                Container(
                  child: SwitchListTile(
                    title: Text('PIN Code'),
                    value: _isPinOn,
                    onChanged: (value) {
                      checkPin();
                    },
                    secondary: Icon(
                      Icons.fiber_pin,
                      color: kDefaultColor,
                    ),
                  ),
                ),
                Container(
                  // color: Colors.grey[200],
                  child: ListTile(
                    title: Text(
                      _lang.translate('version'),
                      style: TextStyle(
                        fontWeight: FontWeight.w600,
                        // color: Colors.grey[600],
                      ),
                    ),
                  ),
                ),
                Container(
                  height: 2,
                  margin: const EdgeInsets.only(left: 20.0, right: 20.0),
                  color: Colors.grey[300],
                ),
                Container(
                  child: ListTile(
                    title: Text(
                      '0.1',
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
        mobile: Container(
          height: MediaQuery.of(context).size.height,
          child: Column(
            children: <Widget>[
              Container(
                // color: Colors.grey[200],
                child: ListTile(
                  title: Text(
                    _lang.translate('general'),
                    style: TextStyle(
                      fontWeight: FontWeight.w600,
                      //color: Colors.grey[600],
                    ),
                  ),
                ),
              ),
              Container(
                height: 2,
                margin: const EdgeInsets.only(left: 20.0, right: 20.0),
                color: Colors.grey[300],
              ),
              InkWell(
                onTap: () {
                  Navigator.pushReplacementNamed(context, LangView);
                },
                splashColor: Colors.grey,
                child: ListTile(
                  title: Text(_lang.translate('language')),
                  leading: Icon(
                    Icons.language,
                    color: kDefaultColor,
                  ),
                  trailing: Icon(
                    Icons.arrow_forward_ios,
                    color: kDefaultColor,
                  ),
                ),
              ),
              InkWell(
                onTap: () {},
                splashColor: Colors.grey,
                child: ListTile(
                  title: Text(_lang.translate('currency')),
                  leading: Icon(
                    Icons.monetization_on,
                    color: kDefaultColor,
                  ),
                  trailing: Icon(
                    Icons.arrow_forward_ios,
                    color: kDefaultColor,
                  ),
                ),
              ),
              const SizedBox(height: 20),
              Container(
                //color: Colors.grey[200],
                child: ListTile(
                  title: Text(
                    _lang.translate('security'),
                    style: TextStyle(
                      fontWeight: FontWeight.w600,
                      //  color: Colors.grey[600],
                    ),
                  ),
                ),
              ),
              Container(
                height: 2,
                margin: const EdgeInsets.only(left: 20.0, right: 20.0),
                color: Colors.grey[300],
              ),
              InkWell(
                onTap: () {
                  Navigator.pushNamed(context, ResetChoiceView);
                },
                splashColor: Colors.grey,
                child: ListTile(
                  title: Text(_lang.translate('reset_password')),
                  leading: Icon(
                    Icons.lock,
                    color: kDefaultColor,
                  ),
                  trailing: Icon(
                    Icons.arrow_forward_ios,
                    color: kDefaultColor,
                  ),
                ),
              ),
              Container(
                  child: SwitchListTile(
                title: Text('Touch ID'),
                value: _isTouchIdOn,
                onChanged: (value) {
                  checkTouchID();
                },
                secondary: Icon(
                  Icons.fingerprint,
                  color: kDefaultColor,
                ),
              )),
              Container(
                child: SwitchListTile(
                  title: Text('PIN Code'),
                  value: _isPinOn,
                  onChanged: (value) {
                    checkPin();
                  },
                  secondary: Icon(
                    Icons.fiber_pin,
                    color: kDefaultColor,
                  ),
                ),
              ),
              const SizedBox(height: 20),
              Container(
                //color: Colors.grey[200],
                child: ListTile(
                  title: Text(
                    _lang.translate('version'),
                    style: TextStyle(
                      fontWeight: FontWeight.w600,
                      //  color: Colors.grey[600],
                    ),
                  ),
                ),
              ),
              Container(
                height: 2,
                margin: const EdgeInsets.only(left: 20.0, right: 20.0),
                color: Colors.grey[300],
              ),
              Container(
                child: ListTile(
                  title: Text(
                    '0.1',
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
