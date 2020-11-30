import 'package:flutter/material.dart';
import 'package:selendra_marketplace_app/all_export.dart';

class IndividualChat extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: Row(
          children: [
            Padding(
                child: CircleAvatar(
                  backgroundImage: AssetImage('images/avatar.png'),
                ),
                padding: const EdgeInsets.only(right: 10, left: 0)),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Hello',
                  style: titleTextStyle,
                ),
                Text(
                  'last seen 10 minutes ago',
                  style: TextStyle(fontSize: 10.0),
                ),
              ],
            )
          ],
        ),
        leading: InkWell(
          onTap: () {
            Navigator.pop(context);
          },
          child: Icon(
            Icons.arrow_back,
            color: kDefaultColor,
          ),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 10.0),
            child: DropdownButton<String>(
              icon: Icon(Icons.more_vert, color: kDefaultColor),
              items: <String>['One', 'Two', 'Free', 'Four']
                  .map<DropdownMenuItem<String>>((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(
                    value,
                  ),
                );
              }).toList(),
              onChanged: (value) => {},
            ),
          ),
        ],
      ),
      body: GestureDetector(
        onTap: () => FocusScope.of(context).unfocus(),
        child: Container(
          child: Column(
            children: [
              Expanded(
                child: Container(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 10.0, vertical: 10.0),
                  child: Column(
                    children: [
                      Row(
                        children: [
                          CircleAvatar(
                            backgroundImage: AssetImage('images/avatar.png'),
                          ),
                          SizedBox(
                            width: 5.0,
                          ),
                          Container(
                            width: MediaQuery.of(context).size.width / 2,
                            decoration: BoxDecoration(
                              color: kDefaultColor,
                              borderRadius: BorderRadius.circular(4.0),
                            ),
                            child: Container(
                              padding: EdgeInsets.all(5.0),
                              margin: EdgeInsets.all(5.0),
                              child: Text(
                                'Hello World! Welcome to Selendra ',
                                style: TextStyle(color: Colors.white),
                                overflow: TextOverflow.visible,
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 10.0,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Container(
                            width: MediaQuery.of(context).size.width / 2,
                            decoration: BoxDecoration(
                              color: kDefaultColor,
                              borderRadius: BorderRadius.circular(4.0),
                            ),
                            child: Container(
                              padding: EdgeInsets.all(5.0),
                              margin: EdgeInsets.all(5.0),
                              child: Text(
                                'Hello World! Welcome to Selendra ',
                                style: TextStyle(color: Colors.white),
                                overflow: TextOverflow.visible,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 5.0),
                child: Row(
                  children: [
                    IconButton(
                      icon: Icon(
                        Icons.attach_file,
                        color: kDefaultColor,
                      ),
                      onPressed: () => {},
                    ),
                    Expanded(
                      child: TextField(
                        decoration: InputDecoration.collapsed(
                          hintText: 'Send Messages',
                        ),
                      ),
                    ),
                    IconButton(
                      icon: Icon(
                        Icons.send,
                        color: kDefaultColor,
                      ),
                      onPressed: () => {},
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
