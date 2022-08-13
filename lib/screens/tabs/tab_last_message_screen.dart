import 'package:flutter/material.dart';
import 'package:tchat/models/last_message_model.dart';
import 'package:tchat/models/user_model.dart';
import 'package:tchat/screens/TChatBaseScreen.dart';
import 'package:tchat/screens/chat/chat_screen.dart';
import 'package:tchat/shared_preferences/shared_preference.dart';
import 'package:tchat/widgets/items/item_last_message.dart';

class TabLastMessageScreen extends StatefulWidget {
  final UserModel profile;
  const TabLastMessageScreen({Key? key, required this.profile}) : super(key: key);

  @override
  State<TabLastMessageScreen> createState() => _TabLastMessageScreenState();
}

class _TabLastMessageScreenState extends TChatBaseScreen<TabLastMessageScreen> {
  List<LastMessageModel> listMessage = <LastMessageModel>[];
  String languageCode ='';
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: _listView(),
        ),
      ],
    );
  }
  @override
  void initState() {
    super.initState();
    _init();
  }
  Widget _listView() {
      return listMessage.isNotEmpty?ListView.separated(
        padding: const EdgeInsets.only(left: 0.0,top: 0.0,right: 0.0,bottom: 8.0),
        itemBuilder: (context, index) =>
            ItemLastMessage(profile:widget.profile, message:listMessage[index],languageCode:languageCode, onClick: () {
             _gotoChat(listMessage[index]);
            },),
        itemCount: listMessage.length,
        separatorBuilder: (context, index) {
          return const Divider(
            color: Colors.grey,height: 0.5,
            indent: 60.0,// padding left
            endIndent: 0,// padding right
          );
        },
      ):Container();

  }
  _init()async{
    SharedPre.getInstance();
     await SharedPre.getStringKey(SharedPre.sharedPreLanguageCode).then((value) {
       if(value!=null){
         setState(() {
           languageCode =value;
         });
       }

    });
    getData();
    //log('tab ${widget.profile.toString()}');
  }
  getData()async{
   // log('${getNameScreenOpening()} getData()');
    await messageBloc.getLastMessage(widget.profile.id!).then((value){
      if(mounted){
        setState(() {
          listMessage.clear();
          listMessage.addAll(value);
        });
      }
    });
  }
  _gotoChat(LastMessageModel message){
    UserModel toUser =UserModel();
    toUser.id =message.idReceiver;
    toUser.fullName =message.nameReceiver;
    toUser.photoUrl =message.photoReceiver;
    toUser.cover ="";
    addScreen(ChatScreen(meAccount: widget.profile, toUser: toUser));
  }
  @override
  void onResume() {
    super.onResume();
    getData();
  }

}

