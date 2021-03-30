import 'package:flutter/material.dart';
import 'package:albazaar_app/all_export.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

class Body extends StatelessWidget {
  
  final bool check;
  final List<NotificationModel> _notification;
  final Function snackBar;
  final Function removeMessage;
  final Function checkChange;

  Body(
    this._notification,
    {
      this.check,
      this.snackBar,
      this.removeMessage,
      this.checkChange
    }
  );
  
  double fontSize =  12;

  int _selectedIndex;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: _notification.length,
      itemBuilder: (context, index) {
        return Column(
          children: [
            Slidable(
              actionPane: SlidableDrawerActionPane(),
              actionExtentRatio: 0.25,
              child: Container(
                height: 120,
                // margin: const EdgeInsets.symmetric(vertical: 5, horizontal: 5),
                decoration: BoxDecoration(
                  color: Colors.white,
                ),
                child: Row(
                  children: [
                    MyCard(
                      mLeft: 20,
                      height: 50,
                      width: 53,
                      image: DecorationImage(
                        fit: BoxFit.cover,
                        image: NetworkImage(_notification[index].img,)
                      ),
                    ),
                    
                    MyPadding(
                      pLeft: 16, pRight: 0,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          MyText(
                            text: _notification[index].title,
                            fontSize: fontSize + 4,
                          ),

                          MyText(
                            text: _notification[index].subTitle,
                            fontSize: fontSize,
                          )
                        ]
                      ),
                    ),

                    Expanded(child: Container(),),
                    MyPadding(
                      pRight: 20,
                      pLeft: 0,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          
                          MyText(
                            fontSize: fontSize,
                            text: _notification[index].date
                          ),

                          MyText(
                            fontSize: fontSize,
                            text: _notification[index].time
                          ),

                          MyText(
                            fontSize: fontSize,
                            text: _notification[index].moment
                          )
                        ],
                      ), 
                    )
                  ],
                )
              ), 
              actions: [
                
                IconSlideAction(
                  caption: 'Delete',
                  iconWidget: Radio(
                    value: 1,
                    groupValue: false,
                    // fillColor: MaterialStateProperty.all(AppServices.hexaCodeToColor(AppColors.secondary)),
                    // activeColor: kDefaultColor,
                    onChanged: (val) {
                      checkChange(val);
                      // setSelectedIndex(val);
                    },
                  ),
                  onTap: () {
                    // checkChange(check);            
                    // removeMessage(index);
                  },
                )
              ],
              secondaryActions: <Widget>[
                IconSlideAction(
                  caption: 'Delete',
                  color: AppServices.hexaCodeToColor(AppColors.delete),
                  icon: Icons.delete,
                  onTap: () {
                    snackBar();
                    print("Delete");               
                    removeMessage(index);
                  },
                ),
              ]
            ),

            if (index != _notification.length-1) Divider(height: 1, color: Colors.grey[400],)
          ],
        );
      },
    );
  }
}
