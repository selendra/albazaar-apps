import 'package:flutter/material.dart';
import 'package:selendra_marketplace_app/constants.dart';


class ReuseAlertDialog {
   static getItem (String title,String content,String btnOne,Function func1,String btnTwo,Function func2){
     return AlertDialog(
       shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(kDefaultRadius)),
       title: Text(title),
       content: Text(content),
       actions: [
         FlatButton(child: Text(btnOne),onPressed: func1,),
         FlatButton(child: Text(btnTwo),onPressed: func2,)
       ],
       
     );
   }
}

/*class ReuseAlertDialog extends StatelessWidget {

  final String title,content;
  ReuseAlertDialog({this.title,this.content});

  @override
    Widget build(BuildContext context){
    return simpleAlertDialog(context);
  }
  simpleAlertDialog(BuildContext context) async {
    return showDialog(
        context: (context),
        builder: (context) {
          return AlertDialog(
            title: Text(title),
            actions: [
              FlatButton(
                child: Text('OK'),
                onPressed: () {
                  Navigator.pop(context);
                },
              )
            ],
          );
        });
  }

}*/
