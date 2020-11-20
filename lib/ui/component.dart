import 'package:selendra_marketplace_app/all_export.dart';

class MyDropDown extends StatelessWidget{

  final String hint;
  final List data;
  final String keyPair;
  final Function onChanged;

  MyDropDown({
    this.hint,
    this.data,
    this.keyPair,
    this.onChanged
  });
    
  Widget build(BuildContext context) {
    return Container(
      height: 60,
      width: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(
        border: Border.all(color: kDefaultColor, width: 1),
        borderRadius: BorderRadius.circular(kDefaultRadius),
      ),
      child: DropdownButtonHideUnderline(
        child: new DropdownButton<String>(
          hint: Text(hint),
          items: data.map((dynamic value) {
            return new DropdownMenuItem<String>(
              value: value['$keyPair'],
              child: new Text(value['$keyPair']),
            );
          }).toList(),
          onChanged: onChanged,
        ),
      )
      // ListTile(
      //   title: _addProduct.categories.text.isEmpty
      //   ? Text(
      //     AppLocalizeService.of(context).translate('categories'),
      //   )
      //   : Text(_addProduct.categories.text),
      //   trailing: Icon(
      //     Icons.arrow_forward_ios,
      //     color: kDefaultColor,
      //   ),
      //   onTap: () {
      //     routeA();
      //   },
      // ),
    );
  }
}