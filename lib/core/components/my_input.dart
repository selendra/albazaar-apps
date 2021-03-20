import 'package:albazaar_app/all_export.dart';

class MyInputField extends StatelessWidget{

  final Key key;
  final Widget icon;
  final String labelText;
  final String prefixText;
  final double pLeft, pTop, pRight, pBottom;
  final height;
  final bool obcureText;
  final bool enableInput;
  final List<TextInputFormatter> textInputFormatter;
  final TextInputType inputType;
  final TextInputAction inputAction;
  final TextEditingController controller;
  final FocusNode focusNode;
  final Function validateField;
  final Function onChanged;
  final Function onSubmit;  

  MyInputField({/* User Input Field */
    this.key,
    this.icon,
    this.labelText,
    this.prefixText,
    this.pLeft: 0, this.pTop: 0, this.pRight: 0, this.pBottom: 0,
    this.height,
    this.obcureText = false,
    this.enableInput = true,
    this.textInputFormatter,
    this.inputType = TextInputType.text,
    this.inputAction = TextInputAction.next,
    @required this.controller,
    @required this.focusNode,
    @required this.validateField,
    @required this.onChanged,
    @required this.onSubmit
  });

  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.fromLTRB(pLeft, pTop, pRight, pBottom),
      height: height,
      child: TextFormField(
          key: this.key,
          enabled: enableInput,
          focusNode: focusNode,
          keyboardType: inputType,
          obscureText: obcureText,
          controller: controller,
          textInputAction: inputAction,
          style: TextStyle(color: Colors.black54, fontSize: 18.0),
          validator: validateField,
          decoration: InputDecoration(
            prefix: icon,
            labelText: labelText,
            labelStyle: TextStyle(
              fontSize: 18.0,
              color: focusNode.hasFocus || controller.text != ""
              ? Colors.black.withOpacity(0.3)
              : Colors.black
            ),
            prefixText: prefixText,
            prefixStyle: TextStyle(color: AppServices.hexaCodeToColor(AppColors.primary), fontSize: 18.0),
            /* Prefix Text */
            filled: true, 
            fillColor: Colors.white,
            enabledBorder: myTextInputBorder(controller.text != ""
              ? Colors.black.withOpacity(0.3)
              : Colors.transparent
            ),
            /* Enable Border But Not Show Error */
            border: errorOutline(),
            /* Show Error And Red Border */
            focusedBorder: myTextInputBorder(Colors.black.withOpacity(0.3)),
            /* Default Focuse Border Color*/
            focusColor: Colors.black,
            /* Border Color When Focusing */
            contentPadding: EdgeInsets.fromLTRB(21, 23, 21, 23), // Default padding = -10.0 px
            // suffixIcon: icon,
          ),
          inputFormatters: textInputFormatter,
          /* Limit Length Of Text Input */
          onChanged: onChanged,
          onFieldSubmitted: (value) {
            onSubmit(context);
          },
        )
      // Material(
      //   borderRadius: BorderRadius.circular(12),
      //   elevation: 0,
      //   shadowColor: Colors.transparent,
      //   child: 
      // )
    );
  }
}

/* User input Outline Border */
OutlineInputBorder myTextInputBorder(Color borderColor, ) {
  return OutlineInputBorder(
    borderSide: BorderSide(color: borderColor, width: 1),
    borderRadius: BorderRadius.circular(12)
  );
}

OutlineInputBorder errorOutline() {
  /* User Error Input Outline Border */
  return OutlineInputBorder(borderSide: BorderSide(color: Colors.red),borderRadius: BorderRadius.circular(12));
}