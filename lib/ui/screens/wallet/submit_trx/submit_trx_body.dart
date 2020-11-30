import 'package:selendra_marketplace_app/all_export.dart';

class SubmitTrxBody extends StatelessWidget{

  final bool enableInput;
  final dynamic dialog;
  final ModelScanPay scanPayM;
  final Function validateWallet; 
  final Function validateAmount; 
  final Function validateMemo;
  final Function onChanged; 
  final Function onSubmit; 
  final Function validateInput; 
  final Function clickSend; 
  final Function resetAssetsDropDown;
  final PopupMenuItem Function(Map<String, dynamic>) item;

  SubmitTrxBody({
    this.enableInput,
    this.dialog,
    this.scanPayM,
    this.validateWallet,
    this.validateAmount,
    this.validateMemo,
    this.onChanged,
    this.onSubmit,
    this.validateInput,
    this.clickSend,
    this.resetAssetsDropDown,
    this.item,
  });
  
  Widget build(BuildContext context) {

    List<MyInputField> listInput = [
      
      MyInputField(
        pBottom: 16,
        labelText: "Receiver addres",
        prefixText: null,
        textInputFormatter: [
          LengthLimitingTextInputFormatter(TextField.noMaxLength),
        ],
        inputType: TextInputType.text,
        controller: scanPayM.controlReceiverAddress,
        focusNode: scanPayM.nodeReceiverAddress,
        validateField: validateWallet,
        onChanged: onChanged,
        onSubmit: onSubmit
      ),
      
      MyInputField(
        pBottom: 16,
        labelText: "Amount",
        prefixText: null,
        textInputFormatter: [
          LengthLimitingTextInputFormatter(TextField.noMaxLength)
        ],
        inputType: TextInputType.number,
        controller: scanPayM.controlAmount,
        focusNode: scanPayM.nodeAmount,
        validateField: validateAmount,
        onChanged: onChanged,
        onSubmit: onSubmit
      ),

      MyInputField(
        pBottom: 16,
        labelText: "Memo",
        prefixText: null,
        textInputFormatter: [
          LengthLimitingTextInputFormatter(TextField.noMaxLength)
        ],
        inputType: TextInputType.text,
        controller: scanPayM.controlMemo,
        focusNode: scanPayM.nodeMemo,
        validateField: validateMemo,
        onChanged: onChanged,
        onSubmit: onSubmit
      )
    ];

    return Column(
      children: [

        MyAppBar(
          title: "Send wallet",
          onPressed: (){
            Navigator.pop(context);
          },
        ),

        Expanded(
          child: Form(
            key: scanPayM.formStateKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                
                listInput[0],

                Container( /* Type of payment */
                  margin: EdgeInsets.only(bottom: 16.0, left: 16, right: 16),
                  child: Material(
                    borderRadius: BorderRadius.circular(10),
                    elevation: 10.0,
                    shadowColor: Colors.black.withOpacity(0.7),
                    child:customDropDown(
                      scanPayM.asset != null ? scanPayM.asset : "Asset name", 
                      scanPayM.portfolio, 
                      scanPayM, 
                      resetAssetsDropDown,
                      item
                    ),
                  )
                ),

                listInput[1],

                listInput[2],
                  
                Container(
                  margin: const EdgeInsets.all(16.0),
                  child: ReuseButton.getItem(
                    "Request code", 
                    scanPayM.enable ? clickSend : null, 
                    context
                  ),
                )
              ],
            ),
          ),
        )
      ],
    );
  }
}

