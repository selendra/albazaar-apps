import 'package:selendra_marketplace_app/all_export.dart';

void snackBar(GlobalKey<ScaffoldState> globalKey, String contents) {
  final snackbar = SnackBar(
    duration: Duration(seconds: 2),
    content: Text(contents),
  );
  //ScaffoldMessenger.of(globalKey.currentContext).showSnackBar(snackbar);
  globalKey.currentState.showSnackBar(snackbar);
}
