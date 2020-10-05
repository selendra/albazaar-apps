import 'package:flutter/material.dart';
import 'package:selendra_marketplace_app/all_export.dart';

class Body extends StatelessWidget {
  List<NotificationModel> _notification = [
    NotificationModel(
        'https://i.pinimg.com/originals/24/5e/34/245e341e485ca2d1178ac76230587e00.jpg',
        'Aliza sent you a message',
        '5 minutes ago'),
    NotificationModel('https://images6.alphacoders.com/348/348379.jpg',
        'Aliza sent you a message', '5 minutes ago'),
    NotificationModel('https://eskipaper.com/images/cute-little-girl-1.jpg',
        'Aliza sent you a message', '5 minutes ago'),
    NotificationModel(
        'https://i.pinimg.com/originals/35/37/9f/35379f32387bb23dd48bf235b071eaf5.jpg',
        'Aliza sent you a message',
        '5 minutes ago'),
    NotificationModel(
        'https://s1.1zoom.me/big3/318/Little_girls_Smile_489609.jpg',
        'Aliza sent you a message',
        '5 minutes ago'),
    NotificationModel(
        'https://i.pinimg.com/originals/24/5e/34/245e341e485ca2d1178ac76230587e00.jpg',
        'Aliza sent you a message',
        '5 minutes ago'),
    NotificationModel(
        'https://img.freepik.com/free-photo/happy-cute-little-girl-running-grass-park-happiness_109285-143.jpg?size=626&ext=jpg',
        'Aliza sent you a message',
        '5 minutes ago'),
    NotificationModel(
        'https://c4.wallpaperflare.com/wallpaper/982/256/975/cute-little-girl-kid-smiling-decoration-on-head-barefoot-wallpaper-preview.jpg',
        'Aliza sent you a message',
        '5 minutes ago'),
  ];
  @override
  Widget build(BuildContext context) {
    return Container(
      child: ListView.builder(
        itemCount: _notification.length,
        itemBuilder: (context, index) {
          return Container(
            margin: EdgeInsets.symmetric(vertical: 5, horizontal: 5),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(kDefaultRadius),
            ),
            child: ListTile(
              leading: CircleAvatar(
                backgroundImage: NetworkImage(_notification[index].img),
              ),
              title: Text(
                _notification[index].title,
                style: TextStyle(fontSize: 14.0),
              ),
              subtitle: Text(
                _notification[index].time,
                style: TextStyle(fontSize: 12.0),
              ),
            ),
          );
        },
      ),
    );
  }
}
