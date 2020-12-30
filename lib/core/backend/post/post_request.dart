import 'dart:io';

import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'package:selendra_marketplace_app/all_export.dart';
import 'package:http/http.dart' as _http;

class PostRequest {
  SelendraApi _sldApi = SelendraApi();

  Backend _backend = Backend();

  Future<dynamic> inviteFriend(String phoneNumber) async {
    _backend.token = await StorageServices.fetchData('user_token');
    // _backend.bodyEncode = json.encode({"phone": phoneNumber});
    // if (_backend.token != null) {
    //   _backend.response = await _http.post("${_sldApi.walletAPI}/invite-phonenumber",
    //       headers: _backend.conceteHeader(
    //           "authorization", "Bearer ${_backend.token["token"]}"),
    //       body: _backend.bodyEncode);
    // }
    // return json.decode(_backend.response.body);
    return null;
  }

  /* ------------------User Login-------------- */

  Future<_http.Response> loginByPhone(String phone, String passwords) async {
    _backend.bodyEncode = json.encode({
      /* Convert to Json String */
      "phone": "+855$phone",
      "password": passwords
    });
    _backend.response = await _http.post('${_sldApi.api}/loginbyphone',
        headers: _backend.conceteHeader(null, null), body: _backend.bodyEncode);
    return _backend.response;
  }

  Future<_http.Response> loginByEmail(String email, String passwords) async {
    /* User Login */
    _backend.bodyEncode = json.encode({
      /* Convert to Json String */
      "email": email,
      "password": passwords
    });
    _backend.response = await _http.post('${_sldApi.api}/loginbyemail',
        headers: _backend.conceteHeader(null, null), body: _backend.bodyEncode);
    return _backend.response;
  }

  /* -----------------User Regiser-------------- */

  Future<_http.Response> registerByPhone(
      String _phone, String passwords) async {
    _backend.bodyEncode = json.encode(/* Convert to Json Data ( String ) */
        {"phone": "+855$_phone", "password": passwords});
    _backend.response = await _http.post('${_sldApi.api}/registerbyphone',
        headers: _backend.conceteHeader(null, null), body: _backend.bodyEncode);
    return _backend.response;
  }

  Future<_http.Response> registerByEmail(String email, String passwords) async {
    _backend.bodyEncode = json.encode(/* Convert to Json Data ( String ) */
        {"email": email, "password": passwords});
    _backend.response = await _http.post('${_sldApi.api}/registerbyemail',
        headers: _backend.conceteHeader(null, null), body: _backend.bodyEncode);
    return _backend.response;
  }

  /* Post User Information */
  Future<_http.Response> uploadProfile(var _model) async {
    //ModelUserInfo
    _backend.token = await StorageServices.fetchData('user_token');
    _backend.bodyEncode = json.encode({
      "first_name": _model.controlFirstName.text,
      "mid_name": _model.controlMidName.text,
      "last_name": _model.controlLastName.text,
      "gender": _model.gender
    });
    if (_backend.token != null) {
      _backend.response = await _http.post("${_sldApi.api}/userprofile",
          headers: _backend.conceteHeader(
              "authorization", "Bearer ${_backend.token["token"]}"),
          body: _backend.bodyEncode);
      return _backend.response;
    }
    return null;
  }

  /* Post Get Wallet */
  Future<_http.Response> retreiveWallet(String _pins) async {
    _backend.token = await StorageServices.fetchData('user_token');
    _backend.bodyEncode = json.encode({"pin": _pins});
    if (_backend.token != null) {
      _backend.response = await _http.post("${_sldApi.api}/getwallet",
          headers: _backend.conceteHeader(
              "authorization", "Bearer ${_backend.token["token"]}"),
          body: _backend.bodyEncode);
      return _backend.response;
    }
    return null;
  }

  Future<Map<String, dynamic>> addAsset(var _model) async {
    /* Add New Asset */
    _backend.token = await StorageServices.fetchData('user_token');
    _backend.bodyEncode = json.encode({
      "asset_code": _model.controllerAssetCode.text,
      "asset_issuer": _model.controllerIssuer.text
    });
    if (_backend.token != null) {
      _backend.response = await _http.post("${_sldApi.api}/addasset",
          headers: _backend.conceteHeader(
              "authorization", "Bearer ${_backend.token['token']}"),
          body: _backend.bodyEncode);
      return json.decode(_backend.response.body);
    }
    return null;
  }

  /* QR Code Send Request */
  Future<_http.Response> sendPayment(ModelScanPay _model) async {
    _backend.token = await StorageServices.fetchData('user_token');
    _backend.bodyEncode = json.encode({
      "pin": _model.pin,
      "asset_code": _model.asset,
      "destination": _model.controlReceiverAddress.text,
      "amount": _model.controlAmount.text,
      "memo": _model.controlMemo.text
    });
    if (_backend.token != null) {
      _backend.response = await _http.post("${_sldApi.walletAPI}/sendpayment",
          headers: _backend.conceteHeader("authorization", "Bearer ${_backend.token["token"]}"),
          body: _backend.bodyEncode);
      return _backend.response;
    }
    return null;
  }

