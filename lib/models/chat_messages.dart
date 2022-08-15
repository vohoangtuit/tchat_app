import 'package:cloud_firestore/cloud_firestore.dart';

class ChatMessages {

  static const messageCheckOnline ='checkOnline';

  static const messageIdSender ='idSender';
  static const messageNameSender ='nameSender';
  static const messagePhotoSender ='photoSender';

  static const messageIdReceiver ='idReceiver';
  static const messageNameReceiver ='nameReceiver';
  static const messagePhotoReceiver ='photoReceiver';

  static const messageTimestamp ='timestamp';
  static const messageContent ='content';
  static const messageType ='type';
  static const messageStatus ='status';

  String idSender;
  String nameSender;
  String photoSender;

  String idReceiver;
  String nameReceiver;
  String photoReceiver;

  String timestamp;
  String content;
  int type;
  int status;

  ChatMessages(
      {
        required this.idSender,
        required this.nameSender,
        required this.photoSender,

        required this.idReceiver,
        required this.nameReceiver,
        required this.photoReceiver,

        required this.timestamp,
        required this.content,
        required this.type,
        required this.status
      });

  Map<String, dynamic> toJson_() {
    final data = <String, dynamic>{};
    data[messageIdSender] = idSender;
    data[messageNameSender] = nameSender;
    data[messagePhotoSender] = photoSender;

    data[messageIdReceiver] = idReceiver;
    data[messageNameReceiver] = nameReceiver;
    data[messagePhotoReceiver] = photoReceiver;

    data[messageTimestamp] = timestamp;
    data[messageContent] = content;
    data[messageType] = type;
    data[messageStatus] = status;
    return data;
  }
  static List<ChatMessages>listFromSnapshot(List<QueryDocumentSnapshot> snapshots){
    List<ChatMessages> list =<ChatMessages>[];
    if(snapshots.isNotEmpty){
      for (var item in snapshots) {
        ChatMessages chat =ChatMessages(

             idSender:item[messageIdSender],
             nameSender:item[messageNameSender],
             photoSender:item[messagePhotoSender],

             idReceiver:item[messageIdReceiver],
             nameReceiver:item[messageNameReceiver],
             photoReceiver:item[messagePhotoReceiver],

             timestamp:item[messageTimestamp],
             content:item[messageContent],
             type:item[messageType],
             status:item[messageStatus],
        );
        list.add(chat);
      }
    }
    return list;
  }
}
class MessageType {
  static const text = 0;
  static const image = 1;
  static const sticker = 2;
}
