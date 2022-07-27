
import 'dart:async';

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:rxdart/rxdart.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tchat/models/chat_messages.dart';
import 'package:tchat/models/user_model.dart';
import 'package:tchat/providers/chat_provider.dart';

class RealTimeDatabase extends  ChangeNotifier{
  String tagTChatApp = 'TChatApp';
  String tagUser= 'Users';
  String tagMessage= 'Messages';


  late BuildContext? context;

  late DatabaseReference databaseReference;

  late FirebaseApp app;

  late FirebaseDatabase database;

  late SharedPreferences prefs;

  RealTimeDatabase.getInstance({this.context}) {
    initDB();
  }
  void initDB() async {
    app = await Firebase.initializeApp();
    database = FirebaseDatabase.instance;
    databaseReference = database.ref(tagTChatApp);// todo root
    prefs = await SharedPreferences.getInstance();
  }
  Future<void> loginAccount(UserModel userModel) async {
    var query = databaseReference
        .child('$tagUser/${userModel.id}');
    query.once().then((snapshot) {
      if (snapshot.snapshot.value != null) {
        DataSnapshot dataValues = snapshot.snapshot;
        Map<dynamic, dynamic> values =
        dataValues.value as Map<dynamic, dynamic>;
        values.forEach((key, value) {
          databaseReference
              .child(
              '$tagUser/${userModel.id!}')
              .update({'lastLogin':DateTime.now().microsecondsSinceEpoch.toString()});
        });
      } else {
        databaseReference
            .child(
            '$tagUser/${userModel.id}')// todo .push(): id tự generate từ firebase
            .set(userModel.toJson())
            .then((value) => {});
      }
    });
  }
  Future<List<UserModel>> getListUser() async {
    List<UserModel> list =<UserModel>[];
    var postsSnapshot =  databaseReference.child(tagUser);//limitToFirst(3)
    await  postsSnapshot.get().then(( snapshot)  {
      if(snapshot.children.isNotEmpty){
        Map<dynamic, dynamic> values = snapshot.value as Map<dynamic, dynamic>;
        //print('snapshot.children ${snapshot.children.toString()}');
       // print('values ${values.toString()}');
        values.forEach((key, value) {
       //   print('key ${key.toString()}');
        //  print('value ${value.toString()}');
          UserModel item =UserModel.fromJson(value);
          list.add(item);
        });
      }
    });
    return list;

  }

  Future<List<ChatMessages>> getListChat(String idFrom,String idTo) async {
    List<ChatMessages> list =<ChatMessages>[];
    // var postsSnapshot =  databaseReference.child('$tagMessage/$idFrom/$idTo').limitToFirst(10);
    // await  postsSnapshot.get().then(( snapshot)  {
    //   if(snapshot.children.isNotEmpty){
    //     Map<dynamic, dynamic> values = snapshot.value as Map<dynamic, dynamic>;
    //   //  print('snapshot.children ${snapshot.children.toString()}');
    //      print('values ${values.toString()}');
    //     values.forEach((key, value) {
    //       //   print('key ${key.toString()}');
    //       //  print('value ${value.toString()}');
    //       ChatMessages item =ChatMessages.fromJson(value);
    //       list.add(item);
    //     });
    //   }
    // });
    // var postsSnapshot= databaseReference.child('$tagMessage/$idFrom/$idTo').onChildAdded.listen((event) {
    //   Map<dynamic, dynamic> values = event.snapshot.value as Map<dynamic, dynamic>;
    //   ChatMessages item =ChatMessages.fromJson(values);
    //   list.add(item);
    //   print('item ${item.content}');
    // });
    var postsSnapshot= databaseReference.child('$tagMessage/$idFrom/$idTo').onChildAdded;
    await postsSnapshot.listen((event) {
      Map<dynamic, dynamic> values = event.snapshot.value as Map<dynamic, dynamic>;
    });
    print('list ${list.length}');
    return list;
  }
  final PublishSubject<List<ChatMessages>> getDataChat = PublishSubject<List<ChatMessages>>();
  Stream<List<ChatMessages>> get dataChatStream => getDataChat.stream;
  Future<void>getListChat_(String idFrom,String idTo)  async{
    List<ChatMessages> list =<ChatMessages>[];
    // var postsSnapshot =  databaseReference.child('$tagMessage/$idFrom/$idTo').limitToFirst(10);
    // await  postsSnapshot.get().then(( snapshot)  {
    //   if(snapshot.children.isNotEmpty){
    //     Map<dynamic, dynamic> values = snapshot.value as Map<dynamic, dynamic>;
    //   //  print('snapshot.children ${snapshot.children.toString()}');
    //      print('values ${values.toString()}');
    //     values.forEach((key, value) {
    //       //   print('key ${key.toString()}');
    //       //  print('value ${value.toString()}');
    //       ChatMessages item =ChatMessages.fromJson(value);
    //       list.add(item);
    //     });
    //   }
    // });
    // var postsSnapshot= databaseReference.child('$tagMessage/$idFrom/$idTo').onChildAdded.listen((event) {
    //   Map<dynamic, dynamic> values = event.snapshot.value as Map<dynamic, dynamic>;
    //   ChatMessages item =ChatMessages.fromJson(values);
    //   list.add(item);
    //   print('item ${item.content}');
    // });
    databaseReference.child('$tagMessage/$idFrom/$idTo').onChildAdded.listen((event) {
      Map<dynamic, dynamic> values = event.snapshot.value as Map<dynamic, dynamic>;
            ChatMessages item =ChatMessages.fromJson(values);
      list.add(item);

    });
    getDataChat.sink.add(list);
  }
  sendMessage(UserModel me,UserModel to, String content,int type) async {
    var timestamp =DateTime.now().millisecondsSinceEpoch.toString();
    ChatMessages send =ChatMessages(idFrom: me.id!,idTo: to.id!,timestamp: timestamp,content: content,type: type,status: MessageStatus.sending);
    databaseReference
       // .child('$tagMessage/${me.id!}/${to.id}').push()// todo .push(): id tự generate từ firebase
        .child('$tagMessage/${me.id!}/${to.id}/$timestamp')//
        .set(send.toJson_())
        .then((value) => {});

    databaseReference
    // .child('$tagMessage/${me.id!}/${to.id}').push()// todo .push(): id tự generate từ firebase
        .child('$tagMessage/${to.id!}/${me.id}/$timestamp')//
        .set(send.toJson_())
        .then((value) => {});
  }
}