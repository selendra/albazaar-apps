import 'package:albazaar_app/all_export.dart';
import 'package:latlong/latlong.dart';

class ShopModel {

  TabController tabController;

  bool isSold = false;

  // For Button
  bool canSubmit = false;
  List<dynamic> shopCreate = [];

  String thumbnail;

  String profile;
  String cover;

  List<Product> product;
  TextEditingController about;
  
  double lat, long;

  String locationName;

  MapController mapController = MapController();
  LocationMarker marker = LocationMarker(lat: 11.56959, long: 104.92104);

  void init(){
    lat = 11.56959;
    long = 104.92104;
    locationName = '';
    thumbnail = '';
    profile = '';
    product = [];
    cover = '';
    about = TextEditingController();
  }
}