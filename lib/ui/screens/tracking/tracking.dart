import 'package:flutter/material.dart';
import 'package:selendra_marketplace_app/all_export.dart';
import 'package:selendra_marketplace_app/core/providers/seller_provider.dart';

class Tracking extends StatefulWidget {
  final OrderProduct productOrder;
  Tracking({this.productOrder});
  @override
  _TrackingState createState() => _TrackingState();
}

class _TrackingState extends State<Tracking> {
  double _currentValue = 0;
  String statusReminder = '';

  @override
  void initState() {
    super.initState();
    checkProgress();
  }

  void checkProgress() {
    var track = Provider.of<SellerProvider>(context, listen: false);
    if (track.isShipment) {
      setState(() {
        _currentValue = 50;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: ReuseSimpleAppBar.getItem('Tracking', context),
      body: Container(
        margin: EdgeInsets.symmetric(horizontal: 10.0),
        child: Column(
          children: [
            Card(
              shape: kDefaultShape,
              child: Container(
                height: 200,
                margin: EdgeInsets.all(10.0),
                width: MediaQuery.of(context).size.width,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '${widget.productOrder.name}',
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 22),
                    ),
                    Text('Order: ${widget.productOrder.id}'),
                    Text('Reminder: Buyer has confirmes order recieved'),
                    SizedBox(
                      height: 40,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        reuseText('Battambong', TextAlign.start),
                        reuseText('Phnom Penh', TextAlign.start),
                      ],
                    ),
                    _sliderTheme(
                      Slider(
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
                  ],
                ),
              ),
            ),
            Expanded(
              child: Card(
                shape: kDefaultShape,
                child: Stack(
                  children: [
                    Container(
                      margin: EdgeInsets.only(
                        top: 60.0,
                        bottom: 60.0,
                        left: 40.0,
                        right: 40.0,
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              reuseText(
                                DateTime.now().toString(),
                                TextAlign.end,
                              ),
                              reuseText(
                                'Pick Up',
                                TextAlign.start,
                              ),
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              reuseText(
                                DateTime.now().toString(),
                                TextAlign.end,
                              ),
                              reuseText(
                                'Dispatched',
                                TextAlign.start,
                              ),
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              reuseText(
                                DateTime.now().toString(),
                                TextAlign.end,
                              ),
                              reuseText(
                                'Delivered',
                                TextAlign.start,
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    Center(
                      child: Container(
                        child: Transform(
                          alignment: FractionalOffset.center,
                          transform: Matrix4.identity()
                            ..rotateZ(90 * 3.1415927 / 180),
                          child: _sliderTheme(
                            Slider(
                              value: _currentValue,
                              min: 0,
                              max: 100,
                              divisions: 2,
                              onChanged: (double value) {},
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
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
        child: child);
  }
}
