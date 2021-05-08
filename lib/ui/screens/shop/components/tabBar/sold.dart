import 'package:albazaar_app/all_export.dart';
import 'package:albazaar_app/core/components/row_of_product.dart';
import 'package:albazaar_app/core/providers/shop_provider.dart';
import 'package:albazaar_app/ui/screens/seller_confirmation/seller_confrmation_body.dart';

class Sold extends StatelessWidget{

  final Function refresh;

  Sold({this.refresh});

  Widget build(BuildContext context) {

    // Sold
    return Column(
      children: [
        Align(
          alignment: Alignment.centerLeft,
          child: MyText(
            bottom: 8,
            text: "Products Sold",
            fontSize: 25,
            color: AppColors.secondary,
            textAlign: TextAlign.left,
            fontWeight: FontWeight.w700,
          )
        ),
        Align(
          alignment: Alignment.centerLeft,
          child: MyText(
            text: "Products that you sold to your customer",
            color: AppColors.lowBlack,
            textAlign: TextAlign.left,
            fontSize: 16,
            bottom: 24,
          )
        ),

        Flexible(
          child: RefreshIndicator(
            onRefresh: refresh,
            child: Consumer<SellerProvider>(
              builder: (context, value, child) {
                return Container(
                  child: value.buyerCompleteList.isNotEmpty
                  ? ListView.builder(
                    itemCount: value.buyerCompleteList.length,
                    shrinkWrap: true,
                    itemBuilder: (context, index) {
                      return RowOfProduct(
                        sellerModel: value.buyerCompleteList[index],
                        onTap: (){

                          Navigator.of(context).push(
                            RouteAnimation(
                              enterPage: SellerConfirmBody(
                                productOrder: value.buyerCompleteList[index],
                              ),
                            ), //productsProvider.orItems[index]))
                          );
                        },
                      );
                    }
                  )
                  : Center(
                    child: SvgPicture.asset(
                      '${AppConfig.illustratePath}empty.svg',
                      height: MediaQuery.of(context).size.height * 0.3,
                      width: MediaQuery.of(context).size.width * 0.3,
                    ),
                  ),
                );
              },
            ),
          ),
        )
      ],
    );
  }
}