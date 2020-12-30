import 'package:selendra_marketplace_app/all_export.dart';
import 'package:http/http.dart' as _http;

class GetRequest {
  SelendraApi _sldApi = SelendraApi();

  PrefService _pref = PrefService();

  Backend _backend = Backend();

  Future<_http.Response> getUserProfile() async {
    /* Get User Profile */
    _backend.token = await StorageServices.fetchData('user_token');
    if (_backend.token != null) {
      _backend.response = await _http.get("${_sldApi.api}/userprofile",
          headers: _backend.conceteHeader(
              "authorization", "Bearer ${_backend.token['token']}"));
      return _backend.response;
    }
    return null;
  }

  Future<_http.Response> checkExpiredToken() async {
    /* Expired Token In Welcome Screen */
    _backend.token = await StorageServices.fetchData('user_token');
    if (_backend.token != null) {
      _backend.response = await _http.get("${_sldApi.api}/userprofile",
          headers: _backend.conceteHeader(
              "authorization", "Bearer ${_backend.token['token']}"));
      return _backend.response;
    }
    return null;
  }

  Future<_http.Response> shippingServices() async {
    /* Expired Token In Welcome Screen */
    await _pref.read('token').then((value) {
      _backend.token = Map<String, dynamic>.from({"token": value});
    });
    if (_backend.token != null) {
      _backend.response = await _http.get("${_sldApi.api}/shipping-services",
          headers: _backend.conceteHeader(
              "authorization", "Bearer ${_backend.token['token']}"));
      return _backend.response;
    }
    return null;
  }

  Future<_http.Response> categories() async {
    /* Expired Token In Welcome Screen */
    await _pref.read('token').then((value) {
      _backend.token = Map<String, dynamic>.from({"token": value});
    });
    if (_backend.token != null) {
      _backend.response = await _http.get("${_sldApi.api}/product-categories",
          headers: _backend.conceteHeader(
              "authorization", "Bearer ${_backend.token['token']}"));
      return _backend.response;
    }
    return null;
  }

  Future<_http.Response> paymentOpt() async {
    /* Expired Token In Welcome Screen */
    await _pref.read('token').then((value) {
      _backend.token = Map<String, dynamic>.from({"token": value});
    });
    if (_backend.token != null) {
      _backend.response = await _http.get("${_sldApi.api}/payment-options",
          headers: _backend.conceteHeader(
              "authorization", "Bearer ${_backend.token['token']}"));
      return _backend.response;
    }
    return null;
  }

  Future<_http.Response> weightOpt() async {
    /* Expired Token In Welcome Screen */
    await _pref.read('token').then((value) {
      _backend.token = Map<String, dynamic>.from({"token": value});
    });
    if (_backend.token != null) {
      _backend.response = await _http.get("${_sldApi.api}/weight-options",
          headers: _backend.conceteHeader(
              "authorization", "Bearer ${_backend.token['token']}"));
      return _backend.response;
    }
    return null;
  }

  Future<_http.Response> getAllBuyerOrder() async {
    await _pref.read('token').then((value) {
      _backend.token = Map<String, dynamic>.from({"token": value});
    });
    if (_backend.token != null) {
      _backend.response = await _http.get(
        "${_sldApi.api}/list-order-from-seller",
        headers: _backend.conceteHeader(
            "authorization", "Bearer ${_backend.token['token']}"),
      );

      return _backend.response;
    }
    return null;
  }

  /* User History */
  Future<_http.Response> getTrxHistory() async {
    _backend.token = await StorageServices.fetchData('user_token');
    if (_backend.token != null) {
      _backend.response = await _http.get("${_sldApi.walletAPI}/trx-history",
          headers: _backend.conceteHeader(
              "authorization", "Bearer ${_backend.token['token']}"));

      return _backend.response;
    }
    return null;
  }

  Future<_http.Response> getPortfolio() async {
    /* User Porfolio */
    _backend.token = await StorageServices.fetchData('user_token');
    if (_backend.token != null) {
      _backend.response = await _http.get("${_sldApi.api}/portforlio",
          headers: _backend.conceteHeader(
              "authorization", "Bearer ${_backend.token['token']}"));
      return _backend.response;
    }
    return null;
  }

  Future getAllBranches() async {
    _backend.token = await StorageServices.fetchData('user_token');
    if (_backend.token != null) {
      _backend.response = await _http.get("${_sldApi.api}/get-all-branches",
          headers: _backend.conceteHeader(
              "authorization", "Bearer ${_backend.token['token']}"));
      return json.decode(_backend.response.body);
    }
    return null;
  }

  Future<dynamic> getReceipt() async {
    _backend.token = await StorageServices.fetchData('user_token');
    if (_backend.token != null) {
      _backend.response = await _http.get("${_sldApi.api}/get-receipt",
          headers: _backend.conceteHeader(
              "authorization", "Bearer ${_backend.token['token']}"));
      return json.decode(_backend.response.body);
    }
    return null;
  }
  /*--------------------------------Transaction--------------------------------*/

  /* List Branches */
  Future<List<dynamic>> listBranches() async {
    _backend.token = await StorageServices.fetchData('user_token');
    if (_backend.token != null) {
      _backend.response = await _http.get('${_sldApi.api}/listBranches',
          headers: {
            HttpHeaders.authorizationHeader: "Bearer ${_backend.token['TOKEN']}"
          });
      _backend.data = json.decode(_backend.response.body);
      return _backend.data['message'];
    }
    return null;
  }

  // Future<Map<String, dynamic>> submitInvoice(ModelInvoice _model) async { /* Confirm Receipt */
  //   _backend.token = await StorageServices.fetchData('user_token');
  //   if (_backend.token != null){
  //     _backend.response = await _http.post(
  //       "${_sldApi.api}/confirmreceipt",
  //       headers: {
  //         HttpHeaders.authorizationHeader: "Bearer ${_backend.token['TOKEN']}"
  //       },
  //       body: _model.bodyReceipt(_model)
  //     );
  //     return json.decode(_backend.response.body);
  //   }
  //   return null;
  // }
}
