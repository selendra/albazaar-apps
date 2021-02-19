import 'package:selendra_marketplace_app/all_export.dart';

class MyCard extends StatelessWidget {

  final Alignment align;
  final double radius;
  final String hexaColor;
  final double bTopLeft; 
  final double bTopRight;
  final double bBottomLeft;
  final double bBottomRight;
  // Margin 
  final double mRight;
  final double mLeft;
  final double mTop;
  final double mBottom;
  final Widget child;

  MyCard({
    this.radius = 12,
    this.hexaColor = AppColors.white,
    this.align = Alignment.center,
    this.mRight = 0,
    this.mLeft = 0,
    this.mTop = 0,
    this.mBottom = 0,
    this.bTopLeft,
    this.bTopRight,
    this.bBottomLeft,
    this.bBottomRight,
    this.child
  });

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: align,
      child: Container(
        margin: EdgeInsets.fromLTRB(mLeft, mTop, mRight, mBottom),
        decoration: BoxDecoration(
          color: AppServices.hexaCodeToColor(hexaColor),
          borderRadius: BorderRadius.only(topLeft: Radius.circular(bTopLeft), topRight: Radius.circular(bTopRight), bottomLeft: Radius.circular(bBottomLeft), bottomRight: Radius.circular(bBottomRight)),
        ),
        child: child,
      )
    );
  }
}