import 'package:albazaar_app/all_export.dart';
import 'package:albazaar_app/core/components/countries.dart';

class SignInModel {

  bool enable = false;
  bool hidePassword = true;

  String label;

  String countryCode = countries[36]['dial_code'];

  // Validator
  String phoneNMailValidate;
  String passwordValidate;


  TextEditingController phone = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();

  FocusNode phoneNode = FocusNode();
  FocusNode emailNode = FocusNode();
  FocusNode passwordNode = FocusNode();

  final PageController pageController = PageController(initialPage: 0);

  bool isLoading = false;

  TabController tabController;

  bool isPageCanChanged = true;

  final formKey = GlobalKey<FormState>();
}