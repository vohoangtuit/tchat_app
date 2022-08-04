import 'package:floor/floor.dart';
const String lastMessaeUid ='uid';
const String lastMessageIdReceiver ='idReceiver';
const String lastMessageNameReceiver ='nameReceiver';
const String lastMessagePhotoReceiver ='photoReceiver';

const String lastMessageTimestamp ='timestamp';
const String lastMessageContent ='content';
const String lastMessageType ='type';
const String lastMessageStatus ='status';
@entity
class LastMessageModel{
  @PrimaryKey(autoGenerate: true)
  int? idDB;
  String? uid;
  String? idReceiver='';
  String? nameReceiver='';
  String? photoReceiver='';
  String? timestamp='';
  String? content='';
  int? type=0;//type: 0 = text, 1 = image, 2 = sticker
  int? status=0;
  LastMessageModel({this.idDB,this.uid,this.idReceiver,this.nameReceiver,this.photoReceiver,this.content,this.type,this.timestamp,this.status});

  LastMessageModel.fromJson(Map<String, dynamic> json){
    uid = json[lastMessaeUid];
    idReceiver = json[lastMessageIdReceiver];
    nameReceiver = json[lastMessageNameReceiver];
    photoReceiver = json[lastMessagePhotoReceiver];
    content = json[lastMessageContent];
    type = json[lastMessageType];
    timestamp = json[lastMessageTimestamp];
    status = json[lastMessageStatus];
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data[lastMessaeUid] = uid;
    data[lastMessageIdReceiver] = idReceiver;
    data[lastMessageNameReceiver] = nameReceiver;
    data[lastMessagePhotoReceiver] = photoReceiver;

    data[lastMessageTimestamp] = timestamp;
    data[lastMessageContent] = content;
    data[lastMessageType] = type;
    data[lastMessageStatus] = status;

    return data;
  }

  @override
  String toString() {
    return '{idDB: $idDB, uid: $uid, idReceiver: $idReceiver, nameReceiver: $nameReceiver, photoReceiver: $photoReceiver, timestamp: $timestamp, content: $content, type: $type, status: $status}';
  }
}