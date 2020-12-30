import 'package:flutter/material.dart';
import 'package:flutter_absolute_path/flutter_absolute_path.dart';
import 'package:selendra_marketplace_app/all_export.dart';

class Body extends StatefulWidget {
  
  @override
  _BodyState createState() => _BodyState();
}

class _BodyState extends State<Body> {
  final _formKey = GlobalKey<FormState>();
  final _firstNameKey = GlobalKey<FormFieldState<String>>();
  final _midNameKey = GlobalKey<FormFieldState<String>>();
  final _lastNameKey = GlobalKey<FormFieldState<String>>();
  String firstName, midName, lastName, gender, imageUri, address, alertText;
  int _selectedIndex;
  final snackBar = SnackBar(content: Text('Please Select a Gender'));

  bool _isLoading = false, isCheck = false;

  bool validateAndSave() {
    if (_formKey.currentState.validate()) {
      _formKey.currentState.save();
      return true;
    } else {
      return false;
    }
  }

  Future<void> showAlertDialog(BuildContext context) {
    // set up the button
    Widget okButton = FlatButton(
      child: Text("OK"),
      onPressed: () {
        Navigator.pop(context);
      },
    );

    AlertDialog alert = AlertDialog(
      title: Text(alertText),
      actions: [
        okButton,
      ],
    );

    // show the dialog
    return showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }

  @override
  void initState() {
    super.initState();
    _selectedIndex = 0;
  }

  void onChanged(String value){
    if (firstName != null && lastName != null && gender != null && address != null){
      setState((){
        isCheck = true;
      });
    } else if (isCheck == true) {
      setState((){
        isCheck = false;
      });
    }
  }
  
  void setSelectedIndex(int val) {
    setState(() {
      _selectedIndex = val;
      if (val == 1) gender = 'M'; 
      else gender = 'F';
    });
    onChanged(val.toString());
  }

  Future<void> validateAndSubmit() async {
    if (_selectedIndex == 0) {
      Scaffold.of(context).showSnackBar(snackBar);
    } else {
      if (validateAndSave()) {
        switch (_selectedIndex) {
          case 1:
            gender = 'M';
            break;
          case 2:
            gender = 'F';
            break;
        }
        setState(() {
          _isLoading = true;
        });
        await onSetUserPf();
      }
    }
  }

  Future<void>onSetUserPf() async {
    await UserProvider().setUserPf(firstName, midName, lastName, gender, imageUri, address).then((value) async {
      
      if (value.containsKey('error')){
        alertText = value['error']['message'];

      } else {
        alertText = value['message'];
        // Refetch User Data
        await Provider.of<UserProvider>(context, listen: false).localFetchProfile();

        // After Copy Key
        await Provider.of<UserProvider>(context, listen: false).fetchPortforlio(); 
        
        // Disable Loading
        setState(() {
          _isLoading = false;
        });
      }
      
      await showAlertDialog(context);

      // Close Add User Screen
      Navigator.pop(context);
    });
  }

  Future<void> loadAsset() async {
    List<Asset> resultList = List<Asset>();

    try {
      resultList = await MultiImagePicker.pickImages(
        enableCamera: false,
        cupertinoOptions: CupertinoOptions(takePhotoIcon: "chat"),
        maxImages: 1,
        materialOptions: MaterialOptions(
          actionBarColor: '#${kDefaultColor.value.toRadixString(16)}',
          actionBarTitle: "Selendra App",
          allViewTitle: "All Photos",
          useDetailsView: false,
          selectCircleStrokeColor: "#000000",
        ),
      );
      
      // Check User Cancel Upload Image
      if (resultList != null){
        getAssettoFile(resultList);
      }
    } catch (e) {
      e.toString();
    }

    if (!mounted) return;

    // setState(() {
    //   imageUri = resultList;
    // });
  }

