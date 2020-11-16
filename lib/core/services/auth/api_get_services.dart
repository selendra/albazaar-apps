// import 'dart:io';
// import 'package:flutter/foundation.dart';
// import 'package:http/http.dart' as http;
// import 'dart:convert';
// import 'package:geolocator/geolocator.dart';
// import 'package:selendra_marketplace_app/all_export.dart';

// class ApiGetServices with ChangeNotifier {
//   var _mUser = new User();
//   User get mUser => _mUser;
//   String alertText;
//   PrefService _prefService = PrefService();

//   //FETCH USER INFORMATION FROM ENDPOINT
//   Future<void> fetchUserPf(String _token) async {
//     //MAKE SERVER REQUEST AND WAIT FOR REPSONSE
//     var response =
//         await http.get(ApiUrl.SET_USER_PROFILE, headers: <String, String>{
//       "accept": "application/json",
//       "authorization": "Bearer " + _token,
//     });

//     //DECODE RESPONSE BODY ASSIGN IT TO USER OBJECT
//     var responseBody = json.decode(response.body);
//     _mUser = User.fromJson(responseBody);

//     //THIS WILL SAVE ALL USER INFORMATION TO SHARE PREFERENCE
//     _prefService.saveString('user', jsonEncode(responseBody));

//     //IT CHECK IF THE FIRSTNAME MIDNAME LASTNAME IS ALL NULL AND SET THE EMPTY STRING
//     if (_mUser.firstName == null &&
//         _mUser.midName == null &&
//         _mUser.lastName == null) {
//       _mUser.firstName = '';
//       _mUser.midName = '';
//       _mUser.lastName = '';
//     }

//     //NOTIFY IF ANYTHING CHANGE
//     notifyListeners();
//   }

//   //READ USER INFO FROM SHARE PREFERENCE
//   void fetchUserInfo() {
//     _prefService.read('user').then((value) {
//       var responseBody = json.decode(value);
//       _mUser = User.fromJson(responseBody);
//     });
//   }

//   //FETCH USER INFOMATION OF SOCIAL ACCOUNT USER
//   void fetchSocialUserInfo(String email, String displayName, String photoUrl) {
//     _mUser.email = email;
//     _mUser.firstName = displayName;
//     _mUser.lastName = '';
//     _mUser.midName = '';
//     _mUser.profileImg = photoUrl;
//   }

//   //UPDATE USER GENDER
//   void setGender(String value) {
//     mUser.gender = value;
//     print(mUser.gender);
//     notifyListeners();
//   }

//   //FETCH PORTFORLIO OF THE USER
//   Future<String> fetchPortforlio() async {
//     try {
//       // if (response.statusCode != 200) throw HttpException('${response.statusCode}');
//       await _prefService.read('token').then((onValue) async {
//         var response =
//             await http.get(ApiUrl.DISPLAY_PORTFORLIO, headers: <String, String>{
//           "accept": "application/json",
//           "authorization": "Bearer " + onValue,
//         });

//         if (response.statusCode == 200) {
//           var responseBody = json.decode(response.body);
//           print(responseBody);

//           if (responseBody['error'] == null) {
//             mBalance = Balance.fromMap(responseBody);
//           } else {
//             alertText = responseBody['error']['message'];
//             print(alertText);
//           }

//           alertText = response.statusCode.toString();
//         } else {
//           throw HttpException("${response.statusCode}");
//         }
//       });
//     } on SocketException {
//       print('No Internet connection 😑');
//     } on HttpException {
//       print("Couldn't find the post 😱");
//     } on FormatException {
//       print("Bad response format 👎");
//     }

//     return alertText ?? '';
//   }

//   //FETCH PLACE WHEN USER SEARCH IN MAP
//   Future<Placemark> fetchPlaceList(String query) async {
//     var response = await http.get(ApiUrl.MAP_SEARCH + query);
//     print(response.body);
//     if (response.statusCode == 200) {
//       return null;
//     } else {
//       print(response.statusCode);
//     }
//     return null;
//   }
// }
