import 'package:albazaar_app/all_export.dart';
import 'package:albazaar_app/core/providers/shop_provider.dart';

class Sold extends StatelessWidget{

  final Function refresh;

  Sold({this.refresh});

  Widget build(BuildContext context) {

    // Sold
    return RefreshIndicator(
      onRefresh: refresh,
      child: Consumer<SellerProvider>(
        builder: (context, value, child) {
          return Container(
            child: value.buyerCompleteList.isNotEmpty
            ? ListView.builder(
              itemCount: value.buyerCompleteList.length,
              shrinkWrap: true,
              itemBuilder: (context, index) {
                return InkWell(
                  onTap: () {
                    // Navigator.of(context).push(
                    //   RouteAnimation(
                    //     enterPage: OrderDetail(
                    //       productOrder: value.buyerCompleteList[index],
                    //     ),
                    //   ), //productsProvider.orItems[index]))
                    // );
                  },
                  child: Card(
                    elevation: 0,
                    shape: kDefaultShape,
                    child: Container(
                      height: 120,
                      width: MediaQuery.of(context).size.width,
                      margin: EdgeInsets.all(10.0),
                      child: Row(
                        children: [

                          ClipRRect(
                            borderRadius: BorderRadius.circular(kDefaultRadius),
                            child: Container(
                              width: 120,
                              height: 120,
                              decoration: BoxDecoration(
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.grey[300],
                                    spreadRadius: 5.0,
                                    blurRadius: 5.0,
                                  ),
                                ],
                              ),
                              child: CachedNetworkImage(
                                imageUrl: value.buyerCompleteList[index].thumbnail,
                                fit: BoxFit.cover
                              ),
                            ),
                          ),

                          MyPadding(
                            pLeft: 12, pRight: 0,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Flexible(
                                  child: Row(
                                    children: [
                                      MyText(
                                        text: "Name:",
                                        bottom: 10,
                                      ),

                                      MyText(
                                        left: 6,
                                        text: "${value.buyerCompleteList[index].name}",
                                        bottom: 10,
                                        overflow: TextOverflow.clip,
                                      ),
                                    ],
                                  )
                                ),
                                
                                Flexible(
                                  child: Row(
                                    children: [
                                      MyText(
                                        text: "Qty:",
                                        bottom: 10,
                                      ),

                                      MyText(
                                        left: 6,
                                        text: "${value.buyerCompleteList[index].qauantity}",
                                        bottom: 10,
                                      )
                                    ],
                                  )
                                ),

                                Flexible(
                                  child: Row(
                                    children: [
                                      MyText(
                                        text: "Price:",
                                        bottom: 10,
                                      ),

                                      MyText(
                                        left: 6,
                                        text: "${value.buyerCompleteList[index].price}",
                                        bottom: 10,
                                      )
                                    ],
                                  )
                                ),

                                Flexible(
                                  child: Row(
                                    children: [
                                      MyText(
                                        text: "Status:",
                                        bottom: 10,
                                      ),

                                      MyText(
                                        left: 6,
                                        text: "${value.buyerCompleteList[index].orderStatus}",
                                        color: AppColors.secondary,
                                        bottom: 10,
                                      )
                                    ],
                                  )
                                )
                              ],
                            ),
                          ),

                          Flexible(
                            child: Container(
                              padding: EdgeInsets.only(left: 12, right: 5),
                              child: Align(
                                alignment: Alignment.centerRight,
                                child: Icon(Icons.arrow_forward_ios_outlined, size: 16)
                              )
                            )
                          )
                        ],
                      ),
                    ),
                  ),
                );
              }
            )
            : Center(
              child: SvgPicture.asset(
                'assets/undraw_loving_it.svg',
                height: MediaQuery.of(context).size.height * 0.3,
                width: MediaQuery.of(context).size.width * 0.3,
              ),
            ),
          );
        },
      ),
    );
  }
}