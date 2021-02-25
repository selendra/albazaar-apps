import 'package:selendra_marketplace_app/all_export.dart';
import 'package:selendra_marketplace_app/core/components/card_c.dart';

class SellerInformation extends StatelessWidget {
  
  @override
  Widget build(BuildContext context) {
    final double margin = 20;
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Center(
        child: MyCard(
          mRight: margin, mLeft: margin,
          width: MediaQuery.of(context).size.width,
          hexaColor: AppColors.white,
          height: 510,
          child: Column(
            children: [

            ],
          ),
        )
      ),
    );
  }
}