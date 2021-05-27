import 'package:albazaar_app/all_export.dart';

class ProfileModel {
  
  final formKey = GlobalKey<FormState>();

  PrefService prefService = PrefService();
  String mGender;

  TextEditingController first = TextEditingController();
  TextEditingController mid = TextEditingController();
  TextEditingController last = TextEditingController();

  TextEditingController email = TextEditingController();
  TextEditingController phone = TextEditingController();
  TextEditingController address = TextEditingController();
  
}