import 'package:rxdart/subjects.dart';
import 'package:tchat/bloc/base_bloc.dart';
import 'package:tchat/models/last_message_model.dart';

class MessageBloc extends BaseBloc{
 MessageBloc({required super.screen});
 final getMessage = PublishSubject<List<LastMessageModel>?>();
 Stream<List<LastMessageModel>?> get lastMessageStream => getMessage.stream;
 @override
 void dispose() {
  super.dispose();
  getMessage.close();
 }
 Future<void> getLastMessageStream(String uid) async {
  List<LastMessageModel> list =<LastMessageModel>[];
  await floorDB.getInstance();
  await  floorDB.messageDao!.getSingleLastMessage(uid).then((value){
   list =value;
  });
  if(!getMessage.isClosed) {
   getMessage.sink.add(list);
  }
 }
 Future<List<LastMessageModel>> getLastMessage(String uid) async {
  await floorDB.getInstance();
  List<LastMessageModel> list =<LastMessageModel>[];
  await floorDB.getInstance();
  await  floorDB.messageDao!.getSingleLastMessage(uid).then((value){
   list =value;
  });
  return list;
 }
 updateLastMessageByID(LastMessageModel message)async{

  await floorDB.getInstance();
  await floorDB.messageDao!.getLastMessageById(message.idReceiver!).then((value) {
   if (value != null) {
    message.idDB = value.idDB;
    floorDB.messageDao!.updateLastMessageById(message).then((value) {});
   } else {
    floorDB.messageDao!.insertMessage(message).then((value) => {});
   }
  });
 }

 deleteAllLastMessage()async{
  await floorDB.getInstance();
  await floorDB.messageDao!.deleteAllLastMessage();
 }
}