import 'package:flutter/material.dart';
import 'package:albazaar_app/all_export.dart';

class BtnQty extends StatelessWidget {
  final String count;
  final Function addQty;
  final Function minusQty;
  final Function numberPressed;
  final Function tapText;

  BtnQty(this.count, this.addQty, this.minusQty, this.numberPressed, {this.tapText});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: _btnQtyRow(numberPressed: numberPressed, context: context, tapText: tapText)
    );
  }

  Widget _btnQtyRow({Function numberPressed, BuildContext context, Function tapText}) {

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
            onTap: tapText,
            child: MyText(
              pLeft: 5, pRight: 5,
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
