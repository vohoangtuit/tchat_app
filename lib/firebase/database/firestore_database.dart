import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:tchat/firebase/notification/data_model.dart';
import 'package:tchat/firebase/notification/sent/notification_sent.dart';
import 'package:tchat/models/chat_messages.dart';
import 'package:tchat/models/friends_model.dart';
import 'package:tchat/models/user_model.dart';
import 'package:tchat/models/user_online_model.dart';


class FirebaseService{
  static const firebaseID ='id';

  static const firebaseNotifications ='notifications';
  static const firebaseUsers ='users';
  static const firebaseMessages ='messages';
  static const firebaseGroups ='groups';
  static const firebaseFriends ='friends';


  static const storePhoto ='photo';
  static const storeCover ='cover';
  static const storeAvatar ='avatar';
  late FirebaseFirestore firebaseFirestore;
  FirebaseService.getInstance(){
    firebaseFirestore =FirebaseFirestore.instance;
  }


  static String getStringPathAvatar(String uid){// user id
    //String fileName =DateTime.now().millisecondsSinceEpoch.toString();
    String avatar_ ='avatar_';// todo gán cứng name file, lần sau update ghi đè, ko cần xóa file củ
    return '/$uid/$storeAvatar/$avatar_';
  }
  static String getStringPathCover(String uid){// user id
    // String fileName =DateTime.now().millisecondsSinceEpoch.toString();
    String cover_ ='cover_';
    return '/$uid/$storeCover/$cover_';
  }
  String getStringPathListPhoto(String uid){// user id
    String fileName =DateTime.now().millisecondsSinceEpoch.toString();
    return '/$uid/$storePhoto/$fileName';
  }
  Future<Stream<QuerySnapshot>>getAllUser()async{
   return FirebaseFirestore.instance.collection(FirebaseService.firebaseUsers).snapshots();
  }
  Future<Stream<QuerySnapshot>>getMessageChat(String idSender, String idReceiver)async{
    //print('idSender $idSender idReceiver $idReceiver');
    return  FirebaseFirestore.instance
        .collection(firebaseMessages)
        .doc(idSender)
        .collection(idReceiver)
        .orderBy(ChatMessages.messageTimestamp, descending: true)
        .limit(50)
        .snapshots();
  }
  chatListenerData(String myID,String toID){
    return FirebaseFirestore.instance
        .collection(firebaseMessages)
        .doc(myID)
        .collection(toID)
        .limit(1)
        .orderBy(ChatMessages.messageTimestamp, descending: true);
  }
  Future<DocumentSnapshot> getInfoUserProfile(String id)async{
    DocumentSnapshot documentSnapshot = await FirebaseFirestore.instance.collection(firebaseUsers).doc(id).get();
    return documentSnapshot;
  }
  Future<UserModel> getProfile({required UserModel user})async{
    DocumentSnapshot value = await FirebaseFirestore.instance.collection(firebaseUsers).doc(user.id).get();
    UserModel? account;
    if(value.data()!=null){
    var json = value.data() as  Map<String, dynamic>;
    account = UserModel.fromJson(json);
    if(user.idDB!=null){
      account.idDB =user.idDB;
    }
    }
    return account!;
  }
  Future<DocumentSnapshot> checkUserIsFriend(String idMe,String idFriend)async{
    DocumentSnapshot documentSnapshot = await FirebaseFirestore.instance
        .collection(firebaseFriends).doc(idMe).collection(idMe).doc(idFriend).get();
    return documentSnapshot;
  }
  getFriendsWithType(String myId,int type)async{
    return await FirebaseFirestore.instance.collection(firebaseFriends).doc(myId).collection(myId).where(FriendModel.friendStatusRequest,isEqualTo: type).get();
  }
  requestAddFriend(UserModel myProfile,UserModel user,FriendModel fromRequest,FriendModel toRequest){
    WriteBatch writeBatch =  FirebaseFirestore.instance.batch();
    DocumentReference from = FirebaseFirestore.instance.collection(firebaseFriends).doc(myProfile.id).collection(myProfile.id!).doc(user.id); // todo: lấy user id làm id trên firebase
    //DocumentReference from = fireBaseStore.collection(FIREBASE_FRIENDS).doc(myProfile.id).collection(user.id).doc(user.id); // todo: lấy user id làm id trên firebase
    //DocumentReference from = fireBaseStore.collection(FIREBASE_FRIENDS).doc(myProfile.id).collection(user.id).doc();todo id tự generate on firebase
    DocumentReference to = FirebaseFirestore.instance.collection(firebaseFriends).doc(user.id).collection(user.id!).doc(myProfile.id); // todo: lấy user id làm id trên firebase
    // DocumentReference to = fireBaseStore.collection(FIREBASE_FRIENDS).doc(user.id).collection(myProfile.id).doc(myProfile.id); // todo: lấy user id làm id trên firebase
    // DocumentReference to = fireBaseStore.collection(FIREBASE_FRIENDS).doc(user.id).collection(myProfile.id); todo id tự generate on firebase
    writeBatch.set(from, fromRequest.toJson());
    writeBatch.set(to, toRequest.toJson());
    return  writeBatch.commit();
  }
  acceptFriend(String myID, String userID)async{
    WriteBatch writeBatch = FirebaseFirestore.instance.batch();
    DocumentReference from = FirebaseFirestore.instance
        .collection(firebaseFriends)
        .doc(myID)
        .collection(myID)
        .doc(userID);
    DocumentReference to = FirebaseFirestore.instance
        .collection(firebaseFriends)
        .doc(userID)
        .collection(userID)
        .doc(myID);
    writeBatch.update(from, {FriendModel.friendStatusRequest: FriendModel.friendSuccess});
    writeBatch.update(to, {FriendModel.friendStatusRequest: FriendModel.friendSuccess});
    //return await writeBatch.commit();
    return  writeBatch.commit();
  }
  removeFriend(String myID, String userID)async{
    WriteBatch writeBatch = FirebaseFirestore.instance.batch();
    DocumentReference from = FirebaseFirestore.instance
        .collection(firebaseFriends)
        .doc(myID)
        .collection(myID)
        .doc(userID);
    DocumentReference to = FirebaseFirestore.instance
        .collection(firebaseFriends)
        .doc(userID)
        .collection(userID)
        .doc(myID);
    writeBatch.delete(from);
    writeBatch.delete(to);
    return  writeBatch.commit();
    // return  writeBatch;
  }
   userLogin(UserModel user,ValueChanged<UserModel> valueUser)async{
     String time =DateTime.now().millisecondsSinceEpoch.toString();
     firebaseFirestore.collection(firebaseUsers).doc(user.id).get().then((value)  {
       if(value.exists){// todo get data from firebase
         var json = value.data() as  Map<String, dynamic>;
         user =UserModel.fromJson(json);
         user.isLogin =true;
         user.lastLogin =time;
         valueUser(user);
       }else{
         user.isLogin =true;
         user.createdAt=time;
         user.lastUpdated=time;
         user.lastLogin =time;
         addUser(user);
         valueUser(user);
       }
     });
  }
  addUser(UserModel user)async{
    firebaseFirestore.collection(firebaseUsers).doc(user.id).set(user.toJson()).then((data) async {
    }).catchError((err) {
      log('FirebaseDataFunc Error addUser ${err.toString()}');
    });

  }
  updateUser(UserModel user)async{
    // String time =DateTime.now().millisecondsSinceEpoch.toString();
    // user.lastUpdated=time;
    // user.lastLogin=time;
    // user.isLogin =true;
    firebaseFirestore.collection(firebaseUsers).doc(user.id).update(user.toJson()).then((data) async {
    }).catchError((err) {
      log('FirebaseDataFunc Error updateUser ${err.toString()}');
    });
  }
  sentNotificationRequestAddFriend(String toUid, String nameRequest, String formId)async {
    DataNotifyModel data = DataNotifyModel(uid: formId, type: notificationTypeNewAddFriend, title: '', content: '',clickAction: 'FLUTTER_NOTIFICATION_CLICK');
    NotificationSent sent = NotificationSent(toUId: toUid, title: nameRequest, body: 'Send you request add friend',clickAction: 'FLUTTER_NOTIFICATION_CLICK', data: data.toJson());
   // todo: lấy user id làm id trên firebase
    String time =DateTime.now().millisecondsSinceEpoch.toString();
    log('sent ${sent.toString()}');
    firebaseFirestore
        .collection(firebaseNotifications)
        .doc(toUid)
        .collection(notificationAddFriend)
   .add(sent.toJson())
        .then((value) {
     log('sentNotificationRequestAddFriend ');
    }).catchError((err) {
      log('sentNotificationRequestAddFriend Error:  $err');
    });
  }

  senNotificationNewMessage(String toUid, String nameRequest, String formId, String content) async{
    DataNotifyModel data = DataNotifyModel(uid: formId, type: notificationTypeNewMessage, title: '', content: content,clickAction: 'FLUTTER_NOTIFICATION_CLICK');
    NotificationSent sent = NotificationSent(
        toUId: toUid,
        title: nameRequest,
        body: 'you have got a new message',
        clickAction: 'FLUTTER_NOTIFICATION_CLICK',
        data: data.toJson());
    firebaseFirestore
        .collection(firebaseNotifications)
        .doc(toUid)
        .collection(notificationMessage)
        .add(sent.toJson())
        .then((value) {});
  }
  createUserOnline(String myId,UserModel user, bool online){
    UserOnLineModel userOnLineModel = UserOnLineModel(uid: user.id,name: user.fullName,lastAccess: '',isOnline: online);
    firebaseFirestore
        .collection(firebaseMessages)
        .doc(myId)
        .collection(user.id!)
        .doc(UserOnLineModel.userOnLineIsOnline).set(userOnLineModel.toJson()).then((value){

    });
  }
}


void log(String msg){
  if (kDebugMode) {
    print(msg);
  }
}
