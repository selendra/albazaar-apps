import 'package:albazaar_app/all_export.dart';

class RateProduct extends StatelessWidget{

  int rateAmount = 3;

  int sale = 15;
  
  Widget build(BuildContext context){
    return Row(
      children: [

        ListView.builder(
          itemCount: 5,
          scrollDirection: Axis.horizontal,
          shrinkWrap: true,
          itemBuilder: (context, index){
            return Padding(
              padding: EdgeInsets.only(right: 7),
              child: SvgPicture.asset('assets/icons/rate_star.svg', color: index <= rateAmount ? AppServices.hexaCodeToColor(AppColors.secondary) : AppServices.hexaCodeToColor(AppColors.secondary).withOpacity(0.5), height: 13, width: 13)
            );
          }
        ),

        MyText(
          textAlign: TextAlign.left,
          text: "(${sale.toString()} sold)",
          fontSize: 12,
          color: "#000000",
        )
      ],
    );
  }
}