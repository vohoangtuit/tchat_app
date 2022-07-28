import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:tchat/models/chat_messages.dart';
import 'package:tchat/models/friends_model.dart';
import 'package:tchat/models/user_model.dart';


class FirebaseDataFunc{
  static const firebaseID ='id';

  static const firebaseNotifications ='notifications';
  static const firebaseUsers ='users';
  static const firebaseMessages ='messages';
  static const firebaseGroups ='groups';
  static const firebaseFriends ='friends';


  static const storePhoto ='photo';
  static const storeCover ='cover';
  static const storeAvatar ='avatar';


  String getStringPathAvatar(String uid){// user id
    //String fileName =DateTime.now().millisecondsSinceEpoch.toString();
    String avatar_ ='avatar_';// todo gán cứng name file, lần sau update ghi đè, ko cần xóa file củ
    return '/$uid/$storeAvatar/$avatar_';
  }
  String getStringPathCover(String uid){// user id
    // String fileName =DateTime.now().millisecondsSinceEpoch.toString();
    String cover_ ='cover_';
    return '/$uid/$storeCover/$cover_';
  }
  String getStringPathListPhoto(String uid){// user id
    String fileName =DateTime.now().millisecondsSinceEpoch.toString();
    return '/$uid/$storePhoto/$fileName';
  }
  getAllUser()async{
    return  FirebaseFirestore.instance
        .collection(firebaseUsers)
        .snapshots();
  }
  getMessageChat(String idSender, String idReceiver)async{
    print('idSender $idSender idReceiver $idReceiver');
    return await FirebaseFirestore.instance
        .collection(firebaseMessages)
        .doc( idSender)
        .collection(idReceiver)
        .orderBy(ChatMessages.messageTimestamp, descending: true)
        .limit(20)
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
  void updateUserInfo(UserModel user){
    FirebaseFirestore.instance.collection(firebaseUsers).doc(user.id).update({UserModel.userFullName:  user.fullName,UserModel.userGender: user.gender,UserModel.userBirthday:user.birthday,UserModel.userUpdatedAt: user.updatedAt
    }).then((data) async {
     // FBCallBack(user,true);
     // Fluttertoast.showToast(msg: "Update info success");
    }).catchError((err) {
     // Fluttertoast.showToast(msg: err.toString());
    });
  }
}