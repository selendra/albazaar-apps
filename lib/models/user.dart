class User{

  String name;
  String email;
  String userId;

  User(this.name, this.email, this.userId);

  User.fromJson(Map<String,dynamic> parseJson){
    name = parseJson['name'];
    email = parseJson['email'];
    userId = parseJson['id'];
  }

}