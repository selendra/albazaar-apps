import 'package:albazaar_app/all_export.dart';

class CommentUser extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      shrinkWrap: true,
      itemCount: 5,
      itemBuilder: (context, index){
        return MyPadding(
          pRight: 0, pLeft: 0,
          pBottom: 30,
          child: Column(
            children: [
              Row(
                children: [

                  //Profile
                  MyCard(
                    hexaColor: AppColors.secondary,
                    mRight: 10,
                    width: 45, height: 42,
                    align: Alignment.centerLeft,
                    child: SvgPicture.asset('assets/avatar_user.svg', width: 25, height: 25),
                  ),

                  // Name & About
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      MyText(
                        pBottom: 5,
                        text: 'God',
                        fontWeight: FontWeight.w600,
                        fontSize: 16,
                      ),

                      Row(
                        children: [
                          Padding(
                            padding: EdgeInsets.only(right: 7),
                            child: SvgPicture.asset('assets/icons/rate_star.svg', height: 13, width: 13)
                          ),
                          Padding(
                            padding: EdgeInsets.only(right: 7),
                            child: SvgPicture.asset('assets/icons/rate_star.svg', height: 13, width: 13)
                          ),
                          Padding(
                            padding: EdgeInsets.only(right: 7),
                            child: SvgPicture.asset('assets/icons/rate_star.svg', height: 13, width: 13)
                          ),
                          Padding(
                            padding: EdgeInsets.only(right: 7),
                            child: SvgPicture.asset('assets/icons/rate_star.svg', height: 13, width: 13)
                          ),
                          Padding(
                            padding: EdgeInsets.only(right: 7),
                            child: SvgPicture.asset('assets/icons/rate_star.svg', height: 13, width: 13)
                          )
                        ],
                      ),
                    ],
                  ),

                  Expanded(child: Container()),

                  MyText(
                    text: '23 Jan, 2021',
                    fontWeight: FontWeight.w600,
                    color: AppColors.primary,
                    fontSize: 16,
                  )
                  
                ],
              ),

              MyText(
                pTop: 30,
                textAlign: TextAlign.start,
                text: "Orange carrots are long, cone shaped vegetable with a orange colored flesh. It is one of the best vegetable in terms of nutriotional content"
              )
            ],
          )
        );
      }
    );
  }
}