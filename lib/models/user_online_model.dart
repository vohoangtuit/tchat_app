

class UserOnLineModel{
  static const userOnLineUid ='uid';
  static const userOnLineName ='name';
  static const userOnLineLastAccess ='lastAccess';
  static const userOnLineIsOnline ='isOnline';

  String? uid;
  String? name;
  String? lastAccess;
  bool? isOnline;
  UserOnLineModel({this.uid,this.name,this.lastAccess,this.isOnline});
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data =  <String, dynamic>{};
    data[userOnLineUid] = uid;
    data[userOnLineName] = name;
    data[userOnLineLastAccess] = lastAccess;
    data[userOnLineIsOnline] = isOnline;
    return data;
  }
  factory UserOnLineModel.fromJson(Map<String, dynamic> json)=>UserOnLineModel(
      uid: json[userOnLineUid],
      name: json[userOnLineName],
      lastAccess: json[userOnLineLastAccess],
      isOnline: json[userOnLineIsOnline]
  );

  @override
  String toString() {
    return 'UserOnLineModel{uid: $uid, name: $name, lastAccess: $lastAccess, isOnline: $isOnline}';
  }
}