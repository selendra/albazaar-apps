import 'package:albazaar_app/all_export.dart';

class ShopTabbar extends StatelessWidget{
  Widget build(BuildContext context){
    return MyPadding(
      pLeft: pd10+2, pRight: pd10+2,
      pBottom: pd20,
      child: Row(
        children: [

          Container(
            height: 50,
            decoration: BoxDecoration(
              color: AppServices.hexaCodeToColor(AppColors.secondary),
              borderRadius: BorderRadius.circular(30.0),
            ),
            child: TextButton(
              onPressed: (){},
              child: Row(
                children: [
                  Icon(Icons.search, color: Colors.white),
                  MyText(
                    pLeft: 10,
                    fontSize: 16.0,
                    text: "Search",
                    color: AppColors.white,
                  )
                ],
              ),
            )
          ),

          Expanded(
            child: MyText(
              text: "All",
              color: AppColors.secondary,
            )
          ),
          
          Expanded(
            child: MyText(
              text: "Pending"
            )
          ),
          
          Expanded(
            child: MyText(
              left: 10,
              text: "Sold"
            )
          ),

          // SvgPicture.asset('assets/icons/plus.svg', height: 18, width: 18, color: AppServices.hexaCodeToColor(AppColors.secondary)),
          
        ],
      ),
    );
  }
}