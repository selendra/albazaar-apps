import 'package:selendra_marketplace_app/all_export.dart';
import 'package:selendra_marketplace_app/core/models/seller_m.dart';
import 'package:selendra_marketplace_app/ui/screens/seller_confirmation/seller_confrmation_body.dart';

class SellerConfirm extends StatefulWidget {

  final SellerModel productOrder;

  SellerConfirm({
    this.productOrder
  });

  @override
  _SellerConfirmState createState() => _SellerConfirmState();
}

class _SellerConfirmState extends State<SellerConfirm> {

  @override
  initState(){
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: ReuseSimpleAppBar.getItem(
        AppLocalizeService.of(context).translate('payment_n_shipment'),
        context
      ),
      body: SellerConfirmBody(
        productOrder: widget.productOrder
      ),
    );
  }
}