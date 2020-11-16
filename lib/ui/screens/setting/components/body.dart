import 'package:flutter/material.dart';
import 'package:selendra_marketplace_app/all_export.dart';

class Body extends StatefulWidget {
  @override
  _BodyState createState() => _BodyState();
}

class _BodyState extends State<Body> {
  bool _isTouchIdOn = false;
  bool _isPinOn = false;

  void checkTouchID() {
    setState(() {
      _isTouchIdOn = !_isTouchIdOn;
      if (_isTouchIdOn == true) {
        print('Fingerprint Active');
      } else {
        print('Fingerprint is not Active');
      }
    });
  }

  void checkPin() {
    setState(() {
      _isPinOn = !_isPinOn;
      if (_isPinOn == true) {
        print('PIN is on');
      } else {
        print('Pin is Off');
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    var _lang = AppLocalizeService.of(context);
    return Container(
      child: Column(
        children: <Widget>[
          Container(
            color: Colors.grey[200],
            child: ListTile(
              title: Text(
                _lang.translate('general'),
                style: TextStyle(
                  fontWeight: FontWeight.w600,
                  color: Colors.grey[600],
                ),
              ),
            ),
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
            color: Colors.grey[200],
            child: ListTile(
              title: Text(
                _lang.translate('security'),
                style: TextStyle(
                  fontWeight: FontWeight.w600,
                  color: Colors.grey[600],
                ),
              ),
            ),
          ),
          InkWell(
            onTap: () {
              Navigator.pushNamed(context, ResetChoiceView);
            },
            splashColor: Colors.grey,
            child: ListTile(
              title: Text('Reset Password'),
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
            color: Colors.grey[200],
            child: ListTile(
              title: Text(
                _lang.translate('version'),
                style: TextStyle(
                  fontWeight: FontWeight.w600,
                  color: Colors.grey[600],
                ),
              ),
            ),
          ),
          Container(
            child: ListTile(
              title: Text(
                '0.1',
              ),
            ),
          ),
          Expanded(
            child: Container(
              color: Colors.grey[200],
            ),
          )
        ],
      ),
    );
  }
}
