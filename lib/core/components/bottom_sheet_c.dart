import 'package:selendra_marketplace_app/all_export.dart';
import 'package:selendra_marketplace_app/ui/screens/wallet/qr_scanner/qr_scanner.dart';

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
                        await Permission.camera.request().isGranted.then((response) async {
                          if (response){
                            var value = await Navigator.push(context,MaterialPageRoute(builder: (context) => QrScanner(portList: [])));

                            // Prevent Close Scan QR With Scan
                            if (value != null){
                              await Navigator.push(context, MaterialPageRoute(builder: (context) => SubmitTrx(value, false, portfolioList))).then((value) async {
                              
                                // Update Data On Wallet Screen
                                if (value != null){
                                  await Provider.of<UserProvider>(context, listen: false).fetchPortforlio();
                                  // await Provider.of<TrxHistoryProvider>(context, listen: false).fetchTrxHistory();
                                  resetState();
                                }
                              });
                            }
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
