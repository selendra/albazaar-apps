import 'package:flutter/material.dart';
import 'package:selendra_marketplace_app/all_export.dart';

class TransactionHistory extends StatelessWidget {
  final String title;
  final String amount;
  final String logo;

  TransactionHistory({this.title, this.amount, this.logo});

  List _buildList(int count) {
    List<Widget> listItems = List();

    for (int i = 0; i < count; i++) {
      listItems.add(
        Container(
          margin: EdgeInsets.symmetric(horizontal: 10.0, vertical: 0.0),
          child: Card(
            elevation: 0,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(kDefaultRadius),
              side: BorderSide(
                color: kDefaultColor,
              ),
            ),
            child: ListTile(
              onTap: () {},
              trailing: Text(
                'Amount',
                style: TextStyle(fontWeight: FontWeight.w900),
              ),
              leading: Image.asset(logo, width: 30, height: 30),
              title: Text(
                'Sent',
                style: TextStyle(fontWeight: FontWeight.w900),
              ),
            ),
          ),
        ),
      );
    }
    return listItems;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: CustomScrollView(
          slivers: [
            SliverAppBar(
              expandedHeight: MediaQuery.of(context).size.height * 0.3,
              floating: false,
              pinned: true,
              snap: false,
              title: Text(
                title,
                style: const TextStyle(
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
      ),
    );
  }
}