  Future<Map<String, dynamic>> addMerchant(dynamic _model) async {
    /* Add New Merchant */
    _backend.token = await StorageServices.fetchData('user_token');
    _backend.bodyEncode = json.encode({
      "asset-code": _model.controlAssetCode.text,
      "destination": _model.controlDestination.text,
      "amount": _model.controlAmount.text,
      "memo": _model.controlMemo.text
    });
    if (_backend.token != null) {
      _backend.response = await _http.post("${_sldApi.api}/sendpayment",
          headers: _backend.conceteHeader(
              "authorization", "Bearer ${_backend.token['token']}"),
          body: _backend.bodyEncode);
      return json.decode(_backend.response.body);
    }
    return null;
  }

  Future<Map<String, dynamic>> addReceipt(var _modelScanInvoice) async {
    /* Scan Receipt */
    _backend.bodyEncode = json.encode({
      "receipt_no": _modelScanInvoice.controlBillNO.text,
      "amount": _modelScanInvoice.controlAmount.text,
      "location": _modelScanInvoice.controlLocation.text,
      "image_uri": _modelScanInvoice.imageUrlList['uri'],
      "approval_code": _modelScanInvoice.controlApproveCode.text
    });
    _backend.token = await StorageServices.fetchData('user_token');
    if (_backend.token != null) {
      _backend.response = await _http.post("${_sldApi.api}/addreceipt",
          headers: _backend.conceteHeader(
              "authorization", "Bearer ${_backend.token['token']}"),
          body: _backend.bodyEncode);
      return json.decode(_backend.response.body);
    }
    return null;
  }

  // Sign Up & Verification
  Future<_http.Response> resendCode(String phoneNumber) async {
    _backend.bodyEncode = json.encode({
      "phone": "+855$phoneNumber",
    });
    _backend.response = await _http.post("${_sldApi.api}/resend-code",
        headers: _backend.conceteHeader(null, null), body: _backend.bodyEncode);
    return _backend.response;
  }

  // Add Phone To Exist Email
  Future<_http.Response> addPhone(String phone) async {
    _backend.token = await StorageServices.fetchData('user_token');
    _backend.bodyEncode = json.encode({"phone": "+855$phone"});
    _backend.response = await _http.post("${_sldApi.api}/add-phonenumber",
        headers: _backend.conceteHeader(
            "authorization", "Bearer ${_backend.token['token']}"),
        body: _backend.bodyEncode);
    return _backend.response;
  }

  // Confirm User Account By Phone Number
  Future<_http.Response> confirmAccount(String phone, var _smsCodeModel) async {
    _backend.bodyEncode = json.encode({
      "phone": "${_smsCodeModel.countryCode}$phone",
      "verification_code": _smsCodeModel.verifyCode
    });
    _backend.response = await _http.post("${_sldApi.api}/account-confirmation",
        headers: _backend.conceteHeader(null, null), body: _backend.bodyEncode);
    return _backend.response;
  }

  // Confirm User Account By Phone Number
  Future<_http.Response> forgetPassword(var forgetM, String value) async {
    _backend.bodyEncode = json.encode({
      forgetM.key: value,
    });
    _backend.response = await _http.post("${_sldApi.api}/${forgetM.endpoint}",
        headers: _backend.conceteHeader(null, null), body: _backend.bodyEncode);
    return _backend.response;
  }

  // Confirm User Account By Phone Number
  Future<_http.Response> resetPass(
      var forgetM, String value, String endpoint) async {
    _backend.bodyEncode = json.encode({
      "temp_code": forgetM.controlResetCode.text,
      forgetM.key: value,
      "password": forgetM.controlConfirmPasswords.text
    });
    _backend.response = await _http.post("${_sldApi.api}/$endpoint",
        headers: _backend.conceteHeader(null, null), body: _backend.bodyEncode);
    return _backend.response;
  }

  Future<Map<String, dynamic>> changePIN(var _model) async {
    _backend.token = await StorageServices.fetchData('user_token');
    _backend.bodyEncode = json.encode({
      "current_pin": _model.controllerOldPin.text,
      "new_pin": _model.controllerConfirmPin.text,
    });
    if (_backend.token != null) {
      _backend.response = await _http.post("${_sldApi.api}/change-pin",
          headers: _backend.conceteHeader(
              "authorization", "Bearer ${_backend.token['token']}"),
          body: _backend.bodyEncode);
      return json.decode(_backend.response.body);
    }
    return null;
  }

