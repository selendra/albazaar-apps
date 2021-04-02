class ChatModel {
  String name;
  String messageText;
  String imageUrl;
  String time;
  ChatModel({this.name, this.messageText, this.imageUrl, this.time});
}

class ChatMessage{
  String messageContent;
  String messageType;
  
  ChatMessage({
    this.messageContent, this.messageType
  });
}