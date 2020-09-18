import 'dart:async';
import 'package:connectivity/connectivity.dart';
import 'package:selendra_marketplace_app/core/enums/connectivity_status.dart';


class ConnectivityServices{

  StreamController<ConnectivityStatus> streamController = StreamController<ConnectivityStatus>();

  ConnectivityServices(){
    Connectivity().onConnectivityChanged
        .listen((ConnectivityResult result) {
        var connectivityStatus = getStatusFromResult(result);
        streamController.add(connectivityStatus);
    });
  }
  ConnectivityStatus getStatusFromResult(ConnectivityResult result){
    switch(result){
      case ConnectivityResult.mobile:
        return  ConnectivityStatus.CELLULAR;
      case ConnectivityResult.wifi:
        return  ConnectivityStatus.WIFI;
      case ConnectivityResult.none:
        return  ConnectivityStatus.OFFLINE;
      default:
        return ConnectivityStatus.OFFLINE;
    }
  }
}