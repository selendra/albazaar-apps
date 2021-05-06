import 'package:albazaar_app/all_export.dart';
import 'package:albazaar_app/core/components/row_of_product.dart';

class PendingOrder extends StatelessWidget{

  final Function refresh;

  PendingOrder({this.refresh});

  Widget build(BuildContext context) {
    //pending
    return RefreshIndicator(
      onRefresh: refresh,
      child: Column(
        children: [
          Align(
            alignment: Alignment.centerLeft,
            child: MyText(
              bottom: 8,
              text: "Pending",
              fontSize: 25,
              color: AppColors.primary,
              textAlign: TextAlign.left,
              fontWeight: FontWeight.w700,
            )
          ),
          Align(
            alignment: Alignment.centerLeft,
            child: MyText(
              text: "Products that have been ordering that not shipped or arrived you place yet",
              width: MediaQuery.of(context).size.width / 1.5,
              color: AppColors.lowBlack,
              textAlign: TextAlign.left,
              fontSize: 16,
              bottom: 24,
            )
          ),
        
          Flexible(
            child: Consumer<ProductsProvider>(
              builder: (context, value, child) {
                print(value.orItems.length);
                return Container(
                  child: value.orItems.isNotEmpty
                  ? ListView.builder(
                    itemCount: value.orItems.length,
                    shrinkWrap: true,
                    itemBuilder: (context, index) {
                      return RowOfProduct(
                        orderProduct: value.orItems[index],
                        seller: false,
                        onTap: (){
                          Navigator.of(context).push(
                            RouteAnimation(
                              enterPage: OrderDetail(
                                productOrder: value.orItems[index],
                              ),
                            ),
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
        ]
      )
    );
  }
}