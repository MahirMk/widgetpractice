import 'package:json_annotation/json_annotation.dart';
part 'AuthModel.g.dart';
@JsonSerializable()
class Auth {
  Auth({this.userName,this.phoneNumber,this.email,this.password,this.profilePic,this.uid});
  String? userName;
  String? phoneNumber;
  String? email;
  String? password;
  String? profilePic;
  String? uid;

    factory Auth.fromJson(Map<String, dynamic> json) => _$AuthFromJson(json);

    Map<String, dynamic> toJson() => _$AuthToJson(this);
}