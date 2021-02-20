import 'package:selendra_marketplace_app/all_export.dart';

class MyCard extends StatelessWidget {

  final Alignment align;
  final String hexaColor;
  final double height;
  final double width;
  /* Border */
  final double bTopLeft; 
  final double bTopRight;
  final double bBottomLeft;
  final double bBottomRight;
  /* Margin */
  final double mRight;
  final double mLeft;
  final double mTop;
  final double mBottom;
  final Widget child;

  MyCard({
    this.height,
    this.width,
    this.hexaColor = AppColors.white,
    this.align = Alignment.center,
    this.mRight = 0,
    this.mLeft = 0,
    this.mTop = 0,
    this.mBottom = 0,
    this.bTopLeft = 12,
    this.bTopRight = 12,
    this.bBottomLeft = 12,
    this.bBottomRight = 12,
    this.child
  });

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: align,
      child: Container(
        margin: EdgeInsets.fromLTRB(mLeft, mTop, mRight, mBottom),
        height: height,
        width: width,
        decoration: BoxDecoration(
          color: AppServices.hexaCodeToColor(hexaColor),
          borderRadius: BorderRadius.only(topLeft: Radius.circular(bTopLeft), topRight: Radius.circular(bTopRight), bottomLeft: Radius.circular(bBottomLeft), bottomRight: Radius.circular(bBottomRight)),
        ),
        child: child,
      )
    );
  }
}