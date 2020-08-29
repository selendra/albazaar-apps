import 'package:flutter/material.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:selendra_marketplace_app/constants.dart';

class TypeHead extends StatefulWidget {
  final Function searchPlace;

  TypeHead(this.searchPlace);

  @override
  _TypeHeadState createState() => _TypeHeadState();
}

class _TypeHeadState extends State<TypeHead> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _typeAheadController = TextEditingController();
  String _selectedCity;

  @override
  Widget build(BuildContext context) {
    return Container(
        child: Form(
      key: this._formKey,
      child: Padding(
        padding: EdgeInsets.all(32.0),
        child: Column(
          children: <Widget>[
            Container(
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(kDefualtRadius),
                  color: Colors.white),
              child: TypeAheadFormField(
                textFieldConfiguration: TextFieldConfiguration(
                    controller: this._typeAheadController,
                    textInputAction: TextInputAction.search,
                    onChanged: (value) {
                      if(value!=null){
                        widget.searchPlace(value);
                      }
                    },
                    decoration: InputDecoration(
                        focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.greenAccent),
                            borderRadius: BorderRadius.all(
                                Radius.circular(kDefualtRadius))),
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: kDefualtColor),
                          borderRadius:
                              BorderRadius.all(Radius.circular(kDefualtRadius)),
                        ),
                        labelText: 'Place name')),
                suggestionsCallback: (pattern) {
                  return null;
                },
                itemBuilder: (context, suggestion) {
                  return ListTile(
                    title: Text(suggestion),
                  );
                },
                transitionBuilder: (context, suggestionsBox, controller) {
                  return suggestionsBox;
                },
                onSuggestionSelected: (suggestion) {
                  this._typeAheadController.text = suggestion;
                },
                validator: (value) {
                  if (value.isEmpty) {
                    return 'Please select a city';
                  }
                  return null;
                },
                onSaved: (value) => this._selectedCity = value,
              ),
            ),
          ],
        ),
      ),
    ));
  }
}
