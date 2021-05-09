import 'package:flutter/material.dart';
import 'package:albazaar_app/all_export.dart';
import 'package:timeline_tile/timeline_tile.dart';

class Tracking extends StatefulWidget {

  final OrderProduct productOrder;

  Tracking({this.productOrder});

  @override
  _TrackingState createState() => _TrackingState();
}

class _TrackingState extends State<Tracking> {

  int trackingProgress = 0;
  
  double _currentValue = 0;
  
  String statusReminder = '';

  @override
  void initState() {
    checkTrackingProgress();
    super.initState();
  }

  void checkTrackingProgress(){
    if (widget.productOrder.orderStatus == "Pay Success"){
      setState((){
        trackingProgress = 1;
      });
    } 
    else if (widget.productOrder.orderStatus == "Shipment"){
      setState((){
        trackingProgress = 2;
      });
    }
    else if (widget.productOrder.orderStatus == "Order Complete"){
      setState((){
        trackingProgress = 3;
      });
    }
    print(trackingProgress);
  }

  @override
  Widget build(BuildContext context) {

    final loadedProduct = Provider.of<ProductsProvider>(context, listen: false).findById(widget.productOrder.productId);

    return Scaffold(
      appBar: ReuseSimpleAppBar.getItem('Tracking', context),
      body: Container(
        margin: EdgeInsets.all(12.0),
        child: Column(
          children: [
            
            Card(
              shape: kDefaultShape,
              margin: EdgeInsets.only(bottom: 16),
              child: Container(
                // height: 200,
                margin: const EdgeInsets.all(12.0),
                padding: EdgeInsets.all(12),
                width: MediaQuery.of(context).size.width,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [

                    SizedBox(height: 5),
                    Text(
                      'Order Information',
                      style: TextStyle(fontWeight: FontWeight.bold, fontSize: 22),
                    ),

                    SizedBox(height: 10),
                    Text(
                      '${widget.productOrder.name}',
                      style: TextStyle(
                        fontWeight: FontWeight.bold, 
                        fontSize: 20,
                        color: AppServices.hexaCodeToColor(AppColors.primary)
                      ),
                    ),

                    SizedBox(height: 10.0),
                    Text('Order: ${widget.productOrder.id}'),

                    SizedBox(height: 5),
                    Text('Reminder: ${widget.productOrder.orderStatus}'),

                    SizedBox(height: 40),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        reuseText("${loadedProduct.address}", TextAlign.start),
                        reuseText("${widget.productOrder.shippingAddress}", TextAlign.end),
                      ],
                    ),

                    _sliderTheme(
                      AbsorbPointer(
                        child: Slider(
                          value: _currentValue,
                          min: 0,
                          max: 100,
                          divisions: 2,
                          //label: 'Battambong',
                          onChanged: (double value) {
                            setState(() {
                              _currentValue = value;
                            });
                          },
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            
            Expanded(
              child: Card(
                shape: kDefaultShape,
                margin: EdgeInsets.zero,
                child: Container(
                  width: MediaQuery.of(context).size.width,
                  margin: EdgeInsets.all(12),
                  child: Column(
                    children: <Widget>[

                      Expanded(
                        child: TimelineTile(
                          axis: TimelineAxis.vertical,
                          alignment: TimelineAlign.manual,
                          lineXY: 0.4,
                          isFirst: true,
                          afterLineStyle: trackingProgress != 0 ? LineStyle(color: AppServices.hexaCodeToColor(AppColors.primary)) : LineStyle(),
                          indicatorStyle: IndicatorStyle(
                            width: trackingProgress == 0 ? 40 : 30,
                            height: trackingProgress == 0 ? 40 : 30,
                            padding: const EdgeInsets.all(8),
                            indicator: Container(
                              padding: trackingProgress == 0 ? EdgeInsets.all(6) : EdgeInsets.zero,
                              decoration: trackingProgress == 0 ? BoxDecoration(
                                shape: BoxShape.circle,
                                color: AppServices.hexaCodeToColor(AppColors.primary),
                              ) : BoxDecoration(),
                              child: SvgPicture.asset("${AppConfig.iconPath}package.svg", color: trackingProgress == 0 ? Colors.white : Colors.black),
                            ),
                          ),
                          startChild: Align(
                            alignment: Alignment.centerRight,
                            child: MyText(text: DateTime.now().toString(), textAlign: TextAlign.right, pRight: 20, fontSize: 14),
                          ),
                          endChild: Padding(
                            padding: EdgeInsets.only(left: 20),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                MyText(text: "Place Order"),
                                Text("Product has been place order. wait for receive", style: TextStyle(fontSize: 12, color: AppServices.hexaCodeToColor(AppColors.lowBlack)))
                              ],
                            )
                          ),
                        )
                      ),

                      Expanded(
                        child: TimelineTile(
                          // If TrackingProgress == Tracking 
                          beforeLineStyle: trackingProgress != 0 ? LineStyle(color: AppServices.hexaCodeToColor(AppColors.primary)) : LineStyle(),
                          afterLineStyle: trackingProgress > 1 ? LineStyle(color: AppServices.hexaCodeToColor(AppColors.primary)) : LineStyle(),
                          alignment: TimelineAlign.manual,
                          lineXY: 0.4,
                          indicatorStyle: IndicatorStyle(
                            width: trackingProgress == 1 ? 40 : 30,
                            height: trackingProgress == 1 ? 40 : 30,
                            drawGap: true,
                            padding: const EdgeInsets.all(8),
                            indicator: Container(
                              padding: trackingProgress == 1 ? EdgeInsets.all(6) : EdgeInsets.zero,
                              decoration: trackingProgress == 1 ? BoxDecoration(
                                shape: BoxShape.circle,
                                color: AppServices.hexaCodeToColor(AppColors.primary),
                              ) : BoxDecoration(),
                              child: SvgPicture.asset("${AppConfig.iconPath}receive.svg", color: trackingProgress == 1 ? Colors.white : Colors.black),
                            )
                          ),
                          startChild: Align(
                            alignment: Alignment.centerRight,
                            child: MyText(text: DateTime.now().toString(), textAlign: TextAlign.right, pRight: 20, fontSize: 14),
                          ),
                          endChild: Padding(
                            padding: EdgeInsets.only(left: 20),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                MyText(text: "Received"),
                                Text("Product has been receive. wait for dispatch", style: TextStyle(fontSize: 12, color: AppServices.hexaCodeToColor(AppColors.lowBlack)))
                              ],
                            )
                          ),
                        )
                      ),

                      Expanded(
                        child: TimelineTile(
                          beforeLineStyle: trackingProgress > 1 ? LineStyle(color: AppServices.hexaCodeToColor(AppColors.primary)) : LineStyle(),
                          afterLineStyle: trackingProgress > 2 ? LineStyle(color: AppServices.hexaCodeToColor(AppColors.primary)) : LineStyle(),
                          alignment: TimelineAlign.manual,
                          lineXY: 0.4,
                          indicatorStyle: IndicatorStyle(
                            width: trackingProgress == 2 ? 40 : 30,
                            height: trackingProgress == 2 ? 40 : 30,
                            padding: const EdgeInsets.all(8),
                            drawGap: true,
                            indicator: Container(
                              padding: trackingProgress == 2 ? EdgeInsets.all(6) : EdgeInsets.zero,
                              decoration: trackingProgress == 2 ? BoxDecoration(
                                shape: BoxShape.circle,
                                color: AppServices.hexaCodeToColor(AppColors.primary),
                              ) : BoxDecoration(),
                              child: SvgPicture.asset("${AppConfig.iconPath}transmit.svg", color: trackingProgress == 2 ? Colors.white : Colors.black),
                            )
                          ),
                          startChild: Align(
                            alignment: Alignment.centerRight,
                            child: MyText(text: DateTime.now().toString(), textAlign: TextAlign.right, pRight: 20, fontSize: 14),
                          ),
                          endChild: Padding(
                            padding: EdgeInsets.only(left: 20),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                MyText(text: "Shipping"),
                                Text("Product is shipping. please be patience", style: TextStyle(fontSize: 12, color: AppServices.hexaCodeToColor(AppColors.lowBlack)))
                              ],
                            )
                          ),
                        )
                      ),
                      
                      Expanded(
                        child: TimelineTile(
                          beforeLineStyle: trackingProgress == 3 ? LineStyle(color: AppServices.hexaCodeToColor(AppColors.primary)) : LineStyle(),
                          afterLineStyle: LineStyle(),
                          alignment: TimelineAlign.manual,
                          lineXY: 0.4,
                          isLast: true,
                          indicatorStyle: IndicatorStyle(
                            width: trackingProgress == 3 ? 40 : 30,
                            height: trackingProgress == 3 ? 40 : 30,
                            padding: const EdgeInsets.all(8),
                            drawGap: true,
                            indicator: Container(
                              padding: trackingProgress == 3 ? EdgeInsets.all(6) : EdgeInsets.zero,
                              decoration: trackingProgress == 3 ? BoxDecoration(
                                shape: BoxShape.circle,
                                color: AppServices.hexaCodeToColor(AppColors.primary),
                              ) : BoxDecoration(),
                              child: SvgPicture.asset("${AppConfig.iconPath}arrived.svg", color: trackingProgress == 3 ? Colors.white : Colors.black),
                            )
                          ),
                          startChild: Align(
                            alignment: Alignment.centerRight,
                            child: MyText(text: DateTime.now().toString(), textAlign: TextAlign.right, pRight: 20, fontSize: 14),
                          ),
                          endChild: Padding(
                            padding: EdgeInsets.only(left: 20),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                MyText(text: "Arrived"),
                                Text("Product had arrive destination", style: TextStyle(fontSize: 12, color: AppServices.hexaCodeToColor(AppColors.lowBlack))),
                              ],
                            )
                          ),
                        )
                      ),
                    ],
                  ),
                )
              )
            )
              // Stack(
              //   children: [
              //     // Container(
              //     //   color: Colors.red,
              //     //   height: 300,
              //     //   // margin: EdgeInsets.only(
              //     //   //   top: 60.0,
              //     //   //   bottom: 60.0,
              //     //   //   left: 40.0,
              //     //   //   right: 40.0,
              //     //   // ),
              //     //   child: Column(
              //     //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
              //     //     children: [
              //     //       Row(
              //     //         mainAxisAlignment: MainAxisAlignment.spaceBetween,
              //     //         children: [
              //     //           reuseText(
              //     //             DateTime.now().toString(),
              //     //             TextAlign.end,
              //     //           ),
              //     //           reuseText(
              //     //             'Pick Up',
              //     //             TextAlign.start,
              //     //           ),
              //     //         ],
              //     //       ),
              //     //       Row(
              //     //         mainAxisAlignment: MainAxisAlignment.spaceBetween,
              //     //         children: [
              //     //           reuseText(
              //     //             DateTime.now().toString(),
              //     //             TextAlign.end,
              //     //           ),
              //     //           reuseText(
              //     //             'Dispatched',
              //     //             TextAlign.start,
              //     //           ),
              //     //         ],
              //     //       ),
              //     //       Row(
              //     //         mainAxisAlignment: MainAxisAlignment.spaceBetween,
              //     //         children: [
              //     //           reuseText(
              //     //             DateTime.now().toString(),
              //     //             TextAlign.end,
              //     //           ),
              //     //           reuseText(
              //     //             'Delivered',
              //     //             TextAlign.start,
              //     //           ),
              //     //         ],
              //     //       ),
              //     //     ],
              //     //   ),
              //     // ),

              //     ,

              //     // Transform(
              //     //   alignment: FractionalOffset.center,
              //     //   transform: Matrix4.identity()..rotateZ(90 * 3.1415927 / 180),
              //     //   child: 
              //       // _sliderTheme(
              //       //   AbsorbPointer(
              //       //     child: Slider(
              //       //       value: _currentValue,
              //       //       min: 0,
              //       //       max: 100,
              //       //       divisions: 2,
              //       //       onChanged: (double value) {},
              //       //     ),
              //       //   ),
              //       // )
              //   //   )
              //   ],
              // ),
            // ),
          ],
        ),
      ),
    );
  }

  Widget reuseText(String text, TextAlign textAlign) {
    return Container(
      width: 100,
      child: Text(
        text,
        textAlign: textAlign,
        overflow: TextOverflow.ellipsis,
        style: TextStyle(
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  _sliderTheme(Widget child) {
    return SliderTheme(
      data: SliderTheme.of(context).copyWith(
        trackShape: RoundedRectSliderTrackShape(),
        thumbColor: kDefaultColor,
        trackHeight: 4,
        activeTrackColor: kDefaultColor,
        inactiveTrackColor: kDefaultColor.withAlpha(50),
      ),
      child: child
    );
  }
}
