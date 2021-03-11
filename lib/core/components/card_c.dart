import 'package:albazaar_app/all_export.dart';

class MyCard extends StatelessWidget {

  final Alignment align;
  final Alignment alignChild;
  final String hexaColor;
  final double colorOpacity;
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
  /* Padding */
  final double pRight;
  final double pLeft;
  final double pTop;
  final double pBottom;
  final Widget child;
  final DecorationImage image;
  final BoxBorder boxBorder;
  final List<BoxShadow> boxShadow;

  MyCard({
    this.height,
    this.width,
    this.hexaColor = AppColors.white,
    this.colorOpacity = 1.0,
    this.align = Alignment.center,
    this.alignChild = Alignment.center,
    this.mRight = 0,
    this.mLeft = 0,
    this.mTop = 0,
    this.mBottom = 0,
    this.pRight = 0,
    this.pLeft = 0,
    this.pTop = 0,
    this.pBottom = 0,
    this.bTopLeft = 12,
    this.bTopRight = 12,
    this.bBottomLeft = 12,
    this.bBottomRight = 12,
    this.boxBorder,
    this.child,
    this.image,
    this.boxShadow
  });

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: align,
      child: Container(
        margin: EdgeInsets.fromLTRB(mLeft, mTop, mRight, mBottom),
        height: height,
        padding: EdgeInsets.fromLTRB(pLeft, pTop, pRight, pBottom),
        width: width,
        alignment: alignChild,
        decoration: BoxDecoration(
          color: AppServices.hexaCodeToColor(hexaColor).withOpacity(colorOpacity),
          borderRadius: BorderRadius.only(topLeft: Radius.circular(bTopLeft), topRight: Radius.circular(bTopRight), bottomLeft: Radius.circular(bBottomLeft), bottomRight: Radius.circular(bBottomRight)),
          border: boxBorder,
          image: image,
          boxShadow: boxShadow
        ),
        child: child,
      )
    );
  }
}