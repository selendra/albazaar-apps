import 'package:selendra_marketplace_app/all_export.dart';

class StorageServices{

  static String _decode;
  static SharedPreferences _preferences;

  static Future<SharedPreferences> setData(dynamic _data, String _path) async {
    _preferences = await SharedPreferences.getInstance();
    _decode = jsonEncode(_data);
    _preferences.setString(_path, _decode);
    return _preferences;
  }

  static Future<SharedPreferences> setUserID(String _data, String _path) async {
    _preferences = await SharedPreferences.getInstance();
    _decode = jsonEncode(_data);
    _preferences.setString(_path, _decode);
    return _preferences;
  }

  static Future<dynamic>fetchData(String _path) async {
    _preferences = await SharedPreferences.getInstance();
    dynamic _data = _preferences.getString(_path);
    if ( _data == null ) return null;
    else {
      return await jsonDecode(_data);
    }
  }

  static Future<void> removeKey(String path) async {
    _preferences = await SharedPreferences.getInstance();
    _preferences.remove(path);
  }

  static Future<String> fetchId(String _path) async {
    _preferences = await SharedPreferences.getInstance();
    _decode = jsonDecode(_preferences.getString(_path));
    return _decode;
  }
}