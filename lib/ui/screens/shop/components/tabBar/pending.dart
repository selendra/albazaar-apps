import 'package:albazaar_app/all_export.dart';
import 'package:albazaar_app/core/components/row_of_product.dart';

class Pending extends StatelessWidget{

  final Function refresh;

  Pending({this.refresh});

  Widget build(BuildContext context) {

    // Pending
    return Column(
      children: [
        Align(
          alignment: Alignment.centerLeft,
          child: MyText(
            text: "Pending",
            fontSize: 25,
            color: AppColors.secondary,
            textAlign: TextAlign.left,
            fontWeight: FontWeight.w700,
            bottom: 8,
          )
        ),
        Align(
          alignment: Alignment.centerLeft,
          child: MyText(
            text: "Products that your customer has been ordered and not arrived you place yet",
            width: MediaQuery.of(context).size.width / 1.5,
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
                  child: value.buyerPendingList.isNotEmpty
                  ? ListView.builder(
                    itemCount: value.buyerPendingList.length,
                    shrinkWrap: true,
                    itemBuilder: (context, index) {
                      return RowOfProduct(
                        sellerModel: value.buyerPendingList[index],
                        onTap: (){

                          // Navigator.of(context).push(
                          //   RouteAnimation(
                          //     enterPage: OrderDetail(
                          //       productOrder: value.buyerPendingList[index],
                          //     ),
                          //   ), //productsProvider.orItems[index]))
                          // );
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