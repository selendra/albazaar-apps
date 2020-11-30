import 'package:selendra_marketplace_app/all_export.dart';

Widget customDropDown(String label, List list, dynamic _model, Function changeValue, PopupMenuItem Function(Map<String, dynamic>) item) {
  /* Custom DropDown */
  return Container(
    padding: EdgeInsets.only(top: 11.0, bottom: 11.0, left: 26.0, right: 14.0),
    decoration: BoxDecoration(
        // color: hexaCodeToColor(AppColors.cardColor),
        borderRadius: BorderRadius.circular(5),
        // border: Border.all(
        //     width: 1,
        //     color: label == "Gender"
        //         ? Colors.transparent
        //         : hexaCodeToColor("#FFFFFF")
        //             .withOpacity(0.3)) /* Control Border Gender Color */
    ),
    child: Row(
      children: <Widget>[
        Expanded(
          child: MyText(
            text: label,
            textAlign: TextAlign.left,
          ),
        ),
        Theme(
          data: ThemeData(canvasColor: Colors.black.withOpacity(0.1)),
          child: PopupMenuButton(
            offset: Offset.zero,
            padding: EdgeInsets.all(12),
            onSelected: (index) {
              changeValue(index);
            },
            icon: Icon(
              Icons.keyboard_arrow_down,
              color: Colors.black,
            ),
            itemBuilder: (BuildContext context) {
              return list.map((list) {
                return item(list);
              }).toList();
            },
          ),
        )
      ],
    ),
  );
}