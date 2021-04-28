import 'package:flutter/material.dart';
import 'package:albazaar_app/all_export.dart';

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
  
  TextEditingController address = TextEditingController();

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
                  ],
                ),
              );
            },
          ),
        );
      },
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          MyText(
            textAlign: TextAlign.left,
            text: "Shipping Address",
            color: AppColors.primary,
            bottom: 12,
          ),

          Row(
            children: [
              Expanded(
                child: MyInputField(
                  labelText: "Your address",
                  controller: address,
                  focusNode: FocusScopeNode(),
                  validateField: (String value){

                  },
                  onChanged: (String value){

                  },
                  onSubmit: (String value){

                  },
                )
              ),

              Container(
                padding: EdgeInsets.only(left: 6, right: 6),
                child: SvgPicture.asset("${AppConfig.iconPath}check_in.svg", width: 20, height: 20)
              )
            ],
          )
        ],
      ),
    );
  }
}
