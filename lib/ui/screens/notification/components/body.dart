import 'package:flutter/material.dart';
import 'package:albazaar_app/all_export.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:flutter_swipe_action_cell/core/cell.dart';
import 'package:flutter_swipe_action_cell/core/controller.dart';

class Body extends StatelessWidget {
  
  final int check;
  final SlidableController slidableController;
  final SwipeActionController swipeActionController;
  final List<int> checkList;
  final List<NotificationModel> _notification;
  final Function snackBar;
  final Function removeMessage;
  final Function checkChange;
  final Function editSwipe;

  Body(
    this._notification,
    {
      this.slidableController,
      this.swipeActionController,
      this.check,
      this.checkList,
      this.snackBar,
      this.removeMessage,
      this.checkChange,
      this.editSwipe
    }
  );
  
  double fontSize =  12;

  int _selectedIndex;

  @override
  Widget build(BuildContext context) {
    print(slidableController.activeState);
    return ListView.builder(
      itemCount: _notification.length,
      itemBuilder: (context, index) {
        return SwipeActionCell(
          index: index,
          controller: swipeActionController,
          closeWhenScrolling: false,
          key: ValueKey(index), 
          trailingActions: [
            
            SwipeAction(
              content: MyText(text: 'Remove', color: AppColors.white,),
              onTap: (b){
                // snackBar();
                // print("Delete");               
                // removeMessage(index);
                editSwipe();
              }
            )
          ],
          leadingActions: [

            SwipeAction(
              color: Colors.white,
              content: Radio(
                value: index,
                groupValue: checkList[index],
                // fillColor: MaterialStateProperty.all(AppServices.hexaCodeToColor(AppColors.secondary)),
                // activeColor: kDefaultColor,
                onChanged: (val) {
                },
              ),
              onTap: (b){
                checkChange(index); 
              }
            )
          ],
          child: Column(
            children: [

              Container(
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
              
              if (index != _notification.length-1) Divider(height: 1, color: Colors.grey[400],)
            ]
          )
        );
        // Column(
        //   children: [

        //     Slidable(
        //       controller: slidableController,
        //       actionPane: SlidableDrawerActionPane(),
        //       actionExtentRatio: 0.25,
        //       child: Container(
        //         height: 120,
        //         // margin: const EdgeInsets.symmetric(vertical: 5, horizontal: 5),
        //         decoration: BoxDecoration(
        //           color: Colors.white,
        //         ),
        //         child: Row(
        //           children: [
        //             MyCard(
        //               mLeft: 20,
        //               height: 50,
        //               width: 53,
        //               image: DecorationImage(
        //                 fit: BoxFit.cover,
        //                 image: NetworkImage(_notification[index].img,)
        //               ),
        //             ),
                    
        //             MyPadding(
        //               pLeft: 16, pRight: 0,
        //               child: Column(
        //                 crossAxisAlignment: CrossAxisAlignment.start,
        //                 mainAxisAlignment: MainAxisAlignment.center,
        //                 children: [
        //                   MyText(
        //                     text: _notification[index].title,
        //                     fontSize: fontSize + 4,
        //                   ),

        //                   MyText(
        //                     text: _notification[index].subTitle,
        //                     fontSize: fontSize,
        //                   )
        //                 ]
        //               ),
        //             ),

        //             Expanded(child: Container(),),
        //             MyPadding(
        //               pRight: 20,
        //               pLeft: 0,
        //               child: Column(
        //                 crossAxisAlignment: CrossAxisAlignment.end,
        //                 mainAxisSize: MainAxisSize.min,
        //                 children: [
                          
        //                   MyText(
        //                     fontSize: fontSize,
        //                     text: _notification[index].date
        //                   ),

        //                   MyText(
        //                     fontSize: fontSize,
        //                     text: _notification[index].time
        //                   ),

        //                   MyText(
        //                     fontSize: fontSize,
        //                     text: _notification[index].moment
        //                   )
        //                 ],
        //               ), 
        //             )
        //           ],
        //         )
        //       ), 
        //       actions: [
        //         IconSlideAction(
        //           iconWidget: Radio(
        //             value: index,
        //             groupValue: checkList[index],
        //             // fillColor: MaterialStateProperty.all(AppServices.hexaCodeToColor(AppColors.secondary)),
        //             // activeColor: kDefaultColor,
        //             onChanged: (val) {
        //             },
        //           ),
        //           closeOnTap: false,
        //           onTap: () {
        //             checkChange(index);            
        //             // removeMessage(index);
        //           },
        //         )
        //       ],
        //       secondaryActions: <Widget>[
        //         IconSlideAction(
        //           caption: 'Delete',
        //           color: AppServices.hexaCodeToColor(AppColors.delete),
        //           icon: Icons.delete,
        //           onTap: () {
        //             snackBar();
        //             print("Delete");               
        //             removeMessage(index);
        //           },
        //         ),
        //       ]
        //     ),

        //     if (index != _notification.length-1) Divider(height: 1, color: Colors.grey[400],)
        //   ],
        // );
      },
    );
  }
}
