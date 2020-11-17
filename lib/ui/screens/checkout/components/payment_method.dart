import 'package:flutter/material.dart';
import 'package:selendra_marketplace_app/all_export.dart';

class PaymentMethod extends StatefulWidget {
  final String _character;
  final Function setVal;

  PaymentMethod(this._character, this.setVal);

  @override
  _PaymentMethodState createState() => _PaymentMethodState();
}

class _PaymentMethodState extends State<PaymentMethod> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        showBottomSheet(
          shape: kDefaultShape,
          context: context,
          builder: (context) => StatefulBuilder(
            builder: (context, setState) {
              return Container(
                color: Colors.white,
                height: MediaQuery.of(context).size.height / 2,
                child: Column(
                  children: [
                    ListTile(
                      trailing: IconButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        icon: Icon(
                          Icons.clear,
                          color: kDefaultColor,
                        ),
                      ),
                      title: Text('Payment Method'),
                    ),
                    RadioListTile(
                      activeColor: kDefaultColor,
                      title: Text('Direct Payment'),
                      value: 'Direct Payment',
                      groupValue: widget._character,
                      onChanged: (value) {
                        print(value);
                        widget.setVal(value);
                        setState(() {});
                      },
                    ),
                    RadioListTile(
                      activeColor: kDefaultColor,
                      title: Text('Escrow Payment'),
                      value: 'Escrow Payment',
                      groupValue: widget._character,
                      onChanged: (value) {
                        print(value);
                        widget.setVal(value);
                        setState(() {});
                      },
                    )
                  ],
                ),
              );
            },
          ),
        );
      },
      child: Card(
        elevation: 0,
        shape: kDefaultShape,
        child: Container(
          child: ListTile(
            title: Text(
              widget._character,
              style: TextStyle(fontSize: 14.0, fontWeight: FontWeight.bold),
            ),
            leading: Icon(Icons.payment),
            trailing: Icon(Icons.arrow_forward_ios),
          ),
        ),
      ),
    );
  }
}
