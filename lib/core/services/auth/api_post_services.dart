// import 'dart:convert';
// import 'dart:io';
// import 'package:http/http.dart' as http;
// import 'package:flutter/material.dart';
// import 'package:flutter_image_compress/flutter_image_compress.dart';
// import 'package:http_parser/http_parser.dart';
// import 'package:selendra_marketplace_app/all_export.dart';
// import 'package:provider/provider.dart';

// class ApiPostServices with ChangeNotifier {
//   String _alertText, _token;
//   PrefService _pref = PrefService();
//   String get alertText => _alertText;

//   //USER SIGN IN USING EMAIL AND PASSWORD
//   Future<String> signInByEmail(String email, String password, context) async {
//     var response = await http.post(ApiUrl.LOG_IN_URL,
//         headers: ApiHeader.headers,
//         body: jsonEncode(<String, String>{
//           'email': email,
//           'password': password,
//         }));
//     if (response.statusCode == 200) {
//       var responseJson = json.decode(response.body);
//       _token = responseJson['token'];
//       if (_token != null) {
//         _pref.saveString('token', _token);
//         Provider.of<ApiGetServices>(context, listen: false).fetchUserPf(_token);
//         Provider.of<ProductsProvider>(context, listen: false).getVegi();
//         Navigator.pushReplacementNamed(context, BottomNavigationView);
//       } else {
//         _alertText = responseJson['message'];
//         if (_alertText == null) {
//           _alertText = responseJson['error']['message'];
//           print(_alertText);
//         }
//       }
//     } else {
//       print(response.body);
//     }
//     notifyListeners();
//     return _alertText;
//   }

//   //USER SIGN IN USING PHONE NUMBER AND PASSWORD
//   Future<String> signInByPhone(String phone, String password, context) async {
//     var response = await http.post(ApiUrl.LOG_IN_PHONE,
//         headers: ApiHeader.headers,
//         body: jsonEncode(<String, String>{
//           'phone': phone,
//           'password': password,
//         }));
//     if (response.statusCode == 200) {
//       var responseJson = json.decode(response.body);

//       _token = responseJson['token'];

//       if (_token != null) {
//         print(_token);
//         _pref.saveString('token', _token);
//         Provider.of<ApiGetServices>(context, listen: false)
//             .fetchPortforlio()
//             .then((onValue) {
//           if (onValue == '200') {
//             Provider.of<ApiGetServices>(context, listen: false)
//                 .fetchUserPf(_token);
//             Provider.of<ProductsProvider>(context, listen: false).getVegi();
//             Navigator.pushReplacementNamed(context, BottomNavigationView);
//           }
//         });
//       } else {
//         try {
//           _alertText = responseJson['error']['message'];
//         } catch (e) {
//           _alertText = responseJson['message'];
//         }
//       }
//     } else {
//       print(response.body);
//     }
//     return _alertText;
//   }

//   //USER RESET THEIR PASSWORD BY EMAIL
//   Future<String> forgetPasswordByEmail(String email) async {
//     var response = await http.post(ApiUrl.RESET_BY_EMAIL,
//         headers: ApiHeader.headers,
//         body: jsonEncode(<String, String>{'email': email}));
//     if (response.statusCode == 200) {
//       var responseBody = json.decode(response.body);
//       _alertText = responseBody['message'];
//     }
//     return _alertText;
//   }

//   //USER RESET THEIR PASSWORD BY PHONE NUMBER
//   Future<String> forgetPasswordByPhone(String phoneNumber) async {
//     var response = await http.post(ApiUrl.RESET_BY_PHONE,
//         headers: ApiHeader.headers,
//         body: jsonEncode(<String, String>{'phone': '+855' + phoneNumber}));
//     if (response.statusCode == 200) {
//       var responseBody = json.decode(response.body);
//       _alertText = responseBody['message'];
//     }
//     return _alertText;
//   }

//   //USER SIGN UP THEIR ACCOUNT USING EMAIL AND PASSWORD
//   Future<String> signUpByEmail(String email, String password) async {
//     var response = await http.post(ApiUrl.SIGN_UP_EMAIL,
//         headers: ApiHeader.headers,
//         body: jsonEncode(<String, String>{
//           'email': email,
//           'password': password,
//         }));
//     if (response.statusCode == 200) {
//       var responseBody = jsonDecode(response.body);
//       _alertText = responseBody['message'];
//     } else {
//       print(response.body);
//     }

//     return _alertText;
//   }

//   //USER SIGN UP THEIR ACCOUNT USING PHONE AND PASSWORD
//   Future<String> signUpByPhone(String phone, String password, context) async {
//     var response = await http.post(ApiUrl.SIGN_UP_PHONE,
//         headers: ApiHeader.headers,
//         body: jsonEncode(<String, String>{
//           'phone': phone,
//           'password': password,
//         }));

//     if (response.statusCode == 200) {
//       var responseBody = json.decode(response.body);
//       _alertText = responseBody['message'];

//       if (_alertText == 'Successfully registered!') {
//         Navigator.pushReplacement(
//             context,
//             MaterialPageRoute(
//                 builder: (context) => OTPScreen(phone, password)));
//       } else {
//         return _alertText;
//       }
//     } else {
//       print(response.body);
//     }
//     return _alertText;
//   }

