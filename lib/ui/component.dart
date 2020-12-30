import 'package:selendra_marketplace_app/all_export.dart';

class Components {
  static void dialogLoading({BuildContext context, String contents}) {
    showDialog(
        barrierDismissible: false,
        context: context,
        builder: (context) {
          return WillPopScope(
            onWillPop: () => Future(() => false),
            child: Material(
              color: Colors.transparent,
              child: Stack(
                alignment: Alignment.center,
                children: <Widget>[
                  Column(
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      CircularProgressIndicator(
                        backgroundColor: Colors.transparent,
                      ),
                      contents == null
                          ? Container()
                          : Padding(
                              child: Text(
                                contents,
                                style: TextStyle(color: Color(0xffFFFFFF)),
                              ),
                              padding:
                                  EdgeInsets.only(bottom: 10.0, top: 10.0)),
                    ],
                  )
                ],
              ),
            ),
          );
        });
  }

  /* Dialog of response from server */
  static Future dialog(BuildContext context, var text, var title,
      {FlatButton action, Color bgColor}) async {
    var result = await showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            backgroundColor: bgColor,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0)),
            title: Align(
              alignment: Alignment.center,
              child: title,
            ),
            content: Padding(
              padding: EdgeInsets.only(top: 15.0, bottom: 5.0),
              child: text,
            ),
            actions: <Widget>[
              FlatButton(
                child: Text('Close'),
                onPressed: () => Navigator.of(context).pop(text),
              ),
              action
            ],
          );
        });
    return result;
  }
}

class MyDropDown extends StatelessWidget {
  final String hint;
  final List data;
  final String keyPair;
  final Function onChanged;

  MyDropDown({this.hint, this.data, this.keyPair, this.onChanged});

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
            hint: Padding(
              padding: EdgeInsets.only(left: 10),
              child: Text(hint),
            ),
            items: data.map((dynamic value) {
              return new DropdownMenuItem<String>(
                value: value['$keyPair'],
                child: Text(value['$keyPair']),
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
