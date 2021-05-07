import 'package:albazaar_app/all_export.dart';
import 'package:albazaar_app/core/components/row_of_product.dart';

class AllOrder extends StatelessWidget{

  final Function refresh;

  AllOrder({this.refresh});

  Widget build(BuildContext context) {

    //all
    return Column(
      children: [
        Align(
          alignment: Alignment.centerLeft,
          child: MyText(
            bottom: 8,
            text: "All Orders",
            fontSize: 25,
            color: AppColors.primary,
            textAlign: TextAlign.left,
            fontWeight: FontWeight.w700,
          )
        ),
        Align(
          alignment: Alignment.centerLeft,
          child: MyText(
            text: "All Products that are ordered",
            color: AppColors.lowBlack,
            textAlign: TextAlign.left,
            fontSize: 16,
            bottom: 24,
          )
        ),

        Flexible(
          child: RefreshIndicator(
            onRefresh: refresh,
            child: Consumer<ProductsProvider>(
              builder: (context, value, child) {
                return Container(
                  child: value.allOrderItems.isNotEmpty
                  ? ListView.builder(
                    itemCount: value.allOrderItems.length,
                    shrinkWrap: true,
                    itemBuilder: (context, index) {
                      return RowOfProduct(
                        orderProduct: value.allOrderItems[index],
                        seller: false,
                        onTap: (){
                          Navigator.of(context).push(
                            RouteAnimation(
                              enterPage: OrderDetail(
                                productOrder: value.allOrderItems[index],
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
          )
        )
      ],
    );
  }
}