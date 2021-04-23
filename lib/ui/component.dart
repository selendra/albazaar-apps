import 'package:albazaar_app/all_export.dart';

class Components {
  static void dialogLoading({@required BuildContext context, String contents}) {
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
                MyCard(
                  pLeft: 10, pRight: 10, pTop: 10, pBottom: 10,
                  hexaColor: AppColors.white,
                  width: 80,
                  height: 80,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      CircularProgressIndicator(
                        backgroundColor: Colors.transparent,
                        // valueColor: AlwaysStoppedAnimation(hexaCodeToColor(AppColors.lightBlueSky))
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
                )
              ],
            ),
          ),
        );
      }
    );
  }

  /* Dialog of response from server */
  static Future dialog(
    BuildContext context, 
    var text, 
    var title, 
    {
      TextButton action, 
      String firsTxtBtn = "Close", 
      Color bgColor, 
      Color barrierColor, 
      bool removeBtn: false,
      double pLeft: 10,
      double pRight: 10,
      double pTop: 15.0,
      double pBottom: 5
    }
  ) async {
    var result = await showDialog(
      context: context,
      barrierColor: barrierColor,
      builder: (BuildContext context) {
        return StatefulBuilder(builder: (context, setState){
          return AlertDialog(
            backgroundColor: bgColor,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.0)),
            contentPadding: EdgeInsets.only(left: pLeft, top: pTop, right: pRight, bottom: pBottom),
            title: title != null ? Align(
              alignment: Alignment.center,
              child: title,
            ) : null,
            content: text,
            actions: !removeBtn ? <Widget>[
              TextButton(
                child: Text(firsTxtBtn),
                onPressed: () => Navigator.of(context).pop(text),
              ),
              action
            ] : null,
          );
        });
      }
    );
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
