import 'package:flutter/material.dart';
import 'package:albazaar_app/all_export.dart';

class BtnQty extends StatelessWidget {
  final String count;
  final Function addQty;
  final Function minusQty;

  BtnQty(this.count, this.addQty, this.minusQty);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: _btnQtyRow(),
    );
  }

  Widget _btnQtyRow() {
    return Container(
      child: Row(
        children: <Widget>[
          ReuseBtnQty(() {
            minusQty();
          }, Icons.remove),
          SizedBox(
            width: 10,
          ),
          Text(
            '$count',
            style: TextStyle(fontSize: 30, fontWeight: FontWeight.w900, color: AppServices.hexaCodeToColor(AppColors.primary)),
          ),
          SizedBox(
            width: 10,
          ),
          ReuseBtnQty(() {
            addQty();
          }, Icons.add),
        ],
      ),
    );
  }
}
