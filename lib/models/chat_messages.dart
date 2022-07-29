import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:tchat/allConstants/firestore_constants.dart';

class ChatMessages {

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

  Map<String, dynamic> toJson() {
    return {
      FirestoreConstants.idFrom: idSender,
      FirestoreConstants.idTo: idReceiver,
      FirestoreConstants.timestamp: timestamp,
      FirestoreConstants.content: content,
      FirestoreConstants.type: type,
      FirestoreConstants.status: status,
    };
  }
  //
  // factory ChatMessages.fromDocument(DocumentSnapshot documentSnapshot) {
  //   String idFrom = documentSnapshot.get(FirestoreConstants.idFrom);
  //   String idTo = documentSnapshot.get(FirestoreConstants.idTo);
  //   String timestamp = documentSnapshot.get(FirestoreConstants.timestamp);
  //   String content = documentSnapshot.get(FirestoreConstants.content);
  //   int type = documentSnapshot.get(FirestoreConstants.type);
  //   int status = documentSnapshot.get(FirestoreConstants.status);
  //
  //   return ChatMessages(
  //       idSender: idFrom,
  //       idTo: idTo,
  //       timestamp: timestamp,
  //       content: content,
  //       type: type,
  //     status: status,
  //
  //   );
  // }
  //
  // factory ChatMessages.fromJson(Map<dynamic, dynamic> json) {
  // String  idFrom = json[FirestoreConstants.idFrom];
  // String idTo = json[FirestoreConstants.idTo];
  // String  timestamp = json[FirestoreConstants.timestamp];
  // String  content = json[FirestoreConstants.content];
  // int  type = json[FirestoreConstants.type];
  // int  status = json[FirestoreConstants.status];
  // return ChatMessages(
  //     idSender: idFrom,
  //     idTo: idTo,
  //     timestamp: timestamp,
  //     content: content,
  //     type: type,
  //   status: status,
  // );
  // }
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
