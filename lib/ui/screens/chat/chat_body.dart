import 'package:albazaar_app/all_export.dart';
import 'package:albazaar_app/core/models/chat_m.dart';

class ChatBody extends StatelessWidget {

  List<ChatModel> chatUsers;
  List<ChatMessage> messages;

  ChatBody({
    this.chatUsers,
    this.messages
  });

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: messages.length,
      shrinkWrap: true,
      padding: EdgeInsets.only(top: 10,bottom: 10),
      itemBuilder: (builder, index){
        return Container(
          padding: EdgeInsets.only(left: 14,right: 14,top: 10,bottom: 10),
          child: Align(
            alignment: (messages[index].messageType == "receiver"?Alignment.topLeft:Alignment.topRight),
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                color: (messages[index].messageType  == "receiver"? Colors.grey : Colors.blue[200]),
              ),
              padding: EdgeInsets.all(16),
              child: Text(messages[index].messageContent, style: TextStyle(fontSize: 15, color: Colors.white),),
            ),
          ),
        );
      },
    );
  }
}