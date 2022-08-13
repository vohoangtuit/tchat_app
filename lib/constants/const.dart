import 'dart:ui';

final themeColor = Color(0xFF42A5F5);
final primaryColor = Color(0xff203152);
final whiteColor = Color(0xFFFFFFFF);
final greyColor = Color(0xffaeaeae);
final greyColor2 = Color(0xffE8E8E8);
class Const{
  Const._();
  //---------todo MAIN SCREEN ACTION CLICK TABBAR------------
  static const int mainClickSearch =1;
  static const int mainClickAddTabMessage =2;
  static const int mainClickAddContact =3;
  static const int mainClickAddGroup =4;
  static const int mainClickAddTimeLine =5;
  static const int mainClickNotificationTabTimeLine =6;
  static const int mainClickSettingTabMore =7;
// todo Socket IO
  //final String SOCKET_URL ="http://192.168.29.148:5000";
  static const String SOCKET_URL ="https://chatsocket2008.herokuapp.com";
  static const String SOCKET_SUBSCRIBE ='subscribe';
  static const String SOCKET_UNSUBSCRIBE ='unsubscribe';
  static const String SOCKET_TYPING ='typing';
  static const String SOCKET_STOP_TYPING ='stop_typing';
  static const String SOCKET_QUERY_ID_CHAT ='idChat';
  static  const String SOCKET_SENDER_CHAT_ID ='senderChatID';
  static const String SOCKET_RECEIVER_CHAT_ID ='receiverChatID';
  static const String SOCKET_GROUP_CHAT_ID ='groupChatId';
  static const String SOCKET_DISCONNECT ='disconnect';
  static const String SOCKET_USER_JOINED ='user_joined';
  static const String SOCKET_USER_LEFT ='user_left';
  static const String SOCKET_USER_ID ='user_id';
  static  const String SOCKET_LIST_USERS ='list_users';
  // todo update picture

  static const int pictureTypeAvatar =1;
  static const int pictureTypeCover =2;
  static const int choosePictureCamera =1;
  static const int choosePictureLibrary =2;
  static const int choosePictureViewPicture =3;

  static const String pathAvatarNotAvailable ='assets/images/avatar_not_available.png';
  static const String pathCoverNotAvailable ='assets/images/cover.png';

  static const String messageModel ='MessageModel';
  static  const String messageCheckOnline ='CHECK_ONLINE';
  static const String messageId ='id';

  static const String messageIdSender ='idSender';
  static const String messageNameSender ='nameSender';
  static const String messagePhotoSender ='photoSender';

  static const String messageIdReceiver ='idReceiver';
  static const String messageNameReceiver ='nameReceiver';
  static const String messagePhotoReceiver ='photoReceiver';

  static const String messageTimestamp ='timestamp';
  static const String messageContent ='content';
  static const String messageType ='type';
  static String messageStatus ='status';
  static String messageGroupId ='groupId';


  static String tChatCached ='TChat_Cached';


}




//



