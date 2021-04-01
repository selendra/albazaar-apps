import 'package:albazaar_app/all_export.dart';
import 'package:albazaar_app/core/models/message_m.dart';
import 'package:albazaar_app/ui/screens/chat/chat_body.dart';

class Chat extends StatefulWidget {

  final MessageModel messageModel;

  Chat({this.messageModel});

  @override
  _ChatState createState() => _ChatState();
}

class _ChatState extends State<Chat> {
  
  Widget build(BuildContext context){
    var _lang = AppLocalizeService.of(context);
    return Scaffold(
      appBar: ReuseSimpleAppBar.getItem(
        widget.messageModel.name,
        context,
        actions: [
          Align(
            alignment: Alignment.centerRight,
            child: MyText(
              pRight: 20,
              text: widget.messageModel.active ? 'active' : 'inactive',
            )
          )
        ]
      ),
      body: BodyScaffold(
        height: MediaQuery.of(context).size.height,
        child: MyPadding(
          pLeft: 0, pRight: 0,
          pBottom: 65,
          child: ChatBody(
            // _messageScreen,
            // swipeActionController: swipe,
            // check: check,
            // checkList: checkList,
            // snackBar: snackBar,
            // removeMessage: removeMessage,
            // checkChange: checkChange,
            // editSwipe: editSwipe
          )
        ),
      )
    );
  }
}