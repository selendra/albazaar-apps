import 'package:albazaar_app/all_export.dart';

class MessageModel extends NotificationModel{

  bool active;
  String name;
  bool newMessage;

  MessageModel(img, title, subTitle, moment, time, date, this.name, this.active, this.newMessage) : 
  super(
    img, title, subTitle, moment, time, date
  );
}
