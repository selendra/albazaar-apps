import 'package:selendra_marketplace_app/all_export.dart';

class MyBodyScaffold extends StatelessWidget{

  final double  pLeft; final double pTop; final double pRight; final double pBottom;
  final EdgeInsetsGeometry padding;
  final double height;
  final ScrollPhysics scroll;
  final Widget child;

  MyBodyScaffold({
    this.pLeft = 0,
    this.pTop = 0,
    this.pRight = 0,
    this.pBottom = 0,
    this.padding = const EdgeInsets.fromLTRB(35, 35, 35, 70),
    this.scroll = const NeverScrollableScrollPhysics(),
    this.height,
    this.child
  });
  
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          physics: scroll,
          child: Container( 
            height: height,
            width: MediaQuery.of(context).size.width, 
            padding: padding,
            child: Expanded(
              child: child
            ),
          ),
        )
      )
    );
  }
}