import 'package:flutter/material.dart';

class Body extends StatefulWidget {
  @override
  _BodyState createState() => _BodyState();
}

class _BodyState extends State<Body> {

  bool _isTouchIdOn = false;
  bool _isPinOn = false;


  void checkTouchID (){
    setState(() {
      _isTouchIdOn = !_isTouchIdOn;
      if(_isTouchIdOn==true){
        print('Fingerprint Active');
      }else{
        print('Fingerprint is not Active');
      }
    });
  }
  void checkPin(){
    setState(() {
      _isPinOn = !_isPinOn;
      if(_isPinOn==true){
        print('PIN is on');
      }else{
        print('Pin is Off');
      }
    });
  }
  @override
  Widget build(BuildContext context) {
    return _buildBody();
  }
  Widget _buildBody(){
    return Container(
      child: Column(
        children: <Widget>[
          Container(
            color: Colors.grey[200],
            child: ListTile(
              title: Text(
                'GENERAL',
                style: TextStyle(
                  fontWeight: FontWeight.w600,
                  color: Colors.grey[600],
                ),
              ),
            ),
          ),
          InkWell(
            onTap: (){
              print('Accounts');
            },
            splashColor: Colors.grey,
            child: ListTile(
              title: Text('Accounts'),
              leading: Icon(Icons.account_circle),
              trailing: Icon(Icons.arrow_forward_ios),
            ),
          ),
          InkWell(
            onTap: (){
              print('Language');
            },
            splashColor: Colors.grey,
            child: ListTile(
              title: Text('Language'),
              leading: Icon(Icons.language),
              trailing: Icon(Icons.arrow_forward_ios),
            ),
          ),
          InkWell(
            onTap: (){
              print('Currency');
            },
            splashColor: Colors.grey,
            child: ListTile(
              title: Text('Currency'),
              leading: Icon(Icons.monetization_on),
              trailing: Icon(Icons.arrow_forward_ios),
            ),
          ),
          Container(
            color: Colors.grey[200],
            child: ListTile(
              title: Text(
                'SECURITY',
                style: TextStyle(
                  fontWeight: FontWeight.w600,
                  color: Colors.grey[600],
                ),
              ),
            ),
          ),
          Container(
              child: SwitchListTile(
                title: Text('Touch ID'),
                value: _isTouchIdOn,
                onChanged: (value){
                  checkTouchID();
                },
                secondary: Icon(Icons.fingerprint),
              )
          ),
          Container(
            child: SwitchListTile(
              title: Text('PIN Code'),
              value: _isPinOn,
              onChanged: (value){
                checkPin();
              },
              secondary: Icon(Icons.fiber_pin),
            ),
          ),
          Container(
            color: Colors.grey[200],
            child: ListTile(
              title: Text(
                'VERSION',
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
