import 'package:albazaar_app/all_export.dart';

class ListWidgetBuilder{

  static Widget imageRowBuilder({BuildContext context, dynamic image, Function onPressed, int selected, int index}){
    return GestureDetector(
      onTap: onPressed,
      child: MyCard(
        hexaColor: "#FFFFFF",
        mRight: 10,
        boxBorder: Border.all(width: 2, color: selected == index ? AppServices.hexaCodeToColor(AppColors.primary) : Colors.transparent),
        width: selected == index ? 60 : 40, height: selected == index ? 60 : 40,
        image: DecorationImage(
          fit: BoxFit.cover,
          image: CachedNetworkImageProvider(image)
        ), 
      ),
    );
  }
}