import 'package:albazaar_app/core/models/message_m.dart';
import 'package:albazaar_app/ui/screens/message/message_body.dart';
import 'package:flutter/material.dart';
import 'package:albazaar_app/all_export.dart';
import 'package:flutter_swipe_action_cell/core/controller.dart';

class MessageScreen extends StatefulWidget {

  @override
  _MessageScreenState createState() => _MessageScreenState();
}

class _MessageScreenState extends State<MessageScreen> {

  SwipeActionController swipe = SwipeActionController();

  int check = -1;
  List<int> checkList = [];
  bool selectedAll = false;

  List<MessageModel>_messageScreen = [
    MessageModel(
      'https://i.pinimg.com/originals/24/5e/34/245e341e485ca2d1178ac76230587e00.jpg',
      'Aliza sent you a message',
      'Buy your grapes',
      '5 minutes ago',
      '09:24 pm',
      '23/Jan/2021',
      'Aliza',
      true,
      true,
    ),
    MessageModel(
      'https://images6.alphacoders.com/348/348379.jpg',
      'Aliza sent you a message', 
      'Buy your grapes',
      '5 minutes ago',
      '09:24 pm',
      '23/Jan/2021',
      'Aliza',
      false,
      true,
    ),
    MessageModel(
      'https://eskipaper.com/images/cute-little-girl-1.jpg',
      'Aliza sent you a message', 
      'Buy your grapes',
      '5 minutes ago',
      '09:24 pm',
      '23/Jan/2021',
      'Aliza',
      true,
      false
    ),
    MessageModel(
      'https://i.pinimg.com/originals/35/37/9f/35379f32387bb23dd48bf235b071eaf5.jpg',
      'Aliza sent you a message',
      'Buy your grapes',
      '5 minutes ago',
      '09:24 pm',
      '23/Jan/2021',
      'Aliza',
      true,
      false
    ),
    MessageModel(
      'https://s1.1zoom.me/big3/318/Little_girls_Smile_489609.jpg',
      'Aliza sent you a message',
      'Buy your grapes',
      '5 minutes ago',
      '09:24 pm',
      '23/Jan/2021',
      'Aliza',
      true,
      false
    ),
    MessageModel(
      'https://i.pinimg.com/originals/24/5e/34/245e341e485ca2d1178ac76230587e00.jpg',
      'Aliza sent you a message',
      'Buy your grapes',
      '5 minutes ago',
      '09:24 pm',
      '23/Jan/2021',
      'Aliza',
      false,
      false
    ),
    MessageModel(
      'https://img.freepik.com/free-photo/happy-cute-little-girl-running-grass-park-happiness_109285-143.jpg?size=626&ext=jpg',
      'Aliza sent you a message',
      'Buy your grapes',
      '5 minutes ago',
      '09:24 pm',
      '23/Jan/2021',
      'Aliza',
      false,
      false
    ),
    MessageModel(
      'https://c4.wallpaperflare.com/wallpaper/982/256/975/cute-little-girl-kid-smiling-decoration-on-head-barefoot-wallpaper-preview.jpg',
      'Aliza sent you a message',
      'Buy your grapes',
      '5 minutes ago',
      '09:24 pm',
      '23/Jan/2021',
      'Aliza',
      true,
      false
    ),
  ];

  void snackBar() {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: MyText(text: "Item  deleted", color: AppColors.white),)
    );
  }

  void removeMessage(List<int> items){
    _messageScreen.removeRange(items.first, items.length);
    setState((){});
  }

  void checkChange(int index){
    print("On change $index");
    print("List ${checkList[index]}");
    if(checkList[index] != -1){
      setState((){
        this.checkList[index] = -1;
      });
    } else {
      setState((){
        this.checkList[index] = index;
      });
    }
    print(checkList[index]);
  }

  void openSlidePrimary(){
  }

  void editSwipe(){
    swipe.toggleEditingMode();
    setState((){});
  }

  @override
  void initState() {
    checkList.length = _messageScreen.length;
    checkList.fillRange(0, checkList.length-1, -1);
    openSlidePrimary();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var _lang = AppLocalizeService.of(context);
    return Scaffold(
      appBar: ReuseSimpleAppBar.getItem(
        AppLocalizeService.of(context).translate('message'), 
        context,
        actions: [
          if (swipe.isEditing) IconButton(
            icon: Icon(
              Icons.delete,
              color: Colors.red,
            ),
            onPressed: (){
              if (swipe.getSelectedIndexPaths().length != 0){
                print(swipe.getSelectedIndexPaths());
                // swipe.getSelectedIndexPaths().forEach((element) {
                removeMessage(swipe.getSelectedIndexPaths());
                //   // swipe.deleteCellAt(indexPaths: swipe.getSelectedIndexPaths());
                // });
                swipe.deselectAll();

                if (_messageScreen.length == 0){
                  swipe.stopEditingMode();
                }
                setState(() {
                  
                });
              }
            },
          ),

          if (swipe.isEditing) IconButton(
            icon: Icon(
              Icons.close,
              color: AppServices.hexaCodeToColor(AppColors.primary),
            ),
            onPressed: (){
              swipe.stopEditingMode();
              setState(() { });
            },
          ),

          if (swipe.isEditing) GestureDetector(
            child: Align(
              alignment: Alignment.center,
              child: MyText(
                pRight: 20, pLeft: 12,
                text: selectedAll ? "Clear" : "All",
                color: AppColors.primary,
              )
            ),
            onTap: (){
              if (selectedAll == false) {
                swipe.selectAll(dataLength: _messageScreen.length);
              } else {
                swipe.deselectAll();
              }
              selectedAll = !selectedAll;
              setState(() {
                
              });
            },
          ),

          if (!swipe.isEditing) IconButton(
            icon: SvgPicture.asset('assets/icons/options.svg', height: 20, width: 5, color: AppServices.hexaCodeToColor(AppColors.primary)),
            onPressed: (){
              editSwipe();
            },
          )      
        ]
      ),
      body: BodyScaffold(
        height: MediaQuery.of(context).size.height,
        child: MyPadding(
          pLeft: 0, pRight: 0,
          pBottom: 65,
          child: _messageScreen.length == 0 ? Center(
            child: MyText(text: "No message", fontSize: 20,)
          ) 
          : MessageScreenBody(
            _messageScreen,
            swipeActionController: swipe,
            check: check,
            checkList: checkList,
            snackBar: snackBar,
            removeMessage: removeMessage,
            checkChange: checkChange,
            editSwipe: editSwipe
          )
        ),
      )
    );
  }
}
