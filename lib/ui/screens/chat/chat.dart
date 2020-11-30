import 'package:flutter/material.dart';
import 'package:selendra_marketplace_app/all_export.dart';

class Chat extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var _lang = AppLocalizeService.of(context);
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          _lang.translate('message'),
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
              margin: const EdgeInsets.only(bottom: 2.0),
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
                trailing: Column(
                  children: [
                    Text(
                      '12:00 pm',
                      style: TextStyle(fontSize: 10.0),
                    ),
                    SizedBox(height: 10.0),
                    Container(
                      height: 30,
                      width: 30,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: kDefaultColor,
                      ),
                      child: Center(
                        child: Text(
                          '20',
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 12.0,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
