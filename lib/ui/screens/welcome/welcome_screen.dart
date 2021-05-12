import 'package:albazaar_app/all_export.dart';
import 'package:flutter/material.dart';
import 'package:albazaar_app/ui/screens/welcome/components/body.dart';

class WelcomeScreen extends StatelessWidget {

  Backend _backend = Backend();

  Future<void> guestAcc(BuildContext context) async {
    Components.dialogLoading(context: context);
    try {
      await Provider.of<ProductsProvider>(context, listen: false).productListingGuestAcc();
      await StorageServices.setData(true, DbKey.guestAcc);

      // Close Loading
      Navigator.pop(context);
      
      Navigator.pushReplacementNamed(context, BottomNavigationView);
    } catch (e){
      await Components.dialog(context, Text(e.toString(), textAlign: TextAlign.center,), Text("Oops"));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Body(
      guestAcc: guestAcc
    );
  }
}
