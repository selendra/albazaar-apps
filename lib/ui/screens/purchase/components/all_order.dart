import 'package:albazaar_app/all_export.dart';

class AllOrder extends StatelessWidget{

  final Function refresh;

  AllOrder({this.refresh});

  Widget build(BuildContext context) {

    //all
    return RefreshIndicator(
      onRefresh: refresh,
      child: Consumer<ProductsProvider>(
        builder: (context, value, child) {
          return Container(
            child: value.allOrderItems.isNotEmpty
            ? ListView.builder(
              itemCount: value.allOrderItems.length,
              itemBuilder: (context, index) {
                return InkWell(
                  onTap: () {
                    Navigator.of(context).push(
                      RouteAnimation(
                        enterPage: OrderDetail(
                          productOrder: value.allOrderItems[index],
                        ),
                      ), //productsProvider.orItems[index]))
                    );
                  },
                  child: Card(
                    elevation: 0,
                    shape: kDefaultShape,
                    child: Container(
                      height: 100,
                      width: MediaQuery.of(context).size.width,
                      margin: EdgeInsets.all(10.0),
                      child: Row(
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.circular(kDefaultRadius),
                            child: Container(
                              width: 100,
                              height: 100,
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
                                imageUrl: value.allOrderItems[index].thumbnail,
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
                                        text: "${value.allOrderItems[index].name}",
                                        bottom: 10,
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
                              ],
                            ),
                          )

                          // Column(
                          //   crossAxisAlignment: CrossAxisAlignment.start,
                          //   children: [
                          //     Container(
                          //       height: 20,
                          //       width: MediaQuery.of(context).size.width / 2,
                          //       child: ListTile(
                          //         title: Text(
                          //           value.allOrderItems[index].name,
                          //           style: TextStyle(
                          //             fontWeight: FontWeight.bold
                          //           ),
                          //         ),
                          //         isThreeLine: true,
                          //         subtitle: Text('Qty: ${value.allOrderItems[index].qauantity}'),
                          //       ),
                          //     ),
                          //     SizedBox(
                          //       height: 10,
                          //     ),
                          //     Container(
                          //       height: 20,
                          //       width: MediaQuery.of(context).size.width / 2,
                          //       child: ListTile(
                          //         subtitle: Text(
                          //           'Price: ${value.allOrderItems[index].price}៛ ',
                          //           style: TextStyle(
                          //             fontWeight: FontWeight.bold,
                          //             color: kDefaultColor,
                          //           ),
                          //         ),
                          //       ),
                          //     ),
                          //   ],
                          // ),
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