import 'package:albazaar_app/all_export.dart';
import 'package:albazaar_app/ui/screens/chat/chat.dart';
import 'package:flutter_swipe_action_cell/core/cell.dart';
import 'package:flutter_swipe_action_cell/core/controller.dart';
import 'package:albazaar_app/core/models/message_m.dart';

class MessageScreenBody extends StatelessWidget {
  
  final int check;
  final SwipeActionController swipeActionController;
  final List<int> checkList;
  final List<MessageModel> message;
  final Function snackBar;
  final Function removeMessage;
  final Function checkChange;
  final Function editSwipe;

  MessageScreenBody(
    this.message,
    {
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
    return ListView.builder(
      itemCount: message.length,
      itemBuilder: (context, index) {
        return GestureDetector(
          onTap: (){
            Navigator.push(context, MaterialPageRoute(builder: (context) => Chat(messageModel: message[index],) ));
          },
          child: SwipeActionCell(
            selectedIndicator: Icon(Icons.add_circle, color: AppServices.hexaCodeToColor(AppColors.primary)),
            backgroundColor: Colors.white,
            index: index,
            controller: swipeActionController,
            closeWhenScrolling: false,
            key: ValueKey(index),
            trailingActions: [
              
              SwipeAction(
                widthSpace: 100,
                icon: MyPadding(
                  pLeft: 0, pRight: 10,
                  child: MyText(text: 'Remove', color: AppColors.white,)
                ),
                onTap: (b){
                  // snackBar();
                  // print("Delete");               
                  removeMessage(swipeActionController.getSelectedIndexPaths());
                }
              )
            ],
            child: Column(
              children: [

                Container(
                    height: 120,
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
                            image: NetworkImage(message[index].img,)
                          ),
                        ),
                        
                        MyPadding(
                          pLeft: 16, pRight: 0,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              MyText(
                                text: message[index].title,
                                fontSize: fontSize + 5,
                              ),

                              MyText(
                                text: message[index].subTitle,
                                fontWeight: message[index].newMessage ? FontWeight.w800 : FontWeight.normal,
                                color: message[index].newMessage ? "#000000" : AppColors.lowBlack,
                                fontSize: fontSize + 3,
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
                                pBottom: 10,
                                fontSize: fontSize,
                                text: message[index].time
                              ),

                              MyText(
                                pBottom: 10,
                                fontSize: fontSize,
                                text: message[index].moment
                              ),

                              Row(
                                children: [
                                  MyText(text: message[index].active ? "Active" : "Inactive", fontSize: fontSize),
                                  message[index].newMessage ? MyPadding(
                                    pLeft: 10, pRight: 0,
                                    child: SvgPicture.asset(AppConfig.iconPath+'dot.svg', height: 10, width: 10)
                                  ) : Container()
                                ]
                              )
                            ],
                          ), 
                        )
                      ],
                    )
                  ),
                
                if (index != message.length-1) Divider(height: 1, color: Colors.grey[400],)
              ]
            )
          ),
        );
      },
    );
  }
}
