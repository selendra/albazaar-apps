import 'package:selendra_marketplace_app/all_export.dart';

class AddProduct {
  
  final formKeyDetail = GlobalKey<FormState>();
  final formKeySeller = GlobalKey<FormState>();

  TextEditingController title = TextEditingController();
  TextEditingController price =  TextEditingController();
  TextEditingController description = TextEditingController();
  TextEditingController contactName = TextEditingController();
  TextEditingController phoneNumber = TextEditingController();
  TextEditingController address = TextEditingController();
  TextEditingController categories = TextEditingController();
  TextEditingController district = TextEditingController();
  TextEditingController city = TextEditingController();
}