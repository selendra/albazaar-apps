import 'package:flutter/material.dart';
import 'package:selendra_marketplace_app/all_export.dart';

class Chat extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          'Message',
          style: TextStyle(
              fontWeight: FontWeight.bold, fontSize: 22, color: kDefaultColor),
        ),
        elevation: 0,
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back,
            color: kDefaultColor,
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        actions: [
          IconButton(
            icon: Icon(
              Icons.search,
              color: kDefaultColor,
            ),
            onPressed: () {
              print('search');
            },
          ),
        ],
      ),
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: ListView.builder(
          itemCount: 20,
          itemBuilder: (context, index) {
            return Container(
              margin: EdgeInsets.only(bottom: 2.0),
              height: 70,
              color: Colors.white,
              child: ListTile(
                onTap: () => Navigator.pushNamed(context, IndividualChatView),
                leading: Container(
                  height: 60,
                  width: 60,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.red,
                  ),
                  child: Image(
                    image: AssetImage('images/avatar.png'),
                  ),
                ),
                title: Text(
                  'Hello',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                ),
                subtitle: Text('Hello world!'),
                trailing: Icon(
                  Icons.check_circle,
                  color: kDefaultColor,
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
