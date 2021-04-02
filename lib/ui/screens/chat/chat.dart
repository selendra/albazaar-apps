import 'package:albazaar_app/all_export.dart';
import 'package:albazaar_app/core/models/chat_m.dart';
import 'package:albazaar_app/core/models/message_m.dart';
import 'package:albazaar_app/ui/screens/chat/chat_body.dart';

class Chat extends StatefulWidget {

  final MessageModel messageModel;

  Chat({this.messageModel});

  @override
  _ChatState createState() => _ChatState();
}

class _ChatState extends State<Chat> {

  List<ChatModel> chatUsers = [
    ChatModel(name: "Jane Russel", messageText: "Awesome Setup", imageUrl: "images/userImage1.jpeg", time: "Now"),
    ChatModel(name: "Glady's Murphy", messageText: "That's Great", imageUrl: "images/userImage2.jpeg", time: "Yesterday"),
    ChatModel(name: "Jorge Henry", messageText: "Hey where are you?", imageUrl: "images/userImage3.jpeg", time: "31 Mar"),
    ChatModel(name: "Philip Fox", messageText: "Busy! Call me in 20 mins", imageUrl: "images/userImage4.jpeg", time: "28 Mar"),
    ChatModel(name: "Debra Hawkins", messageText: "Thankyou, It's awesome", imageUrl: "images/userImage5.jpeg", time: "23 Mar"),
    ChatModel(name: "Jacob Pena", messageText: "will update you in evening", imageUrl: "images/userImage6.jpeg", time: "17 Mar"),
    ChatModel(name: "Andrey Jones", messageText: "Can you please share the file?", imageUrl: "images/userImage7.jpeg", time: "24 Feb"),
    ChatModel(name: "John Wick", messageText: "How are you?", imageUrl: "images/userImage8.jpeg", time: "18 Feb"),
  ];

  List<ChatMessage> messages = [
    ChatMessage(messageContent: "Hello, Will", messageType: "receiver"),
    ChatMessage(messageContent: "How have you been?", messageType: "receiver"),
    ChatMessage(messageContent: "Hey Kriss, I am doing fine dude. wbu?", messageType: "sender"),
    ChatMessage(messageContent: "ehhhh, doing OK.", messageType: "receiver"),
    ChatMessage(messageContent: "Is there any thing wrong?", messageType: "sender"),
  ];
  
  Widget build(BuildContext context){
    var _lang = AppLocalizeService.of(context);
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        //backgroundColor: Colors.white,
        toolbarHeight: 68,
        elevation: 0,
        brightness: Brightness.light,
        flexibleSpace: SafeArea(
          child: Row(
            children: [
              IconButton(
                alignment: Alignment.centerRight,
                icon: SvgPicture.asset('assets/icons/back.svg'),
                onPressed: () {
                  Navigator.pop(context);
                },
              ),

              MyCard(
                mLeft: 20,
                height: 30,
                width: 30,
                image: DecorationImage(
                  fit: BoxFit.cover,
                  image: NetworkImage(widget.messageModel.img)
                ),
              ),

              MyText(
                pLeft: 20,
                text:  widget.messageModel.name,
              ),
              Expanded(child: Container()),

              Align(
                alignment: Alignment.centerRight,
                child: MyText(
                  pRight: 10,
                  text: widget.messageModel.active ? 'Online' : 'Offline',
                )
              ) 
            ],
          ),
        ),
      ),
      body: Stack(
        children: [
          BodyScaffold(
            // physics: NeverScrollableScrollPhysics(),
            bottom: 0,
            height: MediaQuery.of(context).size.height,
            child: MyPadding(
              pLeft: 0, pRight: 0,
              pBottom: 65,
              child: ChatBody(
                chatUsers: chatUsers,
                messages: messages
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
          ),

          Align(
            alignment: Alignment.bottomLeft,
            child: Container(
              // padding: EdgeInsets.only(bottom: 12),
              width: double.infinity,
              color: Colors.white,
              height: 60,
              child: Row(
                children: [
                  Expanded(
                    child: MyPadding(
                      pLeft: 12, pRight: 0,
                      child: TextFormField(
                        maxLines: null,
                        decoration: InputDecoration(
                          contentPadding: EdgeInsets.only(left: 20, top: 5, bottom: 5),
                          hintText: 'Write message...',
                          enabledBorder: OutlineInputBorder(borderSide: BorderSide.none),
                          border: OutlineInputBorder(borderSide: BorderSide.none),
                          focusedBorder: OutlineInputBorder(borderSide: BorderSide.none)
                        ),
                      )
                    )
                  ),

                  IconButton(
                    icon: Icon(Icons.send, color: AppServices.hexaCodeToColor(AppColors.primary)),
                    onPressed: (){
                      
                    },

                  )
                ]
              )
            ),
          )
        ] 
      )
    );
  }
}