import 'package:selendra_marketplace_app/all_export.dart';

class MyBodyScaffold extends StatelessWidget{

  final double  pLeft; final double pTop; final double pRight; final double pBottom;
  final EdgeInsetsGeometry padding;
  final double height;
  final ScrollPhysics scroll;
  final Widget child;
  final Widget bottomAppBar;
  final Widget floatingActionBtn;

  MyBodyScaffold({
    this.pLeft = 0,
    this.pTop = 0,
    this.pRight = 0,
    this.pBottom = 0,
    this.padding = const EdgeInsets.fromLTRB(0, 0, 0, 0),
    this.scroll = const NeverScrollableScrollPhysics(),
    this.height,
    this.child,
    this.bottomAppBar,
    this.floatingActionBtn
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
            child: child,
          ),
        ), 
        floatingActionButton: floatingActionBtn,
        bottomNavigationBar: bottomAppBar,
      )
    );
  }
}