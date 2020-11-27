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

  void onClickChange(String btnTitle){
    print(btnTitle);
    setState((){
      if (btnTitle == 'payment'){
        widget.productOrder.isPayment = true;
      } else {
        widget.productOrder.isShipping = true;
      }
      print(widget.productOrder.isPayment);
      print(widget.productOrder.isPayment);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: ReuseSimpleAppBar.getItem(
        AppLocalizeService.of(context).translate('payment_n_shipment'),
        context
      ),
      body: SellerConfirmBody(
        productOrder: widget.productOrder,
        onClickChange: onClickChange
      ),
    );
  }
}