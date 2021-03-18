import 'package:albazaar_app/all_export.dart';

class SignInModel {

  bool enable = false;

  String label;

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