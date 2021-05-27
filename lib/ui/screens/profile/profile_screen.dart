import 'package:albazaar_app/core/models/profile_m.dart';
import 'package:flutter/material.dart';
import 'package:albazaar_app/ui/screens/profile/components/body.dart';
import 'package:albazaar_app/ui/reuse_widget/reuse_simple_appbar.dart';

class ProfileScreen extends StatefulWidget {
  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen>{

  ProfileModel _profileModel = ProfileModel();

  parseUserData(){
    _profileModel.first.text = "Daveat";
    _profileModel.mid.text = "";
    _profileModel.last.text = "Corn";
    _profileModel.mGender = "Male";

    _profileModel.email.text = "condaveat@gmail.com";
    _profileModel.phone.text = "+85511725228";
    _profileModel.address.text = "22E1, Steng mean chey, Phnom penh";
  }

  @override
  void initState() {
    // parseUserData();
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: ReuseSimpleAppBar.getItem('Profile', context),
      body: Body(
        profileModel: _profileModel
      ),
    );
  }
}
