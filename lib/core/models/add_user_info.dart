import 'package:selendra_marketplace_app/all_export.dart';

class AddUserInfoModel {

  String image = '';
  String gender = '';

  TextEditingController firstName = TextEditingController();
  TextEditingController midName = TextEditingController();
  TextEditingController lastName = TextEditingController();
  TextEditingController address = TextEditingController();

  FocusNode firstNameNode = FocusNode();
  FocusNode midNameNode = FocusNode();
  FocusNode lastNameNode = FocusNode();
  FocusNode addressNode = FocusNode();
  
}