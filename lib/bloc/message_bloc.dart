import 'package:rxdart/subjects.dart';
import 'package:tchat/bloc/base_bloc.dart';
import 'package:tchat/models/last_message_model.dart';
import 'package:tchat/providers/app_provider.dart';

import '../screens/TChatBaseScreen.dart';

class MessageBloc extends BaseBloc{
 MessageBloc({required AppProvider appProvider, required TChatBaseScreen screen}) : super(appProvider:appProvider, screen:screen);
 final getMessage = PublishSubject<List<LastMessageModel>?>();

//  MessageBloc({required super.appProvider, required super.screen});
 Stream<List<LastMessageModel>?> get lastMessageStream => getMessage.stream;
 @override
 void dispose() {
  super.dispose();
  getMessage.close();
 }
 Future<void> getLastMessageStream(String uid) async {
  List<LastMessageModel> list =<LastMessageModel>[];

  await  messageDao.getSingleLastMessage(uid).then((value){
   list =value;
  });
  if(!getMessage.isClosed) {
   getMessage.sink.add(list);
  }
 }
 Future<List<LastMessageModel>> getLastMessage(String uid) async {
  List<LastMessageModel> list =<LastMessageModel>[];
  await  messageDao.getSingleLastMessage(uid).then((value){
   list =value;
  });
  return list;
 }
 updateLastMessageByID(LastMessageModel message)async{

  await messageDao.getLastMessageById(message.idReceiver!).then((value) {
   if (value != null) {
    message.idDB = value.idDB;
    messageDao.updateLastMessageById(message).then((value) {});
   } else {
   messageDao.insertMessage(message).then((value) => {});
   }
  });
 }

 deleteAllLastMessage()async{
  await messageDao.deleteAllLastMessage();
 }
}