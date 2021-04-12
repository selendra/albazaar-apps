import 'package:albazaar_app/all_export.dart';

class MyAppBar{

  double  pLeft; double pTop; double pRight; double pBottom;
  Widget leading;
  EdgeInsetsGeometry margin;
  String title;
  String titleHexaColor;
  Function onPressed;
  
  PreferredSizeWidget appBar({
    leading,
    titleHexaColor,
    pLeft = 0,
    pTop = 0,
    pRight = 0,
    pBottom = 0,
    margin = const EdgeInsets.fromLTRB(0, 0, 0, 0),
    @required title,
    onPressed
  }) {
    
    return AppBar(
      // height: 65.0, 
      leadingWidth: 0,
      toolbarHeight: 70,
      elevation: 0,
      backgroundColor: Colors.white,
      brightness: Brightness.light,
      leading: null,
      flexibleSpace: Align(
        alignment: Alignment.centerLeft,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            leading ?? Container(),
            MyText(
              color: titleHexaColor ?? AppColors.primary,
              text: title,
              fontWeight: FontWeight.w700,
              fontSize: 22,
            )
          ],
        )
      )
    );
  }
}