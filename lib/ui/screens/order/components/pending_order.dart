import 'package:albazaar_app/all_export.dart';

class PendingOrder extends StatelessWidget{

  final Function refresh;

  PendingOrder({this.refresh});

  Widget build(BuildContext context) {
    //pending
    return Column(
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

        RefreshIndicator(
          onRefresh: refresh,
          child: Consumer<ProductsProvider>(
            builder: (context, value, child) {
              return Container(
                child: value.orItems.isNotEmpty
                ? ListView.builder(
                  itemCount: value.orItems.length,
                  shrinkWrap: true,
                  itemBuilder: (context, index) {
                    return InkWell(
                      onTap: () {
                        Navigator.of(context).push(
                          RouteAnimation(
                            enterPage: OrderDetail(
                              productOrder: value.orItems[index],
                            ),
                          ),
                        );
                      },
                      child: Card(
                        elevation: 0,
                        shape: kDefaultShape,
                        child: Container(
                          height: 120,
                          width: MediaQuery.of(context).size.width,
                          margin: const EdgeInsets.all(10.0),
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
                                  child: Image.network(
                                    value.orItems[index].thumbnail,
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ),

                              Flexible(
                                child: MyPadding(
                                  pLeft: 12, pRight: 0,
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Flexible(
                                        child: Row(
                                          mainAxisSize: MainAxisSize.min,
                                          children: [
                                            MyText(
                                              text: "Name:",
                                              bottom: 10,
                                            ),

                                            MyText(
                                              left: 6,
                                              text: "${value.allOrderItems[index].name}",
                                              bottom: 10,
                                              overflow: TextOverflow.ellipsis,
                                            )
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
                                              text: "${value.allOrderItems[index].qauantity}",
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
                                              text: "${value.allOrderItems[index].price}",
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
                                              text: "${value.allOrderItems[index].orderStatus}",
                                              color: AppColors.secondary,
                                              bottom: 10,
                                            )
                                          ],
                                        )
                                      )
                                    ],
                                  ),
                                )
                              ),

                              Expanded(
                                child: Container(
                                  padding: EdgeInsets.only(left: 12),
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
        )
      ]
    );
  }
}