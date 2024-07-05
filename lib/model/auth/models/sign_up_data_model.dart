class SignUpDataModel {
  String? fname;
  String? lname;
  String? nid;
  String? phone;
  String? email;
  String? password;

  @override
  String toString() {
    return """
    fname: $fname
    lname: $lname
    nid: $nid
    phone: $phone
    email: $email
    password: $password
    """;
  }

  toJson() {
    final user = <String, dynamic>{
      "fname": fname,
      "lname": lname,
      "role": 3,
      "nid": nid,
      "phone": phone,
      "email": email,
    };

    return user;
  }
}

final signUpDataModel = SignUpDataModel();
