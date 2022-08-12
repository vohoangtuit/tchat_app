import 'dart:ui';

final themeColor = Color(0xFF42A5F5);
final primaryColor = Color(0xff203152);
final whiteColor = Color(0xFFFFFFFF);
final greyColor = Color(0xffaeaeae);
final greyColor2 = Color(0xffE8E8E8);

//final String SOCKET_URL ="http://192.168.29.148:5000";
const String SOCKET_URL ="https://chatsocket2008.herokuapp.com";

// todo Socket IO
const String SOCKET_SUBSCRIBE ='subscribe';
const String SOCKET_UNSUBSCRIBE ='unsubscribe';
const String SOCKET_TYPING ='typing';
const String SOCKET_STOP_TYPING ='stop_typing';
const String SOCKET_QUERY_ID_CHAT ='idChat';
const String SOCKET_SENDER_CHAT_ID ='senderChatID';
const String SOCKET_RECEIVER_CHAT_ID ='receiverChatID';
const String SOCKET_GROUP_CHAT_ID ='groupChatId';
const String SOCKET_DISCONNECT ='disconnect';
const String SOCKET_USER_JOINED ='user_joined';
const String SOCKET_USER_LEFT ='user_left';
const String SOCKET_USER_ID ='user_id';
const String SOCKET_LIST_USERS ='list_users';

//---------todo MAIN SCREEN ACTION CLICK TABBAR------------
const int mainClickSearch =1;
const int mainClickAddTabMessage =2;
const int mainClickAddContact =3;
const int mainClickAddGroup =4;
const int mainClickAddTimeLine =5;
const int mainClickNotificationTabTimeLine =6;
const int mainClickSettingTabMore =7;


// todo update picture

const int pictureTypeAvatar =1;
const int pictureTypeCover =2;
const int choosePictureCamera =1;
const int choosePictureLibrary =2;
const int choosePictureViewPicture =3;

//
const String pathAvatarNotAvailable ='assets/images/avatar_not_available.png';
const String pathCoverNotAvailable ='assets/images/cover.png';


// todo route screen opening, using for notification
const int ROUTE_DEFAULT =0;
const int ROUTE_CHAT_SCREEN =1;
const int ROUTE_USER_PROFILE_SCREEN =2;

const String messageModel ='MessageModel';
const String messageCheckOnline ='CHECK_ONLINE';
const String messageId ='id';

const String messageIdSender ='idSender';
const String messageNameSender ='nameSender';
const String messagePhotoSender ='photoSender';

const String messageIdReceiver ='idReceiver';
const String messageNameReceiver ='nameReceiver';
const String messagePhotoReceiver ='photoReceiver';

const String messageTimestamp ='timestamp';
const String messageContent ='content';
const String messageType ='type';
const String messageStatus ='status';
const String messageGroupId ='groupId';
