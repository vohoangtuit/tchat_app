import 'dart:core';

class UserModel{
  int? idDB;
  String? id;
  String? email;
  String? fullName;
  String? createdAt;
  String? updatedAt;
  String? photoUrl ;
  String? deviceToken ;
  String? address ;
  String? phone ;
  String? birthday ;
  bool? isOnline;
  int? socialIdType;

  UserModel({
      this.id,
      this.email,
      this.fullName,
      this.createdAt,
      this.updatedAt,
      this.photoUrl,
      this.deviceToken,
      this.address,
      this.phone,
      this.birthday,
      this.isOnline,
      this.socialIdType
  });
  UserModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    email = json['email'] ?? "";
    fullName = json['fullName'] ?? "";
    createdAt = json['createdAt'] ?? "";
    updatedAt = json['updatedAt'] ?? "";
    photoUrl = json['photoUrl'] ?? "";
    deviceToken = json['deviceToken'] ?? "";
    address = json['address'] ?? "";
    phone = json['phone'] ?? "";
    birthday = json['birthday'] ?? "";
    isOnline = json['isOnline'] ;
    socialIdType = json['socialIdType'] ;
  }
  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['id'] = id;
    data['email'] = email;
    data['fullName'] = fullName;
    data['createdAt'] = createdAt;
    data['updatedAt'] = updatedAt;
    data['photoUrl'] = photoUrl;
    data['deviceToken'] = deviceToken;
    data['address'] = address;
    data['phone'] = phone;
    data['birthday'] = birthday;
    data['isOnline'] = isOnline;
    data['socialIdType'] = socialIdType;
    return data;
  }

  @override
  String toString() {
    return '{idDB: $idDB, id: $id, email: $email, fullName: $fullName, createdAt: $createdAt, updatedAt: $updatedAt, photoUrl: $photoUrl, deviceToken: $deviceToken, address: $address, phone: $phone, birthday: $birthday, isOnline: $isOnline, socialIdType: $socialIdType}';
  }
}