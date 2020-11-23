import 'package:flutter/material.dart';
import 'package:selendra_marketplace_app/all_export.dart';

class SellerProfile extends StatefulWidget {
  final String username;
  SellerProfile(this.username);

  @override
  _SellerProfileState createState() => _SellerProfileState();
}

class _SellerProfileState extends State<SellerProfile>
    with TickerProviderStateMixin {
  TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(vsync: this, length: 2);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            height: MediaQuery.of(context).size.height * 0.3,
            width: MediaQuery.of(context).size.width,
            child: Image.network(
              'https://images.unsplash.com/photo-1563991522451-90d2395a8854?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&w=1000&q=80',
              fit: BoxFit.cover,
            ),
          ),
          SizedBox(height: 100),
          SingleChildScrollView(
            child: Column(
              children: [
                Center(
                  child: Container(
                    margin: EdgeInsets.only(
                        top: MediaQuery.of(context).size.height * 0.2),
                    height: 120,
                    width: 120,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      image: DecorationImage(
                        image: NetworkImage(
                            'https://staticg.sportskeeda.com/editor/2020/09/9f615-15992439400294-800.jpg'),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 20.0,
                ),
                Text(
                  widget.username,
                  style: titleTextStyle,
                ),
                SizedBox(
                  height: 10,
                ),
                ReuseAuthTab(_tabController, 'Post', 'Contact'),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
