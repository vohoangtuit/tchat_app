import 'dart:ui';

final themeColor = Color(0xFF42A5F5);
final primaryColor = Color(0xff203152);
final whiteColor = Color(0xFFFFFFFF);
final greyColor = Color(0xffaeaeae);
final greyColor2 = Color(0xffE8E8E8);

//final String SOCKET_URL ="http://192.168.29.148:5000";
final String SOCKET_URL ="https://chatsocket2008.herokuapp.com";

// todo Socket IO
final String SOCKET_SUBSCRIBE ='subscribe';
final String SOCKET_UNSUBSCRIBE ='unsubscribe';
final String SOCKET_TYPING ='typing';
final String SOCKET_STOP_TYPING ='stop_typing';
final String SOCKET_QUERY_ID_CHAT ='idChat';
final String SOCKET_SENDER_CHAT_ID ='senderChatID';
final String SOCKET_RECEIVER_CHAT_ID ='receiverChatID';
final String SOCKET_GROUP_CHAT_ID ='groupChatId';
final String SOCKET_DISCONNECT ='disconnect';
final String SOCKET_USER_JOINED ='user_joined';
final String SOCKET_USER_LEFT ='user_left';
final String SOCKET_USER_ID ='user_id';
final String SOCKET_LIST_USERS ='list_users';

//---------todo MAIN SCREEN ACTION CLICK TABBAR------------
const int mainClickSearch =1;
const int mainClickAddTabMessage =2;
const int mainClickAddContact =3;
const int mainClickAddGroup =4;
const int mainClickAddTimeLine =5;
const int mainClickNotificationTabTimeLine =6;
const int mainClickSettingTabMore =7;


// todo update picture

final int PICTURE_TYPE_AVATAR =1;
final int PICTURE_TYPE_COVER =2;
final int CHOOSE_PICTURE_CAMERA =1;
final int CHOOSE_PICTURE_LIBRARY =2;
final int CHOOSE_PICTURE_VIEW_PICTURE =3;

//
final String PATH_AVATAR_NOT_AVAILABLE ='images/avatar_not_available.png';
final String PATH_COVER_NOT_AVAILABLE ='images/cover.png';


// todo route screen opening, using for notification
final int ROUTE_DEFAULT =0;
final int ROUTE_CHAT_SCREEN =1;
final int ROUTE_USER_PROFILE_SCREEN =2;