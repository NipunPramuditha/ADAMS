//variable initializaion
class User {
  final String id;
  final String email;
  final String name;
  final String datetime;
  final String status;
  final bool newUser;
  final int logincount;

  User(
      {this.id,
      this.email,
      this.name,
      this.datetime,
      this.status,
      this.newUser,
      this.logincount});

  User.fromMap(Map<String, dynamic> data, documentId)
      : email = data["email"],
        name = data["name"],
        datetime = data["datetime"],
        status = data["status"],
        newUser = data["newUser"],
        logincount = data["logincount"],
        id = documentId;

  Map<String, dynamic> toMap() {
    return {
      "id": id,
      "email": email,
      "name": name,
      "datetime": datetime,
      "status": status,
      "newUser": newUser,
      "logincount": logincount
    };
  }
}
