class AuthData {
   String? userName;
   String? phoneNumber;
   String? email;
   String? password;

  AuthData({this.userName, this.phoneNumber, this.email, this.password});

  AuthData.fromJson(Map<String, dynamic> json) {
    userName = json['userName'];
    phoneNumber = json['phoneNumber'];
    email = json['email'];
    password = json['password'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data =  Map<String, dynamic>();
    data['userName'] = userName;
    data['phoneNumber'] = phoneNumber;
    data['email'] = email;
    data['password'] = password;
    return data;
    return data;
  }
}