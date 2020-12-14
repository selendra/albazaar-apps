import 'package:selendra_marketplace_app/all_export.dart';

class MyBottomSheet{

  dynamic response;
  
  Future<dynamic> trxOptions({
    BuildContext context,
    List portfolioList,
    Function resetState
  }) {
    return showModalBottomSheet(
      context: context, 
      isScrollControlled: true,
      builder: (context) {
      return Container(
        decoration: BoxDecoration(
          color: Colors.white//hexaCodeToColor(AppColors.bgdColor)
        ),
        height: 153,
        child: Column(
          children: [

            Align(
              alignment: Alignment.center,
              child: MyText(
                color: "#FFFFFF",
                top: 20,
                bottom: 33,
                text: "Transaction options",
              ),
            ),
            
            Row(
              children: [

                Expanded(
                  child: MyBottomSheetItem(
                    subTitle: "Scan wallet",
                    icon: "sld_qr.svg",
                    action: () async {
                      try {
                        var value = await TrxOptionMethod.scanQR(context, portfolioList, resetState);
                        await Navigator.push(context, MaterialPageRoute(builder: (context) => SubmitTrx(value, false, []/* widget.portList */))).then((value) async {
                          
                          // Update Data On Wallet Screen
                          if (value != null){
                            await Provider.of<UserProvider>(context, listen: false).fetchPortforlio();
                            // await Provider.of<TrxHistoryProvider>(context, listen: false).fetchTrxHistory();
                            resetState();
                          }
                        });
                      } catch (e){
                        // print(e.message);
                      }
                    },
                  ),
                ),

                Expanded(
                  child: MyBottomSheetItem(
                    icon: "form.svg",
                    subTitle: "Fill wallet", 
                    action: () {
                      TrxOptionMethod.navigateFillAddress(context, portfolioList, resetState);
                    }
                  )
                ),

                Expanded(
                  child: MyBottomSheetItem(
                    icon: "contact.svg",
                    subTitle: "From Contact", 
                    action: () {
                      TrxOptionMethod.selectContact(context, portfolioList, resetState);
                    }
                  )
                )
              ],
            )
          ],
        ),
      );
    });
  }

  Future<dynamic> notification({
    BuildContext context
  }) {
    return showModalBottomSheet(
      context: context, 
      isScrollControlled: true,
      builder: (context) {
      return Container(
        decoration: BoxDecoration(
          color: Colors.white//hexaCodeToColor(AppColors.bgdColor)
        ),
        height: MediaQuery.of(context).size.height - 107,
        child: Column(
          children: [
            Align(
              alignment: Alignment.center,
              child: MyText(
                color: "#FFFFFF",
                top: 20,
                bottom: 33,
                text: "",
              ),
            ),

            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SvgPicture.asset('assets/no_data.svg', height: 200),

                  MyText(
                    text: "There are no notification found"
                  )
                ],
              )
            )
          ],
        ),
      );
    },
    );
  }
}
