import 'package:flutter/material.dart';
import 'package:selendra_marketplace_app/all_export.dart';

class ShippingInformation extends StatefulWidget {
  final String _character;
  final Function setVal;

  ShippingInformation(this._character, this.setVal);

  @override
  _ShippingInformationState createState() => _ShippingInformationState();
}

class _ShippingInformationState extends State<ShippingInformation> {
  String _address;
  final _formKey = GlobalKey<FormState>();

  void validateAndSubmit() {
    if (_formKey.currentState.validate()) {
      _formKey.currentState.save();
      widget.setVal(_address);
      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    var _lang = AppLocalizeService.of(context);
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
                // margin: EdgeInsets.symmetric(horizontal: 20.0),
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
                      title: Text(_lang.translate('shipping_information')),
                    ),
                    SizedBox(
                      height: 10.0,
                    ),
                    Consumer<UserProvider>(
                      builder: (context, value, child) => Container(
                        margin: EdgeInsets.symmetric(horizontal: 20.0),
                        child: Form(
                          key: _formKey,
                          child: ReuseTextField(
                            hintText: 'Address',
                            initialValue: value.mUser.address == null
                                ? ''
                                : value.mUser.address,
                            validator: (value) => value.isEmpty
                                ? 'Address cannot be empty'
                                : null,
                            onSaved: (newValue) => _address = newValue,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 40.0,
                    ),
                    Container(
                      margin: EdgeInsets.symmetric(horizontal: 20.0),
                      child: ReuseButton.getItem('Add', () {
                        validateAndSubmit();
                      }, context),
                    ),
                    // RadioListTile(
                    //   activeColor: kDefaultColor,
                    //   title: Text('Direct Payment'),
                    //   value: 'Direct Payment',
                    //   groupValue: widget._character,
                    //   onChanged: (value) {
                    //     print(value);
                    //     widget.setVal(value);
                    //     setState(() {});
                    //   },
                    // ),
                    // RadioListTile(
                    //   activeColor: kDefaultColor,
                    //   title: Text('Escrow Payment'),
                    //   value: 'Escrow Payment',
                    //   groupValue: widget._character,
                    //   onChanged: (value) {
                    //     print(value);
                    //     widget.setVal(value);
                    //     setState(() {});
                    //   },
                    // )
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
              overflow: TextOverflow.ellipsis,
              style: TextStyle(fontSize: 14.0, fontWeight: FontWeight.bold),
            ),
            // leading: Icon(Icons.payment),
            trailing: Icon(
              Icons.edit,
              color: kDefaultColor,
            ),
          ),
        ),
      ),
    );
  }
}
