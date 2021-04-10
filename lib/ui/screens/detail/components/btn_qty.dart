import 'package:flutter/material.dart';
import 'package:albazaar_app/all_export.dart';

class BtnQty extends StatelessWidget {
  final String count;
  final Function addQty;
  final Function minusQty;
  final Function numberPressed;

  BtnQty(this.count, this.addQty, this.minusQty, this.numberPressed);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: _btnQtyRow(numberPressed: numberPressed),
    );
  }

  Widget _btnQtyRow({Function numberPressed}) {
    return Container(
      child: Row(
        children: <Widget>[
          ReuseBtnQty(() {
            minusQty();
          }, Icons.remove),
          SizedBox(
            width: 10,
          ),
          GestureDetector(
            onTap: numberPressed,
            child: MyText(
              pLeft: 10, pRight: 10,
              text: '$count',
              fontSize: 30,
              fontWeight: FontWeight.w900, color: AppColors.primary,
            )
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
