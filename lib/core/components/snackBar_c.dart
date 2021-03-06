import 'package:albazaar_app/all_export.dart';

void snackBar(GlobalKey<ScaffoldState> globalKey, String contents) {
  final snackbar = SnackBar(
    duration: Duration(seconds: 2),
    content: Text(contents),
  );
  globalKey.currentState.showSnackBar(snackbar);
}
