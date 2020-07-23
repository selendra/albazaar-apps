import 'package:flutter/material.dart';

class Body extends StatefulWidget {
  final String name, url, email;
  Body(this.name,this.url,this.email);

  @override
  _BodyState createState() => _BodyState();
}

class _BodyState extends State<Body> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        child: Column(
          children: <Widget>[
            SizedBox(height: 20,),
            InkWell(
              onTap: (){
                print('Accounts');
              },
              splashColor: Colors.grey,
              child: ListTile(
                title: Text('Profile photo'),
                trailing: CircleAvatar(backgroundImage: NetworkImage(widget.url),),
              ),
            ),
            Container(
              height: 2,
              margin: EdgeInsets.only(left: 20.0,right: 20.0),
              color: Colors.grey[300],
            ),
            inkWell((){}, 'Name', widget.name),
            inkWell((){}, 'Account Info', widget.email),
            inkWell((){}, 'Gender', 'Male'),
            inkWell((){}, 'Date of Birth', '/Sep'),
            Container(
              height: 2,
              margin: EdgeInsets.only(left: 20.0,right: 20.0),
              color: Colors.grey[300],
            ),
            inkWell((){}, 'Shipping Address', 'Cambodia'),

          ],
        ),
      ),
    );
  }
  Widget inkWell(Function onTap,String title,String trailing){
    return InkWell(
      onTap: onTap,
      splashColor: Colors.grey,
      child: ListTile(
        title: Text(title),
        trailing: Text(trailing),
      ),
    );
  }
}
