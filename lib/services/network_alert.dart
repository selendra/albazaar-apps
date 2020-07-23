import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:selendra_marketplace_app/enums/connectivity_status.dart';

class NetworkAlert extends StatefulWidget {

  final Widget child;
  NetworkAlert(this.child);

  @override
  _NetworkAlertState createState() => _NetworkAlertState();
}

class _NetworkAlertState extends State<NetworkAlert> {
  Widget _popupDialog(BuildContext context) {
    setState(() {
      showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
              title: Text('No Internet Connection !!!'),
              content: Text('Please check your internet connection ..'),
              actions: <Widget>[
                FlatButton(
                    onPressed: () => Navigator.pop(context),
                    child: Text('OK')),
              ],
            );
          });
    });
  }
  @override
  Widget build(BuildContext context) {
    var connectionStatus = Provider.of<ConnectivityStatus>(context);

    if (connectionStatus == ConnectivityStatus.OFFLINE) {
      return Container(
        child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                CircularProgressIndicator(),
                SizedBox(height: 20,),
                Text('No Internet Connection'),
              ],
            ),
        ),
      );
    }else{
      return widget.child;
    }

  }
}
