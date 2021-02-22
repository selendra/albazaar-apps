
import 'package:selendra_marketplace_app/all_export.dart';

class MyText extends StatelessWidget{

  final String text; final String color; final double fontSize; final FontWeight fontWeight;
  final double top; final double right; final double bottom; final double left;
  final double pTop; final double pRight; final double pBottom; final double pLeft;
  final double width; final double height; final TextAlign textAlign;
  final TextOverflow overflow;
  final int maxLine;

  MyText({
    this.text, this.color = AppColors.txtBtn, this.fontSize = 18, this.fontWeight = FontWeight.normal,
    this.top = 0, this.right = 0, this.bottom = 0, this.left = 0,
    this.pLeft = 0, this.pRight = 0, this.pTop = 0, this.pBottom = 0,
    this.width, this.height, this.textAlign = TextAlign.center,
    this.overflow, this.maxLine
  });
  
  Widget build(BuildContext context){
    return Container(
      margin: EdgeInsets.fromLTRB(this.left, this.top, this.right, this.bottom),
      padding: EdgeInsets.fromLTRB(pLeft, pTop, pRight, pBottom),
      child: SizedBox(
        width: this.width,
        height: this.height,
        child: Text(
          this.text,
          style: TextStyle(
            fontWeight: this.fontWeight,
            color: Color(AppUtils.convertHexaColor(this.color)),
            fontSize: this.fontSize
          ),
          textAlign: this.textAlign,
          overflow: overflow,
          maxLines: maxLine,
        )
      ),
    );
  }
}

Widget warningTitleDialog() {
  return Text(
    'Oops...',
    style: TextStyle(fontWeight: FontWeight.bold),
  );
}