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

    //Notify that value is updated and update the ui
    notifyListeners();
  }

  /*It read user information from share preference
   *(local storage on device)
   */
  void fetchUserInfo() {
    _prefService.read('user').then((value) {
      if (value != null) {
        var responseBody = json.decode(value);
        _mUser = User.fromJson(responseBody);
      }
    });
  }

  //Fetch user info from social
  void fetchSocialUserInfo(
      String email, String firstName, String lastName, String photoUrl) {
    _mUser.email = email;
    _mUser.firstName = firstName;
    _mUser.lastName = lastName;
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

  //This function is use to set user profile information to the Api
  Future<String> setUserPf(String firstName, String midName, String lastName,
      String gender, String imageUri, String address) async {
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
            "image_uri": imageUri,
            "address": address,
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

//This function is use to update user profile information to the Api
  Future<String> updateUserPf(String firstName, String midName, String lastName,
      String gender, String imageUri, String address) async {
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
            "image_uri": imageUri,
            "address": address
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
      print("My Token $value");
      print("My PIN $pin");
      var response = await http.post(ApiUrl.GET_WALLET,
          headers: <String, String>{
            "accept": "application/json",
            "authorization": "Bearer " + value,
            "Content-Type": "application/json"
          },
          body: jsonEncode(<String, String>{"pin": pin}));
      print("Getting wallet ${response.body}");
      var responseBody = json.decode(response.body);
      if (response.statusCode == 200) {
        String _seed;

        alertText = responseBody['message'];
        //var wallet = WalletResponse.fromJson(responseBody);
        _seed = responseBody['message']['seed'];

        if (_seed != null) {
          _prefService.saveString('seed', _seed);
        }
      } else {
        alertText = responseBody['error']['message'];
      }
    });
    return alertText;
  }

  //This function is use to fetch portforlio of the logged in user
  Future<String> fetchPortforlio() async {
    // mBalance = Balance();
    try {
      await _prefService.read('token').then((onValue) async {
        http.Response response =
            await http.get(ApiUrl.DISPLAY_PORTFORLIO, headers: <String, String>{
          "accept": "application/json",
          "authorization": "Bearer " + onValue,
        });

        if (response.statusCode == 200) {
          var responseBody = json.decode(response.body);
          if (responseBody.containsKey('error')) {
            alertText = responseBody['error']['message'];
          } else {
            if (mBalance.data != null) mBalance.data.balance = '';
            mBalance = Balance.fromMap(responseBody);

            // Check Balance Retrieve NULL
            if (mBalance.data != null)
              wallets[0].amount = mBalance.data.balance;
            notifyListeners();
          }

          alertText = response.statusCode.toString();
        } else {
          throw HttpException("${response.statusCode}");
        }
      });
    } catch (e) {
      print(e.toString());
    }

    notifyListeners();
    return alertText ?? '';
  }

  Future<String> upLoadImage(File _image) async {
    /* Upload image to server by use multi part form*/
    //SharedPreferences isToken = await SharedPreferences.getInstance();
    String token;

    // token = isToken.getString('token');
    await _prefService.read('token').then((value) {
      token = value;
    });

    /* Compress image file */
    List<int> compressImage = await FlutterImageCompress.compressWithFile(
      _image.path,
      minHeight: 900,
      minWidth: 600,
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
    String imageUrl;
    try {
      /* Start send to server */
      http.StreamedResponse response = await request.send();
      imageUrl = await response.stream.bytesToString();
    } catch (e) {}

    print('imagr url $imageUrl');

    return imageUrl;
  }
}
