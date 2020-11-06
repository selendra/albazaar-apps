import 'package:flutter/material.dart';
import 'package:selendra_marketplace_app/all_export.dart';

class TransactionHistory extends StatelessWidget {
  final String title;
  final String amount;

  TransactionHistory({this.title, this.amount});

  List _buildList(int count) {
    List<Widget> listItems = List();

    for (int i = 0; i < count; i++) {
      listItems.add(new Padding(
          padding: new EdgeInsets.all(20.0),
          child: new Text('Item ${i.toString()}',
              style: new TextStyle(fontSize: 25.0))));
    }
    return listItems;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            expandedHeight: MediaQuery.of(context).size.height * 0.3,
            floating: false,
            pinned: true,
            snap: false,
            title: Text(
              title,
              style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 22.0),
            ),
            leading: IconButton(
              icon: Icon(
                Icons.arrow_back,
                color: Colors.white,
              ),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
            backgroundColor: kDefaultColor,
            flexibleSpace: ReuseFlexSpace(amount),
            actions: <Widget>[
              IconButton(
                icon: const Icon(
                  Icons.add_circle,
                  color: Colors.white,
                ),
                tooltip: 'Add new entry',
                onPressed: () {/* ... */},
              ),
            ],
          ),
          SliverList(
            delegate: SliverChildListDelegate(
              _buildList(50),
            ),
          ),
        ],
      ),
    );
  }
}