  Future<Map<String, dynamic>> changePassword(var _model) async {
    _backend.token = await StorageServices.fetchData('user_token');
    _backend.bodyEncode = json.encode({
      "current_password": _model.controlOldPassword.text,
      "new_password": _model.controlConfirmPassword.text,
    });
    if (_backend.token != null) {
      _backend.response = await _http.post("${_sldApi.api}/change-password",
          headers: _backend.conceteHeader(
              "authorization", "Bearer ${_backend.token['token']}"),
          body: _backend.bodyEncode);
      return json.decode(_backend.response.body);
    }
    return null;
  }

  Future<Map<String, dynamic>> getReward(String hashs) async {
    _backend.token = await StorageServices.fetchData('user_token');
    _backend.bodyEncode = json.encode({"hashs": hashs});
    if (_backend.token != null) {
      _backend.response = await _http.post("${_sldApi.api}/get-rewards",
          headers: _backend.conceteHeader(
              "authorization", "Bearer ${_backend.token['token']}"),
          body: _backend.bodyEncode);
      return json.decode(_backend.response.body);
    }
    return null;
  }

  Future<_http.Response> addProductImage(String image, String productId) async {
    _backend.token = await StorageServices.fetchData('user_token');
    _backend.bodyEncode = json.encode({
      "url": image,
      "product-id": productId,
    });
    if (_backend.token != null) {
      _backend.response = await _http.post("${_sldApi.api}/products-images",
        headers: _backend.conceteHeader("authorization", "Bearer ${_backend.token['token']}"),
        body: _backend.bodyEncode
      );
      return _backend.response;
    }
    return null;
  }

  Future<_http.Response> markPamyment(String orderId) async {
    _backend.token = await StorageServices.fetchData('user_token');
    _backend.bodyEncode = json.encode({
      "order-id": orderId
    });
    if (_backend.token != null) {
      _backend.response = await _http.post("${_sldApi.api}/mark-order-payment",
        headers: _backend.conceteHeader("authorization", "Bearer ${_backend.token['token']}"),
        body: _backend.bodyEncode
      );
      return _backend.response;
    }
    return null;
  }

  Future<_http.Response> markShipment(String orderId) async {
    _backend.token = await StorageServices.fetchData('user_token');
    _backend.bodyEncode = json.encode({
      "order-id": orderId
    });
    if (_backend.token != null) {
      _backend.response = await _http.post("${_sldApi.api}/mark-order-shipment",
        headers: _backend.conceteHeader("authorization", "Bearer ${_backend.token['token']}"),
        body: _backend.bodyEncode
      );
      return _backend.response;
    }
    return null;
  }

  /* Post To Get Wallet Form Contact */
  Future<_http.Response>getWalletFromContact(String contact) async {
    _backend.token = await StorageServices.fetchData('user_token');
    _backend.bodyEncode = json.encode({"phone": contact});
    if (_backend.token != null) {
      _backend.response = await _http.post('${_sldApi.walletAPI}/wallet-lookup',
          headers: _backend.conceteHeader(
              "authorization", "Bearer ${_backend.token['token']}"),
          body: _backend.bodyEncode);
      return _backend.response;
    }
    return null;
  }

  Future<_http.Response> addListing(AddProduct product) async {
    _backend.token = await StorageServices.fetchData('user_token');
    _backend.bodyEncode = json.encode({
      "name": product.productName.text,
      "price": product.price.text,
      "shipping": product.shipping,
      "weight": product.weight,
      "description": product.description.text,
      "thumbnail": product.imageUrl,
      "category-id": product.category,
      "payment-id": product.paymentOpt
    });
    if (_backend.token != null) {
      _backend.response = await _http.post('${_sldApi.api}/add-product',
          headers: _backend.conceteHeader(
              "authorization", "Bearer ${_backend.token['token']}"),
          body: _backend.bodyEncode);
      return _backend.response;
    }
    return null;
  }

  /* OCR Image */
  Future ocrImage(String imageuri) async {
    // "_https://i.ibb.co/r69pMmx/ocr.png"
    // Map<String, dynamic> bodys = {
    //   "imguri": imageuri,
    //   "amount": "Grand Total(\$)",
    //   "trxdate": "Bill Date"
    // };
    //final response = await _http.post(_sldApi.urlOCR, body: bodys);
  }

  // Upload Fil Image To Get Url Image
  Future<String> upLoadImage(File _image, String endpoint) async {

    /* Compress image file */
    List<int> compressImage = await FlutterImageCompress.compressWithFile(
      _image.path,
      minHeight: 900,
      minWidth: 600,
      quality: 100,
    );
    /* Make request */

    var request = new _http.MultipartRequest('POST', Uri.parse('${_sldApi.apiPostImage}/$endpoint'));
    /* Make Form of Multipart */
    var multipartFile = new _http.MultipartFile.fromBytes(
      'file',
      compressImage,
      filename: 'image_picker.jpg',
      contentType: MediaType.parse('image/jpeg'),
    );
    request.files.add(multipartFile);
    /* Start send to server */
    String imageUrl;
    try{
      var r = await request.send();
      imageUrl = await r.stream.bytesToString();
    } catch (e) {
      // print(e);
    }
    return imageUrl;
  }
}
