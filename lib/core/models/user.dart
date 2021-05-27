import 'package:albazaar_app/all_export.dart';

class User {

  final formKey = GlobalKey<FormState>();

  PrefService prefService = PrefService();
  String mGender;

  TextEditingController first = TextEditingController();
  TextEditingController mid = TextEditingController();
  TextEditingController last = TextEditingController();

  TextEditingController emailCon = TextEditingController();
  TextEditingController phone = TextEditingController();
  TextEditingController addressCon = TextEditingController();

  String description;
  String address = '';
  String email;
  String firstName;
  dynamic documentsId;
  String wallet;
  String midName;
  dynamic occupation;
  dynamic nationality;
  bool isPartner;
  String phonenumber;
  String statusName;
  String lastName;
  String gender;
  String profileImg = '';
  DateTime createdAt;

  User({
    this.description,
    this.address,
    this.email,
    this.firstName,
    this.documentsId,
    this.wallet,
    this.midName,
    this.occupation,
    this.nationality,
    this.isPartner,
    this.phonenumber,
    this.statusName,
    this.lastName,
    this.gender,
    this.profileImg,
    this.createdAt,
  });

  User.fromJson(Map<String, dynamic> parseJson) {
    description = parseJson["description"];
    address = parseJson["address"];

    email = parseJson["email"];
    emailCon.text = parseJson["email"];
    phone.text = parseJson["phonenumber"];
    addressCon.text = parseJson["address"];

    first.text = parseJson["first_name"]; 
    mid.text = parseJson["mid_name"]; 
    last.text = parseJson["last_name"]; 

    firstName = parseJson["first_name"];
    documentsId = parseJson["documents_id"];
    wallet = parseJson["wallet"];
    midName = parseJson["mid_name"];
    occupation = parseJson["occupation"];
    nationality = parseJson["nationality"];
    isPartner = parseJson["is_partner"];
    phonenumber = parseJson["phonenumber"];
    statusName = parseJson["status_name"];
    lastName = parseJson["last_name"];
    gender = parseJson["gender"];
    profileImg =
        parseJson["profile_img"] == 'null' ? null : parseJson["profile_img"];
    createdAt = DateTime.parse(parseJson["created_at"]);
  }
}
