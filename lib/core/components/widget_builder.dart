import 'package:albazaar_app/all_export.dart';

class ListWidgetBuilder{

  static Widget imageRowBuilder({BuildContext context, dynamic image, Function onPressed}){
    return GestureDetector(
      onTap: onPressed,
      child: MyCard(
        hexaColor: "#FFFFFF",
        mRight: 10,
        boxBorder: Border.all(width: 2, color: AppServices.hexaCodeToColor(AppColors.primary)),
        width: 40, height: 40,
        image: DecorationImage(
          fit: BoxFit.cover,
          image: CachedNetworkImageProvider(image)
        ), 
      ),
    );
  }
}