//   //USER UPDATE THEIR PROFILE INFORMATION
//   Future<String> setUserPf(String firstName, String midName, String lastName,
//       String gender, context) async {
//     await _pref.read('token').then((value) async {
//       print(value);
//       var response = await http.post(
//         ApiUrl.SET_USER_PROFILE,
//         headers: <String, String>{
//           "accept": "application/json",
//           "authorization": "Bearer " + value,
//           "Content-Type": "application/json"
//         },
//         body: jsonEncode(
//           <String, String>{
//             "first_name": firstName,
//             "mid_name": midName,
//             "last_name": lastName,
//             "gender": gender,
//           },
//         ),
//       );

//       var responseBody = json.decode(response.body);
//       if (response.statusCode == 200) {
//         _alertText = responseBody['message'];
//         Provider.of<ApiGetServices>(context, listen: false).fetchUserPf(value);
//       } else {
//         _alertText = responseBody['error']['message'];
//       }
//     });
//     print(_alertText);
//     return _alertText;
//   }

//   //USER REQUEST TO GET THEIR PEER TO PEER WALLET
//   Future<String> getWallet(String pin) async {
//     await _pref.read('token').then((value) async {
//       var response = await http.post(ApiUrl.GET_WALLET,
//           headers: <String, String>{
//             "accept": "application/json",
//             "authorization": "Bearer " + value,
//             "Content-Type": "application/json"
//           },
//           body: jsonEncode(<String, String>{"pin": pin}));
//       var responseBody = json.decode(response.body);
//       if (response.statusCode == 200) {
//         String _seed;
//         try {
//           _alertText = responseBody['message'];
//         } catch (e) {
//           var wallet = WalletResponse.fromJson(responseBody);
//           print(wallet);
//           _seed = responseBody['message']['seed'];
//           if (_seed != null) {
//             print(_seed);
//             _pref.saveString('seed', _seed);
//           }
//         }
//       } else {
//         print(responseBody);
//         _alertText = responseBody['error']['message'];
//       }
//     });
//     return _alertText;
//   }

//   //USER VERIFY THEIR IDENTITY USING PHONE NUMBER
//   Future<String> verifyByPhone(String phone, String verifyCode) async {
//     var response = await http.post(ApiUrl.VERIFY_BY_PHONE,
//         headers: ApiHeader.headers,
//         body: jsonEncode(<String, String>{
//           'phone': phone,
//           'verification_code': verifyCode,
//         }));

//     if (response.statusCode == 200) {
//       var responseBody = json.decode(response.body);
//       try {
//         _alertText = responseBody['error']['message'];
//       } catch (e) {}
//     }

//     return _alertText;
//   }

//   //ADD PHONE NUMBER TO THEIR EXISTING ACCOUNT
//   Future<String> addPhoneNumber(String _token, String _phoneNumber) async {
//     var response = await http.post(ApiUrl.ADD_PHONE_NUMBER,
//         headers: <String, String>{
//           "accept": "application/json",
//           "authorization": "Bearer " + _token,
//           "Content-Type": "application/json"
//         },
//         body: jsonEncode(<String, String>{
//           "phone": _phoneNumber,
//         }));
//     if (response.statusCode == 200) {
//       var responseBody = json.decode(response.body);
//       print(responseBody);
//       if (responseBody != null) {
//         try {
//           _alertText = responseBody['message'];
//           if (_alertText == null) {
//             _alertText = responseBody['error']['message'];
//           }
//         } catch (e) {
//           _alertText = responseBody['error']['message'];
//         }
//       }
//       print(_alertText);
//     }
//     return _alertText;
//   }

//   //RESEND THE OTP CODE BY USING PHONE NUMBER
//   Future<String> resendCode(String phoneNumber) async {
//     var response = await http.post(ApiUrl.RESEND_CODE,
//         headers: ApiHeader.headers,
//         body: <String, String>{
//           'phone': phoneNumber,
//         });
//     if (response.statusCode == 200) {
//       var responseJson = json.decode(response.body);
//       try {
//         _alertText = responseJson['message'];
//       } catch (e) {
//         _alertText = responseJson['error']['message'];
//       }
//     }

//     return _alertText;
//   }

//   Future<String> upLoadImage(File _image) async {
//     /* Upload image to server by use multi part form*/
//     //SharedPreferences isToken = await SharedPreferences.getInstance();
//     String token, imageUrl;

//     // token = isToken.getString('token');
//     await _pref.read('token').then((value) {
//       token = value;
//     });
//     /* Compress image file */
//     List<int> compressImage = await FlutterImageCompress.compressWithFile(
//       _image.path,
//       minHeight: 1300,
//       minWidth: 1000,
//       quality: 100,
//     );
//     /* Make request */
//     var request = new http.MultipartRequest(
//         'POST', Uri.parse('https://s3.zeetomic.com/upload'));
//     /* Make Form of Multipart */
//     var multipartFile = new http.MultipartFile.fromBytes(
//       'file',
//       compressImage,
//       filename: 'image_picker.jpg',
//       contentType: MediaType.parse('image/jpeg'),
//     );
//     /* Concate Token With Header */
//     request.headers.addAll({
//       "accept": "application/json",
//       "authorization": "Bearer " + token,
//       "Content-Type": "application/json"
//     });
//     request.files.add(multipartFile);
//     /* Start send to server */
//     http.StreamedResponse response = await request.send();
//     /* Getting response */
//     response.stream.transform(utf8.decoder).listen((data) {
//       print("Image url $data");
//       imageUrl = data;
//     });

//     return imageUrl;
//   }
// }