  Future<void> getAssettoFile(List<Asset> resultList) async {
    for (Asset asset in resultList) {
      final filePath = await FlutterAbsolutePath.getAbsolutePath(asset.identifier);

      try {
        if (filePath != null) {
          await Provider.of<UserProvider>(context, listen: false)
              .upLoadImage(File(filePath))
              .then((value) {
            setState(() {
              imageUri = json.decode(value)['uri'];
              Provider.of<UserProvider>(context, listen: false).mUser.profileImg =
                  imageUri;
            });
          });
        }
      } catch (e){
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(30.0),
      child: _isLoading
      ? Center(
        child: CircularProgressIndicator(),
      )
      : SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Column(
            children: <Widget>[

              SizedBox(
                height: MediaQuery.of(context).size.height * 0.1,
              ),
              Consumer<UserProvider>(
                builder: (context, value, child) {
                  return Container(
                    margin: EdgeInsets.all(5),
                    width: 100, height: 100,
                    decoration: BoxDecoration(
                      color: Colors.black,
                      borderRadius: BorderRadius.circular(50),
                      border: Border.all(width: 1, color: Colors.greenAccent)
                    ),
                    child: ClipOval(
                      child: FadeInImage(
                        fit: BoxFit.cover,
                        placeholder: AssetImage('images/loading.gif'), 
                        image: value.mUser.profileImg == null
                          ? AssetImage('images/avatar.png')
                          : NetworkImage(value.mUser.profileImg)
                      ),
                    ),
                  );
                }
                // CircleAvatar(
                //   backgroundImage: ,
                // ),
              ),

              Padding(
                padding: EdgeInsets.only(top: 10, right: 5, left: 5, bottom: 5),
                child: InkWell(
                  onTap: () => loadAsset(),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.add),
                      Text(AppLocalizeService.of(context).translate('profile_photo'))
                    ],
                  ),
                )
              ),

              SizedBox(
                height: 20,
              ),
              _firstName(),

              SizedBox(
                height: 20,
              ),
              _midName(),

              SizedBox(
                height: 20,
              ),
              _lastName(),

              SizedBox(
                height: 20,
              ),
              _address(),

              SizedBox(
                height: 20,
              ),
              _radioBtn(),

              SizedBox(
                height: 40,
              ),
              ReuseButton.getItem('Submit', !isCheck ? null : () async {
                await validateAndSubmit();
              }, context),
            ],
          ),
        ),
      ),
    );
  }

  Widget _radioBtn() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: <Widget>[
        Align(
          alignment: Alignment.topLeft,
          child: Container(
            child: Text(
              'Gender',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
          ),
        ),
        SizedBox(
          height: 10,
        ),
        Container(
          child: Row(
            children: <Widget>[
              Radio(
                value: 1,
                groupValue: _selectedIndex,
                activeColor: kDefaultColor,
                onChanged: (val) {
                  setSelectedIndex(val);
                },
              ),
              Text('Male'),
              Radio(
                value: 2,
                groupValue: _selectedIndex,
                activeColor: kDefaultColor,
                onChanged: (val) {
                  setSelectedIndex(val);
                },
              ),
              Text('Female'),
            ],
          ),
        )
      ],
    );
  }

  Widget _firstName() {
    return ReuseTextField(
      fieldKey: _firstNameKey,
      labelText: 'Firstname',
      onSaved: (value) => firstName = value,
      onChanged: (String value){
        firstName = value;
        onChanged(value);
      },
    );
  }

  Widget _midName() {
    return ReuseTextField(
      fieldKey: _midNameKey,
      labelText: 'Midname',
      onSaved: (value) => midName = value,
      onChanged: (String value){
        midName = value;
        onChanged(value);
      },
    );
  }

  Widget _lastName() {
    return ReuseTextField(
      fieldKey: _lastNameKey,
      labelText: 'Lastname',
      onSaved: (value) => lastName = value,
      onChanged: (String value){
        lastName = value;
        onChanged(value);
      },
    );
  }

  Widget _address() {
    return ReuseTextField(
      labelText: 'Adderss',
      onSaved: (value) => address = value,
      onChanged: (String value){
        address = value;
        onChanged(value);
      },
    );
  }
}
