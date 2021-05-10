import 'package:albazaar_app/all_export.dart';
import 'package:shimmer/shimmer.dart';

class InviteBody extends StatelessWidget{

  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [

      Container(
        height: 300,
        width: double.infinity,
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 16.0),
        child: Column(
          mainAxisSize: MainAxisSize.max,
          children: <Widget>[
            Expanded(
              child: Shimmer.fromColors(
                baseColor: Colors.grey[300],
                highlightColor: Colors.grey[100],
                child: ListView.builder(
                  shrinkWrap: true,
                  itemBuilder: (_, __) => Padding(
                    padding: const EdgeInsets.only(bottom: 8.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Container(
                          width: 300.0,
                          height: 300.0,
                          color: Colors.white,
                          margin: EdgeInsets.only(bottom: 12),
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Container(
                              width: 100,
                              height: 8.0,
                              color: Colors.white,
                            ),
                            const Padding(
                              padding: EdgeInsets.symmetric(vertical: 2.0),
                            ),
                            Container(
                              width: 100,
                              height: 8.0,
                              color: Colors.white,
                            ),
                            const Padding(
                              padding: EdgeInsets.symmetric(vertical: 2.0),
                            ),
                            Container(
                              width: 40.0,
                              height: 8.0,
                              color: Colors.white,
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
                  itemCount: 6,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 8.0),
              child: Text("helo")
              // FlatButton(
              //     onPressed: () {
              //       setState(() {
              //         _enabled = !_enabled;
              //       });
              //     },
              //     child: Text(
              //       _enabled ? 'Stop' : 'Play',
              //       style: Theme.of(context).textTheme.button.copyWith(
              //           fontSize: 18.0,
              //           color: _enabled ? Colors.redAccent : Colors.green),
              //     )),
            )
          ],
        ),
      ),

        MyPadding(
          pTop: pd35,
          pBottom: pd35,
          child: SvgPicture.asset('${AppConfig.illustratePath}gift.svg', width: 200, height: 200),
        ),

        MyText(
          width: MediaQuery.of(context).size.width/1.5,
          text: "Share your code with your friend to get some rewards",
          bottom: pd35*2,
        ),

        MyText(
          text: "REFERRAL CODE",
          bottom: 12,
        ),
        MyCard(
          pLeft: 12,
          pBottom: 12,
          pRight: 12,
          pTop: 12,
          width: 200,
          child: MyText(
            text: "XUYE895EW",
            fontWeight: FontWeight.bold,
            fontSize: 30,
          ),
          mBottom: pd35,
        ),

        MyFlatButton(
          height: 80,
          buttonColor: AppColors.secondary,
          width: MediaQuery.of(context).size.width/1.5,
          child: MyText(text: "Claim Now", color: AppColors.white),
          action: (){
          
          }
        )

      ],
    );
  }
}