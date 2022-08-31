import 'package:floor/floor.dart';
import 'package:tchat/models/user_model.dart';
@entity
class PersonModel{
  @PrimaryKey(autoGenerate: true)
  int? id;
  String? uid;
  String? fullName;
  String? createdAt;
  String? lastUpdated;
  String? lastLogin;

  PersonModel({this.id, this.uid, this.fullName,this.createdAt,
      this.lastUpdated, this.lastLogin});

  PersonModel.fromJson(Map<dynamic, dynamic> json) {
   // id = json[userId];
    uid = json['id'];
   fullName = json['fullName'] ?? "";
    createdAt = json['createdAt'] ?? "";
    lastUpdated = json['lastUpdated'] ?? "";
    lastLogin = json['lastLogin'] ?? "";
  }
  PersonModel.fromLogin(UserModel user){
    uid = user.uid;
    fullName = user.fullName ?? "";
    createdAt = user.createdAt ?? "";
    lastUpdated = user.lastUpdated ?? "";
    lastLogin = user.lastLogin ?? "";
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['uid'] = uid;
    data['fullName'] = fullName??'';
    data['createdAt'] = createdAt??'';
    data['lastUpdated'] = lastUpdated??'';
    data['lastLogin'] = lastLogin??'';

    return data;
  }

  @override
  String toString() {
    return 'PersonModel{id: $id, uid: $uid, fullName: $fullName, createdAt: $createdAt, lastUpdated: $lastUpdated, lastLogin: $lastLogin}';
  }
}