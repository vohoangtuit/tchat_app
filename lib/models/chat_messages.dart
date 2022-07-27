import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:tchat/allConstants/firestore_constants.dart';

class ChatMessages {
  String idFrom;
  String idTo;
  String timestamp;
  String content;
  int? type;
  int? status;

  ChatMessages(
      {required this.idFrom,
      required this.idTo,
      required this.timestamp,
      required this.content,
      required this.type,
      required this.status
      });

  Map<String, dynamic> toJson() {
    return {
      FirestoreConstants.idFrom: idFrom,
      FirestoreConstants.idTo: idTo,
      FirestoreConstants.timestamp: timestamp,
      FirestoreConstants.content: content,
      FirestoreConstants.type: type,
      FirestoreConstants.status: status,
    };
  }

  factory ChatMessages.fromDocument(DocumentSnapshot documentSnapshot) {
    String idFrom = documentSnapshot.get(FirestoreConstants.idFrom);
    String idTo = documentSnapshot.get(FirestoreConstants.idTo);
    String timestamp = documentSnapshot.get(FirestoreConstants.timestamp);
    String content = documentSnapshot.get(FirestoreConstants.content);
    int type = documentSnapshot.get(FirestoreConstants.type);
    int status = documentSnapshot.get(FirestoreConstants.status);

    return ChatMessages(
        idFrom: idFrom,
        idTo: idTo,
        timestamp: timestamp,
        content: content,
        type: type,
      status: status,

    );
  }
  factory ChatMessages.fromJson(Map<dynamic, dynamic> json) {
  String  idFrom = json[FirestoreConstants.idFrom];
  String idTo = json[FirestoreConstants.idTo];
  String  timestamp = json[FirestoreConstants.timestamp];
  String  content = json[FirestoreConstants.content];
  int  type = json[FirestoreConstants.type];
  int  status = json[FirestoreConstants.status];
  return ChatMessages(
      idFrom: idFrom,
      idTo: idTo,
      timestamp: timestamp,
      content: content,
      type: type,
    status: status,
  );
  }
  Map<String, dynamic> toJson_() {
    final data = <String, dynamic>{};
    data['idFrom'] = idFrom;
    data['idTo'] = idTo;
    data['timestamp'] = timestamp;
    data['content'] = content;
    data['type'] = type;
    data['status'] = status;
    return data;
  }
}
