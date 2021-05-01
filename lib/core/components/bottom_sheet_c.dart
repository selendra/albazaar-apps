import 'package:albazaar_app/all_export.dart';
import 'package:albazaar_app/core/components/card_c.dart';
import 'package:albazaar_app/core/services/auth/find_service.dart';
import 'package:albazaar_app/ui/screens/wallet/qr_scanner/qr_scanner.dart';

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

  Future contactOption({BuildContext context}){
    return showModalBottomSheet(
      context: context, 
      isScrollControlled: true,
      builder: (context) {
      return Container(
        decoration: BoxDecoration(
          color: AppServices.hexaCodeToColor(AppColors.bgColor),
        ),
        height: 153,
        child: Column(
          children: [

            Align(
              alignment: Alignment.center,
              child: MyText(
                color: AppColors.black,
                top: 20,
                bottom: 33,
                text: "Contact options",
              ),
            ),

            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [

                Padding(
                  padding: EdgeInsets.only(right: 40),
                  child: BtnSocial(
                    () {
                    // facebookSignIn();
                    }, 
                    'assets/facebook.svg'
                  ),
                ),

                Padding(
                  padding: EdgeInsets.only(right: 40),
                  child: BtnSocial(() {
                  // googleSignIn();
                  }, 'assets/google.svg'),
                ),

                BtnSocial(() {
                  // googleSignIn();
                }, 'assets/telegram.svg')
              ],
            )
          ],
        ),
      );
    },
    );
  }

  Future measurementOptions({BuildContext context}){
    final scaleList = Provider.of<AddProductProvider>(context, listen: false).addProduct.weightList;
    return showModalBottomSheet(
      context: context, 
      isScrollControlled: true,
      builder: (context) {
      return Container(
        decoration: BoxDecoration(
          color: AppServices.hexaCodeToColor(AppColors.bgColor),
        ),
        // height: 200,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [

            Align(
              alignment: Alignment.center,
              child: MyText(
                color: AppColors.black,
                fontWeight: FontWeight.bold,
                top: 20,
                bottom: 33,
                text: "Scale options",
                fontSize: 20,
              ),
            ),

            ListView.builder(
              itemCount: scaleList.length,
              shrinkWrap: true,
              itemBuilder: (context, index){
                return Container(
                  height: 50,
                  child: Column(
                    children: [
                      GestureDetector(
                        onTap: (){
                          Navigator.pop(context, scaleList[index]);
                        },
                        child: Align(
                          alignment: Alignment.center,
                          child: MyText(
                            width: MediaQuery.of(context).size.width,
                            text: FindingServices().findScaleById(scaleList[index]['id'], scaleList),
                          ),
                        ),
                      ),

                      if (index != scaleList.length - 1 ) Divider(height: 1)
                    ],
                  )
                );
              },
            )
          ],
        ),
      );
    });
  }

  Future locationOptions({BuildContext context}){
    final locationList = [
      "Search location",
      "Current location"
    ];

    return showModalBottomSheet(
      context: context, 
      isScrollControlled: true,
      builder: (context) {
      return Container(
        decoration: BoxDecoration(
          color: AppServices.hexaCodeToColor(AppColors.bgColor),
        ),
        // height: 200,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [

            Align(
              alignment: Alignment.center,
              child: MyText(
                color: AppColors.secondary,
                fontWeight: FontWeight.bold,
                top: 20,
                bottom: 33,
                text: "Location options",
                fontSize: 20,
              ),
            ),

            ListView.builder(
              itemCount: locationList.length,
              shrinkWrap: true,
              itemBuilder: (context, index){
                return Column(
                  children: [
                    Container(
                      height: 50,
                      child: GestureDetector(
                        onTap: (){
                          Navigator.pop(context, index);
                        },
                        child: Align(
                          alignment: Alignment.center,
                          child: MyText(
                            width: MediaQuery.of(context).size.width,
                            text: locationList[index],
                          ),
                        ),
                      ),

                    ),
                    if (index != locationList.length - 1 ) Divider(height: 1)
                  ],
                );
              },
            )
          ],
        ),
      );
    });
  }
}
