import 'package:selendra_marketplace_app/all_export.dart';

class ItemList extends StatelessWidget {

  final String title;
  final String trailing;


  ItemList({
    this.title,
    this.trailing
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(bottom: 10),
      child: Row(
        children: [
          SizedBox(
            width: 80,
            child: Text("$title: ", textAlign: TextAlign.left, style: TextStyle(fontSize: 13),),
          ),
          Expanded(
            child: Padding(
              padding: EdgeInsets.only(left: 5),
              child: Text(trailing, overflow: TextOverflow.ellipsis, style: TextStyle(fontSize: 13)),
            )
          ),
        ],
      )
    );
  }
}