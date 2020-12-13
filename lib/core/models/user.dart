class User {
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
