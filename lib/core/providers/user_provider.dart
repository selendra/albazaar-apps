import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:selendra_marketplace_app/all_export.dart';
import 'package:http_parser/http_parser.dart';

class UserProvider with ChangeNotifier {
  var _mUser = new User();
  User get mUser => _mUser;
  String alertText;
  PrefService _prefService = PrefService();

  //Fetch user profile from Api
  Future<void> fetchUserPf(String _token) async {
    //This response variable is user to the repsonse from requesting to api
    http.Response response =
        await http.get(ApiUrl.SET_USER_PROFILE, headers: <String, String>{
      "accept": "application/json",
      "authorization": "Bearer " + _token,
    });

    //Decode repsonsebody and assign it user object
    var responseBody = json.decode(response.body);
    _mUser = User.fromJson(responseBody);

    //This will save all user information to sharepreferenece
    _prefService.saveString('user', jsonEncode(responseBody));

    //It check if the string of username is null and set it to empty string
    if (_mUser.firstName == null &&
        _mUser.midName == null &&
        _mUser.lastName == null) {
      _mUser.firstName = '';
      _mUser.midName = '';
      _mUser.lastName = '';
    }

    //NOTIFY IF ANYTHING CHANGE
    notifyListeners();
  }

  //READ USER INFO FROM SHARE PREFERENCE
  void fetchUserInfo() {
    _prefService.read('user').then((value) {
      if (value != null) {
        var responseBody = json.decode(value);
        _mUser = User.fromJson(responseBody);
      }
    });
  }

  //FETCH USER INFOMATION OF SOCIAL ACCOUNT USER
  void fetchSocialUserInfo(String email, String displayName, String photoUrl) {
    _mUser.email = email;
    _mUser.firstName = displayName;
    _mUser.lastName = '';
    _mUser.midName = '';
    _mUser.profileImg = photoUrl;
  }

  void setLocation(String location) {
    _mUser.address = location;
    notifyListeners();
  }

  //Update user gender
  void setGender(String value) {
    mUser.gender = value;
    notifyListeners();
  }

  //This function is use to update user profile information to the Api
  Future<String> setUserPf(String firstName, String midName, String lastName,
      String gender, BuildContext context) async {
    await _prefService.read('token').then((value) async {
      var response = await http.post(
        ApiUrl.SET_USER_PROFILE,
        headers: <String, String>{
          "accept": "application/json",
          "authorization": "Bearer " + value,
          "Content-Type": "application/json"
        },
        body: jsonEncode(
          <String, String>{
            "first_name": firstName,
            "mid_name": midName,
            "last_name": lastName,
            "gender": gender,
          },
        ),
      );

      var responseBody = json.decode(response.body);
      if (response.statusCode == 200) {
        alertText = responseBody['message'];
        fetchUserPf(value);
      } else {
        alertText = responseBody['error']['message'];
      }
    });
    return alertText;
  }

  //This function is use to request wallet from the api
  Future<String> getWallet(String pin) async {
    await _prefService.read('token').then((value) async {
      var response = await http.post(ApiUrl.GET_WALLET,
          headers: <String, String>{
            "accept": "application/json",
            "authorization": "Bearer " + value,
            "Content-Type": "application/json"
          },
          body: jsonEncode(<String, String>{"pin": pin}));
      var responseBody = json.decode(response.body);
      if (response.statusCode == 200) {
        String _seed;
        try {
          alertText = responseBody['message'];
        } catch (e) {
          var wallet = WalletResponse.fromJson(responseBody);
          _seed = responseBody['message']['seed'];
          if (_seed != null) {
            _prefService.saveString('seed', _seed);
          }
        }
      } else {
        alertText = responseBody['error']['message'];
      }
    });
    return alertText;
  }

  //This function is use to fetch portforlio of the logged in user
  Future<String> fetchPortforlio() async {
    try {
      await _prefService.read('token').then((onValue) async {
        http.Response response = await http.get(ApiUrl.DISPLAY_PORTFORLIO, headers: <String, String>{
          "accept": "application/json",
          "authorization": "Bearer " + onValue,
        });

        if (response.statusCode == 200) {
          var responseBody = json.decode(response.body);
          if (responseBody['error'] == null) {
            mBalance = Balance.fromMap(responseBody);
            wallets[0].amount = mBalance.data.balance;
            notifyListeners();
          } else {
            alertText = responseBody['error']['message'];
          }

          alertText = response.statusCode.toString();
        } else {
          throw HttpException("${response.statusCode}");
        }
      });
    } catch (e) {
      // print(e.toString());
    }

    notifyListeners();
    return alertText ?? '';
  }

  Future<String> upLoadImage(File _image) async {
    /* Upload image to server by use multi part form*/
    //SharedPreferences isToken = await SharedPreferences.getInstance();
    String token, imageUrl;

    // token = isToken.getString('token');
    await _prefService.read('token').then((value) {
      token = value;
    });
    /* Compress image file */
    List<int> compressImage = await FlutterImageCompress.compressWithFile(
      _image.path,
      minHeight: 1300,
      minWidth: 1000,
      quality: 100,
    );
    /* Make request */
    var request = new http.MultipartRequest(
        'POST', Uri.parse('https://s3.selendra.com/upload'));
    /* Make Form of Multipart */
    var multipartFile = new http.MultipartFile.fromBytes(
      'file',
      compressImage,
      filename: 'image_picker.jpg',
      contentType: MediaType.parse('image/jpeg'),
    );
    /* Concate Token With Header */
    request.headers.addAll({
      "accept": "application/json",
      "authorization": "Bearer " + token,
      "Content-Type": "application/json"
    });
    request.files.add(multipartFile);
    /* Start send to server */
    http.StreamedResponse response = await request.send();
    /* Getting response */
    response.stream.transform(utf8.decoder).listen((data) {
      imageUrl = data;
    });

    return imageUrl;
  }
}
